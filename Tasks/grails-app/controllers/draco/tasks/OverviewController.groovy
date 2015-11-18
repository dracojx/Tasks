package draco.tasks

class OverviewController {

	def index() {
		def todoList = Task.where{
			activate == true &&
			user == User.get(session.userId) &&
			status in ['0', '1']
		}.order('status', 'desc').order('updateDate', 'desc').findAll()

		def preparingList = Task.findAllByStatusAndActivate('4', true)
		
		def crInstanceList = [] as SortedSet
		
		preparingList.each {
			crInstanceList.addAll(it.getCrs())
		}
		crInstanceList = crInstanceList.unique()

		respond todoList, model:[preparingList: preparingList, crInstanceList: crInstanceList]
	}
}
