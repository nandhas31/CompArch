#include <stdio.h>
#include <stdlib.h>
struct node{
    int data;
    struct node *next;
};

void addAtFront(int data, struct node *head){
    if(head == NULL){
        struct node head;
        head.data = data;
        head.next = NULL;
    }
    else{
        struct node* curr = head;
        while (curr->next != NULL){
            curr = curr->next;
        }
        curr -> next = (struct node*)(malloc(sizeof(struct node)));
        curr -> next -> data= data;
        curr -> next -> next = NULL;

            
    }
}
int main(int argc, char* argv[]){
    struct node *head = (struct node*)malloc(sizeof(struct node));
    head -> data = 1;
    head -> next = NULL;
    addAtFront(5,head);
}
//struct node remove(int index){}

void printall(){

}