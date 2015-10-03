package draco.tasks

import grails.transaction.Transactional

import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.usermodel.IndexedColors
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.xssf.usermodel.XSSFWorkbook

@Transactional
class ExcelService {
	
	def messageSource
	
	def writeExcel(OutputStream out, Locale locale) {
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
		
		wb.write(out)
		out.close()
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
					def message = messageSource.getMessage('task.logs.log', 
						[
							messageSource.getMessage('log.type.'+log.getType(), null, locale),
							log.getProduct().toString()
						] as Object[], locale)
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
