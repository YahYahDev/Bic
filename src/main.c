#include <stdio.h>
#include <string.h>

typedef struct foo{
    int id;
}foo;

typedef struct foo2 foo2;

foo fooNew(int id){
    foo obj = {.id = id};
    return obj;
}


int main(){

}
