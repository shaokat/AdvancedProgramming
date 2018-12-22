#include <iostream>
using namespace std;

int main()
{
    for(int x = 1; x<=4; x++)
    {
        for(int y = 5; y>x; y--)
        {
            cout<<"x,y = "<<x<<", "<<y<<endl;
        }
    }


}