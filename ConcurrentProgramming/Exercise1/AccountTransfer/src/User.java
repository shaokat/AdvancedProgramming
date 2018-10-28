import java.text.DecimalFormat;
import java.util.Random;

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
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Random rand = new Random();
			//int  n = rand.nextInt(50) + 1;
			int r;
			while(true)
			{
				r = rand.nextInt(numberOfUser);
				if(r != this.num) break;
			}
			User fromUser = this;
			User toUser = usr[r];
			int op = rand.nextInt(3);
			
			double amount = (100 - 0) * rand.nextDouble();
			amount =Double.parseDouble(new DecimalFormat("##.##").format(amount));
			
			//System.out.println("Test random Amount: " + amount);
			if(op == 0)
			{
				System.out.println("User #"+this.num + " --> Deposit Amount " + amount);
				this.acnt.deposit(amount);
			}
			else if(op == 1)
			{
				double ret = fromUser.acnt.safeTransfer(amount);
				toUser.acnt.deposit(ret);
				System.out.println("Trasfer Amount " + amount + "--> From "+fromUser.getUserName() + "   To "+toUser.getUserName());
				
			}
			else
			{

				double ret = this.acnt.safeWithdraw(amount);
				System.out.println("User #"+this.num + " --> Withdraw Amount " + ret);
			}
		}
	}
	
	public static int numberOfUser = 10;
	public static User usr[] = new User[numberOfUser];
	
	public static void main(String args[])
	{

		Account account[] = new Account[numberOfUser];

		
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
