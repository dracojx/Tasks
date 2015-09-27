package draco.tasks

class Log implements Comparable{
	String type
	Date updateTime

	static belongsTo = [task: Task, product: Product]
	
    static constraints = {
		type(inList: ["c", "u", "d"]) //新增，修改，删除
    }
	
	public String toString() {
		def user = task?.getUser()
		def time = updateTime.format("yyyy-MM-dd HH:mm:ss")
		return "$task $user, $time"
	}

	@Override
	public int compareTo(Object o) {
		0 - updateTime.compareTo(o.updateTime)
	}
}
