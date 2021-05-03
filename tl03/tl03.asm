;; Timed Lab 3
;; Student Name:

;; Please read the PDF for full directions.
;; The pseudocode for the program you must implement is listed below; it is also listed in the PDF.
;; If there are any discrepancies between the PDF's pseudocode and the pseudocode below, notify a TA on Piazza quickly.
;; However, in the end, the pseudocode is just an example of a program that would fulfill the requirements specified in the PDF.

;; Pseudocode:
;;
;; ABS(x) {
;;     if (x < 0) {
;;         return -x;
;;     } else {
;;         return x;
;;     }
;; }
;;
;;
;;
;; POW3(x) {
;;     if (x == 0) {
;;         return 1;
;;     } else {
;;         return 3 * POW3(x - 1);
;;     }
;; }
;;
;;
;; MAP(array, length) {
;;     i = 0;
;;     while (i < length) {
;;         element = arr[i];
;;         if (i & 1 == 0) {
;;             result = ABS(element);
;;         } else {
;;             result = POW3(element);
;;         }
;;         arr[i] = result;
;;         i++;
;;     }
;; }

.orig x3000
HALT

STACK .fill xF000

; DO NOT MODIFY ABOVE


; START ABS SUBROUTINE
ABS


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
;Buildup
brzp END
NOT R0, R0;
ADD R0, R0, #1;
;Teardown

END STR R0, R5, 3 ; Put the return value here
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

; END ABS SUBROUTINE




; START POW3 SUBROUTINE
POW3
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

ADD R0, R0, #1
ADD R1, R0, #-2;
brn ENDING1
ADD R0, R0, #-1;

ADD R6, R6, #-1 ;Calls pow3 again 
ADD R0, R0, #-1
STR R0, R6, #0 
JSR POW3
LDR R0, R6, #0
ADD R6, R6, #2

AND R1, R1, #0;
ADD R1, R0, #0;
ADD R0, R0, R0;
ADD R0, R1, R0;


AND R2, R2, #0;
AND R3, R3, #0;
AND R4, R4, #0;


ENDING1
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
; END POW3 SUBROUTINE




; START MAP SUBROUTINE
MAP
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
LDR R0, R5, #4 ;array is loaded to R0
LDR R1, R5, #5 ;len is loaded to R1
AND R2, R2, #0 ;Initialize i
NOT R1, R1;
ADD R1, R1, #1;
WHILESTARTMAP 
ADD R2, R1
brp ENDINGMAP
LDR R3, R0, #0;Element is stored here
AND R4, R4, #0;
AND R4, R2, #1;


brz ABSIT
ADD R6, R6, #-1 ;Calls pow3
ADD R0, R0, #-1
STR R3, R6, #0 
JSR POW3
LDR R4, R6, #0
ADD R6, R6, #2
ADD R3, R0, R1;
STR R4, R0, #0;
brnzp MAPWHILEEND
ABSIT 
ADD R6, R6, #-1 ;Calls pow3 again 
ADD R0, R0, #-1
STR R3, R6, #0 
JSR ABS
LDR R4, R6, #0
ADD R6, R6, #2
ADD R3, R0, R1;
STR R4, R0, #0;
MAPWHILEEND
ADD R2, R2, #1;
ADD R0, R0, #1    
brnzp WHILESTARTMAP 
ENDINGMAP
LDR R4, R5, -5 ; Restore all registers
LDR R3, R5, -4
LDR R2, R5, -3
LDR R1, R5, -2
LDR R0, R5, -1
ADD R6, R5, 0; Restore SP
LDR R5, R6, 1; Restore FP
LDR R7, R6, 2
ADD R6, R6, 3; Pop ra,fp,lv1

    ; !!!!! WRITE YOUR CODE HERE !!!!!



RET
; END MAP SUBROUTINE


; ARRAY FOR TESTING
ARRAY .fill x4000
.end

.orig x4000
.fill -2
.fill 5
.fill 3
.fill 2
.fill -6
.fill 0
.end
