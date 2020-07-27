
-- VHDL Instantiation Created from source file control.vhd -- 23:48:02 07/25/2020
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT control
	PORT(
		CLK_OSC : IN std_logic;
		reset : IN std_logic;
		rxf_n : IN std_logic;
		txe_n : IN std_logic;
		bram_data_in : IN std_logic_vector(7 downto 0);
		wr_full_a : IN std_logic;
		rd_data_a : IN std_logic_vector(31 downto 0);
		rd_empty_a : IN std_logic;
		ddr_error : IN std_logic;    
		usb_data : INOUT std_logic_vector(7 downto 0);      
		rd_n : OUT std_logic;
		wr_n : OUT std_logic;
		bram_data_out : OUT std_logic_vector(7 downto 0);
		Bram_w_r : OUT std_logic;
		address_7_0 : OUT std_logic_vector(7 downto 0);
		address_15_8 : OUT std_logic_vector(7 downto 0);
		led_test : OUT std_logic_vector(7 downto 0);
		cmd_en_wr_a : OUT std_logic;
		WR_RD_CMD : OUT std_logic_vector(2 downto 0);
		WR_RD_CMD_pls : OUT std_logic;
		wr_en_pls_a : OUT std_logic;
		wr_data_a : OUT std_logic_vector(31 downto 0);
		ddr_add_inc_pico : OUT std_logic;
		addr_rst_pico : OUT std_logic;
		rd_en_pls_a : OUT std_logic
		);
	END COMPONENT;

	Inst_control: control PORT MAP(
		CLK_OSC => ,
		reset => ,
		usb_data => ,
		rxf_n => ,
		txe_n => ,
		rd_n => ,
		wr_n => ,
		bram_data_in => ,
		bram_data_out => ,
		Bram_w_r => ,
		address_7_0 => ,
		address_15_8 => ,
		led_test => ,
		cmd_en_wr_a => ,
		WR_RD_CMD => ,
		WR_RD_CMD_pls => ,
		wr_en_pls_a => ,
		wr_full_a => ,
		wr_data_a => ,
		ddr_add_inc_pico => ,
		addr_rst_pico => ,
		rd_en_pls_a => ,
		rd_data_a => ,
		rd_empty_a => ,
		ddr_error => 
	);


