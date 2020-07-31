
----------------------------------------------------------------------------------
-- COMPANY      : FPGATECHSOLUTION
-- MODULE NAME  : UART_RECEIVER
-- URL     		: WWW.FPGATECHSOLUTION.COM
----------------------------------------------------------------------------------
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY TOP IS
    PORT ( 
		CLOCK_12MHZ : IN  STD_LOGIC;
		clk_100mhz : IN  STD_LOGIC;
		RESET: IN  STD_LOGIC;
		
TEST_LED : OUT std_logic_vector(7 downto 0);
   
		usb_data : INOUT std_logic_vector(7 downto 0);
		rd_n : OUT std_logic;
		wr_n : OUT std_logic;
		rxf_n : IN std_logic;
		txe_n : IN std_logic;
--TEST1: OUT std_logic;
	  
	  	mcb3_dram_dq : INOUT std_logic_vector(15 downto 0);
		mcb3_dram_udqs : INOUT std_logic;
		mcb3_dram_dqs : INOUT std_logic;
		mcb3_rzq : INOUT std_logic;      
		mcb3_dram_a : OUT std_logic_vector(12 downto 0);
		mcb3_dram_ba : OUT std_logic_vector(1 downto 0);
		mcb3_dram_ras_n : OUT std_logic;
		mcb3_dram_cas_n : OUT std_logic;
		mcb3_dram_we_n : OUT std_logic;
		mcb3_dram_cke : OUT std_logic;
		mcb3_dram_dm : OUT std_logic;
		mcb3_dram_udm : OUT std_logic;
		mcb3_dram_ck : OUT std_logic;
		mcb3_dram_ck_n : OUT std_logic
	

		
	

);
END TOP;

ARCHITECTURE BEHAVIORAL OF TOP IS


	COMPONENT control
	PORT(
		CLK_OSC : IN std_logic;
		reset : IN std_logic;
		rxf_n : IN std_logic;
		txe_n : IN std_logic;
		bram_data_in : IN std_logic_vector(7 downto 0);
		wr_full_a : IN std_logic;
		rd_data_a : IN std_logic_vector(31 downto 0);
		rd_empty_a : IN std_logic;
		ddr_error : IN std_logic;    
		usb_data : INOUT std_logic_vector(7 downto 0);      
		rd_n : OUT std_logic;
		wr_n : OUT std_logic;
		bram_data_out : OUT std_logic_vector(7 downto 0);
		Bram_w_r : OUT std_logic;
		address_7_0 : OUT std_logic_vector(7 downto 0);
		address_15_8 : OUT std_logic_vector(7 downto 0);
		led_test : OUT std_logic_vector(7 downto 0);
		cmd_en_wr_a : OUT std_logic;
		WR_RD_CMD : OUT std_logic_vector(2 downto 0);
			addr_rst_pico_w: out  std_logic;
			addr_rst_pico_r: out  std_logic;	

	       -- Register interface
            User_RegAddr : out std_logic_vector(15 downto 0);
            User_RegDataIn : in std_logic_vector(7 downto 0);
            User_RegDataOut : out std_logic_vector(7 downto 0);
            User_RegWE : out std_logic;
            User_RegRE : out std_logic;
			
					User_read_start : out std_logic;
						User_ddrDataIn1: in std_logic_vector(31 downto 0);
			User_ddrDataIn2: in std_logic_vector(31 downto 0);	
				
		wr_en_pls_a : OUT std_logic;
		wr_data_a : OUT std_logic_vector(31 downto 0);
		ddr_add_inc_pico : OUT std_logic;
--		addr_rst_pico : OUT std_logic;
		rd_en_pls_a : OUT std_logic
		);
	END COMPONENT;


	COMPONENT BRAM
	PORT(
	clka:in std_logic;
	wea:in std_logic_vector(0 downto 0);
	addra:in std_logic_vector(13 downto 0);
	dina:in std_logic_vector(7 downto 0);
	douta:OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	COMPONENT ddr_control
	PORT(
		clk_100Mhz : IN std_logic;
		sys_reset : IN std_logic;
		cmd_en_wr_a : IN std_logic;
		WR_RD_CMD : IN std_logic_vector(2 downto 0);

		wr_en_pls_a : IN std_logic;
		wr_data_a : IN std_logic_vector(31 downto 0);
		ddr_add_inc_pico : IN std_logic;
		addr_rst_pico_w: in  std_logic;
		addr_rst_pico_r: in  std_logic;
		rd_en_pls_a : IN std_logic;
		ddr_error : OUT std_logic;   
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
		USER_ADDRESS_RES:  in  STD_LOGIC;
		load_start_address: in  STD_LOGIC;
		start_address: in  std_logic_vector(27 downto 0);-- must be in multiple of 2 ( address start from )
		start_read:in  STD_LOGIC;
		DATA_OUT1: OUT std_logic_vector(31 downto 0);
		DATA_OUT2: OUT std_logic_vector(31 downto 0)		
		);
	END COMPONENT;



	signal	  bram_data_in:   STD_LOGIC_VECTOR (7 downto 0);
	signal	  bram_data_out:   STD_LOGIC_VECTOR (7 downto 0);
	signal	  Bram_w_r:  STD_LOGIC;
	signal	  address_7_0:   STD_LOGIC_VECTOR (7 downto 0);
	signal	  address_15_8:   STD_LOGIC_VECTOR (7 downto 0);
	signal	  Bram_w_r_en:   STD_LOGIC_VECTOR (0 downto 0);
	signal	  bram_address:   STD_LOGIC_VECTOR (13 downto 0);
	   

	
	
	--///**** write & read control******

	signal cmd_en_wr_a   : std_logic;
	signal WR_RD_CMD     : std_logic_vector(2 downto 0);	

--///**** write control******
	signal wr_en_pls_a   :   std_logic;	
	signal wr_full_a     :   std_logic;
	signal wr_data_a 	 :  std_logic_vector(31 downto 0);
	signal ddr_add_inc_pico:   std_logic;
	signal addr_rst_pico:   std_logic;
--///**** read control*****
	signal rd_en_pls_a	:   std_logic;
	signal rd_data_a 	:  std_logic_vector(31 downto 0);
	signal rd_empty_a	:  std_logic;
    signal ddr_error    :  std_logic;

	
	
	--///**** read control*****
   
    signal user_ddr_data_rd :	std_logic_vector(31 downto 0);
	signal user_ddr_addr_rd :	std_logic_vector(27 downto 0);
	signal user_rd_en_pls	:	std_logic;
	signal user_rd_error    :	std_logic;
	signal user_rd_empty    :	std_logic;
	signal user_cmd_en_rd	:	std_logic;
	
	signal USER_ADDRESS_RES:    STD_LOGIC:= '0';
	signal load_start_address:   STD_LOGIC:= '0';
	signal start_address:   std_logic_vector(27 downto 0);-- must be in multiple of 2 ( address start from )
	signal start_read:  STD_LOGIC:= '0';
	signal DATA_OUT1:  std_logic_vector(31 downto 0);
	signal DATA_OUT2:  std_logic_vector(31 downto 0);
	
	
	
	
	
	
	
	
	
	signal c3_calib_done:	std_logic;
	
	signal addr_rst_pico_w:	std_logic;
	signal addr_rst_pico_r:	std_logic;

		
			       -- Register interface
   signal    User_RegAddr :  std_logic_vector(15 downto 0);
   signal    User_RegDataIn :  std_logic_vector(7 downto 0);
   signal    User_RegDataOut :  std_logic_vector(7 downto 0);
   signal    User_RegWE :  std_logic;
    signal   User_RegRE :  std_logic;
		
		    -- Interrupt signal
    signal Interrupt : std_logic;

    -- Registers
    signal user_reg : std_logic_vector(7 downto 0);
	signal user_reg1 : std_logic_vector(7 downto 0);	
	

signal start_rd_user_ddr, start_read_pico : std_logic;
	
	
BEGIN





	Inst_control: control PORT MAP(
		CLK_OSC =>CLOCK_12MHZ ,
		led_test =>OPEN,--TEST_LED(7 downto 0) ,
		reset =>reset,
		----///**** USB fifo control ******
		usb_data =>usb_data,
		rxf_n =>rxf_n,
		txe_n =>txe_n,
		rd_n =>rd_n,
		wr_n =>wr_n,
		----///**** blockram control ******
		bram_data_in => bram_data_in,
		bram_data_out =>bram_data_out ,
		Bram_w_r =>Bram_w_r,
		address_7_0 =>address_7_0 ,
		address_15_8 =>address_15_8, 
		----///**** User register ******
		User_RegAddr    =>User_RegAddr,    
		User_RegDataIn 	=>User_RegDataOut, 	
		User_RegDataOut	=>User_RegDataIn ,	
		User_RegWE 		=>User_RegWE, 		
		User_RegRE 		=>User_RegRE, 	
		
		User_read_start =>start_read_pico,
		User_ddrDataIn1  =>DATA_OUT1,
		User_ddrDataIn2	 =>DATA_OUT2,
			
		----///**** ddr control******		
		cmd_en_wr_a   =>cmd_en_wr_a ,
		WR_RD_CMD     =>WR_RD_CMD ,
		
		wr_en_pls_a =>wr_en_pls_a ,
		wr_full_a   =>wr_full_a ,
		wr_data_a   =>wr_data_a ,
		ddr_add_inc_pico => ddr_add_inc_pico,
		addr_rst_pico_w =>addr_rst_pico_w ,
		addr_rst_pico_r =>addr_rst_pico_r ,
		rd_en_pls_a => rd_en_pls_a,
		rd_data_a   => rd_data_a,
		rd_empty_a  => rd_empty_a,
		ddr_error=>ddr_error);
		
		

	Inst_BRAM: BRAM PORT MAP(
		clka=>CLOCK_12MHZ,
		wea=>Bram_w_r_en,
		addra=>bram_address,
		dina=>bram_data_out,
		douta=>bram_data_in	);


		bram_address<=address_15_8(5 downto 0) & address_7_0;--
		Bram_w_r_en(0)<=Bram_w_r;



	
			Inst_ddr_control: ddr_control PORT MAP(
		clk_100Mhz =>clk_100mhz  ,
		sys_reset =>RESET ,
		c3_calib_done =>c3_calib_done,
		clk_ddr_fifo_out =>open ,
		c3_rst0 =>open ,
		mcb3_dram_dq =>mcb3_dram_dq ,
		mcb3_dram_a =>mcb3_dram_a ,
		mcb3_dram_ba =>mcb3_dram_ba ,
		mcb3_dram_cke =>mcb3_dram_cke ,
		mcb3_dram_ras_n =>mcb3_dram_ras_n ,
		mcb3_dram_cas_n =>mcb3_dram_cas_n ,
		mcb3_dram_we_n =>mcb3_dram_we_n ,
		mcb3_dram_dm =>mcb3_dram_dm ,
		mcb3_dram_udqs =>mcb3_dram_udqs ,
		mcb3_dram_udm =>mcb3_dram_udm ,
		mcb3_dram_dqs =>mcb3_dram_dqs ,
		mcb3_dram_ck =>mcb3_dram_ck ,
		mcb3_dram_ck_n =>mcb3_dram_ck_n ,
		mcb3_rzq=>mcb3_rzq,
		
		cmd_en_wr_a   =>cmd_en_wr_a ,
		WR_RD_CMD     =>WR_RD_CMD ,

		
		wr_en_pls_a =>wr_en_pls_a ,
		wr_full_a   =>wr_full_a ,
		wr_data_a   =>wr_data_a ,
		ddr_add_inc_pico => ddr_add_inc_pico,
		addr_rst_pico_w =>addr_rst_pico_w ,
		addr_rst_pico_r =>addr_rst_pico_r ,		
		rd_en_pls_a => rd_en_pls_a,
		rd_data_a   => rd_data_a,
		rd_empty_a  => rd_empty_a,
		ddr_error=>ddr_error,
		-- user read interface 
		USER_ADDRESS_RES =>USER_ADDRESS_RES ,
		load_start_address =>load_start_address ,
		start_address =>start_address ,
		start_read =>start_read ,
		DATA_OUT1 =>DATA_OUT1 ,
		DATA_OUT2 =>DATA_OUT2 
	);
	
		
	
start_read<=start_rd_user_ddr or start_read_pico;
	

	--TEST_LED(0)<=user_rd_error or ddr_error ;--c3_calib_done;
	
-------------------------------------------------------------------------------
	-- Implement register write

    process (RESET, CLOCK_12MHZ,User_RegWE,User_RegAddr)
    begin

		if (CLOCK_12MHZ'event and CLOCK_12MHZ='1') then
            if (User_RegWE='1') then

                case User_RegAddr is
                    when X"1000" => Interrupt <= '1';start_rd_user_ddr<= '1';
					when X"1001" => Interrupt <= '0';start_rd_user_ddr<= '0';
                    when X"1063" => user_reg <= User_RegDataIn + 1; -- 99 decimal
					when X"1011" => user_reg1 <= User_RegDataIn ; --  decimal
					
					when X"1022" => start_address(27 downto 24) <= User_RegDataIn(3 downto 0); --  decimal
					when X"1023" => start_address(23 downto 16) <= User_RegDataIn ; --  decimal					
					when X"1024" => start_address(15 downto 8) <= User_RegDataIn ; --  decimal
					when X"1025" => start_address(7 downto 0)  <= User_RegDataIn ; --  decimal	
					
					when X"1026" =>  USER_ADDRESS_RES<='1' ; --  decimal
					when X"1027" =>  USER_ADDRESS_RES<='0' ; --  decimal					
					when X"1028" =>  load_start_address<='1' ; --  decimal
					when X"1029" =>  load_start_address<='0' ; --  decimal						 
						 
						 
                    when others => Interrupt <= '0';
                end case;

            else
                Interrupt <= '0';
            end if;
        end if;
    end process;

    -- Implement register read
    process (User_RegAddr, user_reg,user_reg1)
    begin
        case User_RegAddr is
            when X"1063" => User_RegDataOut <= user_reg; -- 99 decimal
			--when X"1011" => User_RegDataOut <= user_reg1; --  decimal
			
			when X"1011" => User_RegDataOut <= DATA_OUT1(31 downto 24); --  decimal
			when X"1012" => User_RegDataOut <= DATA_OUT1(23 downto 16); --  decimal
			when X"1013" => User_RegDataOut <= DATA_OUT1(15 downto 8); --  decimal
			when X"1014" => User_RegDataOut <= DATA_OUT1(7 downto 0); --  decimal

			when X"1015" => User_RegDataOut <= DATA_OUT2(31 downto 24);
			when X"1016" => User_RegDataOut <= DATA_OUT2(23 downto 16);
			when X"1017" => User_RegDataOut <= DATA_OUT2(15 downto 8); 
			when X"1018" => User_RegDataOut <= DATA_OUT2(7 downto 0); 


			
			
            when others => User_RegDataOut <= X"00";
        end case;
    end process;

	TEST_LED<=user_reg1;


		
	
END BEHAVIORAL;



