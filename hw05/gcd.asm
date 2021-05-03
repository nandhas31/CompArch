;;=============================================================
;; CS 2110 - Spring 2021
;; Homework 5 - Iterative GCD
;;=============================================================
;; Name:
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; a = (argument 1);
;; b = (argument 2);
;; ANSWER = 0;
;;
;; while (a != b) {
;;   if (a > b) {
;;     a = a - b;
;;   } else {
;;     b = b - a;
;;   }
;; }
;; ANSWER = a;

.orig x3000

;; put your code here
LD R1, A 
LD R2, B
AND R3, R3, #0 ;Checks to see if A and B are equal
NOT R3, R2
ADD R3, R3, #1
ADD R3, R3, R1
brz ENDING
AGAIN
AND R3, R3, #0 
NOT R3, R2      ; Check for truth value of if statement
ADD R3, R3, #1
ADD R3, R3, R1
brnz ELSEC
AND R3, R3, #0  ; Do what is in if statement
NOT R3, R2
ADD R3, R3, #1
ADD R1, R1, R3
br ENDELSE
ELSEC
AND R3, R3, #0 ;Do what is in else statement
NOT R3, R1
ADD R3, R3, #1
ADD R2, R2, R3
ENDELSE
AND R3, R3, #0 ;Checks to see if A and B are equal
NOT R3, R2
ADD R3, R3, #1
ADD R3, R3, R1
brnp AGAIN
ENDING
ST R1, ANSWER
HALT

A .fill 20
B .fill 19

ANSWER .blkw 1

.end
