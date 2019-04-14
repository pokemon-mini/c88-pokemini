#ifndef _PM_H
#define _PM_H

#define _BV(bit) ((unsigned char)(1<<(bit)))

/* REGISTERS */

#define REG_BASE	        0x2000

/* Seconds timer */
#define SEC_CTRL          (*(volatile unsigned char *) (REG_BASE+0x08))
#define SEC_CNT           (*(volatile unsigned int *) (REG_BASE+0x09))
#define SEC_CNT_LO        (*(volatile unsigned char *) (REG_BASE+0x09))
#define SEC_CNT_MID       (*(volatile unsigned char *) (REG_BASE+0x0A))
#define SEC_CNT_HI        (*(volatile unsigned char *) (REG_BASE+0x0B))

/* Timer 1 */
#define TMR1_SCALE        (*(volatile unsigned char *) (REG_BASE+0x18))
#define TMR1_OSC          (*(volatile unsigned char *) (REG_BASE+0x19))

#define TMR1_CTRL         (*(volatile unsigned int *) (REG_BASE+0x30))
#define TMR1_CTRL_L       (*(volatile unsigned char *) (REG_BASE+0x30))
#define TMR1_CTRL_H       (*(volatile unsigned char *) (REG_BASE+0x31))
#define TMR1_PRE          (*(volatile unsigned int *) (REG_BASE+0x32))
#define TMR1_PRE_L        (*(volatile unsigned char *) (REG_BASE+0x32))
#define TMR1_PRE_H        (*(volatile unsigned char *) (REG_BASE+0x33))
#define TMR1_PVT          (*(volatile unsigned int *) (REG_BASE+0x34))
#define TMR1_PVT_L        (*(volatile unsigned char *) (REG_BASE+0x34))
#define TMR1_PVT_H        (*(volatile unsigned char *) (REG_BASE+0x35))
#define TMR1_CNT          (*(volatile unsigned int *) (REG_BASE+0x36))
#define TMR1_CNT_L        (*(volatile unsigned char *) (REG_BASE+0x36))
#define TMR1_CNT_H        (*(volatile unsigned char *) (REG_BASE+0x37))

/* Timer 2 */
#define TMR2_SCALE        (*(volatile unsigned char *) (REG_BASE+0x1A))
#define TMR2_OSC          (*(volatile unsigned char *) (REG_BASE+0x1B))

#define TMR2_CTRL         (*(volatile unsigned int *) (REG_BASE+0x38))
#define TMR2_CTRL_L       (*(volatile unsigned char *) (REG_BASE+0x38))
#define TMR2_CTRL_H       (*(volatile unsigned char *) (REG_BASE+0x39))
#define TMR2_PRE          (*(volatile unsigned int *) (REG_BASE+0x3A))
#define TMR2_PRE_L        (*(volatile unsigned char *) (REG_BASE+0x3A))
#define TMR2_PRE_H        (*(volatile unsigned char *) (REG_BASE+0x3B))
#define TMR2_PVT          (*(volatile unsigned int *) (REG_BASE+0x3C))
#define TMR2_PVT_L        (*(volatile unsigned char *) (REG_BASE+0x3C))
#define TMR2_PVT_H        (*(volatile unsigned char *) (REG_BASE+0x3D))
#define TMR2_CNT          (*(volatile unsigned int *) (REG_BASE+0x3E))
#define TMR2_CNT_L        (*(volatile unsigned char *) (REG_BASE+0x3E))
#define TMR2_CNT_H        (*(volatile unsigned char *) (REG_BASE+0x3F))

/* 256 Hz Timer */
#define TMR256_CTRL       (*(volatile unsigned char *) (REG_BASE+0x40))
#define TMR256_CNT        (*(volatile unsigned char *) (REG_BASE+0x41))

/* Timer 3 */
#define TMR3_SCALE        (*(volatile unsigned char *) (REG_BASE+0x1C))
#define TMR3_OSC          (*(volatile unsigned char *) (REG_BASE+0x1D))

#define TMR3_CTRL         (*(volatile unsigned int *) (REG_BASE+0x48))
#define TMR3_CTRL_L       (*(volatile unsigned char *) (REG_BASE+0x48))
#define TMR3_CTRL_H       (*(volatile unsigned char *) (REG_BASE+0x49))
#define TMR3_PRE          (*(volatile unsigned int *) (REG_BASE+0x4A))
#define TMR3_PRE_L        (*(volatile unsigned char *) (REG_BASE+0x4A))
#define TMR3_PRE_H        (*(volatile unsigned char *) (REG_BASE+0x4B))
#define TMR3_PVT          (*(volatile unsigned int *) (REG_BASE+0x4C))
#define TMR3_PVT_L        (*(volatile unsigned char *) (REG_BASE+0x4C))
#define TMR3_PVT_H        (*(volatile unsigned char *) (REG_BASE+0x4D))
#define TMR3_CNT          (*(volatile unsigned int *) (REG_BASE+0x4E))
#define TMR3_CNT_L        (*(volatile unsigned char *) (REG_BASE+0x4E))
#define TMR3_CNT_H        (*(volatile unsigned char *) (REG_BASE+0x4F))

/* System */
#define SYS_CTRL1         (*(volatile unsigned char *)(REG_BASE+0x00))
#define SYS_CTRL2         (*(volatile unsigned char *)(REG_BASE+0x01))
#define SYS_CTRL3         (*(volatile unsigned char *)(REG_BASE+0x02))
#define SYS_BATT          (*(volatile unsigned char *)(REG_BASE+0x10))
#define KEY_PAD           (*(volatile unsigned char *)(REG_BASE+0x52))
#define CART_BUS          (*(volatile unsigned char *)(REG_BASE+0x53))
#define IO_DIR            (*(volatile unsigned char *)(REG_BASE+0x60))
#define IO_DATA           (*(volatile unsigned char *)(REG_BASE+0x61))
#define LCD_CTRL          (*(volatile unsigned char *)(REG_BASE+0xFE))
#define LCD_DATA          (*(volatile unsigned char *)(REG_BASE+0xFF))

#define KEY_A             _BV(0)
#define KEY_B             _BV(1)
#define KEY_C             _BV(2)
#define KEY_UP            _BV(3)
#define KEY_DOWN          _BV(4)
#define KEY_LEFT          _BV(5)
#define KEY_RIGHT         _BV(6)
#define KEY_POWER         _BV(7)


/* IRQs */
#define IRQ_PRI1          (*(volatile unsigned char *)(REG_BASE+0x20))
#define IRQ_PRI2          (*(volatile unsigned char *)(REG_BASE+0x21))
#define IRQ_PRI3          (*(volatile unsigned char *)(REG_BASE+0x22))
#define IRQ_ENA1          (*(volatile unsigned char *)(REG_BASE+0x23))
#define IRQ_ENA2          (*(volatile unsigned char *)(REG_BASE+0x24))
#define IRQ_ENA3          (*(volatile unsigned char *)(REG_BASE+0x25))
#define IRQ_ENA4          (*(volatile unsigned char *)(REG_BASE+0x26))
#define IRQ_ACT1          (*(volatile unsigned char *)(REG_BASE+0x27))
#define IRQ_ACT2          (*(volatile unsigned char *)(REG_BASE+0x28))
#define IRQ_ACT3          (*(volatile unsigned char *)(REG_BASE+0x29))
#define IRQ_ACT4          (*(volatile unsigned char *)(REG_BASE+0x2A))

// IRQ priority bit definitions
#define PRI1_PRC(x)       ((x&0x3)<<6)
#define PRI1_TIM2(x)      ((x&0x3)<<4)
#define PRI1_TIM1(x)      ((x&0x3)<<2)
#define PRI1_TIM3(x)      ((x&0x3)<<0)

#define PRI2_TIM256(x)    ((x&0x3)<<6)
#define PRI2_CART(x)      ((x&0x3)<<4)
#define PRI2_KEY(x)       ((x&0x3)<<2)

#define PRI3_IRSHOCK(x)   ((x&0x3)<<0)

// Handy helpers for IRQ priority
#define PRI_PRC(x)        IRQ_PRI1 &= ~(0x3<<6); \
                          IRQ_PRI1 |= (x&0x3)<<6;

#define PRI_TIM2(x)       IRQ_PRI1 &= ~(0x3<<4); \
                          IRQ_PRI1 |= (x&0x3)<<4;

#define PRI_TIM1(x)       IRQ_PRI1 &= ~(0x3<<2); \
                          IRQ_PRI1 |= (x&0x3)<<2;

#define PRI_TIM3(x)       IRQ_PRI1 &= ~(0x3<<0); \
                          IRQ_PRI1 |= (x&0x3)<<0;

#define PRI_TIM256(x)     IRQ_PRI2 &= ~(0x3<<6); \
                          IRQ_PRI2 |= (x&0x3)<<6;

#define PRI_CART(x)       IRQ_PRI2 &= ~(0x3<<4); \
                          IRQ_PRI2 |= (x&0x3)<<4;

#define PRI_KEY(x)        IRQ_PRI2 &= ~(0x3<<2); \
                          IRQ_PRI2 |= (x&0x3)<<2;

#define PRI_IRSHOCK(x)    IRQ_PRI3 &= ~(0x3<<0); \
                          IRQ_PRI3 |= (x&0x3)<<0;

// IRQ_ENA1/IRQ_ACT1 registers
#define IRQ1_PRC_COMPLETE  _BV(7) // 0x03
#define IRQ1_DIV_OVF       _BV(6) // 0x04
#define IRQ1_TIM2_HI_UF    _BV(5) // 0x05
#define IRQ1_TIM2_LO_UF    _BV(4) // 0x06
#define IRQ1_TIM1_HI_UF    _BV(3) // 0x07
#define IRQ1_TIM1_LO_UF    _BV(2) // 0x08
#define IRQ1_TIM3_HI_UF    _BV(1) // 0x09
#define IRQ1_TIM3_PIVOT    _BV(0) // 0x0A

// IRQ_ENA2/IRQ_ACT2 registers
#define IRQ2_32HZ          _BV(5) // 0x0B
#define IRQ2_8HZ           _BV(4) // 0x0C
#define IRQ2_2HZ           _BV(3) // 0x0D
#define IRQ2_1HZ           _BV(2) // 0x0E
#define IRQ2_CART_EJECT    _BV(1) // 0x13
#define IRQ2_CART          _BV(0) // 0x14

// IRQ_ENA3/IRQ_ACT3 registers
#define IRQ3_KEYPOWER      _BV(7) // 0x15
#define IRQ3_KEYRIGHT      _BV(6) // 0x16
#define IRQ3_KEYLEFT       _BV(5) // 0x17
#define IRQ3_KEYDOWN       _BV(4) // 0x18
#define IRQ3_KEYUP         _BV(3) // 0x19
#define IRQ3_KEYC          _BV(2) // 0x1A
#define IRQ3_KEYB          _BV(1) // 0x1B
#define IRQ3_KEYA          _BV(0) // 0x1C

// IRQ_ENA4/IRQ_ACT4 registers
#define IRQ4_IR_RECV       _BV(7) // 0x0F
#define IRQ4_SHOCK         _BV(6) // 0x10


/* Audio */
#define AUD_CTRL       (*(volatile unsigned char *)(REG_BASE+0x70))
#define AUD_VOL        (*(volatile unsigned char *)(REG_BASE+0x71))

/* PRC */
#define PRC_MODE       (*(volatile unsigned char *)(REG_BASE+0x80))
#define PRC_RATE       (*(volatile unsigned char *)(REG_BASE+0x81))
#define PRC_MAP        (*(volatile void _far **) (REG_BASE+0x82))
#define PRC_MAP_LO     (*(volatile unsigned char *)(REG_BASE+0x82))
#define PRC_MAP_MID    (*(volatile unsigned char *)(REG_BASE+0x83))
#define PRC_MAP_HI     (*(volatile unsigned char *)(REG_BASE+0x84))
#define PRC_SCROLL_X   (*(volatile unsigned char *)(REG_BASE+0x86))
#define PRC_SCROLL_Y   (*(volatile unsigned char *)(REG_BASE+0x85))
#define PRC_SPR        (*(volatile void _far **) (REG_BASE+0x87))
#define PRC_SPR_LO     (*(volatile unsigned char *)(REG_BASE+0x87))
#define PRC_SPR_MID    (*(volatile unsigned char *)(REG_BASE+0x88))
#define PRC_SPR_HI     (*(volatile unsigned char *)(REG_BASE+0x89))
#define PRC_CONT       (*(volatile unsigned char *)(REG_BASE+0x8A))

#define MAP_INVERT      _BV(0)
#define MAP_ENABLE      _BV(1)
#define SPRITE_ENABLE   _BV(2)
#define COPY_ENABLE     _BV(3)

#define MAP_12X16       (0<<4)  // 96*128 pixels
#define MAP_16X12       (1<<4)  // 128*96 pixels
#define MAP_24X8        (2<<4)  // 192*64 pixels
#define MAP_24X16       (3<<4)  // 192*128 pixels

#define RATE_24FPS      (0<<1)  // 72Hz/3
#define RATE_12FPS      (1<<1)  // 72Hz/6
#define RATE_8FPS       (2<<1)  // 72Hz/9
#define RATE_6FPS       (3<<1)  // 72Hz/12
#define RATE_36FPS      (4<<1)  // 72Hz/2
#define RATE_18FPS      (5<<1)  // 72Hz/4
//#define RATE_12FPS      (6<<1)  // 72Hz/6
#define RATE_9FPS       (7<<1)  // 72Hz/8

#define TILEMAP           ((volatile unsigned char *)(0x1360))

typedef volatile struct {
    volatile unsigned char x;
    volatile unsigned char y;
    volatile unsigned char tile;
    volatile unsigned char ctrl;
} oam_sprite_t;

#define OAM               ((oam_sprite_t *)(0x1300))
#define OAM_FLIPH         _BV(0)
#define OAM_FLIPV         _BV(1)
#define OAM_INVERT        _BV(2)
#define OAM_ENABLE        _BV(3)

/* CONSTANTS */


#define TIMER1 0
#define TIMER2 1
#define TIMER3 2
#define CLK_CPU_2MHZ    0
#define CLK_CPU_500KHZ  1
#define CLK_CPU_125KHZ  2
#define CLK_CPU_62500HZ 3
#define CLK_CPU_31250HZ 4
#define CLK_CPU_15625HZ 5
#define CLK_CPU_3906HZ  6
#define CLK_CPU_976HZ   6

_inline void wait_vsync(void) {
    IRQ_ACT1 = IRQ1_PRC_COMPLETE;
    while (!(IRQ_ACT1 & IRQ1_PRC_COMPLETE));
}


#endif /* PM_H */
