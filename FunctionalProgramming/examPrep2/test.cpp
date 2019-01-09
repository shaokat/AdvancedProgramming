#include <iostream>
#include <vector> 

using namespace std;

vector<int> arr{2, 5, 15, 23, 29}; 
vector<int> arr2{2, 5, 15, 23, 29, 30, 35, 40, 45, 46, 47, 50, 52};

//--> 2 + 5 + 15 + 100 + 23 + 29 = 174
// 2 ta continuously 5 100
// 3 ta continuously 5 300
// 4 ta contiuously  5 1000
//vector<int> vect{ 10, 20, 30 };



//2, 5, 15, 23, 29
int rec(int cnt, int curIndex, vector<int> vals)
{
    //0 5 {2, 5, 15, 23, 29}
    if(curIndex == vals.size())
    {
        return 0;
    }

    int curValue = vals[curIndex];  //29
    if(curValue % 5 == 0)
    {
        cnt ++; //2
    }
    else
    {
        cnt = 0;
    }
    
    int bonus = 0;

    if(cnt == 2) bonus = 100;
    if(cnt == 3) bonus = 300;
    if(cnt == 4) bonus = 1000;

    return bonus + curValue + rec(cnt, curIndex+1, vals);


}

int main()
{
    int ans = rec(0, 0, arr2);
    cout << ans<<endl;
    return 0;
}