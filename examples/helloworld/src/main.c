#include "pm.h"

#include <stdint.h>

#include "hello_tiles.h"

int main(void)
{
    uint16_t i;
    
    PRC_MODE = COPY_ENABLE|SPRITE_ENABLE|MAP_ENABLE|MAP_16X12;
    PRC_RATE = RATE_36FPS;

    PRC_MAP_LO = (unsigned long)(hello_tiles) & 0xff;
    PRC_MAP_MID = ((unsigned long)(hello_tiles) >> 8) & 0xff;
    PRC_MAP_HI = ((unsigned long)(hello_tiles) >> 16) & 0xff;

    for (i=0; i<24*16; i++) {
        TILEMAP[i] = i;
    }

    
    
    while(1) {
        
    }
}
