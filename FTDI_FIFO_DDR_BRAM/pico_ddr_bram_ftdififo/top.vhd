
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
   
		usb_data : INOUT std_logic_vector(7 downto 0);
		rd_n : OUT std_logic;
		wr_n : OUT std_logic;
		rxf_n : IN std_logic;
		txe_n : IN std_logic


		
--		USB_RXD : IN  STD_LOGIC;
--		USB_TXD : OUT  STD_LOGIC;
--	  
--	  	mcb3_dram_dq : INOUT std_logic_vector(15 downto 0);
--		mcb3_dram_udqs : INOUT std_logic;
--		mcb3_dram_dqs : INOUT std_logic;
--		mcb3_rzq : INOUT std_logic;      
--		mcb3_dram_a : OUT std_logic_vector(12 downto 0);
--		mcb3_dram_ba : OUT std_logic_vector(1 downto 0);
--		mcb3_dram_ras_n : OUT std_logic;
--		mcb3_dram_cas_n : OUT std_logic;
--		mcb3_dram_we_n : OUT std_logic;
--		mcb3_dram_cke : OUT std_logic;
--		mcb3_dram_dm : OUT std_logic;
--		mcb3_dram_udm : OUT std_logic;
--		mcb3_dram_ck : OUT std_logic;
--		mcb3_dram_ck_n : OUT std_logic
--	

		
	

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

		
	COMPONENT control
	PORT(
		CLK_OSC : IN std_logic;
		rx_232 : IN std_logic;
		rxf_n : IN std_logic;
		txe_n : IN std_logic;
		bram_data_in : IN std_logic_vector(7 downto 0);
		reset : IN std_logic;    
		usb_data : INOUT std_logic_vector(7 downto 0);      
		tx_232 : OUT std_logic;
		rd_n : OUT std_logic;
		wr_n : OUT std_logic;
		bram_data_out : OUT std_logic_vector(7 downto 0);
		Bram_w_r : OUT std_logic;
		address_7_0 : OUT std_logic_vector(7 downto 0);
		address_15_8 : OUT std_logic_vector(7 downto 0);
		led_test : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;


	COMPONENT BRAM
	PORT(
	clka:in std_logic;
	wea:in std_logic_vector(0 downto 0);
	addra:in std_logic_vector(13 downto 0);
	dina:in std_logic_vector(7 downto 0);
	douta:OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;





		signal	  bram_data_in:   STD_LOGIC_VECTOR (7 downto 0);
		signal	  bram_data_out:   STD_LOGIC_VECTOR (7 downto 0);
		signal	  Bram_w_r:  STD_LOGIC;
		signal	  address_7_0:   STD_LOGIC_VECTOR (7 downto 0);
		signal	  address_15_8:   STD_LOGIC_VECTOR (7 downto 0);
			signal			Bram_w_r_en:   STD_LOGIC_VECTOR (0 downto 0);
	 signal	     bram_address:   STD_LOGIC_VECTOR (13 downto 0);
BEGIN



--
--
--	
--
--	Inst_RAM_CONTROL: RAM_CONTROL PORT MAP(
--		RESET =>RESET ,
--		SYSTEM_CLK_100MHZ =>SYSTEM_CLK_100MHZ ,
--		RXD =>USB_RXD ,
--		TXD =>USB_TXD ,
--		RELAY =>OPEN ,
--		BUZZER =>OPEN ,
--		TEST_LED =>TEST_LED ,
--		mcb3_dram_dq =>mcb3_dram_dq ,
--		mcb3_dram_udqs =>mcb3_dram_udqs ,
--		mcb3_dram_dqs =>mcb3_dram_dqs ,
--		mcb3_rzq =>mcb3_rzq ,
--		mcb3_dram_a =>mcb3_dram_a ,
--		mcb3_dram_ba =>mcb3_dram_ba ,
--		mcb3_dram_ras_n =>mcb3_dram_ras_n ,
--		mcb3_dram_cas_n =>mcb3_dram_cas_n ,
--		mcb3_dram_we_n =>mcb3_dram_we_n ,
--		mcb3_dram_cke =>mcb3_dram_cke ,
--		mcb3_dram_dm => mcb3_dram_dm,
--		mcb3_dram_udm =>mcb3_dram_udm ,
--		mcb3_dram_ck =>mcb3_dram_ck ,
--		mcb3_dram_ck_n =>mcb3_dram_ck_n 
--	);




	Inst_control: control PORT MAP(
		CLK_OSC =>CLOCK_12MHZ ,
		led_test =>TEST_LED ,
		reset =>reset,
		rx_232 =>'0' ,
		tx_232 =>open ,
		usb_data =>usb_data ,
		rxf_n =>rxf_n ,
		txe_n =>txe_n ,
		rd_n =>rd_n ,
		wr_n =>wr_n ,
		bram_data_in => bram_data_in,
		bram_data_out =>bram_data_out ,
		Bram_w_r =>Bram_w_r ,
		address_7_0 =>address_7_0 ,
		address_15_8 =>address_15_8 
 
	);

	Inst_BRAM: BRAM PORT MAP(
	clka=>CLOCK_12MHZ,
	wea=>Bram_w_r_en,
	addra=>bram_address,
	dina=>bram_data_out,
	douta=>bram_data_in
		);


--bram_data_in<="01011100";

bram_address<=address_15_8(5 downto 0) & address_7_0;--
Bram_w_r_en(0)<=Bram_w_r;



--//			  TEST_LED(0)<=Bram_w_r;
--//			  TEST_LED(7 DOWNTO 1)<=bram_data_out(7 DOWNTO 1);
--			  
			  
	
END BEHAVIORAL;



