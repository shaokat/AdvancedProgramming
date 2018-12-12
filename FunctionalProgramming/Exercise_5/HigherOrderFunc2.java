import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class HigherOrderFunc2 
{
    public class MyPair<A, B> {
	
        private A fst;
        private B snd;
        
        public MyPair(A fst, B snd) {
            this.fst = fst;
            this.snd = snd;
        }
        
        public A getFst() {
            return fst;
        }
        
        public B getSnd() {
            return snd;
        }
        
        public void setFst(A a) {
            fst = a;
        }
        
        public void setSnd(B b) {
            snd = b;
        }
    }

    
    interface Function1<A, B, C> 
    {
        public C apply(A a, B b);
    }
    interface Function2<A>
    {
        public Boolean apply(A a);
    }

    //zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
    public <A,B,C> List<C> zipWith(Function1<A, B, C> f, List<A> xs, List<B> ys) 
    {
        List<C> res = new ArrayList<C>();
        int len = xs.size(); // Here size of xs and ys should be the same
        for (int i = 0; i<len; i++) 
        {
            res.add(f.apply(xs.get(i), ys.get(i)));
        }
        return res;
    }

    //partition :: (a -> Bool) -> [a] -> ([a], [a])

    public <A> MyPair<List<A>, List<A>> partition(Function2<A> f, List<A> xs)
    {
        List<A> accepted = new ArrayList<>();
        List<A> rejected = new ArrayList<>();
        
        for(int i=0; i<xs.size(); i++)
        {
            A now = xs.get(i);
            if(f.apply(now))
            {
                accepted.add(now);
            }
            else
            {
                rejected.add(now);
            }
        }

        MyPair<List<A>, List<A>> res = new MyPair(accepted, rejected);

        return res;
        
    }
    
    public static void main(String[] args) 
    {
        List<Integer> a = new ArrayList<Integer>();
        int n = 50;
        for(int i=1; i<=n; i++)
        {
            a.add(new Integer(i));
        }
        HigherOrderFunc2 obj = new HigherOrderFunc2();
        System.out.println("Merging by Adding two Lists using zipWidth :");
        System.out.println(obj.zipWith((x,y) -> x+y, a, a));
        
        
        MyPair<List<Integer>, List<Integer>> mp = obj.partition(x -> x % 3 == 0, a);

        System.out.println("Partition %3 == 0");
        for(int i=0; i<mp.getFst().size(); i++)
        {
            System.out.print(mp.getFst().get(i)+" ");
        }
        System.out.println("");
        System.out.println("Partition %3 /= 0");
        for(int i=0; i<mp.getSnd().size(); i++)
        {
            System.out.print(mp.getSnd().get(i)+" ");
        }
        System.out.println("");


    }
}