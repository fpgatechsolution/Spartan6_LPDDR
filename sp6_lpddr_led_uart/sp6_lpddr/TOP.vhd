
----------------------------------------------------------------------------------
-- COMPANY      : FPGATECHSOLUTION
-- MODULE NAME  : UART_RECEIVER
-- URL     		: WWW.FPGATECHSOLUTION.COM
----------------------------------------------------------------------------------
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY TOP IS
    PORT ( 
		CLOCK_12MHZ : IN  STD_LOGIC;
		SYSTEM_CLK_100MHZ : IN  STD_LOGIC;
		RESET: IN  STD_LOGIC;
		
		TEST_LED : OUT std_logic_vector(7 downto 0);		
      
		
		USB_RXD : IN  STD_LOGIC;
		USB_TXD : OUT  STD_LOGIC;
	  
	  	mcb3_dram_dq : INOUT std_logic_vector(15 downto 0);
		mcb3_dram_udqs : INOUT std_logic;
		mcb3_dram_dqs : INOUT std_logic;
		mcb3_rzq : INOUT std_logic;      
		mcb3_dram_a : OUT std_logic_vector(12 downto 0);
		mcb3_dram_ba : OUT std_logic_vector(1 downto 0);
		mcb3_dram_ras_n : OUT std_logic;
		mcb3_dram_cas_n : OUT std_logic;
		mcb3_dram_we_n : OUT std_logic;
		mcb3_dram_cke : OUT std_logic;
		mcb3_dram_dm : OUT std_logic;
		mcb3_dram_udm : OUT std_logic;
		mcb3_dram_ck : OUT std_logic;
		mcb3_dram_ck_n : OUT std_logic
	

		
	

);
END TOP;

ARCHITECTURE BEHAVIORAL OF TOP IS

		COMPONENT RAM_CONTROL
	PORT(
		RESET : IN std_logic;
		SYSTEM_CLK_100MHZ : IN std_logic;
		RXD : IN std_logic;    
		mcb3_dram_dq : INOUT std_logic_vector(15 downto 0);
		mcb3_dram_udqs : INOUT std_logic;
		mcb3_dram_dqs : INOUT std_logic;
		mcb3_rzq : INOUT std_logic;      
		TXD : OUT std_logic;
		RELAY : OUT std_logic;
		BUZZER : OUT std_logic;
		TEST_LED : OUT std_logic_vector(7 downto 0);
		mcb3_dram_a : OUT std_logic_vector(12 downto 0);
		mcb3_dram_ba : OUT std_logic_vector(1 downto 0);
		mcb3_dram_ras_n : OUT std_logic;
		mcb3_dram_cas_n : OUT std_logic;
		mcb3_dram_we_n : OUT std_logic;
		mcb3_dram_cke : OUT std_logic;
		mcb3_dram_dm : OUT std_logic;
		mcb3_dram_udm : OUT std_logic;
		mcb3_dram_ck : OUT std_logic;
		mcb3_dram_ck_n : OUT std_logic
		);
	END COMPONENT;



--SIGNAL COUNT_RGB : STD_LOGIC_VECTOR(7 DOWNTO 0);
--SIGNAL LED_RX    : STD_LOGIC_VECTOR(7 DOWNTO 0);
--SIGNAL LED_SHIFT : STD_LOGIC_VECTOR(7 DOWNTO 0);
--SIGNAL COUNT   	 : STD_LOGIC_VECTOR(23 DOWNTO 0); 
--SIGNAL CLK_1S	 : STD_LOGIC;
--
--
-- SIGNAL   LED_RED : STD_LOGIC;
--  SIGNAL  LED_GREEN : STD_LOGIC;
--  SIGNAL  LED_BLUE : STD_LOGIC;

		
	 
BEGIN





	

	Inst_RAM_CONTROL: RAM_CONTROL PORT MAP(
		RESET =>RESET ,
		SYSTEM_CLK_100MHZ =>SYSTEM_CLK_100MHZ ,
		RXD =>USB_RXD ,
		TXD =>USB_TXD ,
		RELAY =>OPEN ,
		BUZZER =>OPEN ,
		TEST_LED =>TEST_LED ,
		mcb3_dram_dq =>mcb3_dram_dq ,
		mcb3_dram_udqs =>mcb3_dram_udqs ,
		mcb3_dram_dqs =>mcb3_dram_dqs ,
		mcb3_rzq =>mcb3_rzq ,
		mcb3_dram_a =>mcb3_dram_a ,
		mcb3_dram_ba =>mcb3_dram_ba ,
		mcb3_dram_ras_n =>mcb3_dram_ras_n ,
		mcb3_dram_cas_n =>mcb3_dram_cas_n ,
		mcb3_dram_we_n =>mcb3_dram_we_n ,
		mcb3_dram_cke =>mcb3_dram_cke ,
		mcb3_dram_dm => mcb3_dram_dm,
		mcb3_dram_udm =>mcb3_dram_udm ,
		mcb3_dram_ck =>mcb3_dram_ck ,
		mcb3_dram_ck_n =>mcb3_dram_ck_n 
	);



	
END BEHAVIORAL;

