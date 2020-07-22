----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:21:55 05/30/2016 
-- Design Name: 
-- Module Name:    rs_232 - Behavioral 
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



entity rs_232 is
    Port ( clk_12 : in  STD_LOGIC;
           reset : in  STD_LOGIC;
--------------RX-----------------           
			  rx_232 : in  STD_LOGIC;
           rx_strobe : out  STD_LOGIC;
			  rd_pulse: in  STD_LOGIC;
           rx_data : out  STD_LOGIC_VECTOR (7 downto 0);
--------------TX-----------------			  
			  tx_232 : out  STD_LOGIC;
           tx_strobe : in  STD_LOGIC;
           tx_data : in  STD_LOGIC_VECTOR (7 downto 0)
			  
			  );
end rs_232;

architecture Behavioral of rs_232 is

	COMPONENT basic_uart
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		tx_data : IN std_logic_vector(7 downto 0);
		tx_enable : IN std_logic;
		rx : IN std_logic;          
		rx_data : OUT std_logic_vector(7 downto 0);
		rx_enable : OUT std_logic;
		tx_ready : OUT std_logic;
		tx : OUT std_logic
		);
	END COMPONENT;

	COMPONENT latch
	PORT(
		in_b : IN std_logic_vector(7 downto 0);
		clk : IN std_logic;
		en : IN std_logic;          
		out_b : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
		COMPONENT SRf1
	PORT(
		set : IN std_logic;
		reset : IN std_logic;          
		Q : OUT std_logic
		);
	END COMPONENT;





signal rx_enb :   STD_LOGIC;

signal rx_data1 :   STD_LOGIC_VECTOR (7 downto 0);
begin
	Inst_basic_uart: basic_uart PORT MAP(
		clk =>clk_12 ,
		reset =>'0' ,
		rx_data =>rx_data1 ,
		rx_enable =>rx_enb ,
		tx_data =>tx_data ,
		tx_enable =>tx_strobe ,
		tx_ready =>open ,
		rx =>rx_232 ,
		tx =>tx_232 
	);



	Inst_latch: latch PORT MAP(
		in_b =>rx_data1 ,
		clk => clk_12,
		out_b => rx_data,
		en => rx_enb
	);


 	Inst_SRf1: SRf1 PORT MAP(
		set =>rx_enb ,
		reset =>rd_pulse ,
		Q => rx_strobe
	);





end Behavioral;

