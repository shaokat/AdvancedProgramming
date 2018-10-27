
public class User extends Thread 
{
	int num;
	Account acnt;
	public User(int num, Account acnt)
	{
		this.num = num;
		this.acnt = acnt;
	}
	
	public String getUserName()
	{
		return "User:" + num;
	}
	public double getCurrentBalance()
	{
		return acnt.getBalance();
	}
	
	public void run()
	{
		while(true)
		{
			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	
	public static void main(String args[])
	{
		int numberOfUser = 3;
		Account account[] = new Account[numberOfUser];
		User usr[] = new User[numberOfUser];
		
		for(int i=0; i<numberOfUser; i++)
		{
			account[i] = new Account(8829.0);
		}
		
		for(int i=0; i<numberOfUser; i++)
		{
			usr[i] = new User(i, account[i]);
		}
		
		for(int i=0; i<numberOfUser; i++)
		{
			usr[i].start();
		}
		
		while(true)
		{
			try {
				Thread.sleep(5000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			for(int i=0; i<numberOfUser; i++)
			{
				System.out.println(usr[i].getUserName() + "  Balance: " + usr[i].getCurrentBalance());
			}
		}
	}
}
