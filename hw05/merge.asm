;;=============================================================
;; CS 2110 - Spring 2020
;; Homework 5 - Array Merge
;;=============================================================
;; Name:
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; x = 0;
;; y = 0;
;; z = 0;
;; while (x < LENGTH_X && y < LENGTH_Y) {     Demorgan's = !(x >= LENGTH_X || y >= LENGTH_Y)
;;   if (ARR_X[x] <= ARR_Y[y]) {
;;     ARR_RES[z] = ARR_X[x];
;;     z++;
;;     x++;
;;   } else {
;;     ARR_RES[z] = ARR_Y[y];
;;     z++;
;;     y++;
;;   }
;; }
;; while(x < ARRX.length) {
;;   ARR_RES[z] = ARR_X[x];
;;   z++;
;;   x++;
;; }
;; while (y < ARRY.length) {
;;   ARR_RES[z] = ARR_Y[y];
;;   z++;
;;   y++;
;; }



.orig x3000
        AND R0, R0, #0 ;; x = 0;
        AND R1, R1, #0 ;; y = 0;
        AND R2, R2, #0 ;; z = 0;
        AND R7, R7, #0 ;; 
        AND R3, R3, #0
        AND R4, R4, #0
        LD R7, ARR_RES ; x4200
        LD R6, ARR_Y ; x4100
        LD R5, ARR_X ; x4000
WHILESTART AND R3, R3, #0 ; Check for while statement
        AND R3, R3, #0
        LD R3, LENGTH_X
        NOT R3, R3
        ADD R3, R3, #1
        ADD R3, R3, R0
        brzp WHILEEND; Breaks out of while loop if x >= LENGTH_X
        AND R3, R3, #0
        LD R3, LENGTH_Y
        NOT R3, R3
        ADD R3, R3, #1
        ADD R3, R3, R1
        brzp WHILEEND ;Breaks out of while loop if y >= LENGTH_Y
        AND R3, R3, #0 ;if statement
        AND R4, R4, #0
        LDR R3, R5, 0 ; R3 = ARR_X[x]
        AND R4, R4, #0
        LDR R4, R6, 0 ; R6 = ARR_Y[y]
        NOT R4, R4 ;Subtract ARR_Y[y] from R4 = ARR_X[x]  
        ADD R4, R4, #1
        ADD R4, R4, R3
        brnz IF1
                         ; If statement is false, add the first element of ARR_Y to result 
        AND R3, R3, #0
        AND R4, R4, #0
        LDR R3, R6, #0
        STR R3, R7, #0
        ADD R1, R1, #1 ;Increment y and z
        ADD R2, R2, #1
        ADD R6, R6, #1 ;Increment y and z addresses
        ADD R7, R7, #1
        brnzp ENDIF1
IF1      ; If statement is true, add the first element of ARR_X to result 
        AND R3, R3, #0
        AND R4, R4, #0
        LDR R3, R5, #0
        STR R3, R7, #0
        ADD R0, R0, #1 ;Increment x and z
        ADD R2, R2, #1
        ADD R5, R5, #1 ;Increment x and z addresses
        ADD R7, R7, #1
ENDIF1  brnzp WHILESTART

WHILEEND 
WHILE2START AND R3, R3, #0
        LD R3, LENGTH_X
        NOT R3, R3
        ADD R3, R3, #1
        ADD R3, R3, R0
        brzp WHILE2END
        AND R3, R3, #0
        AND R4, R4, #0
        LDR R3, R5, #0
        STR R3, R7, #0
        ADD R0, R0, #1 ;Increment x and z
        ADD R2, R2, #1
        ADD R5, R5, #1 ;Increment x and z addresses
        ADD R7, R7, #1
        brnzp WHILE2START

WHILE2END
WHILE3START AND R3, R3, #0
        LD R3, LENGTH_Y
        NOT R3, R3
        ADD R3, R3, #1
        ADD R3, R3, R1
        brzp WHILE3END
        AND R3, R3, #0
        AND R4, R4, #0
        LDR R3, R6, #0
        STR R3, R7, #0
        ADD R1, R1, #1 ;Increment y and z
        ADD R2, R2, #1
        ADD R6, R6, #1 ;Increment y and z addresses
        ADD R7, R7, #1
        brnzp WHILE3START

WHILE3END
HALT

ARR_X      .fill x4000
ARR_Y      .fill x4100
ARR_RES    .fill x4200

LENGTH_X   .fill 5
LENGTH_Y   .fill 7
LENGTH_RES .fill 12

.end

.orig x4000
.fill 1
.fill 5
.fill 10
.fill 11
.fill 12
.end

.orig x4100
.fill 3
.fill 4
.fill 6
.fill 9
.fill 15
.fill 16
.fill 17
.end
