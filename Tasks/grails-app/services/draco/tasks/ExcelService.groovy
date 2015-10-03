package draco.tasks

import grails.transaction.Transactional

import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.xssf.usermodel.XSSFWorkbook

@Transactional
class ExcelService {

	def writeExcel(OutputStream out, Map<String, String> sheetsName, 
		Map<String, List<String>> headersNames, Map<String, List<?>> objects) {
		Workbook wb = new XSSFWorkbook()
		
		
		wb.write(out)
		out.close()
	}
		
	private writeProduct(Workbook wb, String sheetName, List<String> headerNames, List<Product> products) {
		Sheet sheet = wb.createSheet(sheetName)
	}
}
