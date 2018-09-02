
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
		clk_100mhz : IN  STD_LOGIC;
    	LED1_R  	: OUT  STD_LOGIC;
		LED1_G 	: OUT  STD_LOGIC;
		LED1_B 	: OUT  STD_LOGIC;		
		
		LED2_R  	: OUT  STD_LOGIC;
		LED2_G 	: OUT  STD_LOGIC;
		LED2_B 	: OUT  STD_LOGIC;	
		
		LED3_R  	: OUT  STD_LOGIC;
		LED3_G 	: OUT  STD_LOGIC;
		LED3_B 	: OUT  STD_LOGIC;	
		
		--LED4_R  	: OUT  STD_LOGIC;
		LED4_G 	: OUT  STD_LOGIC;
		LED4_B 	: OUT  STD_LOGIC;	
		
        RESET: IN  STD_LOGIC;
		
		USB_UART_RX : IN  STD_LOGIC;
		USB_UART_TX : OUT  STD_LOGIC;
	  
	  	mcb3_dram_dq : INOUT std_logic_vector(15 downto 0);
		mcb3_dram_udqs : INOUT std_logic;
		mcb3_dram_dqs : INOUT std_logic;
		mcb3_rzq : INOUT std_logic;      
		mcb3_dram_a : OUT std_logic_vector(12 downto 0);
		mcb3_dram_ba : OUT std_logic_vector(2 downto 0);
		mcb3_dram_ras_n : OUT std_logic;
		mcb3_dram_cas_n : OUT std_logic;
		mcb3_dram_we_n : OUT std_logic;
		mcb3_dram_cke : OUT std_logic;
		mcb3_dram_dm : OUT std_logic;
		mcb3_dram_udm : OUT std_logic;
		mcb3_dram_ck : OUT std_logic;
		mcb3_dram_ck_n : OUT std_logic;
		c3_calib_done : OUT std_logic

		
	

);
END TOP;

ARCHITECTURE BEHAVIORAL OF TOP IS

	COMPONENT UART_CONTROL
		PORT(
			RESET : IN STD_LOGIC;
			CLK : IN STD_LOGIC;
			RXD : IN STD_LOGIC;          
			TXD : OUT STD_LOGIC;
			TEST_LED : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
	END COMPONENT;


SIGNAL COUNT_RGB : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL LED_RX    : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL LED_SHIFT : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL COUNT   	 : STD_LOGIC_VECTOR(23 DOWNTO 0); 
SIGNAL CLK_1S	 : STD_LOGIC;


 SIGNAL   LED_RED : STD_LOGIC;
  SIGNAL  LED_GREEN : STD_LOGIC;
  SIGNAL  LED_BLUE : STD_LOGIC;


	COMPONENT lpddr_control
	PORT(
		clk_100mhz : IN std_logic;
		sys_rst_h : IN std_logic;
		cmd_en_wr_a : IN std_logic;
		wr_en_pls_a : IN std_logic;
		wr_data_a : IN std_logic_vector(31 downto 0);
		addr_rstA_wr : IN std_logic;
		addr_incA_wr : IN std_logic;
		cmd_en_rd_a : IN std_logic;
		rd_en_pls_a : IN std_logic;
		addr_rstA_rd : IN std_logic;
		addr_incA_rd : IN std_logic;    
		mcb3_dram_dq : INOUT std_logic_vector(15 downto 0);
		mcb3_dram_udqs : INOUT std_logic;
		mcb3_dram_dqs : INOUT std_logic;
		mcb3_rzq : INOUT std_logic;      
		mcb3_dram_a : OUT std_logic_vector(12 downto 0);
		mcb3_dram_ba : OUT std_logic_vector(2 downto 0);
		mcb3_dram_ras_n : OUT std_logic;
		mcb3_dram_cas_n : OUT std_logic;
		mcb3_dram_we_n : OUT std_logic;
		mcb3_dram_cke : OUT std_logic;
		mcb3_dram_dm : OUT std_logic;
		mcb3_dram_udm : OUT std_logic;
		mcb3_dram_ck : OUT std_logic;
		mcb3_dram_ck_n : OUT std_logic;
		c3_calib_done : OUT std_logic;
		wr_empty_a : OUT std_logic;
		wr_full_a : OUT std_logic;
		rd_data_a : OUT std_logic_vector(31 downto 0);
		rd_empty_a : OUT std_logic;
		test_led : OUT std_logic
		);
	END COMPONENT;

 
 
 
 

	SIGNAL	cmd_en_wr_a  : std_logic;
	SIGNAL	wr_en_pls_a  : std_logic;
	SIGNAL	wr_data_a 	 : std_logic_vector(31 downto 0);
	SIGNAL	addr_rstA_wr : std_logic;
	SIGNAL	addr_incA_wr : std_logic;
	SIGNAL	cmd_en_rd_a  : std_logic;
	SIGNAL	rd_en_pls_a  : std_logic;
	SIGNAL	addr_rstA_rd : std_logic;
	SIGNAL	addr_incA_rd : std_logic;    
	SIGNAL	wr_empty_a   :  std_logic;
	SIGNAL	wr_full_a    :  std_logic;
	SIGNAL	rd_data_a    :  std_logic_vector(31 downto 0);
	SIGNAL	rd_empty_a   :  std_logic;
	SIGNAL	test_led :  std_logic;
		
	 
BEGIN

	INST_UART_CONTROL: UART_CONTROL PORT MAP(
		RESET 	=>RESET ,
		CLK   	=>CLOCK_12MHZ ,
		RXD   	=>USB_UART_RX ,
		TXD      =>USB_UART_TX ,
		TEST_LED=> LED_RX
	);




	PROCESS (CLOCK_12MHZ) 
		BEGIN
			IF RESET='1'  THEN 
				COUNT <= (OTHERS => '0');
			ELSIF CLOCK_12MHZ='1' AND CLOCK_12MHZ'EVENT THEN
				COUNT <= COUNT + 1;
			END IF;
	END PROCESS;
	
	CLK_1S<=COUNT(22);
	
	PROCESS (CLK_1S) 
		BEGIN
			IF RESET='1'  THEN 
				COUNT_RGB <= (OTHERS => '0');
			ELSIF CLK_1S='1' AND CLK_1S'EVENT THEN
				COUNT_RGB <= COUNT_RGB + 1;
			END IF;
	END PROCESS;
	


	  
    LED_RED <=COUNT_RGB(0)  ;
    LED_GREEN<=COUNT_RGB(1)  ;
    LED_BLUE<=COUNT_RGB(2); 


	   LED1_R  <=LED_RED;
		LED1_G 	<=LED_GREEN;
		LED1_B 	<=	LED_BLUE;
		
		LED2_R  <=LED_RED;
		LED2_G 	<=LED_GREEN;
		LED2_B 	<=	LED_BLUE;
		
		LED3_R  <=LED_RED;
		LED3_G 	<=LED_GREEN;
		LED3_B 	<=	LED_BLUE;
		
		--LED4_R  <=LED_RED;
		LED4_G 	<=LED_GREEN;
		LED4_B 	<=	LED_BLUE;
		
		


	Inst_ddr2_top: lpddr_control PORT MAP(
		clk_100mhz 		=> clk_100mhz 		,
		sys_rst_h 		=> RESET 		,
		
		mcb3_dram_dq 	=> mcb3_dram_dq 	,
		mcb3_dram_a 	=> mcb3_dram_a 	,
		mcb3_dram_ba 	=> mcb3_dram_ba 	,
		mcb3_dram_ras_n => mcb3_dram_ras_n ,
		mcb3_dram_cas_n => mcb3_dram_cas_n ,
		mcb3_dram_we_n 	=> mcb3_dram_we_n 	,
		mcb3_dram_cke 	=> mcb3_dram_cke 	,
		mcb3_dram_dm 	=> mcb3_dram_dm 	,
		mcb3_dram_udqs 	=> mcb3_dram_udqs 	,
		mcb3_dram_udm 	=> mcb3_dram_udm 	,
		mcb3_dram_dqs 	=> mcb3_dram_dqs 	,
		mcb3_dram_ck 	=> mcb3_dram_ck 	,
		mcb3_dram_ck_n 	=> mcb3_dram_ck_n 	,
		c3_calib_done 	=> c3_calib_done 	,
		mcb3_rzq 		=> mcb3_rzq 		,
		
		cmd_en_wr_a 	=> cmd_en_wr_a 	,
		wr_en_pls_a 	=> wr_en_pls_a 	,
		wr_data_a 		=> wr_data_a 		,
		wr_empty_a 		=> wr_empty_a 		,
		wr_full_a 		=> wr_full_a 		,
		addr_rstA_wr 	=> addr_rstA_wr 	,
		addr_incA_wr 	=> addr_incA_wr 	,
		cmd_en_rd_a 	=> cmd_en_rd_a 	,
		rd_en_pls_a 	=> rd_en_pls_a 	,
		rd_data_a 		=> rd_data_a 		,
		rd_empty_a 		=> rd_empty_a 		,
		addr_rstA_rd 	=> addr_rstA_rd 	,
		addr_incA_rd 	=> addr_incA_rd 	,
		test_led 		=> test_led 		
	);

	
	
	
	
END BEHAVIORAL;

