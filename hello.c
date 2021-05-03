/**File: hello.c*/
#include <stdio.h>
void printFun(int num);
int main(int argc, char *argv[]){
    char a[] = "String ";
    a[6] = '\0';
    printFun(1);
}
void printFun(const int num){
    printf("%d",num);
}