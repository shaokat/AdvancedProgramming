
public class MultiplierThread extends Thread 
{
	public MultiplierThread()
	{
		
	}
	
	public void run()
	{
		ResourceData obj = ResourceData.getInstance();
		obj.MultiplyValue();
		System.out.println("Done Multiplying");
	}

}
