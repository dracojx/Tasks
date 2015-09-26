package draco.tasks

class Product {
	String itemId
	String title
	String remark
	String mode
	Service sender
	Service receiver
	Adapter source
	Adapter target
	boolean activate
	
	static hasMany = [records: Record]

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
	
	public String toString() {
		return "$itemId($title)"
	}
}
