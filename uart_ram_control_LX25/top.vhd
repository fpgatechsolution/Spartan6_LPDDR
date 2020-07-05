--################################################################################
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Company      : FPGATECHSOLUTION
-- Module Name  : WIFI_TOP
-- URL     		: WWW.FPGATECHSOLUTION.COM
-- Description	: 
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--################################################################################

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE WORK.ESP_FPGA_PACK.ALL;


ENTITY TOP IS
PORT(			
		CLK_100MHZ	: IN STD_LOGIC;-- clock 100MHz		
		RESET			: IN STD_LOGIC;
		RGB_LED: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		TEST_LED	:OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); 		
		USB_RXD	: IN STD_LOGIC; -- USB RX
		USB_TXD 	: OUT STD_LOGIC-- USB TX;
		
		
	);
END ENTITY TOP;

architecture Behavioral of TOP is



	
signal		RELAY:  STD_LOGIC; -- NOT USED
signal		BUZZER:  STD_LOGIC;-- NOT USED
--signal TEST_LED	:  STD_LOGIC_VECTOR(7 DOWNTO 0); 
begin


 
	INST_RAM_CONTROL:RAM_CONTROL
	PORT MAP( 
			RESET	=>(not RESET),
			CLK	=>(CLK_100MHZ),
			RXD	=>(USB_RXD),
			TXD 	=>(USB_TXD),			
			RELAY=>(RELAY),
			BUZZER=>(BUZZER),
			RGB_LED=>(RGB_LED),		
			TEST_LED=>(TEST_LED)
);










end Behavioral;

