
-- VHDL Instantiation Created from source file ddr_control.vhd -- 22:52:12 07/31/2020
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT ddr_control
	PORT(
		clk_100Mhz : IN std_logic;
		sys_reset : IN std_logic;
		addr_rst_pico_w : IN std_logic;
		addr_rst_pico_r : IN std_logic;
		wr_en_pls_a : IN std_logic;
		wr_data_a : IN std_logic_vector(31 downto 0);
		ddr_add_inc_wr : IN std_logic;
		cmd_en_wr_a : IN std_logic;
		rd_en_pls_a : IN std_logic;
		ddr_add_inc_rd : IN std_logic;
		cmd_en_rd_a : IN std_logic;
		user_rd_address : IN std_logic_vector(27 downto 0);
		start_read : IN std_logic;    
		mcb3_dram_dq : INOUT std_logic_vector(15 downto 0);
		mcb3_dram_udqs : INOUT std_logic;
		mcb3_rzq : INOUT std_logic;
		mcb3_dram_dqs : INOUT std_logic;      
		c3_calib_done : OUT std_logic;
		clk_ddr_fifo_out : OUT std_logic;
		c3_rst0 : OUT std_logic;
		mcb3_dram_a : OUT std_logic_vector(12 downto 0);
		mcb3_dram_ba : OUT std_logic_vector(1 downto 0);
		mcb3_dram_cke : OUT std_logic;
		mcb3_dram_ras_n : OUT std_logic;
		mcb3_dram_cas_n : OUT std_logic;
		mcb3_dram_we_n : OUT std_logic;
		mcb3_dram_dm : OUT std_logic;
		mcb3_dram_udm : OUT std_logic;
		mcb3_dram_ck : OUT std_logic;
		mcb3_dram_ck_n : OUT std_logic;
		wr_full_a : OUT std_logic;
		ddr_addr_wr_out : OUT std_logic_vector(27 downto 0);
		rd_data_a : OUT std_logic_vector(31 downto 0);
		rd_empty_a : OUT std_logic;
		ddr_addr_rd_out : OUT std_logic_vector(27 downto 0);
		ddr_error : OUT std_logic;
		user_data_valid : OUT std_logic;
		DATA_OUT1 : OUT std_logic_vector(31 downto 0);
		DATA_OUT2 : OUT std_logic_vector(31 downto 0);
		user_rd_err : OUT std_logic
		);
	END COMPONENT;

	Inst_ddr_control: ddr_control PORT MAP(
		clk_100Mhz => ,
		sys_reset => ,
		c3_calib_done => ,
		clk_ddr_fifo_out => ,
		c3_rst0 => ,
		mcb3_dram_dq => ,
		mcb3_dram_a => ,
		mcb3_dram_ba => ,
		mcb3_dram_cke => ,
		mcb3_dram_ras_n => ,
		mcb3_dram_cas_n => ,
		mcb3_dram_we_n => ,
		mcb3_dram_dm => ,
		mcb3_dram_udqs => ,
		mcb3_rzq => ,
		mcb3_dram_udm => ,
		mcb3_dram_dqs => ,
		mcb3_dram_ck => ,
		mcb3_dram_ck_n => ,
		addr_rst_pico_w => ,
		addr_rst_pico_r => ,
		wr_en_pls_a => ,
		wr_full_a => ,
		wr_data_a => ,
		ddr_add_inc_wr => ,
		cmd_en_wr_a => ,
		ddr_addr_wr_out => ,
		rd_en_pls_a => ,
		rd_data_a => ,
		rd_empty_a => ,
		ddr_add_inc_rd => ,
		cmd_en_rd_a => ,
		ddr_addr_rd_out => ,
		ddr_error => ,
		user_data_valid => ,
		user_rd_address => ,
		start_read => ,
		DATA_OUT1 => ,
		DATA_OUT2 => ,
		user_rd_err => 
	);


