
import java.math.BigInteger;
import java.util.*;

import jdk.nashorn.internal.ir.debug.ObjectSizeCalculator.MemoryLayoutSpecification;

public class HigherOrder
{
    interface Fun1<A, B> {
        public B apply(A a);
    }
    
    //(b -> a -> b) -> b -> t a -> b
    interface Fun2<A, B, C> 
    {
        public C apply(A a, B b);
    }

    public static <A,B> B foldl(Fun2<B,A,B> f, B b, List<A> xs){
        B result = b;
        for(A x : xs){
            result = f.apply(result, x);
        }
        return result;
    } 

    //filter :: (a -> Bool) -> [a] -> [a]



    public static <A> List<A> filter(Fun1<A, Boolean> p, List<A> xs)
    {
        List <A> result = new ArrayList<A>();
        for(A x:xs)
        {
            if(p.apply(x))
               result.add(x);    
        }

        return result;
    }


    public static void main(String args[])
    {
        System.out.println("Hello world");
        List <Integer> myList = new ArrayList<Integer>();
        for(int i=1; i<=5; i++)
        {
            myList.add(new Integer(i));
        }
        List <Integer> newList = filter(x -> x % 2 == 0, myList);
        System.out.println(newList);
        
        System.out.println(foldl((x, y) -> x + y, 4, myList));

        //System.out.println(newList2);

        //Integer a = 10;
        //Integer b = 20;
        //System.out.println(a+b);

    }
}