#include <stdlib.h>
#include <string.h>
#include <stdio.h>
struct user {
    char *name;
    int id;
};

static struct user *create_user(char *name, int id)
{
    struct user * space = (struct user *) malloc(sizeof(struct user));
    if (space == NULL){
        return space;
    }
    space->name = malloc(sizeof(name));
    strcpy(space->name, name);
    space->id = id;
    return space;
}
static int user_equal(const struct user *user1, const struct user *user2)
{
    if (strcmp(user1->name, user2->name) == 0 && (user1->id == user2->id)){
        return 1;
    }

    return 0;
}

int main(void) {
    struct list
}