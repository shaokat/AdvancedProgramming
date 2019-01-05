#include <iostream>
#include <vector>
using namespace std;

#define sz 5000100
 
int prime[1000000];
bool flag[sz+1000];
unsigned long long ans[5000100];


void sieve()
{
    int i, j, k=-1, r;
    for(i=3;i<=sz;i+=2)
        flag[i]=true;
    flag[2]=true;
    prime[++k]=2;
 
 
    for(i=3;i<sz;i+=2)
    {
 
        if(flag[i])
        {
            prime[++k]=i;
            if(sz/i>=i)
            {
                r=i*2;
                for(j=i*i;j<sz;j+=r)
                    flag[j]=false;
            }
        }
    }
 
    cout<<prime[k]<<" "<<k<<endl;
 
}

vector< pair<int,int> > factorization(int n)
{
    long long temp = n;
    vector< pair<int,int> > ret;
    for(int i=0; (long long) prime[i]*prime[i]<=temp; i++)
    {
        if(temp % prime[i] == 0)
        {
            int cnt = 0;
            while(temp>0 && temp % prime[i] == 0)
            {
                cnt ++;
                temp/=prime[i];
            }

            //cout<<"Adding: "<<prime[i]<<", cnt = "<<cnt<<endl;
            pair<int,int> newPair(prime[i], cnt);
            ret.push_back(newPair);

        }
        
    }
    if(temp>1)
    {
       // cout<<"Finally: "<<temp<<", cnt = "<<1<<endl;
        pair<int,int> newPair(temp, 1);
        ret.push_back(newPair);
    }

    return ret;
}

vector<int> concat(vector<int> a, vector<int> b)
{
    for(int i=0; i<b.size(); i++)
    {
        a.push_back(b[i]);
    }
    return a;
}


vector<int> divisors(int cur, int fact,  vector< pair<int,int> > &factors)
{
    if (cur >= factors.size())
    {
        vector<int> ret;
        ret.push_back(fact);
        return ret;
    }

    vector<int> ret;
    int now = 1;
    ret = divisors(cur + 1, fact, factors);
    for(int i=0; i<factors[cur].second; i++)
    {
        now = now * factors[cur].first;
        ret = concat(ret, divisors(cur + 1, fact * now, factors));
        
        //ret = concat(ret, divisors(cur + 1, fact * now, factors));
    }
    return ret;
}

int sumList(vector<int> xs)
{
    int ret = 0;
    for(int i=0; i<xs.size(); i++)
    {
        ret += xs[i];
    }
    return ret;
}

int main()
{
    sieve();
    int n;
    while(true)
    {
        cin>>n;
        for(int i=1; i<=n; i++)
        {
            vector< pair<int,int> > factors = factorization(i);
            vector<int> divs = divisors(0, 1, factors);
            int sum = sumList(divs);
            if(sum - i == i)
            {
                cout<<"Perfect: "<<i<<endl;
            }
        }
        
        
        /*
        cout<<"Got: "<<divs.size()<<endl;
        for(int i=0; i<factors.size(); i++)
        {
            cout<< factors[i].first <<", "<<factors[i].second<<endl; 
        }

        for(int i=0; i<divs.size(); i++)
        {
            cout<<divs[i]<<endl;
        }
        */

    }

    return 0;

}

/*
2 2
3 2

2^0 * 3^0
2^0 * 3^1
2^0 * 3^2
2^1 * 3^0
*/