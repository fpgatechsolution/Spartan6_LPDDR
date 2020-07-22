
-- VHDL Instantiation Created from source file control.vhd -- 22:18:54 07/20/2020
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

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

	Inst_control: control PORT MAP(
		CLK_OSC => ,
		rx_232 => ,
		tx_232 => ,
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
		reset => 
	);


