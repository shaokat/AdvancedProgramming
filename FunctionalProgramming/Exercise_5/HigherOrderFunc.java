import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class HigherOrderFunc 
{
    interface Function1<A, B> 
    {
        public B apply(A a);
    }

    interface Function2<A, B, C> 
    {
        public C apply(A a, B b);
    }
    
    public static <A> List<A> filter(Function1<A, Boolean> p, List<A> xs) 
    {
        List<A> res = new ArrayList<A>();
        for (A x : xs) {
            if(p.apply(x)) {
                res.add(x);
            }
        }
        return res;
    }
    
    public static <A, B> B foldl(Function2<B, A, B> f, B z, List<A> xs) 
    {
        B res = z;
        for (A x : xs) {
            res = f.apply(res, x);
        }
        return res;
    }
    
    public static void main(String[] args) 
    {
        List<Integer> a = new ArrayList<Integer>();
        int n = 100;
        for(int i=1; i<=n; i++)
        {
            a.add(new Integer(i));
        }

        System.out.println("All numbers divisible by 3 in the range 1 to "+n+":");
        System.out.println(filter(x -> x % 3 == 0, a));
        
        System.out.println("Sum of 1 to "+n+":");
        System.out.println(foldl((x, y) -> x + y, 0, a));
       

        List<BigInteger> b = new ArrayList<BigInteger>();
        for(int i=1; i<=n; i++)
        {
            b.add(new BigInteger(String.valueOf(i)));
        }
        
        System.out.println("Product of 1 to "+n+":");
        System.out.println(foldl((x, y) -> x.multiply(y) , new BigInteger("1"), b));

    }
}