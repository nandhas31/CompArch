#include <stdio.h>
int main(int argc, char *argv[]){
    int i = 123;
    int* j = &i;
    *j = 9890;
    printf("%d\n",*j);
    multiplyByTwo(j);
    printf("%d",i);
}
int multiplyByTwo(int* i){
    *i *= 2;
    return 1;
}
