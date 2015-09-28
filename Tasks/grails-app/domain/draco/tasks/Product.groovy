package draco.tasks

class Product implements Comparable {
	String itemId
	String title
	String remark
	String mode
	Service sender
	Service receiver
	Adapter source
	Adapter target
	boolean activate
	SortedSet logs
	
	static hasMany = [logs: Log]

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
	
	public String toString() {
		return "$itemId"
	}

	@Override
	public int compareTo(Object o) {
		return itemId.compareTo(o.itemId)
	}
}
