
-- VHDL Instantiation Created from source file user_read_control.vhd -- 23:17:01 07/29/2020
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT user_read_control
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		USER_ADDRESS_RES : IN std_logic;
		load_start_address : IN std_logic;
		start_address : IN std_logic_vector(27 downto 0);
		start_read : IN std_logic;
		user_ddr_data_rd : IN std_logic_vector(31 downto 0);
		user_rd_error : IN std_logic;
		user_rd_empty : IN std_logic;          
		DATA_OUT1 : OUT std_logic_vector(31 downto 0);
		DATA_OUT2 : OUT std_logic_vector(31 downto 0);
		user_ddr_addr_rd : OUT std_logic_vector(29 downto 0);
		user_rd_en_pls : OUT std_logic;
		user_cmd_en_rd : OUT std_logic
		);
	END COMPONENT;

	Inst_user_read_control: user_read_control PORT MAP(
		clk => ,
		reset => ,
		USER_ADDRESS_RES => ,
		load_start_address => ,
		start_address => ,
		start_read => ,
		DATA_OUT1 => ,
		DATA_OUT2 => ,
		user_ddr_data_rd => ,
		user_ddr_addr_rd => ,
		user_rd_en_pls => ,
		user_rd_error => ,
		user_rd_empty => ,
		user_cmd_en_rd => 
	);


