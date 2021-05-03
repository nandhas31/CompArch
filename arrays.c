#include <stdio.h>
int getFourthElement(int* arr){
    return arr[4];
}
int main(int argc, char *argv[]){
    int numbers[] = {0,1,2,4,5};

    printf("%d", getFourthElement(numbers));
}
