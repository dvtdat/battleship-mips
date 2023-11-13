#
# CO2003 BATTLESHIP
#
# HK231 - CO2003 Computer Architecture Assignment (11-12/2023)
# Ho Chi Minh City University of Technology - VNUHCM
#
# Student: Doan Viet Tien Dat, 2252141, dat.doanviettien@hcmut.edu.vn
# Lecturer: Pham Quoc Cuong - Faculty of Computer Science and Engineering
#
#	GitHub repository: github.com/dvtdat/battleship-mips
#
 
.data
  frameBuffer:  .space 0x20000   # 256 wide x 128 high pixels
  circleSprite: .word 0x0060abd6, 0x00000000, 0x00000000, 0x0060abd6, 0x0060abd6, 0x0060abd6, 0x0060abd6, 0x00000000, 0x00000000, 0x0060abd6,
                      0x00000000, 0x00ff0000, 0x00ff0000, 0x00000000, 0x0060abd6, 0x0060abd6, 0x00000000, 0x00ff0000, 0x00ff0000, 0x00000000,
                      0x00000000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00000000, 0x00000000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00000000,
                      0x0060abd6, 0x00000000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00000000, 0x0060abd6,
                      0x0060abd6, 0x0060abd6, 0x00000000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00000000, 0x0060abd6, 0x0060abd6,
                      0x0060abd6, 0x0060abd6, 0x00000000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00000000, 0x0060abd6, 0x0060abd6,
                      0x0060abd6, 0x00000000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00000000, 0x0060abd6,
                      0x00000000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00000000, 0x00000000, 0x00ff0000, 0x00ff0000, 0x00ff0000, 0x00000000,
                      0x00000000, 0x00ff0000, 0x00ff0000, 0x00000000, 0x0060abd6, 0x0060abd6, 0x00000000, 0x00ff0000, 0x00ff0000, 0x00000000,
                      0x0060abd6, 0x00000000, 0x00000000, 0x0060abd6, 0x0060abd6, 0x0060abd6, 0x0060abd6, 0x00000000, 0x00000000, 0x0060abd6,

.text

### DRAW BACKGROUND SECTION
  la  $t0, frameBuffer            # load frame buffer address
  li  $t1, 32768                  # save 256 x 128 pixels
  li  $t2, 0x0060abd6             # load background color
l1:
  sw    $t2, 0($t0)                 # store current bit on the map to be the same value as $t2 (background color)
  addi  $t0, $t0, 4               # advance to next pixel position in display
  addi  $t1, $t1, -1              # decrement number of pixels
  bnez  $t1, l1                   # repeat while the number of pixels is not zero

### DRAW SPRITE SECTION
  la  $t0, frameBuffer            # load frame buffer address
  la  $t7, circleSprite           # load circle sprite address
  li  $t1, 20                     # x-coordinate
  li  $t2, 20                     # y-coordinate
  li  $t3, 10                     # size of the sprite

  mul $t1, $t1, 256               # convert x-coordinate to row number
  add $t1, $t1, $t2               # add y-coordinate to get the pixel position
  sll $t1, $t1, 2                 # multiply by 4 to get the byte address
  add $t0, $t0, $t1               # add to the base address of the frame buffer

  li  $t5, 0                      # counter for rows
l2:
  li  $t6, 0                      # counter for columns
l3:
  lw   $t4, 0($t7)                # load pixel from sprite
  sw   $t4, 0($t0)                # draw pixel

  addi $t0, $t0, 4                # advance to next pixel position in display
  addi $t7, $t7, 4                # advance to next pixel in sprite
  addi $t6, $t6, 1                # increment column counter
  blt  $t6, $t3, l3               # repeat for each column

  addi $t0, $t0, 1024              # advance to next row in display
  sll  $t8, $t3, 2
  sub  $t0, $t0, $t8              # subtract the width of the sprite
  addi $t5, $t5, 1                # increment row counter
  blt  $t5, $t3, l2               # repeat for each row

### DRAW SPRITE SECTION
  la  $t0, frameBuffer            # load frame buffer address
  la  $t7, circleSprite           # load circle sprite address
  li  $t1, 30                     # x-coordinate
  li  $t2, 30                     # y-coordinate
  li  $t3, 10                     # size of the sprite

  mul $t1, $t1, 256               # convert x-coordinate to row number
  add $t1, $t1, $t2               # add y-coordinate to get the pixel position
  sll $t1, $t1, 2                 # multiply by 4 to get the byte address
  add $t0, $t0, $t1               # add to the base address of the frame buffer

  li  $t5, 0                      # counter for rows
l4:
  li  $t6, 0                      # counter for columns
l5:
  lw   $t4, 0($t7)                # load pixel from sprite
  sw   $t4, 0($t0)                # draw pixel

  addi $t0, $t0, 4                # advance to next pixel position in display
  addi $t7, $t7, 4                # advance to next pixel in sprite
  addi $t6, $t6, 1                # increment column counter
  blt  $t6, $t3, l5               # repeat for each column

  addi $t0, $t0, 1024              # advance to next row in display
  sll  $t8, $t3, 2
  sub  $t0, $t0, $t8              # subtract the width of the sprite
  addi $t5, $t5, 1                # increment row counter
  blt  $t5, $t3, l4               # repeat for each row