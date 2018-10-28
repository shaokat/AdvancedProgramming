public class Account {

    private double balance;

    public Account(double initialDeposit) {
        balance = initialDeposit;
    }

    public synchronized double getBalance() {
        return balance;
    }

    public synchronized void deposit(double amount) {
        balance += amount;
    }
    
    public synchronized double transfer(double amount)
    {
    		this.balance -= amount;
    		return amount;
    }
    
    public synchronized double safeWithdraw(double amount)
    {
    		if(this.balance >= amount)
    		{
    			this.balance -= amount;
    			return amount;
    		}
    		
    		return 0.0;
    } 
    
    public synchronized double safeTransfer(double amount)
    {
    		if(this.balance >= amount)
    		{
    			this.balance -= amount;
    			return amount;
    		}
    		
    		return 0.0;
    }
}
