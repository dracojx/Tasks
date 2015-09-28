package draco.tasks

class Service {
	String name
	String description
	String vendor

    static constraints = {
		name(unique:true, nullable:false, blank:false)
		description(nullable:true, blank:true)
		vendor(nullable:true, blank:true)
    }
	
	public String toString() {
		return name
	}
}
