package sources;

public class Person {
	
	public String name;
	private int rate = 0;

	public void incRate(){
		rate++;
	}
	
	public int getRate() {
		return rate;
	}		
}
