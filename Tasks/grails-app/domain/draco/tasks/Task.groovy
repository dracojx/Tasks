package draco.tasks

class Task {
	String req
	String title
	String remark
	String status = "0"
	User user
	boolean activate = true
	SortedSet crs
	SortedSet logs
	SortedSet tags

	static hasMany = [crs: Cr, logs: Log, tags: Tag]
	
    static constraints = {
		req(unique:true, nullable:false, blank:false)
		title(nullable:true, blank:true)
		remark(nullable:true, blank:true)
		status(inList:["0", "1", "2", "3", "4"]) //0待开发，1开发中, 2单元，3集成，4发布
		user(nullable:false, blank:false)
    }
	
	static mapping = {
		sort "req"
	}
	
	public void setReq(String req) {
		this.req = req?.trim().toUpperCase()
	}

	public void setTitle(String title) {
		this.title = title?.trim()
	}

	public void setRemark(String remark) {
		this.remark = remark?.trim()
	}

	public String toString() {
		return req
	}
}
