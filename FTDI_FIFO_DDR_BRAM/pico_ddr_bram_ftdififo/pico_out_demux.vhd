-- thus is only demux 
LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY PICO_OUT IS
    generic(bus_width:INTEGER:=4);
    
	PORT( strobe	: IN	STD_LOGIC;
		OUT_PORT_NO: OUT	STD_LOGIC_VECTOR((2**bus_width-1) DOWNTO 0);
add: IN	STD_LOGIC_VECTOR((bus_width-1) DOWNTO 0));
END PICO_OUT;

ARCHITECTURE BEH OF PICO_OUT IS
SIGNAL   DECODER: 	STD_LOGIC_VECTOR((2**bus_width-1) DOWNTO 0);
BEGIN
    
  

GEN_LABEL: for I in (2**bus_width-1) downto 0 generate
DECODER(I)<= '1'when add = I else '0';
end generate GEN_LABEL;


process(strobe,DECODER)
    begin 
        IF(strobe='1') THEN
       OUT_PORT_NO<= DECODER;
    ELSE
        
    OUT_PORT_NO<=(OTHERS=>'0');
    END IF;
        
        
        
        
    end process;




end beh;