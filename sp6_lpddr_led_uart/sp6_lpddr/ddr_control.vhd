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
   	ddr_addr_wr:in std_logic_vector(29 downto 0);
	ddr_addr_rd:in std_logic_vector(29 downto 0);

	ddr_data_wr:in std_logic_vector(31 downto 0);		
	ddr_data_rd:out std_logic_vector(31 downto 0);
    cmd_en_wr:in std_logic;
    cmd_en_rd:in std_logic;
	wr_full:out std_logic;
	wr_en_pls:in std_logic;
    rd_en_pls:in std_logic;    
	wr_empty: out std_logic;
    rd_empty: out std_logic;
   ddr_error:out std_logic
   
   );
end ddr_control;

architecture Behavioral of ddr_control is

	 
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
	
	
    SIGNAL  clk_ddr_fifo:std_logic;
	SIGNAL wr_error,rd_error:std_logic;

	
   SIGNAL clkA_addr:std_logic;
 
	

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
   c3_p1_rd_error                          : out std_logic
);
end component;



begin

--assign ddr_addr_a_wr={ddr_addr_a_pico_wr,2'b00};
--assign ddr_addr_a_rd={ddr_addr_a_pico_rd,2'b00};


clk_ddr_fifo_out<=clk_ddr_fifo;

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
  inst_ddr:ddr2  generic map (
    C3_P0_MASK_SIZE => C3_P0_MASK_SIZE,
    C3_P0_DATA_PORT_SIZE => C3_P0_DATA_PORT_SIZE,
    C3_P1_MASK_SIZE => C3_P1_MASK_SIZE,
    C3_P1_DATA_PORT_SIZE => C3_P1_DATA_PORT_SIZE,
    C3_MEMCLK_PERIOD => C3_MEMCLK_PERIOD,
    C3_RST_ACT_LOW => C3_RST_ACT_LOW,
    C3_INPUT_CLK_TYPE => C3_INPUT_CLK_TYPE,
    C3_CALIB_SOFT_IP => C3_CALIB_SOFT_IP,
    C3_SIMULATION => C3_SIMULATION,
    DEBUG_EN => DEBUG_EN,
    C3_MEM_ADDR_ORDER => C3_MEM_ADDR_ORDER,
    C3_NUM_DQ_PINS => C3_NUM_DQ_PINS,
    C3_MEM_ADDR_WIDTH => C3_MEM_ADDR_WIDTH,
    C3_MEM_BANKADDR_WIDTH => C3_MEM_BANKADDR_WIDTH
)
    port map (

    c3_sys_clk       =>    clk_100Mhz,
  c3_sys_rst_i    	 =>    sys_reset,                        

  mcb3_dram_dq       =>    mcb3_dram_dq,  
  mcb3_dram_a        =>    mcb3_dram_a,  
  mcb3_dram_ba       =>    mcb3_dram_ba,
  mcb3_dram_ras_n    =>    mcb3_dram_ras_n,                        
  mcb3_dram_cas_n    =>    mcb3_dram_cas_n,                        
  mcb3_dram_we_n     =>    mcb3_dram_we_n,                          
  mcb3_dram_cke      =>    mcb3_dram_cke,                          
  mcb3_dram_ck       =>    mcb3_dram_ck,                          
  mcb3_dram_ck_n     =>    mcb3_dram_ck_n,       
  mcb3_dram_dqs      =>    mcb3_dram_dqs,                          
  mcb3_dram_udqs  	 =>    mcb3_dram_udqs,    -- for X16 parts           
  mcb3_dram_udm  	 =>    mcb3_dram_udm,     -- for X16 parts
  mcb3_dram_dm  	 =>    mcb3_dram_dm,
  c3_clk0			 =>	   clk_ddr_fifo,
  c3_rst0			 =>    c3_rst0,
	
 
  c3_calib_done      =>    c3_calib_done,  
   mcb3_rzq          =>     mcb3_rzq,
   --********************* MEM WRITE ONLY ********************
   c3_p0_cmd_clk       =>  clk_ddr_fifo,
   c3_p0_cmd_en        =>  cmd_en_wr,
   c3_p0_cmd_instr     =>  "000",
   c3_p0_cmd_bl        =>  "000001",
   c3_p0_cmd_byte_addr =>  ddr_addr_wr,
   --c3_p0_cmd_empty     =>  open,   
   
   c3_p0_wr_clk        =>  clk_ddr_fifo,
   c3_p0_wr_en         =>  wr_en_pls,
   c3_p0_wr_mask       =>  "0000",
   c3_p0_wr_data       =>  ddr_data_wr,
   c3_p0_wr_full       =>  wr_full,
   c3_p0_wr_empty      =>  wr_empty,   
   c3_p0_wr_error      =>  wr_error,
   --c3_p0_wr_count      =>  OPEN,
   
	c3_p0_rd_clk			=> clk_ddr_fifo,	
	c3_p0_rd_en				=> '0',
    --********************* MEM READ ONLY ********************
	 c3_p1_wr_clk			=>clk_ddr_fifo,
	 c3_p1_wr_en			=>'0',
	 c3_p1_wr_mask			=>"0000",
	 c3_p1_wr_data			=>ddr_data_wr,
	 
	 
   c3_p1_cmd_clk       =>  clk_ddr_fifo,
   c3_p1_cmd_en        =>  cmd_en_rd,
   c3_p1_cmd_instr     =>  "001",
   c3_p1_cmd_bl        =>  "000001",
   c3_p1_cmd_byte_addr =>  ddr_addr_rd,   
   
   c3_p1_rd_clk        =>  clk_ddr_fifo,
   c3_p1_rd_en         =>  rd_en_pls,
   c3_p1_rd_data       =>  ddr_data_rd,   
   c3_p1_rd_empty      =>  rd_empty,   
   c3_p1_rd_error      =>  rd_error
   --c3_p1_rd_count      =>  OPEN
 );

ddr_error<=wr_error or rd_error;


end Behavioral;

