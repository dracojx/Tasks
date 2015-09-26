package draco.tasks

class Req {
	String req
	String title
	String remark
	String cr
	String status
	User user

    static constraints = {
		req(unique:true, nullable:false, blank:false)
		title(nullable:false, blank:false)
		remark(nullable:true, blank:true)
		cr(nullable:true, blank:true)
		status(inList:["w", "d", "c"]) //待开发，开发中，已完成
		user(nullable:false, blank:false)
    }
	
	public String toString() {
		return req
	}
}
