package draco.tasks

class Adapter {
	String name

    static constraints = {
		name(unique:true, nullable:false, blank:false)
    }
	
	static mapping = {
		sort "name"
	}
	
	public void setName(String name) {
		this.name = name?.trim()
	}


	public String toString() {
		return name
	}
}
