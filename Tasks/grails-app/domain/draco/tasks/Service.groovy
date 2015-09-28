package draco.tasks

class Service {
	String name

    static constraints = {
		name(unique:true, nullable:false, blank:false)
    }
	
	public String toString() {
		return name
	}
}
