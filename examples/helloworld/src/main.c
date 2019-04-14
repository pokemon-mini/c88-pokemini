#include "pm.h"

#include <stdint.h>

#include "hello_tiles.h"

uint8_t free_time;

int main(void)
{
    uint8_t i, keys;
    
    PRC_MODE = COPY_ENABLE|SPRITE_ENABLE|MAP_ENABLE|MAP_16X12;
    PRC_RATE = RATE_36FPS;

    PRC_MAP = hello_tiles;

    for (i=0; i<16*12; i++) {
        TILEMAP[i] = i;
    }
    
    for(;;) {
        TMR1_OSC = 0x11; // Use Oscillator 2 (31768Hz)
        TMR1_SCALE = 0x08 | 0x02; // Scale 2 (8192 Hz)
        TMR1_CTRL = 0x06; // Enable timer 2 at 0
        wait_vsync();
        TMR1_CTRL = 0; // Pause timer
        free_time = 255-TMR1_CNT_L;
        
        keys = ~KEY_PAD;
        if ((keys & KEY_UP) && (PRC_SCROLL_Y > 0)) {
            PRC_SCROLL_Y--;
        } else if ((keys & KEY_DOWN) && (PRC_SCROLL_Y < 31)) {
            PRC_SCROLL_Y++;
        }
        if ((keys & KEY_LEFT) && (PRC_SCROLL_X > 0)) {
            PRC_SCROLL_X--;
        } else if ((keys & KEY_RIGHT) && (PRC_SCROLL_X < 31)) {
            PRC_SCROLL_X++;
        }
    }
}
