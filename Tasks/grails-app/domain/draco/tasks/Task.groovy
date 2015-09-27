package draco.tasks

class Task {
	String req
	String title
	String remark
	String status
	String stage
	User user

	static hasMany = [crs: Cr]
	
    static constraints = {
		req(unique:true, nullable:false, blank:false)
		title(nullable:false, blank:false)
		remark(nullable:true, blank:true)
		status(inList:["w", "d", "c"]) //待开发，开发中，已完成
		stage(inList:["0", "1", "2", "3"]) //开发，单元，集成，发布
		user(nullable:false, blank:false)
    }
	
	public String toString() {
		return req
	}
}
