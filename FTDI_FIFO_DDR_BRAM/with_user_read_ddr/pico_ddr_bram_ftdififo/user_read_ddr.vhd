

    LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_ARITH.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;


  ENTITY user_read_control IS
	PORT ( 
	        clk,reset : in  STD_LOGIC;    
           start_read:in  STD_LOGIC;
           DATA_OUT1: OUT std_logic_vector(31 downto 0);
           DATA_OUT2: OUT std_logic_vector(31 downto 0);
			  user_data_valid: OUT std_logic;
           
           
           user_ddr_data_rd :	in std_logic_vector(31 downto 0);
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
user_data_valid<='0';    
    ELSIF CLK'EVENT AND CLK = '1' THEN
        
                CASE M_STATE IS		
                
                    WHEN S0=>
					
user_data_valid<='0';
							
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
										if(user_rd_empty ='0')then
										
			                             M_STATE <= S4;			                             
			                             ELSE
			                             M_STATE <= S3;
			                             END IF;
										 
					WHEN S4=>
					
											user_rd_en_pls<='1';
                                       M_STATE <= S5;
													 
					WHEN S5=>
                                       							 
												 user_rd_en_pls<='0';
													 DATA_OUT1<= user_ddr_data_rd;	
													 M_STATE <= S6;	 
													 
                WHEN S6=>      
															 
											M_STATE <= S7;
										
										
				    WHEN S7=>
                                     user_rd_en_pls<='1';
                                     M_STATE <= S8;	

					WHEN S8=>
                                     user_rd_en_pls<='0';												 
                                     M_STATE <= S9;
												DATA_OUT2<= user_ddr_data_rd;												 

					WHEN S9=>
												
												M_STATE <= S10;

				    WHEN S10=>                                                                      
                                     user_data_valid<='1';
                                     M_STATE <= S11;	
                WHEN S11=>                      
                                     	   M_STATE <= S0;
 
                    WHEN OTHERS=>	NULL;
                        
                        
                END CASE ;
    END IF;

    END PROCESS;
    
    
    
    

    

   
    END BEHAVIORAL;



