package draco.tasks

class User {
	String username
	String password
	String name
	boolean admin = false
	boolean system = false
	boolean reset = false
	boolean activate = true

    static constraints = {
		username(unique:true, nullable:false, blank:false)
		password(password:true, nullable:false, blank:false)
		name(nullable:false, blank:false)
    }
	
	static mapping = {
		sort "username"
	}
	
	public void setUsername(String username) {
		this.username = username?.trim().toUpperCase()
	}

	public void setName(String name) {
		this.name = name?.trim()
	}

	public String toString() {
		return name
	}
}
