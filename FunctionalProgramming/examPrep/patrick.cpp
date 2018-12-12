#include <iostream> 
#include <string>
using namespace std;


bool isPrime (long long n)
{


    for(long long i=2; i*i <=n; i++)
    {
        if(n%i == 0) return false;
    }

    return true;

}

int main()
{

    //body

  /*
    string s1; // text
    cout<<"Enter a text: ";
    getline(cin, s1);
    //cout <<"Your name is: "<<s1<<endl;

    for(int i=0; i<100; i++)
    {
        cout<< i+1<<". "<< s1 <<endl;
    }

    */

    /*
    Prime numbers is called 
    3 is prime 
    11 is prime number 

    331 is prime or not? 

    3331 984214747 
    
    4565465113216541
    */


   //9133


   //while(true)
   {
        for(int i=2; i<10000; i++)
        {
            if(isPrime(i) == true)
            {
                cout<<i<<", ";
            }
        }
   }
    //body end



    return 0;
}