
-- VHDL Instantiation Created from source file ddr2_top.vhd -- 11:00:33 08/24/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT ddr2_top
	PORT(
		clk_100mhz : IN std_logic;
		clk_100 : IN std_logic;
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

	Inst_ddr2_top: ddr2_top PORT MAP(
		clk_100mhz => ,
		mcb3_dram_dq => ,
		mcb3_dram_a => ,
		mcb3_dram_ba => ,
		mcb3_dram_ras_n => ,
		mcb3_dram_cas_n => ,
		mcb3_dram_we_n => ,
		mcb3_dram_cke => ,
		mcb3_dram_dm => ,
		mcb3_dram_udqs => ,
		mcb3_dram_udm => ,
		mcb3_dram_dqs => ,
		mcb3_dram_ck => ,
		mcb3_dram_ck_n => ,
		c3_calib_done => ,
		mcb3_rzq => ,
		clk_100 => ,
		sys_rst_h => ,
		cmd_en_wr_a => ,
		wr_en_pls_a => ,
		wr_data_a => ,
		wr_empty_a => ,
		wr_full_a => ,
		addr_rstA_wr => ,
		addr_incA_wr => ,
		cmd_en_rd_a => ,
		rd_en_pls_a => ,
		rd_data_a => ,
		rd_empty_a => ,
		addr_rstA_rd => ,
		addr_incA_rd => ,
		test_led => 
	);


