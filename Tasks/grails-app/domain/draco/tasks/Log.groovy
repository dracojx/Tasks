package draco.tasks

class Log {
	String type
	Task task
	Date updateTime

	static belongsTo = [product: Product]
	
    static constraints = {
		type(inList: ["c", "u", "d"]) //新增，修改，删除
		task(nullable:true, blank:true)
    }
	
	public String toString() {
		def user = task?.getUser()
		return "$task $user,$updateTime"
	}
}
