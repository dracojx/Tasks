package tasks

class User {
	
	String username
	String password
	String name
	String role = '2'
	Boolean reset = true
	Boolean enabled = false

    static constraints = {
		username(unique:true, blank:false, nullable:false)
		password(blank:false, nullable:false)
		name(blank:false, nullable:false)
		role(inList:['0', '1', '2']) //System, Administrator, Normal
    }
}
