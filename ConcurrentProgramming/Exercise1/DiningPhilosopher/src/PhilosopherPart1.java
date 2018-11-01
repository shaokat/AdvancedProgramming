public class PhilosopherPart1 extends Thread{

    /** The stick to the left of the philosopher */
    private StickPart1 left;

    /** The stick to the right of the philosopher */
    private StickPart1 right;

    /** The number of the philosopher */
    private int num;

    /**
     * Constructor for a philosopher
     *
     * @param num
     *            Number of the philosopher
     * @param left
     *            The left stick
     * @param right
     *            The right sticks
     */
    public PhilosopherPart1(int num, StickPart1 left, StickPart1 right) {
        // your code here
    		this.num = num;
    		this.left = left;
    		this.right = right;
    }

    /**
     * The activity loop of a philosopher
     */
    @Override
    public void run() {
    		while(true)
    		{
    			try {
					think();
					getStick(left);
					getStick(right);
					eat();
					putStick(left);
					putStick(right);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
    			
    		}
    		
    }

    /**
     * Put the stick back on the table
     *
     * @param stick
     *            Stick to be laid back
     */
    	private void putStick(StickPart1 stick) {
    		stick.put();
    	}

    /**
     * Eat spaghetti!
     *
     * @throws InterruptedException
     */
    private void eat() throws InterruptedException {
        System.out.println(getPhilName() + " is eating");
        Thread.sleep(1000);
    }

    /**
     * Take the stick!
     *
     * @param stick
     *            Stick to be taken
     * @throws InterruptedException 
     */
    private void getStick(StickPart1 stick) throws InterruptedException 
    {
    		stick.get();
    }

    /**
     * Think a lot
     *
     * @throws InterruptedException
     */
    private void think() throws InterruptedException {
        System.out.println(getPhilName() + " is thinking");
        Thread.sleep(1000);
    }

    /**
     * The name of the philosopher
     *
     * @return the name
     */
    
    public String getPhilName() {
        return "Philosopher#" + num;
    }

    public static void main(String[] args) {

    		System.out.println("Philosophers Started Working");
        int num = 5;

        if (args.length > 0) {
            num = Integer.parseInt(args[0]);
        }

        StickPart1[] sticks = new StickPart1[num];
        PhilosopherPart1[] phils = new PhilosopherPart1[num];

        for (int i = 0; i < num; ++i) {
            // add Sticks to array
        		sticks[i] = new StickPart1(i);
        }

        for (int i = 0; i < num; ++i) {
            // add Philosophers to array
        		phils[i] = new PhilosopherPart1(i, sticks[i], sticks[(i+1) % num]);
        }
        
        for(int i=0; i<num; ++i)
        {
        		phils[i].start();
        }
    }
    
}
/**
 * Class representing a stick for the dining philosophers
 *
 */
class StickPart1 {

    /** Flag whether this stick is currently used */
    private boolean isUsed;

    /** The number of the stick */
    private int num;

    /**
     * Constructor for a stick
     *
     * @param num
     *            Number of the stick
     */
    public StickPart1(int num) {
    		this.num = num;
    		this.isUsed = false;
    }

    /**
     * Put the stick back on the table. If the stick was already on the table
     * this method has no effect
     */
    public synchronized void  put() 
    {
    		this.isUsed = false;
    		//notify();
    }

    /**
     * Gets the stick from the table. If the stick is currently used, the current
     * thread is suspended until the stick is no longer used.
     * @throws InterruptedException 
     */
    public synchronized void get() throws InterruptedException {
    	while(this.isUsed == true)
    	{
    		Thread.sleep(10);
    	}
    	this.isUsed = true;
    }

    /**
     * Looks for the stick. If the stick is available true is returned, otherwise false.
     *
     * @return true if the stick is available, false otherwise
     */
    public boolean lookFor() {
    		if (isUsed) return false;
    		else return true;
    }

    /**
     * Return the name of the stick
     *
     * @return Name of the stick
     */
    public int  getName() {
    		return this.num;
    }

}

