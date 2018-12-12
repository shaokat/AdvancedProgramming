#include <iostream>
#include <stdio.h>
using namespace std;

#define SZ 1000000

int primes[SZ];

bool flag[SZ];


int Sieve()
{
    for(int i=0; i<SZ; i++)
        flag[i] = true;
    flag[0] = flag[1] = false;

    int k=0;
    for(int i=2; i<SZ; i++)
    {
        if(flag[i])
        {
            primes[k++] = i;
            for(int j=i+i; j<SZ; j+=i)
            {
                flag[j] = false;
            }
        }
    }

    cout<<"Check: "<<k<<" --> "<<primes[k-1]<<endl;
    return k;
}


int main()
{
    freopen("output.txt", "w+", stdout);
    int len = Sieve();
    for(int i=4; i<100; i+=2)
    {
        int temp = i;
        cout<<temp<<": ";
        bool notFound = true;
        for(int j=0; j<len; j++)
        {
            int p1 = primes[j];
            int p2 = temp - p1;
            if(flag[p2] == true)
            {
                cout<<"  ("<<p1<<","<<p2<<")";
                notFound = false;
                
            }
        }
        if(notFound) cout<<"Not found for "<<temp<<endl;
        cout<<endl;
    }

    return 0;
}

