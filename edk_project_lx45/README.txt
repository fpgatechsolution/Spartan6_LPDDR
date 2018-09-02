edk project and source code for peripheral test & lpddr test 

baudrate is 9600


output for peripheral test

#------------------------------------------------#
#************************************************#
#----------WWW.FPGATECHSOLUTION.COM--------------#
#************************************************#
#------------------------------------------------#

Testing Peripheral
On Spartan6 LX45 FPGA



Running UartLiteSelfTestExample() for debug_module...
UartLiteSelfTestExample PASSED

Running GpioOutputExample() for leds...
GpioOutputExample PASSED.
---Exiting main---



################

output for lpddr test


#------------------------------------------------#
#************************************************#
#----------WWW.FPGATECHSOLUTION.COM--------------#
#************************************************#
#------------------------------------------------#

Testing LPDDR MT46H32M16LFBF-5IT:C
On Spartan6 LX45 FPGA


--Starting Memory Test Application--
NOTE: This application runs with D-Cache disabled.As a result, cacheline requests will not be generated
Testing memory region: mcb_ddr3
    Memory Controller: axi_s6_ddrx
         Base Address: 0xa8000000
                 Size: 0x08000000 bytes
          32-bit test: PASSED!
          16-bit test: PASSED!
           8-bit test: PASSED!
--Memory Test Application Complete--