public class Philosopher extends Thread{

    /** The stick to the left of the philosopher */
    private Stick left;

    /** The stick to the right of the philosopher */
    private Stick right;

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
     *            The right stick
     */
    public Philosopher(int num, Stick left, Stick right) {
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
    	private void putStick(Stick stick) {
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
    private void getStick(Stick stick) throws InterruptedException 
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

        Stick[] sticks = new Stick[num];
        Philosopher[] phils = new Philosopher[num];

        for (int i = 0; i < num; ++i) {
            // add Sticks to array
        		sticks[i] = new Stick(i);
        }

        for (int i = 0; i < num; ++i) {
            // add Philosophers to array
        		phils[i] = new Philosopher(i, sticks[i], sticks[(i+1) % num]);
        }
        
        for(int i=0; i<num; ++i)
        {
        		phils[i].start();
        }
    }

}
