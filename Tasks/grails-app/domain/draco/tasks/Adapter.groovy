package draco.tasks

class Adapter {
	String name

    static constraints = {
		name(unique:true, nullable:false, blank:false)
    }
	
	public String toString() {
		return name
	}
}
