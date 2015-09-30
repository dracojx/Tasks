package draco.tasks

class Product implements Comparable {
	String itemId
	String title
	String remark
	String mode = "a"
	Service sender
	Service receiver
	Adapter source
	Adapter target
	boolean activate = true
	SortedSet logs
	SortedSet tags
	
	static hasMany = [logs: Log, tags: Tag]

    static constraints = {
		itemId(unique:true, nullable:false, blank:false)
		title(nullable:true, blank:true)
		remark(nullable:true, blank:true)
		mode(inList:["a", "s"])
		sender(nullable:true, blank:true)
		receiver(nullable:true, blank:true)
		source(nullable:true, blank:true)
		target(nullable:true, blank:true)
    }
	
	static mapping = {
		sort "itemId"
	}
	
	public void setItemId(String itemId) {
		this.itemId = itemId?.trim().toUpperCase()
	}

	public void setTitle(String title) {
		this.title = title?.trim()
	}

	public void setRemark(String remark) {
		this.remark = remark?.trim()
	}

	public String toString() {
		return "$itemId"
	}

	@Override
	public int compareTo(Object o) {
		return itemId.compareTo(o.itemId)
	}
}
