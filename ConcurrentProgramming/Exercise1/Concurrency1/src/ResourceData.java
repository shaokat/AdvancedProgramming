
public class ResourceData 
{
	private static ResourceData instance = new ResourceData();
	int value;
	private ResourceData()
	{
		value = 0;
	}
	
	public static ResourceData getInstance()
	{
		/*
		if(instance == null)
		{
			instance = new ResourceData();
		}
		*/
		
		return instance;
	}
	
	public void setValue(int val)
	{
		this.value = val;
	}
	
	public int getValue()
	{
		return this.value;
	}
	
	public void AddValue()
	{
		this.value+=1;
	}
	public void MultiplyValue()
	{
		this.value*=2;
	}
	
}
