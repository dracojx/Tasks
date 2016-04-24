package draco.tasks

import grails.transaction.Transactional

import java.text.SimpleDateFormat

import org.apache.poi.POIXMLException
import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.usermodel.IndexedColors
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.springframework.web.context.request.RequestContextHolder
import org.springframework.web.servlet.support.RequestContextUtils

@Transactional
class ExcelService {

	def messageSource

	//Upload Excel
	def List<String> readExcel(InputStream is, def userId) {
		def request = RequestContextHolder.currentRequestAttributes().request
		Locale locale = RequestContextUtils.getLocale(request)
		def errors = []
		Workbook wb = null
		try {
			wb =  new XSSFWorkbook(is)
		} catch(POIXMLException e) {
			errors.add(messageSource.getMessage('default.import.failed.message', null, locale))
			return errors
		}
		errors.addAll(this.readProducts(wb, locale, userId))
		errors.addAll(this.readTasks(wb, locale, userId))
		errors.addAll(this.readCrs(wb, locale))
		errors.addAll(this.readServices(wb, locale))
		return errors
	}

	//Download Excel
	def writeExcel(OutputStream os) {
		def request = RequestContextHolder.currentRequestAttributes().request
		Locale locale = RequestContextUtils.getLocale(request)

		Workbook wb = new XSSFWorkbook()

		Font defaultFont = this.defaultFont(wb, locale)
		Font titleFont = this.titleFont(wb, locale)
		Font inactivateFont = this.inactivateFont(wb, locale)

		CellStyle defaultCS = this.defaultCellStyle(wb, defaultFont)
		CellStyle titleCS = this.titleCellStyle(wb, titleFont)
		CellStyle inactivateCS = this.inactivateCellStyle(wb, inactivateFont)

		Map<String, CellStyle> cellStyles = [
			default:defaultCS,
			title:titleCS,
			inactivate: inactivateCS
		]

		this.writeProducts(wb, cellStyles, locale)
		this.writeTasks(wb, cellStyles, locale)
		this.writeCrs(wb, cellStyles, locale)
		this.writeServices(wb, cellStyles, locale)
		this.writePreparing(wb, cellStyles, locale)

		wb.write(os)
		os.close()
	}

	private List<String> readProducts(Workbook wb, Locale locale, def userId) {
		def errors = []
		Sheet sheet = wb.getSheet(messageSource.getMessage('product.label', null, locale))
		if(sheet) {
			def size = sheet.getPhysicalNumberOfRows() - 1
			for(i in 1..size) {
				Row row = sheet.getRow(i)
				def itemId = row.getCell(0).getStringCellValue()
				def title = row.getCell(1).getStringCellValue()
				def remark = row.getCell(2).getStringCellValue()
				def mode = 'a'
				def activate = true
				def sender = null
				def receiver = null
				def source = null
				def target = null
				def logs = [] as SortedSet
				def tags = [] as SortedSet
				def tasks = []


				def modeName = row.getCell(3).getStringCellValue()
				if(modeName?.equalsIgnoreCase(messageSource.getMessage('product.mode.s', null, locale))) {
					mode = 's'
				}
				Cell cell = row.getCell(0)
				if(cell) {
					def font = wb.getFontAt(cell.getCellStyle().getFontIndex())
					activate = !font.getStrikeout()
				}
				def senderName = row.getCell(4).getStringCellValue()
				if(senderName) {
					sender = Service.findByName(senderName.toUpperCase())
					if(!sender) {
						sender = new Service(name:senderName.toUpperCase())
						sender.save flush:true
					}
				}
				def receiverName = row.getCell(5).getStringCellValue()
				if(receiverName) {
					receiver = Service.findByName(receiverName.toUpperCase())
					if(!receiver) {
						receiver = new Service(name:receiverName.toUpperCase())
						receiver.save flush:true
					}
				}
				def sourceName = row.getCell(6).getStringCellValue()
				if(sourceName) {
					source = Adapter.findByName(sourceName.toUpperCase())
					if(!source) {
						source = new Adapter(name:sourceName.toUpperCase())
						source.save flush:true
					}
				}
				def targetName = row.getCell(7).getStringCellValue()
				if(targetName) {
					target = Adapter.findByName(targetName.toUpperCase())
					if(!target) {
						target = new Adapter(name:targetName.toUpperCase())
						target.save flush:true
					}
				}
				def taskReqs = row.getCell(8).getStringCellValue()?.split('\n')
				taskReqs.each {
					if(it) {
						def task = Task.findByReq(it.toUpperCase())
						if(!task) {
							def date = new Date()
							task = new Task(req:it.toUpperCase(), status:'0', createDate:date, updateDate:date, user:User.get(userId))
						}
						tasks.add(task)
					}
				}
				Task.saveAll(tasks)

				def tagNames = row.getCell(9).getStringCellValue()?.split('\n')
				tagNames.each {
					if(it) {
						def tag = Tag.findByName(it)
						if(!tag) {
							tag = new Tag(name:it)
						}
						tags.add(tag)
					}
				}

				def product = Product.findByItemId(itemId.toUpperCase())
				if(!product) {
					product = new Product()
				}
				product.setItemId(itemId.toUpperCase())
				product.setTitle(title)
				product.setRemark(remark)
				product.setMode(mode)
				product.setActivate(activate)
				product.setSender(sender)
				product.setReceiver(receiver)
				product.setSource(source)
				product.setTarget(target)
				product.setTags(tags)

				if(product.validate()) {
					product.save flush:true
				} else {
					errors.add(messageSource.getMessage('default.import.error.message',
							[
								messageSource.getMessage('product.label', null, locale),
								i + 1] as Object[], locale))
				}

				tasks.each {
					def log = Log.findByTaskAndProduct(it, product)
					if(!log) {
						def type = 'u'
						if((!product.getLogs() || product.getLogs().isEmpty()) && logs.isEmpty()) {
							type = 'c'
						}
						log =  new Log(type:type, task:it, product:product, user:User.get(userId))
					}
					logs.add(log)
				}
				Log.saveAll(logs)
			}
		}

		return errors
	}

	private List<String> readTasks(Workbook wb, Locale locale, def userId) {
		def errors = []
		Sheet sheet = wb.getSheet(messageSource.getMessage('task.label', null, locale))
		if(sheet) {
			def tasks = []
			def size = sheet.getPhysicalNumberOfRows() - 1;
			for(i in 1..size) {
				Row row = sheet.getRow(i)
				def req = row.getCell(0).getStringCellValue()
				def title = row.getCell(1).getStringCellValue()
				def user = null
				def status = '0'
				def createDate = null
				def updateDate = null
				def remark = row.getCell(9).getStringCellValue()
				def activate = true
				def logs = [] as SortedSet
				def crs = [] as SortedSet
				def tags = [] as SortedSet
				def products = []
				
				Cell cell = row.getCell(0)
				if(cell) {
					def font = wb.getFontAt(cell.getCellStyle().getFontIndex())
					activate = !font.getStrikeout()
				}

				def userName = row.getCell(2).getStringCellValue()
				if(userName) {
					user = User.findByName(userName)
					if(!user) {
						user = new User(username:userName, name:userName, password:'123456', activate:false)
						user.save flush:true
					}
				} else {
					user = User.get(userId)
				}

				def statusName = row.getCell(3).getStringCellValue()
				if(statusName) {
					for(x in 0..5) {
						if(statusName?.equalsIgnoreCase(messageSource.getMessage('task.status.'+x, null, locale))) {
							status = x.toString()
							break
						}
					}
				}
				
				def productItemIds = row.getCell(4).getStringCellValue().split('\n')
				productItemIds.each {
					if(it) {
						def product = Product.findByItemId(it)
						if(!product) {
							product = new Product(itemId:it)
						}
						products.add(product)
					}
				}
				Product.saveAll(products)
				
				def crNumbers = row.getCell(5).getStringCellValue().split('\n')
				crNumbers.each {
					if(it) {
						def cr = Cr.findByNumber(it)
						if(!cr) {
							cr = new Cr(number:it)
						}
						crs.add(cr)
					}
				}
				Cr.saveAll(crs)

				def tagNames = row.getCell(6).getStringCellValue()?.split('\n')
				tagNames.each {
					if(it) {
						def tag = Tag.findByName(it)
						if(!tag) {
							tag = new Tag(name:it)
						}
						tags.add(tag)
					}
				}
				
				def createDateString = row.getCell(7).getStringCellValue()
				if(createDateString) {
					def df = new SimpleDateFormat("yyyy/MM/dd")
					createDate = df.parse(createDateString)
					def updateDateString = row.getCell(8).getStringCellValue()
					if(updateDateString) {
						updateDate = df.parse(updateDateString)
					} else {
						updateDate = new Date()
					}
				} else {
					createDate = new Date()
					updateDate = createDate
				}
				
				def task = Task.findByReq(req.toUpperCase())
				if(!task) {
					task = new Task()
				}
				task.setReq(req.toUpperCase())
				task.setTitle(title)
				task.setRemark(remark)
				task.setStatus(status)
				task.setUser(user)
				task.setActivate(activate)
				task.setCreateDate(createDate)
				task.setUpdateDate(updateDate)
				task.setCrs(crs)
				task.setTags(tags)

				if(task.validate()) {
					task.save flush:true
				} else {
					errors.add(messageSource.getMessage('default.import.error.message',
							[
								messageSource.getMessage('task.label', null, locale),
								i + 1] as Object[], locale))
				}

				products.each {
					def log = Log.findByTaskAndProduct(task, it)
					if(!log) {
						def type = 'u'
						if(!it.getLogs() || it.getLogs().isEmpty()) {
							type = 'c'
						}
						log =  new Log(type:type, task:task, product:it, user:task.getUser())
					}
					logs.add(log)
				}
				Log.saveAll(logs)


			}
		}

		return errors
	}

	private List<String> readCrs(Workbook wb, Locale locale) {
		def errors = []
		Sheet sheet = wb.getSheet(messageSource.getMessage('cr.label', null, locale))
		if(sheet) {
			def crs = []
			def size = sheet.getPhysicalNumberOfRows() - 1
			for(i in 1..size) {
				Row row = sheet.getRow(i)
				def number = row.getCell(0).getStringCellValue()
				def descripion = row.getCell(1).getStringCellValue()
				def status = '1'
				def products = [] as SortedSet


				for(x in 1..4) {
					def statusName = row.getCell(2).getStringCellValue()
					if(statusName?.equalsIgnoreCase(messageSource.getMessage('cr.status.'+x, null, locale))) {
						status = x.toString()
						break
					}
				}
				
				def productItemIds = row.getCell(3).getStringCellValue()?.split('\n')
				productItemIds.each {
					if(it) {
						def product = Product.findByItemId(it.toUpperCase())
						if(!product) {
							product = new Product(itemId:it.toUpperCase())
						}
						products.add(product)
					}
				}

				def cr = Cr.findByNumber(number.toUpperCase())
				if(!cr) {
					cr = new Cr()
				}
				cr.setNumber(number.toUpperCase())
				cr.setDescription(descripion)
				cr.setStatus(status)
				cr.setProducts(products)
				if(cr.validate()) {
					crs.add(cr)
				} else {
					errors.add(messageSource.getMessage('default.import.error.message',
							[
								messageSource.getMessage('cr.label', null, locale),
								i + 1] as Object[], locale))
				}
			}
			Cr.saveAll(crs)
		}
		return errors
	}

	private List<String> readServices(Workbook wb, Locale locale) {
		def errors = []
		Sheet sheet = wb.getSheet(messageSource.getMessage('service.label', null, locale))
		if(sheet) {
			def services = []
			def size = sheet.getPhysicalNumberOfRows() - 1
			for(i in 1..size) {
				Row row = sheet.getRow(i)
				def name = row.getCell(0)?.getStringCellValue()
				def description = row.getCell(1)?.getStringCellValue()
				def vendor = row.getCell(2)?.getStringCellValue()

				def service = Service.findByName(name.toUpperCase())
				if(!service) {
					service = new Service()
				}
				service.setName(name)
				service.setDescription(description)
				service.setVendor(vendor)
				if(service.validate()) {
					services.add(service)
				} else {
					errors.add(messageSource.getMessage('default.import.error.message',
							[
								messageSource.getMessage('service.label', null, locale),
								i + 1] as Object[], locale))
				}
			}
			Service.saveAll(services)
		}
		return errors
	}

	private writeProducts(Workbook wb, Map<String, CellStyle> cellStyles, Locale locale) {

		//Header
		List<String> header = [
			messageSource.getMessage('product.itemId.label', null, locale),
			messageSource.getMessage('product.title.label', null, locale),
			messageSource.getMessage('product.remark.label', null, locale),
			messageSource.getMessage('product.mode.label', null, locale),
			messageSource.getMessage('product.sender.label', null, locale),
			messageSource.getMessage('product.receiver.label', null, locale),
			messageSource.getMessage('product.source.label', null, locale),
			messageSource.getMessage('product.target.label', null, locale),
			messageSource.getMessage('product.logs.label', null, locale),
			messageSource.getMessage('product.tags.label', null, locale)
		]

		//Create Sheet
		Sheet sheet = wb.createSheet(messageSource.getMessage('product.label', null, locale))

		//Write Header
		Row headerRow = sheet.createRow(0)
		header.eachWithIndex {it, i ->
			Cell cell = headerRow.createCell(i)
			cell.setCellValue(it)
			cell.setCellStyle(cellStyles.get('title'))
		}


		//Products
		List<Product> products = Product.list()
		def rowNumber = 1
		products.each {
			//Write Data
			Row row = sheet.createRow(rowNumber)
			if(it.getItemId()) {
				row.createCell(0).setCellValue(it.getItemId())
			}
			if(it.getTitle()) {
				row.createCell(1).setCellValue(it.getTitle())
			}
			if(it.getRemark()) {
				row.createCell(2).setCellValue(it.getRemark())
			}
			if(it.getMode()) {
				row.createCell(3).setCellValue(messageSource.getMessage('product.mode.'+it.getMode(), null, locale))
			}
			if(it.getSender()) {
				row.createCell(4).setCellValue(it.getSender().toString())
			}
			if(it.getReceiver()) {
				row.createCell(5).setCellValue(it.getReceiver().toString())
			}
			if(it.getSource()) {
				row.createCell(6).setCellValue(it.getSource().toString())
			}
			if(it.getTarget()) {
				row.createCell(7).setCellValue(it.getTarget().toString())
			}
			if(it.getLogs()) {
				StringBuffer sb = new StringBuffer()
				it.getLogs().each {Log log ->
					def message = messageSource.getMessage('product.logs.log',
							[
								messageSource.getMessage('log.type.'+log.getType(), null, locale),
								log.getTask().toString(),
								log.getUser().toString()
							] as Object[], locale)
					sb.append(message).append("\n")
				}
				row.createCell(8).setCellValue(sb.toString().trim())
			}
			if(it.getTags()) {
				StringBuffer sb = new StringBuffer()
				it.getTags().each {Tag tag ->
					sb.append(tag.toString()).append("\n")
				}
				row.createCell(9).setCellValue(sb.toString().trim())
			}

			//Set CellStyle
			if(it.isActivate()) {
				//Activated
				for(i in 0..9) {
					Cell cell = row.getCell(i)
					if(!cell) {
						cell = row.createCell(i)
					}
					cell.setCellStyle(cellStyles.get('default'))
				}
			} else {
				//Inactivated
				for(i in 0..9) {
					Cell cell = row.getCell(i)
					if(!cell) {
						cell = row.createCell(i)
					}
					cell.setCellStyle(cellStyles.get('inactivate'))
				}
			}

			//List Wrap
			for(i in 8..9) {
				row.getCell(i).getCellStyle().setWrapText(true)
			}

			rowNumber++
		}

		//Auto Size
		for(i in 0..9) {
			sheet.autoSizeColumn(i)
		}
	}

	private writeTasks(Workbook wb, Map<String, CellStyle> cellStyles, Locale locale) {

		//Header
		List<String> header = [
			messageSource.getMessage('task.req.label', null, locale),
			messageSource.getMessage('task.title.label', null, locale),
			messageSource.getMessage('task.user.label', null, locale),
			messageSource.getMessage('task.status.label', null, locale),
			messageSource.getMessage('task.logs.label', null, locale),
			messageSource.getMessage('task.crs.label', null, locale),
			messageSource.getMessage('task.tags.label', null, locale),
			messageSource.getMessage('task.createDate.label', null, locale),
			messageSource.getMessage('task.updateDate.label', null, locale),
			messageSource.getMessage('task.remark.label', null, locale)
		]

		//Create Sheet
		Sheet sheet = wb.createSheet(messageSource.getMessage('task.label', null, locale))

		//Write Header
		Row headerRow = sheet.createRow(0)
		header.eachWithIndex {it, i ->
			Cell cell = headerRow.createCell(i)
			cell.setCellValue(it)
			cell.setCellStyle(cellStyles.get('title'))
		}


		//Tasks
		List<Task> tasks = Task.list()
		def rowNumber = 1
		tasks.each {
			//Write Data
			Row row = sheet.createRow(rowNumber)
			if(it.getReq()) {
				row.createCell(0).setCellValue(it.getReq())
			}
			if(it.getTitle()) {
				row.createCell(1).setCellValue(it.getTitle())
			}
			if(it.getUser()) {
				row.createCell(2).setCellValue(it.getUser().toString())
			}
			if(it.getStatus()) {
				row.createCell(3).setCellValue(messageSource.getMessage('task.status.'+it.getStatus(), null, locale))
			}
			if(it.getLogs()) {
				StringBuffer sb = new StringBuffer()
				it.getLogs().each {Log log ->
					def message = "[${messageSource.getMessage('log.type.'+log.getType(), null, locale)}] ${log.getProduct().toString()}"
					sb.append(message).append("\n")
				}
				row.createCell(4).setCellValue(sb.toString().trim())
			}
			if(it.getCrs()) {
				StringBuffer sb = new StringBuffer()
				it.getCrs().each {Cr cr ->
					sb.append(cr.toString()).append("\n")
				}
				row.createCell(5).setCellValue(sb.toString().trim())
			}
			if(it.getTags()) {
				StringBuffer sb = new StringBuffer()
				it.getTags().each {Tag tag ->
					sb.append(tag.toString()).append("\n")
				}
				row.createCell(6).setCellValue(sb.toString().trim())
			}
			if(it.getCreateDate()) {
				row.createCell(7).setCellValue(it.getCreateDate().format('yyyy/MM/dd'))
			}
			if(it.getUpdateDate()) {
				row.createCell(8).setCellValue(it.getUpdateDate().format('yyyy/MM/dd'))
			}
			if(it.getRemark()) {
				row.createCell(9).setCellValue(it.getRemark())
			}

			//Set CellStyle
			if(it.isActivate()) {
				//Activated
				for(i in 0..9) {
					Cell cell = row.getCell(i)
					if(!cell) {
						cell = row.createCell(i)
					}
					cell.setCellStyle(cellStyles.get('default'))
				}
			} else {
				//Inactivated
				for(i in 0..9) {
					Cell cell = row.getCell(i)
					if(!cell) {
						cell = row.createCell(i)
					}
					cell.setCellStyle(cellStyles.get('inactivate'))
				}
			}

			//List Wrap
			for(i in 8..9) {
				row.getCell(i).getCellStyle().setWrapText(true)
			}

			rowNumber++
		}

		//Auto Size
		for(i in 0..9) {
			sheet.autoSizeColumn(i)
		}
	}

	private writeCrs(Workbook wb, Map<String, CellStyle> cellStyles, Locale locale) {

		//Header
		List<String> header = [
			messageSource.getMessage('cr.number.label', null, locale),
			messageSource.getMessage('cr.description.label', null, locale),
			messageSource.getMessage('cr.status.label', null, locale),
			messageSource.getMessage('cr.products.label', null, locale)
		]

		//Create Sheet
		Sheet sheet = wb.createSheet(messageSource.getMessage('cr.label', null, locale))

		//Write Header
		Row headerRow = sheet.createRow(0)
		header.eachWithIndex {it, i ->
			Cell cell = headerRow.createCell(i)
			cell.setCellValue(it)
			cell.setCellStyle(cellStyles.get('title'))
		}

		//Crs
		List<Cr> crs = Cr.list()
		def rowNumber = 1
		crs.each {
			//Write Data
			Row row = sheet.createRow(rowNumber)
			if(it.getNumber()) {
				row.createCell(0).setCellValue(it.getNumber())
			}
			if(it.getDescription()) {
				row.createCell(1).setCellValue(it.getDescription())
			}
			if(it.getStatus()) {
				row.createCell(2).setCellValue(messageSource.getMessage('cr.status.'+it.getStatus(), null, locale))
			}
			if(it.getProducts()) {
				StringBuffer sb = new StringBuffer()
				it.getProducts().each {Product product ->
					sb.append(product.toString()).append("\n")
				}
				row.createCell(3).setCellValue(sb.toString().trim())
			}

			//Set CellStyle
			for(i in 0..3) {
				Cell cell = row.getCell(i)
				if(!cell) {
					cell = row.createCell(i)
				}
				cell.setCellStyle(cellStyles.get('default'))
			}

			//List Wrap
			row.getCell(3).getCellStyle().setWrapText(true)

			rowNumber++
		}

		//Auto Size
		for(i in 0..3) {
			sheet.autoSizeColumn(i)
		}

	}

	private writeServices(Workbook wb, Map<String, CellStyle> cellStyles, Locale locale) {

		//Header
		List<String> header = [
			messageSource.getMessage('service.name.label', null, locale),
			messageSource.getMessage('service.description.label', null, locale),
			messageSource.getMessage('service.vendor.label', null, locale)
		]

		//Create Sheet
		Sheet sheet = wb.createSheet(messageSource.getMessage('service.label', null, locale))

		//Write Header
		Row headerRow = sheet.createRow(0)
		header.eachWithIndex {it, i ->
			Cell cell = headerRow.createCell(i)
			cell.setCellValue(it)
			cell.setCellStyle(cellStyles.get('title'))
		}

		//Services
		List<Service> services = Service.list()
		def rowNumber = 1
		services.each {
			//Write Data
			Row row = sheet.createRow(rowNumber)
			if(it.getName()) {
				row.createCell(0).setCellValue(it.getName())
			}
			if(it.getDescription()) {
				row.createCell(1).setCellValue(it.getDescription())
			}
			if(it.getVendor()) {
				row.createCell(2).setCellValue(it.getVendor())
			}

			//Set CellStyle
			for(i in 0..2) {
				Cell cell = row.getCell(i)
				if(!cell) {
					cell = row.createCell(i)
				}
				cell.setCellStyle(cellStyles.get('default'))
			}

			rowNumber++
		}

		//Auto Size
		for(i in 0..2) {
			sheet.autoSizeColumn(i)
		}

	}

	private writePreparing(Workbook wb, Map<String, CellStyle> cellStyles, Locale locale) {

		//Tasks
		List<Task> tasks = Task.findAllByStatusAndActivate('4', true)

		if(tasks) {
			//Task Header
			List<String> taskHeader = [
				messageSource.getMessage('task.req.label', null, locale),
				messageSource.getMessage('task.title.label', null, locale),
				messageSource.getMessage('task.logs.label', null, locale),
				messageSource.getMessage('task.crs.label', null, locale)
			]

			//Cr Header
			List<String> crHeader = [
				messageSource.getMessage('cr.number.label', null, locale),
				messageSource.getMessage('cr.description.label', null, locale),
				messageSource.getMessage('cr.status.label', null, locale)
			]

			//Create Sheet
			Sheet sheet = wb.createSheet(messageSource.getMessage('excel.sheet.preparing.label', null, locale))

			//Write taskHeader
			Row headerRow = sheet.createRow(0)
			taskHeader.eachWithIndex {it, i ->
				Cell cell = headerRow.createCell(i)
				cell.setCellValue(it)
				cell.setCellStyle(cellStyles.get('title'))
			}

			//Write crHeader
			crHeader.eachWithIndex {it, i ->
				Cell cell = headerRow.createCell(i + 5)
				cell.setCellValue(it)
				cell.setCellStyle(cellStyles.get('title'))
			}

			//Crs
			SortedSet<Cr> crs = [] as SortedSet
			tasks.each {
				crs.addAll(it.getCrs())
			}
			crs = crs.unique()

			//Write Tasks
			def rowNumber = 1
			tasks.each {
				//Write Data
				Row row = sheet.createRow(rowNumber)
				if(it.getReq()) {
					row.createCell(0).setCellValue(it.getReq())
				}
				if(it.getTitle()) {
					row.createCell(1).setCellValue(it.getTitle())
				}
				if(it.getLogs()) {
					StringBuffer sb = new StringBuffer()
					it.getLogs().each {Log log ->
						def message = "[${messageSource.getMessage('log.type.'+log.getType(), null, locale)}] ${log.getProduct().toString()}"
						sb.append(message).append("\n")
					}
					row.createCell(2).setCellValue(sb.toString().trim())
				}
				if(it.getCrs()) {
					StringBuffer sb = new StringBuffer()
					it.getCrs().each {Cr cr ->
						sb.append(cr.toString()).append("\n")
					}
					row.createCell(3).setCellValue(sb.toString().trim())
				}

				//Set CellStyle
				for(i in 0..3) {
					Cell cell = row.getCell(i)
					if(!cell) {
						cell = row.createCell(i)
					}
					cell.setCellStyle(cellStyles.get('default'))
				}

				rowNumber++
			}

			//Write Crs
			rowNumber = 1
			crs.each {
				//Write Data
				Row row = sheet.getRow(rowNumber)
				if(!row) {
					row = sheet.createRow(rowNumber)
				}
				if(it.getNumber()) {
					row.createCell(5).setCellValue(it.getNumber())
				}
				if(it.getDescription()) {
					row.createCell(6).setCellValue(it.getDescription())
				}
				if(it.getStatus()) {
					row.createCell(7).setCellValue(messageSource.getMessage('cr.status.'+it.getStatus(), null, locale))
				}

				//Set CellStyle
				for(i in 5..7) {
					Cell cell = row.getCell(i)
					if(!cell) {
						cell = row.createCell(i)
					}
					cell.setCellStyle(cellStyles.get('default'))
				}

				rowNumber++
			}

			//Auto Size
			for(i in 0..7) {
				sheet.autoSizeColumn(i)
			}
		}

	}

	private CellStyle defaultCellStyle(Workbook wb, Font font) {
		CellStyle style = wb.createCellStyle()
		style.setBorderTop(CellStyle.BORDER_THIN)
		style.setBorderBottom(CellStyle.BORDER_THIN)
		style.setBorderLeft(CellStyle.BORDER_THIN)
		style.setBorderRight(CellStyle.BORDER_THIN)
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
		style.setFont(font)

		return style
	}

	private CellStyle titleCellStyle(Workbook wb, Font font) {
		CellStyle style = wb.createCellStyle()
		style.setBorderTop(CellStyle.BORDER_THIN)
		style.setBorderBottom(CellStyle.BORDER_THIN)
		style.setBorderLeft(CellStyle.BORDER_THIN)
		style.setBorderRight(CellStyle.BORDER_THIN)
		style.setAlignment(CellStyle.ALIGN_CENTER)
		style.setFillPattern(CellStyle.SOLID_FOREGROUND)
		style.setFillForegroundColor(IndexedColors.TEAL.getIndex())
		style.setFont(font)

		return style
	}

	private CellStyle inactivateCellStyle(Workbook wb, Font font) {
		CellStyle style = wb.createCellStyle()
		style.setBorderTop(CellStyle.BORDER_THIN)
		style.setBorderBottom(CellStyle.BORDER_THIN)
		style.setBorderLeft(CellStyle.BORDER_THIN)
		style.setBorderRight(CellStyle.BORDER_THIN)
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
		style.setFillPattern(CellStyle.SOLID_FOREGROUND)
		style.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.getIndex())
		style.setFont(font)

		return style
	}

	private Font defaultFont(Workbook wb, Locale locale) {
		Font font = wb.createFont()
		font.setFontName(messageSource.getMessage('default.excel.font.name', null, locale))
		font.setFontHeight(8)
		return font
	}

	private Font titleFont(Workbook wb, Locale locale) {
		Font font = wb.createFont()
		font.setFontName(messageSource.getMessage('default.excel.font.name', null, locale))
		font.setFontHeight(8)
		font.setBoldweight(Font.BOLDWEIGHT_BOLD)
		font.setColor(IndexedColors.WHITE.getIndex())
		return font
	}

	private Font inactivateFont(Workbook wb, Locale locale) {
		Font font = wb.createFont()
		font.setFontName(messageSource.getMessage('default.excel.font.name', null, locale))
		font.setFontHeight(8)
		font.setStrikeout(true)
		return font
	}
}
