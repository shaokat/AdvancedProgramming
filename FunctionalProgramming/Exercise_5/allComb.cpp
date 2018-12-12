#include <iostream>
#include <vector>

using namespace std;

vector< vector<int> > addVectors(vector< vector<int> > a, vector< vector<int> > b)
{
    for(int i=0; i<b.size(); i++)
    {
        a.push_back(b[i]);
    }
    return a;
}

vector< vector<int> > gen(vector<int> given, vector<int>cur, int depth)
{
    
    vector< vector<int> > ans;
    if(depth >= 4)
    {
        ans.push_back(cur);
        return ans;   
    }
    ans.push_back(cur);

    for(int i=0; i<given.size(); i++)
    {
        vector<int> newVector;
        newVector = cur;
        newVector.push_back(given[i]);
        ans = addVectors(ans, gen(given, newVector, depth+1));
    }

    return ans;
}

int main()
{
    vector<int> input;
    vector<int> cur;
    cur.clear();
    input.push_back(1);
    input.push_back(2);

    vector< vector<int> > ans = gen(input, cur, 0);
    for(int i=0; i<ans.size(); i++)
    {
        for(int j=0; j<ans[i].size(); j++)
        {
            cout<<ans[i][j]<< " ";
        }
        cout<<endl;
    }



    return 0;
}