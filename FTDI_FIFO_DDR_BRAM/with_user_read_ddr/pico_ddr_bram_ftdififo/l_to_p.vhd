


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--USE PRINTER_PACK.ALL;

ENTITY L_TO_P IS
    PORT ( CLK_in : IN  STD_LOGIC;
         LEVEL : IN  STD_LOGIC;
			PULSE : OUT  STD_LOGIC
		);
END L_TO_P;

ARCHITECTURE Beh OF L_TO_P IS
--*******************************************************************************************************************
--*******************************************************SIGNALS LEVEL TO PULSE GEBERATOR***********************************************************


   SIGNAL D_POS,D_NEG:STD_LOGIC;
   SIGNAL D_OUT_POS,D_OUT_NEG:STD_LOGIC;
   SIGNAL clk:STD_LOGIC;

BEGIN 



           clk<=CLK_in;       
       D_POS<= LEVEL;
       
    PROCESS(CLK)
       VARIABLE T1:STD_LOGIC;    
    BEGIN
        IF(CLK'EVENT AND CLK='1')THEN
            T1:=D_POS;
        END IF;
            D_OUT_POS<=T1;
   END PROCESS;
	
D_NEG<=D_POS AND D_OUT_POS;

    PROCESS(CLK)
       VARIABLE T1:STD_LOGIC;    
    BEGIN
        IF(CLK'EVENT AND CLK='1')THEN
            T1:=NOT (D_NEG);
        END IF;
            D_OUT_NEG<=T1;
   END PROCESS;

PULSE<=D_OUT_POS AND D_OUT_NEG;

    END beh;
        

	