package draco.tasks

class Cr implements Comparable{
	String number
	String description
	String status
	SortedSet products
	
	static hasMany = [products: Product]

    static constraints = {
		number(unique:true, nullable:false, blank:false)
		description(nullable:true, blank:true)
		status(inList:["1", "2", "3", "4"]) //0开发，1单元，2集成，3发布
    }
	
	static mapping = {
		sort number: "desc"
	}
	
	public String toString() {
		return number
	}

	@Override
	public int compareTo(Object o) {
		number.compareTo(o.number)
	}
}
