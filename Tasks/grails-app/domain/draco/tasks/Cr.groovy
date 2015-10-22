package draco.tasks

class Cr implements Comparable{
	String number
	String description
	String status = "1"
	SortedSet products
	
	static hasMany = [products: Product]

    static constraints = {
		number(unique:true, nullable:false, blank:false)
		description(nullable:true, blank:true)
		status(inList:["1", "2", "3", "4", "5"]) //1开发，2单元，3集成，4待发布，5发布
    }
	
	static mapping = {
		sort "number"
	}
	
	public void setNumber(String number) {
		this.number = number?.trim().toUpperCase()
	}

	public void setDescription(String description) {
		this.description = description?.trim()
	}

	public String toString() {
		return number
	}

	@Override
	public int compareTo(Object o) {
		number.compareToIgnoreCase(o.number)
	}
}
