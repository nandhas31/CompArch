;;=============================================================
;; CS 2110 - Fall 2020
;; Homework 5 - Palindrome
;;=============================================================
;; Name:
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; string = "racecar";
;; len = 0;
;;
;; // to find the length of the string
;; while (string[len] != '\0') {
;;   len = len + 1;
;; }
;;
;; // to check whether the string is a palindrome
;; result = 1;
;; i = 0;
;; while (i < length) {
;;   if (string[i] != string[length - i - 1]) {
;;     result = 0;
;;     break;
;;   }
;;   i = i + 1;
;; }

.orig x3000

;; put your code here

            AND R0, R0, #0 ;Set up to contain the current char 
            AND R2, R2, #0 ;Holds the length of the string
            LD R1, STRING  ;Loads address of the first char 
WHILELENGTH LDR R0, R1, #0 ;Set to the current char 
            brz WHILELENGTHEND
            ADD R1, R1, #1 ;Increments the index and length variable
            ADD R2, R2, #1 
            brnzp WHILELENGTH
            
WHILELENGTHEND
            AND R1, R1, #0 ;Initializes i
            ADD R1, R1, #-1
WHILE2START ADD R1, R1, #1;Increments i
            AND R4, R4, #0
            ADD R4, R4, #1; Resets the result to 1
            LD R0, STRING  ;Loads address of the first char 
            NOT R3, R2     ;Checks that i is less than length
            ADD R3, R3, #1
            ADD R3, R1, R3
            brzp ENDING
            AND R5, R5, #0 ;Holds the value for stringz + length - i - 1
            NOT R5, R1 ;Next three lines set R5
            ADD R5, R5, R2
            ADD R5, R5, R0
            AND R7, R7, #0
            ADD R7, R1, R0
            LDR R5, R5, #0
            LDR R7, R7, #0
            NOT R7, R7
            ADD R7, R7, #1
            ADD R7, R7, R5
            brnp ENDING2
            brz WHILE2START

ENDING      AND R4, R4, #0
            ADD R4, R4, #1
            ST R4, ANSWER
            HALT 
ENDING2     AND R4, R4, #0
            ST R4, ANSWER
            HALT    

ANSWER .blkw 1
STRING .fill x4000
.end

.orig x4000
.stringz "Q"
.end
