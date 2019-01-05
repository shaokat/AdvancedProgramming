#include <iostream>
using namespace std;


int gcd(int x , int y)
{
    if (y == 0)
      return x;
    else
      return gcd (y,(x % y));
}

int main()
{
    int val1 = 12;
    int val2 = 9;
    int ans = gcd(val1, val2);
    cout<<"Answer is: "<<ans<<endl;
    return 0;
}