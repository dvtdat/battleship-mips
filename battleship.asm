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
  frameBuffer: 	.space 	0x80000		#512 wide x 256 high pixels
.text

### DRAW BACKGROUND SECTION

  la 	$t0, frameBuffer    # load frame buffer addres
  li 	$t1, 8192           # save 512*256 pixels
  li 	$t2, 0x00ff0000     # load light gray color
l1:
  sw   	$t2, 0($t0)
  addi 	$t0, $t0, 4       # advance to next pixel position in display
  addi 	$t1, $t1, -1      # decrement number of pixels
  bnez 	$t1, l1           # repeat while number of pixels is not zero