#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct dog {
    int age;
    char name[4];
} ;
int main(int argc, char ** argv){
    char * i = "hello";
    printf("%s\n", (int *)i + 1);
    struct dog * Doggy = malloc(sizeof(struct dog));
    Doggy->age = 7;
    Doggy = realloc(Doggy, sizeof(struct dog) + 10);
    strcpy(Doggy->name,"jar" );
    printf("Hello %s, you are %i years old", Doggy->name, Doggy->age);

}
