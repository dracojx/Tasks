package draco.tasks

class Cr {
	String id
	String description
	String stage
	
	static hasMany = [products: Product]

    static constraints = {
		id(unique:true, nullable:false, blank:false)
		description(nullable:true, blank:true)
		stage(inList:["1", "2", "3"]) //单元，集成，发布
    }
	
	public String toString() {
		return id
	}
}
