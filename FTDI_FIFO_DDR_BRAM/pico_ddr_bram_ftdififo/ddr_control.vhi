
-- VHDL Instantiation Created from source file ddr_control.vhd -- 23:33:16 07/25/2020
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT ddr_control
	PORT(
		clk_100Mhz : IN std_logic;
		sys_reset : IN std_logic;
		cmd_en_wr_a : IN std_logic;
		WR_RD_CMD : IN std_logic_vector(2 downto 0);
		WR_RD_CMD_pls : IN std_logic;
		wr_en_pls_a : IN std_logic;
		wr_data_a : IN std_logic_vector(31 downto 0);
		ddr_add_inc_pico : IN std_logic;
		addr_rst_pico : IN std_logic;
		rd_en_pls_a : IN std_logic;
		user_ddr_addr_rd : IN std_logic_vector(27 downto 0);
		user_rd_en_pls : IN std_logic;
		user_cmd_en_rd : IN std_logic;    
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
		rd_data_a : OUT std_logic_vector(31 downto 0);
		rd_empty_a : OUT std_logic;
		ddr_error : OUT std_logic;
		user_ddr_data_rd : OUT std_logic_vector(31 downto 0);
		user_rd_error : OUT std_logic;
		user_rd_empty : OUT std_logic
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
		ddr_error => ,
		user_ddr_data_rd => ,
		user_ddr_addr_rd => ,
		user_rd_en_pls => ,
		user_rd_error => ,
		user_rd_empty => ,
		user_cmd_en_rd => 
	);


