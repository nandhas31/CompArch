;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Studly Caps!
;;=============================================================
;; Name:
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;; string = "TWENTY 1 ten";
;; i = 0;
;; while (string[i] != 0) {
;;   if (i % 2 == 0) {
;;   // should be lowercase
;;     if ('A' <= string[i] <= 'Z') { !('A' > string[i] || 'Z' < string[i])
;;       string[i] = string[i] | 32;
;;     }
;;   } else {
;;   // should be uppercase
;;     if ('a' <= string[i] <= 'z') { !('a' > string[i] || )
;;       string[i] = string[i] & ~32;
;;     }
;;   }
;;   i++;
;; }

.orig x3000

        AND R0, R0, #0 ; initialize i
        ADD R0, R0, #-1
        LD R1, STRING; Base value for the string location
        AND R3, R3, #0 ; Checks for even and odd
       
WHILESTART AND R4, R4, #0
        ADD R0, R0, #1
        ADD R4, R1, R0 ;Current char
        LDR R4, R4, #0
        brz WHILEEND
        AND R3, R0, #1
        brp UPPERCASE
        NOT R5, R4
        ADD R5, R5, #1
        LD R6, UPPERA
        ADD R5, R6, R5
        brp WHILESTART
        NOT R5, R4
        ADD R5, R5, #1
        LD R6, UPPERZ
        ADD R5, R6, R5
        brn WHILESTART
        AND R7, R7, #0
        ADD R7, R7, #15
        ADD R7, R7, #15
        ADD R7, R7, #2
        NOT R7, R7
        NOT R6, R4
        AND R7, R7, R6
        NOT R4, R7
        ADD R5, R1, R0
        STR R4, R5, #0
        brnzp WHILESTART
UPPERCASE NOT R5, R4
        ADD R5, R5, #1
        LD R6, LOWERA
        ADD R5, R6, R5
        brp WHILESTART
        NOT R5, R4
        ADD R5, R5, #1
        LD R6, LOWERZ
        ADD R5, R6, R5
        brn WHILESTART
        AND R7, R7, #0
        ADD R7, R7, #15
        ADD R7, R7, #15
        ADD R7, R7, #2
        NOT R7, R7
        AND R4, R7, R4
        LD R1, STRING
        ADD R5, R1, R0
        STR R4, R5, #0
        brnzp WHILESTART

WHILEEND


HALT

UPPERA .fill x41    ;; A in ASCII
UPPERZ .fill x5A	;; Z in ASCII
LOWERA .fill x61	;; a in ASCII
LOWERZ .fill x7A	;; z in ASCII

STRING .fill x4000
.end

.orig x4000
.stringz "cs"
.end
