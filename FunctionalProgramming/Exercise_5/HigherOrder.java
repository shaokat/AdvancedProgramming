import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class HigherOrder {
    
    // interface for a unary function
    interface Fun1<A, B> {
        public B apply(A a);
    }
    
    // interface for a binary function
    interface Fun2<A, B, C> {
        public C apply(A a, B b);
    }
    
    // filter a list using the given predicate
    public static <A> List<A> filter(Fun1<A, Boolean> p, List<A> xs) {
        List<A> res = new ArrayList<A>();
        for (A x : xs) {
            if(p.apply(x)) {
                res.add(x);
            }
        }
        return res;
    }
    
    // fold a list with the given binary function
    public static <A, B> B foldl(Fun2<B, A, B> f, B z, List<A> xs) {
        B res = z;
        for (A x : xs) {
            res = f.apply(res, x);
        }
        return res;
    }
    
    // fold a list with the given binary function
    public static <A, B> B foldlFun1(Fun1<B, Fun1<A, B>> f, B z, List<A> xs) {
        B res = z;
        for (A x : xs) {
            res = f.apply(res).apply(x);
        }
        return res;
    }

    public static void main(String[] args) {
        List<Integer> a = new ArrayList<>(Arrays.asList(1,2,3,4,5,6,7,8,9,10));
        
        System.out.println("All even numbers in the range 1 to 10:");
        System.out.println(filter(x -> x % 2 == 0, a));
        
        System.out.println("The product of the numbers 1 to 10:");
        System.out.println(foldl((z, x) -> z * x, 1, a));

        System.out.println(foldlFun1(z -> (x -> z * x), 1, a));
    }
}