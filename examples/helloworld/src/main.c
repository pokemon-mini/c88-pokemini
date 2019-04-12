#include "pm.h"

#include <stdio.h>
#include <string.h>

int main(void)
{
    PRC_MODE = COPY_ENABLE|SPRITE_ENABLE|MAP_ENABLE|MAP_16X12;
    PRC_RATE = RATE_36FPS;
    /*
    prc_map1_lo = (unsigned char)images_frame0;
    prc_map1_mid = (unsigned char)(((unsigned long)images_frame0)>>8);
    prc_map1_hi = (unsigned char)(((unsigned long)images_frame0)>>16);
    prc_map2_lo = (unsigned char)images_frame1;
    prc_map2_mid = (unsigned char)(((unsigned long)images_frame1)>>8);
    prc_map2_hi = (unsigned char)(((unsigned long)images_frame1)>>16);

    PRC_MAP_LO = prc_map1_lo;
    PRC_MAP_MID = prc_map1_mid;
    PRC_MAP_HI = prc_map1_hi;

    PRC_SPR_LO = (unsigned char)(((unsigned long)sprites));
    PRC_SPR_MID = (unsigned char)(((unsigned long)sprites)>>8);
    PRC_SPR_HI = (unsigned char)(((unsigned long)sprites)>>16);
    */
    while(1) {
        
    }
}
