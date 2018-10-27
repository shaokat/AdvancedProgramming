/**
 * Class representing a stick for the dining philosophers
 *
 */
public class Stick {

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
    public Stick(int num) {
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
    		notify();
    }

    /**
     * Gets the stick from the table. If the stick is currently used, the current
     * thread is suspended until the stick is no longer used.
     * @throws InterruptedException 
     */
    public synchronized void get() throws InterruptedException {
    		if(this.isUsed == true)
    		{
    			wait();
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
