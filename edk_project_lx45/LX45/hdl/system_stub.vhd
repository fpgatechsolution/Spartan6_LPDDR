-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
  port (
    RS232_Uart_1_sout : out std_logic;
    RS232_Uart_1_sin : in std_logic;
    RESET : in std_logic;
    MCB_DDR3_rzq : inout std_logic;
    MCB_DDR3_dram_we_n : out std_logic;
    MCB_DDR3_dram_udqs : inout std_logic;
    MCB_DDR3_dram_udm : out std_logic;
    MCB_DDR3_dram_ras_n : out std_logic;
    MCB_DDR3_dram_ldm : out std_logic;
    MCB_DDR3_dram_dqs : inout std_logic;
    MCB_DDR3_dram_dq : inout std_logic_vector(15 downto 0);
    MCB_DDR3_dram_clk_n : out std_logic;
    MCB_DDR3_dram_clk : out std_logic;
    MCB_DDR3_dram_cke : out std_logic;
    MCB_DDR3_dram_cas_n : out std_logic;
    MCB_DDR3_dram_ba : out std_logic_vector(1 downto 0);
    MCB_DDR3_dram_addr : out std_logic_vector(12 downto 0);
    LEDS_TRI_O : out std_logic_vector(0 to 9);
    clock_generator_0_CLKIN_pin : in std_logic
  );
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
    port (
      RS232_Uart_1_sout : out std_logic;
      RS232_Uart_1_sin : in std_logic;
      RESET : in std_logic;
      MCB_DDR3_rzq : inout std_logic;
      MCB_DDR3_dram_we_n : out std_logic;
      MCB_DDR3_dram_udqs : inout std_logic;
      MCB_DDR3_dram_udm : out std_logic;
      MCB_DDR3_dram_ras_n : out std_logic;
      MCB_DDR3_dram_ldm : out std_logic;
      MCB_DDR3_dram_dqs : inout std_logic;
      MCB_DDR3_dram_dq : inout std_logic_vector(15 downto 0);
      MCB_DDR3_dram_clk_n : out std_logic;
      MCB_DDR3_dram_clk : out std_logic;
      MCB_DDR3_dram_cke : out std_logic;
      MCB_DDR3_dram_cas_n : out std_logic;
      MCB_DDR3_dram_ba : out std_logic_vector(1 downto 0);
      MCB_DDR3_dram_addr : out std_logic_vector(12 downto 0);
      LEDS_TRI_O : out std_logic_vector(0 to 9);
      clock_generator_0_CLKIN_pin : in std_logic
    );
  end component;

  attribute BOX_TYPE : STRING;
  attribute BOX_TYPE of system : component is "user_black_box";

begin

  system_i : system
    port map (
      RS232_Uart_1_sout => RS232_Uart_1_sout,
      RS232_Uart_1_sin => RS232_Uart_1_sin,
      RESET => RESET,
      MCB_DDR3_rzq => MCB_DDR3_rzq,
      MCB_DDR3_dram_we_n => MCB_DDR3_dram_we_n,
      MCB_DDR3_dram_udqs => MCB_DDR3_dram_udqs,
      MCB_DDR3_dram_udm => MCB_DDR3_dram_udm,
      MCB_DDR3_dram_ras_n => MCB_DDR3_dram_ras_n,
      MCB_DDR3_dram_ldm => MCB_DDR3_dram_ldm,
      MCB_DDR3_dram_dqs => MCB_DDR3_dram_dqs,
      MCB_DDR3_dram_dq => MCB_DDR3_dram_dq,
      MCB_DDR3_dram_clk_n => MCB_DDR3_dram_clk_n,
      MCB_DDR3_dram_clk => MCB_DDR3_dram_clk,
      MCB_DDR3_dram_cke => MCB_DDR3_dram_cke,
      MCB_DDR3_dram_cas_n => MCB_DDR3_dram_cas_n,
      MCB_DDR3_dram_ba => MCB_DDR3_dram_ba,
      MCB_DDR3_dram_addr => MCB_DDR3_dram_addr,
      LEDS_TRI_O => LEDS_TRI_O,
      clock_generator_0_CLKIN_pin => clock_generator_0_CLKIN_pin
    );

end architecture STRUCTURE;

