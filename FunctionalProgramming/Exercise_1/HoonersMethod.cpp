#include <iostream> 
using namespace std;

int arr[] = {1, 1, 0, 0, 1};
int n = 5;
int R(int cur, int sum, int Move)
{
	cout<<"Here: cur, sum, move = "<<cur<<", "<<sum<<", "<<Move<<endl;

	if(cur>=4 && Move == 1) return sum;
	
	int ret;
	if(Move == 0)
		ret = R(cur, sum + arr[cur], 1);
	else
		ret = R(cur+1, sum*2, 0);

	return ret;

}


int main()
{
	int ans = R(0, 0, 0);

	cout<<"Hello: "<<ans<<endl;

	return 0;
}