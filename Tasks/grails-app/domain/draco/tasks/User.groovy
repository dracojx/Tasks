package draco.tasks

class User {
	String username
	String password
	String name
	boolean admin = false
	boolean edit = false
	boolean activate = false

    static constraints = {
		username(unique:true, nullable:false, blank:false)
		password(password:true, nullable:false, blank:false)
		name(nullable:true, blank:true)
    }
	
	public String toString() {
		return name
	}
}
