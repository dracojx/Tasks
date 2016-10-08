package tasks

import grails.converters.JSON

class DataController {
	def overview() {
		//TODO
		def task = [
				id:1,
				req: '123',
				status: '1',
				activate:true,
				title:'test',
				updateDate:'2016/10/06'
			]
		render (template: 'overview', model: [task:3, product:5, cr:7, service:8, taskInstanceList:[task]])
	}
}
