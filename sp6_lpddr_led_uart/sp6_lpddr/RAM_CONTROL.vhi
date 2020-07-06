
-- VHDL Instantiation Created from source file RAM_CONTROL.vhd -- 21:15:16 07/06/2020
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT RAM_CONTROL
	PORT(
		RESET : IN std_logic;
		CLK : IN std_logic;
		RXD : IN std_logic;    
		mcb3_dram_dq : INOUT std_logic_vector(15 downto 0);
		mcb3_dram_udqs : INOUT std_logic;
		mcb3_dram_dqs : INOUT std_logic;
		mcb3_rzq : INOUT std_logic;      
		TXD : OUT std_logic;
		RELAY : OUT std_logic;
		BUZZER : OUT std_logic;
		RGB_LED : OUT std_logic_vector(2 downto 0);
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

	Inst_RAM_CONTROL: RAM_CONTROL PORT MAP(
		RESET => ,
		CLK => ,
		RXD => ,
		TXD => ,
		RELAY => ,
		BUZZER => ,
		RGB_LED => ,
		TEST_LED => ,
		mcb3_dram_dq => ,
		mcb3_dram_udqs => ,
		mcb3_dram_dqs => ,
		mcb3_rzq => ,
		mcb3_dram_a => ,
		mcb3_dram_ba => ,
		mcb3_dram_ras_n => ,
		mcb3_dram_cas_n => ,
		mcb3_dram_we_n => ,
		mcb3_dram_cke => ,
		mcb3_dram_dm => ,
		mcb3_dram_udm => ,
		mcb3_dram_ck => ,
		mcb3_dram_ck_n => 
	);


