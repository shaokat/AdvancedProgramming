
public class IntVar {
	
	int i;
    /* Little helper to sleep a period of time */
    private static void sleep(long time) {
        try {
            Thread.sleep(time);
        } catch (InterruptedException e) {
        }
    }
    
    public IntVar()
    {
    		this.i = 0;
    }

    public int getValue() {
        return i;
    }

    public void setValue(int value) {
    		this.i = value;
    }

    public void doubleIt() {
    		this.i *= 2;
    }

    public void incIt() {
    		this.i += 1;
    }
    
    public void syncDoubleIt() {
    		synchronized (this) {
    			this.i *= 2;
    		}
    }

    public void syncIncIt() {
    		synchronized (this) {
    			this.i += 1;
    		}
    }

    /**
     * Execute two @link{Runnable}s concurrently, whereas the second one is
     * started after a given delay
     *
     * @param v
     *            IntVar both Runnables operate on
     *
     * @param pause
     *            Interval to sleep before starting the second Runnable
     *
     * @param r1
     *            first Runnable to be executed
     * @param r2
     *            second Runnable to be executed
     */
    private static void test(final IntVar v, long pause, Runnable r1,
            Runnable r2) {
    	
			Thread t1 = new Thread(r1);
	        Thread t2 = new Thread(r2);
	        t1.start();
	        sleep(pause);
	        t2.start();

	        // wait for both to finish
	        try {
	            t1.join();
	            t2.join();
	        } catch (InterruptedException e) {
	        }

	        // prints the value
	        System.out.println(v.getValue());

    }

    // Yields 0
    private static void zero() {

        final IntVar v = new IntVar();

        // You might want to adjust this value
        long sleepingTime = 0;

        Runnable r1 = new Runnable() {
            public void run() {
                // your code
            		v.incIt();
            }
        };

        Runnable r2 = new Runnable() {
            public void run() {
                // your code
            		v.doubleIt();
            }
        };

        test(v, sleepingTime, r1, r2);
    }

    // Yields 1
    private static void one() {

        final IntVar v = new IntVar();

        // You might want to adjust this value
        long sleepingTime = 100;

        Runnable r1 = new Runnable() {
            public void run() {
                // your code
            		v.doubleIt();
            }
        };

        Runnable r2 = new Runnable() {
            public void run() {
                // your code
            		v.incIt();
            }
        };

        test(v, sleepingTime, r1, r2);
    }

    // Yields 2
    private static void two() {

        final IntVar v = new IntVar();

        // You might want to adjust this value
        long sleepingTime = 100;

        Runnable r1 = new Runnable() {
            public void run() {
                // your code
            		v.incIt();
            }
        };

        Runnable r2 = new Runnable() {
            public void run() {
                // your code
            		v.doubleIt();
            }
        };

        test(v, sleepingTime, r1, r2);
    }

    // Same as zero, but with synchronization; yields 2
    private static void syncZero() {

        final IntVar v = new IntVar();

        // You might want to adjust this value
        long sleepingTime = 0;

        Runnable r1 = new Runnable() {
            public void run() {
                // your code
            		v.syncIncIt();
            }
        };

        Runnable r2 = new Runnable() {
            public void run() {
                // your code
            		v.syncDoubleIt();
            }
        };

        test(v, sleepingTime, r1, r2);
    }

    public static void main(String[] args) {
        zero();
        one();
        two();
        syncZero();
    }

}

