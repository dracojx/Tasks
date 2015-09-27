package draco.tasks

class Task {
	String req
	String title
	String remark
	String status
	User user
	SortedSet crs
	SortedSet logs

	static hasMany = [crs: Cr, logs: Log]
	
    static constraints = {
		req(unique:true, nullable:false, blank:false)
		title(nullable:true, blank:true)
		remark(nullable:true, blank:true)
		status(inList:["0", "1", "2", "3", "4"]) //0待开发，1开发中, 2单元，3集成，4发布
		user(nullable:false, blank:false)
    }
	
	public String toString() {
		return req
	}
}
