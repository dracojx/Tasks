package draco.tasks

class User {
	String username
	String password
	String name
	boolean admin
	boolean edit
	boolean activate

    static constraints = {
		username(unique:true, nullable:false, blank:false)
		password(password:true, nullable:false, blank:false)
		name(nullable:true, blank:true)
    }
	
	public String toString() {
		return name
	}
}
