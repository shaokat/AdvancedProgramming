
public class startingPoint {
	
	public static void main(String args[])
	{
		System.out.println("Hello world");
		AdderThread obj1 = new AdderThread();
		MultiplierThread obj2 = new MultiplierThread();
		
		obj1.start();
		obj2.start();
		
		try {
			Thread.sleep(50);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		System.out.println("Test Value: " + ResourceData.getInstance().getValue());
		
	}

}
