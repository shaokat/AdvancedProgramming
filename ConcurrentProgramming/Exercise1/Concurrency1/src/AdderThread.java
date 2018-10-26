
public class AdderThread extends Thread 
{
	public AdderThread()
	{
		
	}
	
	public void run()
	{
		ResourceData obj = ResourceData.getInstance();
		obj.AddValue();
		System.out.println("Done Adding");
	}
}
