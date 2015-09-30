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
	
	static mapping = {
		sort "name"
	}
	
	public void setName(String name) {
		this.name = name?.trim()
	}

	public void setDescription(String description) {
		this.description = description?.trim()
	}

	public void setVendor(String vendor) {
		this.vendor = vendor?.trim()
	}

	public String toString() {
		return name
	}
}
