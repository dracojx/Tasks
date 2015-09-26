package draco.tasks

class Record {
	String type
	Req req
	Date updateTime

	static belongsTo = [product: Product]
	
    static constraints = {
		type(inList: ["c", "u", "d"]) //新增，修改，删除
		req(nullable:true, blank:true)
    }
	
	public String toString() {
		def user = req?.getUser()
		return "$req $user,$updateTime"
	}
}
