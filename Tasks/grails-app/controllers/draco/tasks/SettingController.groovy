package draco.tasks

import org.springframework.web.servlet.support.RequestContextUtils

class SettingController {
	
	def excelService

    def index() { }

	def upload() {
		if(params.excelFile) {
			def file = request.getFile('excelFile')
			if(!file.isEmpty()) {
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
		} else {
			flash.errors = [message(code:'default.import.failed.message')]
		}
		
		redirect action:'index'
	}

	def download() {
		def filename = message(code:'default.download.filename') + "_${new Date().format('yyyyMMddHHmmssSSS')}.xlsx"
		response.setCharacterEncoding('utf-8')
		response.setContentType('application/vnd.ms-excel')
		response.setHeader('Content-Disposition', "Attachment;Filename='$filename'")
		
		Locale locale = RequestContextUtils.getLocale(request)
		excelService.writeExcel(response.outputStream, locale)
	}
}
