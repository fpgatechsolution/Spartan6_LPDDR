

    LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_ARITH.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;


  ENTITY user_read_control IS
	PORT ( 
	       clk,reset : in  STD_LOGIC;
	       USER_ADDRESS_RES:  in  STD_LOGIC;
           load_start_address: in  STD_LOGIC;
           start_address: in  std_logic_vector(27 downto 0);-- must be in multiple of 2 ( address start from )
           start_read:in  STD_LOGIC;
           DATA_OUT1: OUT std_logic_vector(31 downto 0);
           DATA_OUT2: OUT std_logic_vector(31 downto 0);
           
           
           user_ddr_data_rd :	in std_logic_vector(31 downto 0);
           user_ddr_addr_rd :   out std_logic_vector(29 downto 0);
           user_rd_en_pls   :   out std_logic;
           user_rd_error    :   in std_logic;
           user_rd_empty    :   in std_logic;
           user_cmd_en_rd   :   out std_logic
           
           
                  
          
       );
END user_read_control;

ARCHITECTURE BEHAVIORAL OF user_read_control IS

	constant ddr_burst_length_user   : std_logic_vector(5 downto 0) := "000001"; -- START FROM 0
   

     
    TYPE M_STATE_TYPE IS (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11	 );
    SIGNAL M_STATE : M_STATE_TYPE;    
SIGNAL ddr_addr:std_logic_vector(27 downto 0):= "0000000000000000000000001000";
  SIGNAL  address_cnt_en:std_logic;
    BEGIN





        PROCESS(CLK)
		
          BEGIN
    IF(RESET='1' )THEN
address_cnt_en<='0';
user_rd_en_pls<='0';
user_cmd_en_rd<='0';
    
    ELSIF CLK'EVENT AND CLK = '1' THEN
        
                CASE M_STATE IS		
                
                    WHEN S0=>
					
address_cnt_en<='0';
							
							IF(start_read='1')THEN
                                M_STATE <= S1;
                            else 
                                M_STATE <= S0;
							END IF;
					
					
					WHEN S1=>

							user_cmd_en_rd<='1';
                			M_STATE <= S2;
                
					WHEN S2=>
                
                            user_cmd_en_rd<='0';
							M_STATE <= S3;
 
					WHEN S3=>
					
						--	user_rd_en_pls<='1';
								M_STATE <= S4;
							
      
					WHEN S4=>
                   --             user_rd_en_pls<='0';
							     M_STATE <= S5;
										 
					WHEN S5=>					 
										if(user_rd_empty ='0')then
										 user_rd_en_pls<='1';
			                             M_STATE <= S6;			                             
			                             ELSE
			                             M_STATE <= S5;
			                             END IF;
										 
					WHEN S6=>
                                        user_rd_en_pls<='0';
													  DATA_OUT1<= user_ddr_data_rd;
													 M_STATE <= S7;
													 
					WHEN S7=>
                                        --user_rd_en_pls<='0';									 
													 
													 
                                       
										M_STATE <= S8;
										
										
				    WHEN S8=>
                                     user_rd_en_pls<='1';
                                     M_STATE <= S9;	

					WHEN S9=>
                                     user_rd_en_pls<='0';
												 DATA_OUT2<= user_ddr_data_rd;
                                     M_STATE <= S10;									 

				    WHEN S10=>
                                   --  user_rd_en_pls<='0';
                                      
                                      address_cnt_en<='1';
                                     M_STATE <= S0;	
                                     
                                     	 
 
                    WHEN OTHERS=>	NULL;
                        
                        
                END CASE ;
    END IF;

    END PROCESS;
    
    
    
    
    	PROCESS(clk,RESET,load_start_address, address_cnt_en)	     
        BEGIN
   
            IF( RESET='1' or USER_ADDRESS_RES='1' )THEN
                ddr_addr<="0000000000000000000000001000";    
            ELSIF (clk'EVENT AND clk='1')THEN
                IF(load_start_address='1')THEN
                    ddr_addr<=start_address;
                elsif(address_cnt_en='1' ) THEN
                    ddr_addr<=ddr_addr+ddr_burst_length_user+1; -- increment address with burst length 
                END IF;
            END IF;
    END PROCESS;
    
    
    user_ddr_addr_rd<=ddr_addr &"00";
   
    END BEHAVIORAL;



