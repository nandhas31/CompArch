#ifndef MAIN_H
#define MAIN_H

#include "gba.h"

// TODO: Create any necessary structs
struct obstacle {
    int width;
    int height;
    int col;
    int row;
    int direction;
    volatile u16 color;
};
struct player {
    int numDeaths;
    int  row;
    int col;
};
/*
* For example, for a Snake game, one could be:
*
* struct snake {
*   int heading;
*   int length;
*   int row;
*   int col;
* };
*
* Example of a struct to hold state machine data:
*
* struct state {
*   int currentState;
*   int nextState;
* };
*
*/
void delay(int time){
    volatile int n = 0;
    for (int i = 0; n < 8000*time;i++){
        n++;
    }
}
#endif
