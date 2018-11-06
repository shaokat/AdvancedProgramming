
package boundedbuffer;

import java.util.LinkedList;

public class BufferN<E> 
{
    private LinkedList<Object> elements;
    int maxSize;
    int numberOfElements;
  
    
    public BufferN(int len) throws IllegalArgumentException
    {
        this.maxSize = len;
        this.numberOfElements = 0;
        this.elements = new LinkedList<Object>();
    }
    
    public synchronized E take()
    {
        if(this.isEmpty()) 
        {
            throw new NullPointerException("Buffer is now Empty");
        }
        else
        {
            E ret = (E) this.elements.getFirst();
            this.elements.removeFirst();
            this.numberOfElements--;
            return ret;
        }
        
        
    }
    
    public synchronized void put(E elem)
    {
        if(this.numberOfElements + 1 > this.maxSize)
        {
            throw new ArrayIndexOutOfBoundsException("I don't allow more values than " + this.maxSize);
        }
        else
        {
            this.numberOfElements++;
            this.elements.add(elem);
        }
        
        
    }
    public synchronized boolean isEmpty()
    {
        return this.numberOfElements == 0;
    }
    
    public static void main(String[] args) {
        // TODO code application logic here
        BufferN<String> ob = new BufferN<String>(5);
        ob.put("Rajib");
        ob.put("Sazib");
        ob.put("Abhishek");
        ob.put("Jumon");
        ob.put("Rizwan");
        String got = ob.take();
        System.out.println(got);
        ob.put("Zaki");
        got = ob.take();
        System.out.println(got);
        
        
    }
    
}
