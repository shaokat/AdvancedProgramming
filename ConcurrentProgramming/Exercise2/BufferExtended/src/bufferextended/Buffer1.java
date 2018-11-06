/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bufferextended;

/**
 *
 * @author RajibTheKing
 */
import java.util.concurrent.TimeoutException;

/**
 * Single element buffer with synchronization.
 * 
 * @author FortProg team
 * 
 * @param <E>
 *            Type of the element
 */
public class Buffer1<E> {

	// element + empty flag
	private E content;
	private boolean empty;

	// synchronization objects
	private Object r = new Object();
	private Object w = new Object();

	public Buffer1() {
		empty = true;
	}

	public Buffer1(E content) {
		this.content = content;
		empty = false;
	}

	/**
	 * take the element from the buffer; suspends on an empty buffer.
	 * 
	 * @return element of the buffer
	 * @throws InterruptedException
	 */
	public E take() throws InterruptedException {
		synchronized (r) {
			while (empty) {
				r.wait();
			}
			synchronized (w) {
				empty = true;
				w.notify();
				return content;
			}
		}
	}

	/**
	 * put an element into the buffer; suspends on a full buffer
	 * 
	 * @param o
	 *            Object to put into
	 * @throws InterruptedException
	 */
	public void put(E o) throws InterruptedException {
		synchronized (w) {
			while (!empty) {
				w.wait();
			}
			synchronized (r) {
				content = o;
				empty = false;
				r.notify();
			}
		}
	}

	/**
	 * Return whether the buffer is empty
	 * 
	 * @return true if empty
	 */
	public boolean isEmpty() {
		return empty;
	}

	/**
	 * Read the element from the buffer without emptying it; suspends on an
	 * empty buffer.
	 * 
	 * @return element of the buffer
	 * @throws InterruptedException
	 */
	public E read() throws InterruptedException {
            synchronized (r) {
                if (isEmpty()) 
                {
                    throw new InterruptedException();
                }
                else 
                {
                    synchronized (w) {
                      return this.content;
                    }
                }
                
            }
	}

	/**
	 * Try to put an element into the buffer; succeeds only for an empty buffer
	 * 
	 * @param elem
	 *            Element to put into
	 * @return true if successful
	 */
	public boolean tryPut(E elem) {
        
            synchronized (w) {
                synchronized (r) {
                    if (isEmpty()) {
                        this.content = elem;
                        empty = false;
                        return true;
                    } else {
                        return false;
                    }

                }
            }

        }

	/**
	 * Overwrite the element in the buffer, even if if the buffer is empty
	 * 
	 * @param elem
	 *            Element to overwrite with
	 */
	public void overwrite(E elem) {
            synchronized (w) {
                synchronized (r) {
                    this.content = elem;
                }
            }
	}

	/**
	 * take with timeout. The timeout mechanism has to be handcrafted as there
	 * is no way to detect whether a wait() was left because of a timeout or a
	 * notify().
	 * 
	 * @param timeout
	 *            Maximum time to wait in milliseconds
	 * @return
	 * @throws InterruptedException
	 * @throws TimeoutException
	 *             if a timeout occurred
	 */
	public E take(long timeout) throws InterruptedException, TimeoutException {
            synchronized (r) {
                long startTime = System.currentTimeMillis();
                while(!isEmpty())
                {
                    Thread.sleep(1);
                    long now = System.currentTimeMillis();
                    if(now - startTime > timeout) throw new TimeoutException();
                }
                synchronized (w) {
                    this.empty = true;
                    return this.content;
                }
            }
	
	}
        
        public static void main(String args[])
        {
            System.out.println("Solved Conceptually");
        }
}

