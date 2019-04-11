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
public class Tree {
    String TopPart (int n)
    {
        String ans = "";
        for(int i = 0; i < n; i++)
        {
            ans += addSpace((n-1)-i); 
            ans += addStar(i * 2 + 1);
            ans += "\n";
        
        }
        return ans;
    }
    String addStar (int n){
        String ret = "";
        for (int i = 0; i < n; i++)
            ret += "*";
        return ret;
    }
    
    String addSpace (int n){
        String result = "";
        for (int i = 0; i < n; i++)
            result += " ";
        return result;
    }
}
