;;=============================================================
;; CS 2110 - Spring 2020
;; Homework 6 - Reverse Linked List
;;=============================================================
;; Name: Nandha Sundaravadivel
;;============================================================

;; In this file, you must implement the 'reverseLL' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseLL' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of reverseLL: Node head
;;
;; reverseLL(Node head) {
;;     // note that a NULL address is the same thing as the value 0
;;     if (head == NULL) {
;;         return NULL;
;;     }
;;     if (head.next == NULL) {
;;         return head;
;;     }
;;     Node tail = head.next;
;;     Node newHead = reverseLL(tail);
;;     tail.next = head;
;;     head.next = NULL;
;;     return newHead;
;; }
reverseLL

ADD R6, R6, -4 ; Allocate space for stack
STR R7, R6, 2 ; Save return Addr
STR R5, R6, 1 ; Save old FP
ADD R5, R6, 0; Copy SP to FP
ADD R6, R6, -5; Room for registers
STR R0, R5, -1
STR R1, R5, -2 
STR R2, R5, -3
STR R3, R5, -4
STR R4, R5, -5 ;R6 is pointing here

AND R2, R2, #0
AND R0, R0, #0
LDR R0, R5, #4 ;Checks if the head is null, head is stored in R2
brz ENDING

ADD R2, R2, R0
LDR R1, R0, #0 ;Checks if head.next is null, tail is stored R1
brz ENDING

ADD R6, R6, #-1 ;Calls reverseLL again on head.next
STR R1, R6, #0 
JSR reverseLL
LDR R2, R6, #0 ;Stores newHead in R2
ADD R6, R6, #2

STR R0, R1, #0
AND R1, R1, #0
STR R1, R0, #0

ENDING
STR R2, R5, 3 ; Put the return value here
LDR R4, R5, -5 ; Restore all registers
LDR R3, R5, -4
LDR R2, R5, -3
LDR R1, R5, -2
LDR R0, R5, -1
ADD R6, R5, 0; Restore SP
LDR R5, R6, 1; Restore FP
LDR R7, R6, 2
ADD R6, R6, 3; Pop ra,fp,lv1

RET

;; used by the autograder
STACK .fill xF000
.end

;; The following is an example of a small linked list that starts at x4000.
;;
;; The first number (offset 0) contains the address of the next node in the
;; linked list, or zero if this is the final node.
;;
;; The second number (offset 1) contains the data of this node.
.orig x4000
.fill x4008
.fill 5
.end

.orig x4008
.fill x4010
.fill 12
.end

.orig x4010
.fill 0
.fill -7
.end
