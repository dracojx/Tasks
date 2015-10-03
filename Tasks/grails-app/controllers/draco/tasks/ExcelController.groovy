package draco.tasks

import org.springframework.web.servlet.support.RequestContextUtils

class ExcelController {
	
	def excelService
	
	def download() {
		response.setContentType('application/vnd.ms-excel')
		response.setHeader('Content-Disposition', 'Attachment;Filename="Products.xlsx"')
		
		Locale locale = RequestContextUtils.getLocale(request)
		excelService.writeExcel(response.outputStream, locale)
	}
}
