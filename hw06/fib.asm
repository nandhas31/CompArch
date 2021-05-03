;;=======================================
;; CS 2110 - Spring 2020
;; HW6 - Recursive Fibonacci Sequence
;;=======================================
;; Name: Nandha Sundaravadivel
;;=======================================

;; In this file, you must implement the 'fib' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseLL' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of Fibonacci number: integer n
;;
;; Pseudocode:
;; fib(int n) {
;;     if (n == 0) {
;;         return 0;
;;     } else if (n == 1) {
;;         return 1;
;;     } else {
;;         return fib(n - 1) + fib(n - 2);
;;     }
;; }
fib

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

AND R0, R0, #0
LDR R0, R5, #4 ;Param is loaded to R0
ADD R1, R0, #-1
brnz ENDING ;Goes to ending if param is 0 or 1 and returns param value
ADD R6, R6, #-1 ;Calls fib again 
ADD R0, R0, #-1
STR R0, R6, #0 
JSR fib
LDR R2, R6, #0
ADD R6, R6, #2


ADD R6, R6, #-1 ;Calls fib again -1
ADD R0, R0, #-1
STR R0, R6, #0 
JSR fib
LDR R3, R6, #0
ADD R6, R6, #2
ADD R0, R3, R2
ENDING
STR R0, R5, 3 ; Put the return value here
LDR R4, R5, -5;Restore all registers
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
