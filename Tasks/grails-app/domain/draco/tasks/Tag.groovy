package draco.tasks

class Tag implements Comparable{
	String name

    static constraints = {
		name(unique:true, nullable:false, blank:false)
    }

	public void setName(String name) {
		this.name = name;
	}
	
	public String toString() {
		name
	}

	@Override
	public int compareTo(Object o) {
		name.compareTo(o.name)
	}
	
}
