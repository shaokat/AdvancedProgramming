#include <iostream>
#include <string>
using namespace std;


class Person
{
    string name;
    int height;
    int weight;
public:
    Person ()
    {
        name = "unknown";
        height = -1;
        weight = -1;
    }
    Person (string str, int h, int w)
    {
        name = str;
        height = h;
        weight = w;
    }

    void initialize(string str)
    {
        name = str;
    }

    void initialize(string str, int h)
    {
        name = str;
        height = h;
    }

    void initialize(string str, int h, int w)
    {
        name = str;
        height = h;
        weight = w;
    
    }

    void show()
    {
        cout<<"("<<name<<","<<height<<","<<weight<<")"<<endl;
    }
};

int main()
{
    Person *obj = nullptr;
    
    obj = new Person("Rajib", 172, 70);
    obj->show();
    obj->initialize("Sazib");
    obj->show();
    obj->initialize("Jumon",170,65);
    obj->show();


    
    return 0;
}