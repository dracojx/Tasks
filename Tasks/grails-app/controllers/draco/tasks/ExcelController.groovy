package draco.tasks

import org.springframework.web.servlet.support.RequestContextUtils

class ExcelController {
	
	def excelService
	
	def index() {
		
	}
	
	def upload() {
		def file = request.getFile('excelFile')
		if(file) {
			InputStream is = file.getInputStream()
			Locale locale = RequestContextUtils.getLocale(request)
			excelService.readExcel(is, locale)
			flash.message = "success"
		} else {
			flash.error = "error"
		}
		
		
		redirect action:'index'
	}
	
	def download() {
		response.setContentType('application/vnd.ms-excel')
		response.setHeader('Content-Disposition', 'Attachment;Filename="Products.xlsx"')
		
		Locale locale = RequestContextUtils.getLocale(request)
		excelService.writeExcel(response.outputStream, locale)
	}
}
