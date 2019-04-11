/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sazibtest;

/**
 *
 * @author RajibTheKing
 */
public class SazibTest {

    /**
     * @param args the command line arguments
     */
    


    public static void main(String[] args) {
        int list [] = new int [20];
        for (int i = 0; i <20; i++)
            list [i] = 1 + i;
        SazibTest obj = new SazibTest();
        Tree objTree = new Tree();
        System.out.println("Last value = " + obj.MyLast(list));
        System.out.println("Fib Value = " + obj.fib(0, 1, 6));
        System.out.println("Tree : \n" + objTree.TopPart(4));
        
    }
    
    public int MyLast (int getlist []){
        int sz = getlist.length;
        int ans = getlist[sz-1];
        return ans;
    }
    
    public int fib (int f1,int f2, int n){
        if (n == 0)
            return f1;
        if (n == 1)
            return f2;
        int ret =  fib (f2, f2+f1, n-1);
        System.out.println("Now ret = (f1,f2) "+  f1+"," + f2);
        return ret;
        
    }
    
}
/*
list [o] = 0
i 2
list [2] = 2
i 4
list [4] = 4

fibCal :: Int -> Int -> Int -> Int
fibCal f1 f2 n | n == 0 = f1
               | n == 1 = f2
               | otherwise = fibCal f2 (f2+f1) (n-1)


*/