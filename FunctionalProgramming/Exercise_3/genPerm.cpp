#include <iostream>
#include <string>
#include <vector>
#include <map>
using namespace std;


vector<string> vectorAdd(vector<string> v1, vector<string> v2)
{
	map<string, bool> mp;
	for(int i=0; i<v1.size(); i++)
	{
		mp[v1[i]] = true;
	}
	for(int i=0; i<v2.size(); i++)
	{
		if(mp[v2[i]] == false)
			v1.push_back(v2[i]);
	}
	return v1;
}

vector<string> genPermutation(string str, string temp)
{
	if(str.size() == 0)
	{
		vector<string> v;
		v.push_back(temp);
		return v;
	}
	vector<string> ret;

	for(int i=0; i<str.size(); i++)
	{
		string ss = str;
		string tempToSend = temp+str[i];
		ss.erase(i, 1);
		ret = vectorAdd(ret, genPermutation(ss, tempToSend));
	}
	return ret;

}



int main()
{
	string str;
	while(true)
	{
		cout<<"Enter a string: ";
		cin>>str;
		vector<string> ans = genPermutation(str, "");
		cout<<"Total Perms: "<<ans.size()<<endl;
		for(int i=0; i<ans.size(); i++)
		{
			cout<<ans[i]<<endl;
		}	
	}
	

	return 0;
}

/*
a b c d 
b a c d

    a            b             c

b      c	  a     c        a   b
        

c      b      c     a        b   a
*/






