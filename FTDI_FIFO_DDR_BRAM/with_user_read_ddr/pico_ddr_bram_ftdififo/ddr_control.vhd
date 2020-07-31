----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:02:27 07/03/2020 
-- Design Name: 
-- Module Name:    ddr_control - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ddr_control is
    Port ( 
	
	clk_100Mhz        : in  std_logic;
    sys_reset         : in  std_logic;
	
    c3_calib_done     : out std_logic;
	
    clk_ddr_fifo_out      : out std_logic;
    c3_rst0           : out std_logic;   
    mcb3_dram_dq      : inout  std_logic_vector(15 downto 0);
    mcb3_dram_a       : out std_logic_vector(12 downto 0);
    mcb3_dram_ba      : out std_logic_vector(1 downto 0);
    mcb3_dram_cke     : out std_logic;
    mcb3_dram_ras_n   : out std_logic;
    mcb3_dram_cas_n   : out std_logic;
    mcb3_dram_we_n    : out std_logic;
    mcb3_dram_dm      : out std_logic;
    mcb3_dram_udqs    : inout  std_logic;
    mcb3_rzq          : inout  std_logic;
    mcb3_dram_udm     : out std_logic;
    mcb3_dram_dqs     : inout  std_logic;
    mcb3_dram_ck      : out std_logic;
    mcb3_dram_ck_n    : out std_logic;
	

	
--///**** write & read control******
	addr_rst_pico_w: in  std_logic;
	addr_rst_pico_r: in  std_logic;
	
	
	
--///**** write control******
	wr_en_pls_a : in  std_logic;	
	wr_full_a   : out  std_logic;
	wr_data_a 	: in std_logic_vector(31 downto 0);	
	ddr_add_inc_wr: in  std_logic;
	cmd_en_wr_a : in  std_logic;

--///**** read control*****
	rd_en_pls_a	: in  std_logic;
	rd_data_a 	: out std_logic_vector(31 downto 0);
	rd_empty_a	: out std_logic;
	ddr_add_inc_rd: in  std_logic;
	cmd_en_rd_a : in  std_logic;
	
	ddr_error   : out std_logic;

	
	
	--///**** read control*****
   
	USER_ADDRESS_RES:  in  STD_LOGIC;
    load_start_address: in  STD_LOGIC;
    start_address: in  std_logic_vector(27 downto 0);-- must be in multiple of 2 ( address start from )
    start_read:in  STD_LOGIC;
    DATA_OUT1: OUT std_logic_vector(31 downto 0);
    DATA_OUT2: OUT std_logic_vector(31 downto 0)
  
   );
	end ddr_control;

architecture Behavioral of ddr_control is


	constant ddr_burst_length_pico   : std_logic_vector(5 downto 0) := "000001";-- START FROM 0
	constant ddr_burst_length_user   : std_logic_vector(5 downto 0) := "000001"; -- START FROM 0
	 
	constant C3_P0_MASK_SIZE           : integer := 4;
    constant C3_P0_DATA_PORT_SIZE      : integer := 32;
    constant C3_P1_MASK_SIZE           : integer := 4;
    constant C3_P1_DATA_PORT_SIZE      : integer := 32;
    constant C3_MEMCLK_PERIOD          : integer := 10000;
    constant C3_RST_ACT_LOW            : integer := 0;
    constant C3_INPUT_CLK_TYPE         : string := "SINGLE_ENDED";
    constant C3_CALIB_SOFT_IP          : string := "TRUE";
    constant C3_SIMULATION             : string := "FALSE";
    constant DEBUG_EN                  : integer := 0;
    constant C3_MEM_ADDR_ORDER         : string := "ROW_BANK_COLUMN";
    constant C3_NUM_DQ_PINS            : integer := 16;
    constant C3_MEM_ADDR_WIDTH         : integer := 13;
    constant C3_MEM_BANKADDR_WIDTH     : integer := 2;
	
	

 
		
	
	component ddr2
	generic(
		C3_P0_MASK_SIZE           : integer := 4;
		C3_P0_DATA_PORT_SIZE      : integer := 32;
		C3_P1_MASK_SIZE           : integer := 4;
		C3_P1_DATA_PORT_SIZE      : integer := 32;
		C3_MEMCLK_PERIOD          : integer := 10000;
		C3_RST_ACT_LOW            : integer := 0;
		C3_INPUT_CLK_TYPE         : string := "SINGLE_ENDED";
		C3_CALIB_SOFT_IP          : string := "TRUE";
		C3_SIMULATION             : string := "FALSE";
		DEBUG_EN                  : integer := 0;
		C3_MEM_ADDR_ORDER         : string := "ROW_BANK_COLUMN";
		C3_NUM_DQ_PINS            : integer := 16;
		C3_MEM_ADDR_WIDTH         : integer := 13;
		C3_MEM_BANKADDR_WIDTH     : integer := 2
	);
    port (
		mcb3_dram_dq                            : inout  std_logic_vector(C3_NUM_DQ_PINS-1 downto 0);
		mcb3_dram_a                             : out std_logic_vector(C3_MEM_ADDR_WIDTH-1 downto 0);
		mcb3_dram_ba                            : out std_logic_vector(C3_MEM_BANKADDR_WIDTH-1 downto 0);
		mcb3_dram_cke                           : out std_logic;
		mcb3_dram_ras_n                         : out std_logic;
		mcb3_dram_cas_n                         : out std_logic;
		mcb3_dram_we_n                          : out std_logic;
		mcb3_dram_dm                            : out std_logic;
		mcb3_dram_udqs                          : inout  std_logic;
		mcb3_rzq                                : inout  std_logic;
		mcb3_dram_udm                           : out std_logic;
		c3_sys_clk                              : in  std_logic;
		c3_sys_rst_i                            : in  std_logic;
		c3_calib_done                           : out std_logic;
		c3_clk0                                 : out std_logic;
		c3_rst0                                 : out std_logic;
		mcb3_dram_dqs                           : inout  std_logic;
		mcb3_dram_ck                            : out std_logic;
		mcb3_dram_ck_n                          : out std_logic;
		c3_p0_cmd_clk                           : in std_logic;
		c3_p0_cmd_en                            : in std_logic;
		c3_p0_cmd_instr                         : in std_logic_vector(2 downto 0);
		c3_p0_cmd_bl                            : in std_logic_vector(5 downto 0);
		c3_p0_cmd_byte_addr                     : in std_logic_vector(29 downto 0);
		c3_p0_cmd_empty                         : out std_logic;
		c3_p0_cmd_full                          : out std_logic;
		c3_p0_wr_clk                            : in std_logic;
		c3_p0_wr_en                             : in std_logic;
		c3_p0_wr_mask                           : in std_logic_vector(C3_P0_MASK_SIZE - 1 downto 0);
		c3_p0_wr_data                           : in std_logic_vector(C3_P0_DATA_PORT_SIZE - 1 downto 0);
		c3_p0_wr_full                           : out std_logic;
		c3_p0_wr_empty                          : out std_logic;
		c3_p0_wr_count                          : out std_logic_vector(6 downto 0);
		c3_p0_wr_underrun                       : out std_logic;
		c3_p0_wr_error                          : out std_logic;
		c3_p0_rd_clk                            : in std_logic;
		c3_p0_rd_en                             : in std_logic;
		c3_p0_rd_data                           : out std_logic_vector(C3_P0_DATA_PORT_SIZE - 1 downto 0);
		c3_p0_rd_full                           : out std_logic;
		c3_p0_rd_empty                          : out std_logic;
		c3_p0_rd_count                          : out std_logic_vector(6 downto 0);
		c3_p0_rd_overflow                       : out std_logic;
		c3_p0_rd_error                          : out std_logic;
		c3_p1_cmd_clk                           : in std_logic;
		c3_p1_cmd_en                            : in std_logic;
		c3_p1_cmd_instr                         : in std_logic_vector(2 downto 0);
		c3_p1_cmd_bl                            : in std_logic_vector(5 downto 0);
		c3_p1_cmd_byte_addr                     : in std_logic_vector(29 downto 0);
		c3_p1_cmd_empty                         : out std_logic;
		c3_p1_cmd_full                          : out std_logic;
		c3_p1_wr_clk                            : in std_logic;
		c3_p1_wr_en                             : in std_logic;
		c3_p1_wr_mask                           : in std_logic_vector(C3_P1_MASK_SIZE - 1 downto 0);
		c3_p1_wr_data                           : in std_logic_vector(C3_P1_DATA_PORT_SIZE - 1 downto 0);
		c3_p1_wr_full                           : out std_logic;
		c3_p1_wr_empty                          : out std_logic;
		c3_p1_wr_count                          : out std_logic_vector(6 downto 0);
		c3_p1_wr_underrun                       : out std_logic;
		c3_p1_wr_error                          : out std_logic;
		c3_p1_rd_clk                            : in std_logic;
		c3_p1_rd_en                             : in std_logic;
		c3_p1_rd_data                           : out std_logic_vector(C3_P1_DATA_PORT_SIZE - 1 downto 0);
		c3_p1_rd_full                           : out std_logic;
		c3_p1_rd_empty                          : out std_logic;
		c3_p1_rd_count                          : out std_logic_vector(6 downto 0);
		c3_p1_rd_overflow                       : out std_logic;
		c3_p1_rd_error                          : out std_logic;			
		c3_p2_cmd_clk                           : in std_logic;
		c3_p2_cmd_en                            : in std_logic;
		c3_p2_cmd_instr                         : in std_logic_vector(2 downto 0);
		c3_p2_cmd_bl                            : in std_logic_vector(5 downto 0);
		c3_p2_cmd_byte_addr                     : in std_logic_vector(29 downto 0);
		c3_p2_cmd_empty                         : out std_logic;
		c3_p2_cmd_full                          : out std_logic;
		c3_p2_wr_clk                            : in std_logic;
		c3_p2_wr_en                             : in std_logic;
		c3_p2_wr_mask                           : in std_logic_vector(C3_P1_MASK_SIZE - 1 downto 0);
		c3_p2_wr_data                           : in std_logic_vector(C3_P1_DATA_PORT_SIZE - 1 downto 0);
		c3_p2_wr_full                           : out std_logic;
		c3_p2_wr_empty                          : out std_logic;
		c3_p2_wr_count                          : out std_logic_vector(6 downto 0);
		c3_p2_wr_underrun                       : out std_logic;
		c3_p2_wr_error                          : out std_logic;
		c3_p2_rd_clk                            : in std_logic;
		c3_p2_rd_en                             : in std_logic;
		c3_p2_rd_data                           : out std_logic_vector(C3_P1_DATA_PORT_SIZE - 1 downto 0);
		c3_p2_rd_full                           : out std_logic;
		c3_p2_rd_empty                          : out std_logic;
		c3_p2_rd_count                          : out std_logic_vector(6 downto 0);
		c3_p2_rd_overflow                       : out std_logic;
		c3_p2_rd_error                          : out std_logic);
	end component;

	
			COMPONENT L_TO_P
	PORT(
		CLK_in : IN std_logic;
		LEVEL : IN std_logic;          
		PULSE : OUT std_logic
		);
	END COMPONENT;


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
	
	--SIGNAL WR_RD_CMD :std_logic_vector(2 downto 0);
    
	SIGNAL wr_error,rd_error:std_logic;	
   SIGNAL clkA_addr:std_logic;
	
	

	
	
	signal 	ddr_addr_wr: std_logic_vector(29 downto 0);
	signal  ddr_addr_rd: std_logic_vector(29 downto 0);
	SIGNAL  clk_ddr_fifo:std_logic;
	
	signal  user_ddr_addr: std_logic_vector(29 downto 0);

	
	signal ddr_addr_a_pico_wr: std_logic_vector(27 downto 0);
	signal ddr_addr_a_pico_rd: std_logic_vector(27 downto 0);
	
	
   signal cmd_wr_pls: std_logic;
   signal cmd_rd_pls: std_logic;
   signal rd_en_pls: std_logic;
   signal wr_en_pls: std_logic;
	signal cmd_wr_rd_pls: std_logic;
   signal address_cnt_en: std_logic;
   
   signal ld_addres_en: std_logic:='0';
	signal ld_addres: std_logic_vector(27 downto 0);

    signal user_ddr_data_rd :	std_logic_vector(31 downto 0);
	signal user_ddr_addr_rd :	std_logic_vector(29 downto 0);
	signal user_rd_en_pls	:	std_logic;
	signal user_rd_error    :	std_logic;
	signal user_rd_empty    :	std_logic;
	signal user_cmd_en_rd	:	std_logic;
	
signal ddr_add_wr:	std_logic;
signal ddr_add_rd	:	std_logic;
begin

	Inst_ddr_add_inc_wr: L_TO_P PORT MAP(
		CLK_in =>clk_ddr_fifo ,
		LEVEL =>(ddr_add_inc_wr) ,
		PULSE =>ddr_add_wr 
	);


	Inst_ddr_add_inc_rd: L_TO_P PORT MAP(
		CLK_in =>clk_ddr_fifo ,
		LEVEL =>(ddr_add_inc_rd) ,
		PULSE =>ddr_add_rd 
	);


	
	
-- write address
	PROCESS(ddr_add_wr,sys_reset,addr_rst_pico_w,addr_rst_pico_w)	     
		BEGIN
			IF(sys_reset='1' or addr_rst_pico_w='1')THEN
				ddr_addr_a_pico_wr<="0000000000000000000000001000";		
			ELSIF (clk_ddr_fifo'EVENT AND clk_ddr_fifo='1')THEN
				if(ddr_add_wr='1' ) THEN
					ddr_addr_a_pico_wr<=ddr_addr_a_pico_wr+ddr_burst_length_pico+1; -- increment address with burst length 
				END IF;
			END IF;
	END PROCESS;


-- read address
	PROCESS(ddr_add_rd,sys_reset,addr_rst_pico_w,addr_rst_pico_r)	     
		BEGIN
			IF(sys_reset='1' or addr_rst_pico_r='1')THEN
				ddr_addr_a_pico_rd<="0000000000000000000000001000";	
			ELSIF (clk_ddr_fifo'EVENT AND clk_ddr_fifo='1')THEN
				if(ddr_add_rd='1' ) THEN
					ddr_addr_a_pico_rd<=ddr_addr_a_pico_rd+ddr_burst_length_pico+1; -- increment address with burst length 
				END IF;
			END IF;
	END PROCESS;	
	
	
	
	
	
	
	
	
	
	
	
	
 

 
 	Inst_cmd_wr_pls: L_TO_P PORT MAP(
		CLK_in =>clk_ddr_fifo ,
		LEVEL =>cmd_en_wr_a ,
		PULSE =>cmd_wr_pls ); 
 
  	Inst_cmd_rd_pls: L_TO_P PORT MAP(
		CLK_in =>clk_ddr_fifo ,
		LEVEL =>cmd_en_rd_a ,
		PULSE =>cmd_rd_pls );
 
 
 
 
 
 	Inst_rd_en_pls: L_TO_P PORT MAP(
		CLK_in =>clk_ddr_fifo ,
		LEVEL =>rd_en_pls_a ,
		PULSE =>rd_en_pls );
 
  	Inst_wr_en_pls: L_TO_P PORT MAP(
		CLK_in =>clk_ddr_fifo ,
		LEVEL =>wr_en_pls_a ,
		PULSE =>wr_en_pls );
 
 
 
 ddr_addr_wr<=ddr_addr_a_pico_wr & "00"; 
 ddr_addr_rd<=ddr_addr_a_pico_rd & "00"; 
--user_ddr_addr<=user_ddr_addr_rd & "00";

clk_ddr_fifo_out<=clk_ddr_fifo;

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
	inst_ddr:ddr2  generic map (
		C3_P0_MASK_SIZE 		=> C3_P0_MASK_SIZE,
		C3_P0_DATA_PORT_SIZE	=> C3_P0_DATA_PORT_SIZE,
		C3_P1_MASK_SIZE 		=> C3_P1_MASK_SIZE,
		C3_P1_DATA_PORT_SIZE	=> C3_P1_DATA_PORT_SIZE,
		C3_MEMCLK_PERIOD 		=> C3_MEMCLK_PERIOD,
		C3_RST_ACT_LOW 			=> C3_RST_ACT_LOW,
		C3_INPUT_CLK_TYPE 		=> C3_INPUT_CLK_TYPE,
		C3_CALIB_SOFT_IP 		=> C3_CALIB_SOFT_IP,
		C3_SIMULATION 			=> C3_SIMULATION,
		DEBUG_EN 				=> DEBUG_EN,
		C3_MEM_ADDR_ORDER 		=> C3_MEM_ADDR_ORDER,
		C3_NUM_DQ_PINS 			=> C3_NUM_DQ_PINS,
		C3_MEM_ADDR_WIDTH 		=> C3_MEM_ADDR_WIDTH,
		C3_MEM_BANKADDR_WIDTH   => C3_MEM_BANKADDR_WIDTH
	)
    port map (

		c3_sys_clk         	=> clk_100Mhz,
		c3_sys_rst_i       	=> sys_reset,                        
	
		mcb3_dram_dq       	=> mcb3_dram_dq,  
		mcb3_dram_a        	=> mcb3_dram_a,  
		mcb3_dram_ba       	=> mcb3_dram_ba,
		mcb3_dram_ras_n    	=> mcb3_dram_ras_n,                        
		mcb3_dram_cas_n    	=> mcb3_dram_cas_n,                        
		mcb3_dram_we_n     	=> mcb3_dram_we_n,                          
		mcb3_dram_cke      	=> mcb3_dram_cke,                          
		mcb3_dram_ck       	=> mcb3_dram_ck,                          
		mcb3_dram_ck_n     	=> mcb3_dram_ck_n,       
		mcb3_dram_dqs      	=> mcb3_dram_dqs,                          
		mcb3_dram_udqs	   	=> mcb3_dram_udqs,    -- for X16 parts           
		mcb3_dram_udm  	   	=> mcb3_dram_udm,     -- for X16 parts
		mcb3_dram_dm  	   	=> mcb3_dram_dm,
		c3_clk0		       	=> clk_ddr_fifo,
		c3_rst0			   	=> c3_rst0,
		c3_calib_done      	=> c3_calib_done,  
		mcb3_rzq           	=> mcb3_rzq,
   --*********************  WRITE CMD ONLY ********************
		c3_p0_cmd_clk      	=> clk_ddr_fifo,
		c3_p0_cmd_en       	=> cmd_wr_pls,
		c3_p0_cmd_instr    	=> "000",-- FOR WRITE,"001" FOR READ
		c3_p0_cmd_bl       	=> ddr_burst_length_pico,--burst length
		c3_p0_cmd_byte_addr	=> ddr_addr_wr,
	--********************* MEM WRITE ONLY ********************	
		c3_p0_wr_clk        => clk_ddr_fifo,
		c3_p0_wr_en         => wr_en_pls,
		c3_p0_wr_mask       => "0000",
		c3_p0_wr_data       => wr_data_a,
		c3_p0_wr_full       => wr_full_a,
	--	c3_p0_wr_empty      => wr_empty_a,   
		c3_p0_wr_error      => wr_error,

		
		c3_p0_rd_clk        =>  clk_ddr_fifo,
		c3_p0_rd_en				=>'0',
--		c3_p0_wr_mask  		=> "0000",
	--********************* PICO READ ONLY PORT ********************
		c3_p1_wr_clk		=> clk_ddr_fifo,  -- not used 
		c3_p1_wr_en			=> '0',  -- not used 
		c3_p1_wr_mask		=> "0000",  -- not used 
		c3_p1_wr_data		=> wr_data_a,  -- not used 

		c3_p1_cmd_clk       => clk_ddr_fifo,
		c3_p1_cmd_en        => cmd_rd_pls,
		c3_p1_cmd_instr     => "001",--"000" FOR WRITE,"001" FOR READ
		c3_p1_cmd_bl        => ddr_burst_length_pico,--burst length
		c3_p1_cmd_byte_addr => ddr_addr_rd, 
		
		c3_p1_rd_clk        =>  clk_ddr_fifo,
		c3_p1_rd_en         =>  rd_en_pls,
		c3_p1_rd_data       =>  rd_data_a,   
		c3_p1_rd_empty      =>  rd_empty_a,   
		c3_p1_rd_error      =>  rd_error,
		
	--********************* USER READ ONLY PORT ********************
		c3_p2_wr_clk		=> clk_ddr_fifo,  -- not used 
		c3_p2_wr_en			=> '0',  -- not used 
		c3_p2_wr_mask		=> "0000",  -- not used 
		c3_p2_wr_data		=> wr_data_a,  -- not used 
		
		c3_p2_cmd_clk       => clk_ddr_fifo,
		c3_p2_cmd_en        => user_cmd_en_rd,
		c3_p2_cmd_instr     => "001",--"000" FOR WRITE,"001" FOR READ
		c3_p2_cmd_bl        => ddr_burst_length_user,--burst length
		c3_p2_cmd_byte_addr => user_ddr_addr_rd,
		
		c3_p2_rd_clk        =>  clk_ddr_fifo,
		c3_p2_rd_en         =>  user_rd_en_pls,
		c3_p2_rd_data       =>  user_ddr_data_rd,   
		c3_p2_rd_empty      =>  user_rd_empty,   
		c3_p2_rd_error      =>  user_rd_error		

	);

ddr_error<=wr_error or rd_error;



	Inst_user_read_control: user_read_control PORT MAP(
		clk =>clk_ddr_fifo ,
		reset =>sys_reset ,
		USER_ADDRESS_RES =>USER_ADDRESS_RES ,
		load_start_address =>load_start_address ,
		start_address =>start_address ,
		start_read =>start_read ,
		DATA_OUT1 =>DATA_OUT1 ,
		DATA_OUT2 =>DATA_OUT2 ,
		
		user_ddr_data_rd =>user_ddr_data_rd ,
		user_ddr_addr_rd =>user_ddr_addr_rd ,
		user_rd_en_pls =>user_rd_en_pls ,
		user_rd_error =>user_rd_error ,
		user_rd_empty =>user_rd_empty ,
		user_cmd_en_rd =>user_cmd_en_rd 
	);
	
	
    


end Behavioral;

