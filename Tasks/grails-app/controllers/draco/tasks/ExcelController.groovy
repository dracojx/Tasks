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
			def errors = excelService.readExcel(is, locale, session.userId)
			if(errors.isEmpty()) {
				flash.message = message(code:'default.import.successed.message')
			} else {
				flash.errors = errors
			}
		} else {
			flash.errors = [message(code:'default.import.failed.message')]
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
