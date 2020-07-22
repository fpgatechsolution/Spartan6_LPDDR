
----------------------------------------------------------------------------------
-- COMPANY      : FPGATECHSOLUTION
-- MODULE NAME  : UART_RECEIVER
-- URL     		: WWW.FPGATECHSOLUTION.COM
----------------------------------------------------------------------------------
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library unisim;
use unisim.vcomponents.all;

entity control is
    Port ( CLK_OSC : in  STD_LOGIC;
           rx_232 : in  STD_LOGIC;
			  tx_232 : out  STD_LOGIC;
			  
			  usb_data  : inout std_logic_vector(7 downto 0);
			  rxf_n : in    std_logic;
			  txe_n : in    std_logic;
			  rd_n  : out   std_logic;
			  wr_n  : out   std_logic;
			  
			  bram_data_in: in  STD_LOGIC_VECTOR (7 downto 0);
			  bram_data_out: out  STD_LOGIC_VECTOR (7 downto 0);
			  Bram_w_r:out  STD_LOGIC;
			  address_7_0: out  STD_LOGIC_VECTOR (7 downto 0);
			  address_15_8: out  STD_LOGIC_VECTOR (7 downto 0);
			  led_test :  out  STD_LOGIC_VECTOR (7 downto 0);	
			  
           reset : in  STD_LOGIC);
end control;

architecture Behavioral of control is


	COMPONENT rs_232
	PORT(
		clk_12 : IN std_logic;
		reset : IN std_logic;
		rx_232 : IN std_logic;
		rd_pulse : IN std_logic;
		tx_strobe : IN std_logic;
		tx_data : IN std_logic_vector(7 downto 0);          
		rx_strobe : OUT std_logic;
		rx_data : OUT std_logic_vector(7 downto 0);
		tx_232 : OUT std_logic
		);
	END COMPONENT;




 component kcpsm6 
    generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                    interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
             scratch_pad_memory_size : integer := 64);
    port (                   address : out std_logic_vector(11 downto 0);
                         instruction : in std_logic_vector(17 downto 0);
                         bram_enable : out std_logic;
                             in_port : in std_logic_vector(7 downto 0);
                            out_port : out std_logic_vector(7 downto 0);
                             port_id : out std_logic_vector(7 downto 0);
                        write_strobe : out std_logic;
                      k_write_strobe : out std_logic;
                         read_strobe : out std_logic;
                           interrupt : in std_logic;
                       interrupt_ack : out std_logic;
                               sleep : in std_logic;
                               reset : in std_logic;
                                 clk : in std_logic);
  end component;

	
  component PICO_CODE                             
      generic(             C_FAMILY : string := "S6"; 
                  C_RAM_SIZE_KWORDS : integer := 1;
               C_JTAG_LOADER_ENABLE : integer := 0);
      Port (      address : in std_logic_vector(11 downto 0);
              instruction : out std_logic_vector(17 downto 0);
                   enable : in std_logic;
                      rdl : out std_logic;                    
                      clk : in std_logic);
    end component;



	COMPONENT PICO_OUT
	PORT(
		strobe : IN std_logic;
		add : IN std_logic_vector(3 downto 0);          
		OUT_PORT_NO : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT input_buff
	PORT(
		in_b : IN std_logic_vector(7 downto 0);
		en : IN std_logic;          
		out_b : OUT std_logic_vector(7 downto 0)
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
	
	
			COMPONENT dcm_wrapper
PORT(
    reset : IN std_logic;
    clk_in1 : IN std_logic;
    clk_out1 : OUT std_logic;          
    locked : OUT std_logic
    );
END COMPONENT;


			COMPONENT ready_ff
PORT(
    set : IN std_logic;
    reset : IN std_logic;
    rdyq : OUT std_logic  

    );
END COMPONENT;

	


            
--constant [7:0] 	hwbuild = 8'h00 ;
--constant [11:0] 	interrupt_vector = 12'h3FF ;
--parameter integer scratch_pad_memory_size = 64 ;   

signal  address:std_logic_vector(11 downto 0);
signal  instruction:std_logic_vector(17 downto 0);
signal  in_port:std_logic_vector(7 downto 0);
signal  out_port:std_logic_vector(7 downto 0);
signal 	port_id:std_logic_vector(7 downto 0);
signal	bram_enable: std_logic;
signal	write_strobe: std_logic;
signal	k_write_strobe: std_logic;
signal	read_strobe: std_logic;
signal	interrupt: std_logic;
signal	interrupt_ack: std_logic;
signal	sleep: std_logic;

--//***************** INTERNAL WIRE AND REG DEFINE FOR PICO****************************
--//***********************************************************************************
signal out_port_no :std_logic_vector(15 downto 0);
signal in_port_no:std_logic_vector(15 downto 0);
--//***************** INTERNAL WIRE AND REG DEFINE FOR UART****************************
--//***********************************************************************************
signal rd_pulse: std_logic;
signal rx_strobe: std_logic;
signal rx_data_o,TEST:std_logic_vector(7 downto 0);

signal tx_data:std_logic_vector(7 downto 0);
signal tx_strobe: std_logic;
signal usb_data_in:std_logic_vector(7 downto 0);
signal usb_data_out:std_logic_vector(7 downto 0);
signal clk_30_buff: std_logic;
signal clk_50,clk_12: std_logic;
signal reset_rdl: std_logic;
signal usb_cntrl_rd_wr: std_logic;
signal rd_n_buff,data_from_usb_rdy: std_logic;
begin




clk_12<=CLK_OSC;


  processor: kcpsm6
    generic map (                 hwbuild => X"00", 
                         interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address,
               instruction => instruction,
               bram_enable => bram_enable,
                   port_id => port_id,
              write_strobe => write_strobe,
            k_write_strobe => k_write_strobe,
                  out_port => out_port,
               read_strobe => read_strobe,
                   in_port => in_port,
                 interrupt => interrupt,
             interrupt_ack => interrupt_ack,
                     sleep => sleep,
                     reset => reset_rdl,
                       clk => clk_12);
 




  program_rom: PICO_CODE                    --Name to match your PSM file
    generic map(             C_FAMILY => "S6",   --Family 'S6', 'V6' or '7S'
                    C_RAM_SIZE_KWORDS => 1,      --Program size '1', '2' or '4'
                 C_JTAG_LOADER_ENABLE => 1)      --Include JTAG Loader when set to '1' 
    port map(      address => address,      
               instruction => instruction,
                    enable => bram_enable,
                       rdl => reset_rdl,
                       clk => clk_12);



usb_data<= usb_data_out when( usb_cntrl_rd_wr='0') else (others=>'Z');



rd_n<= rd_n_buff;
			  
  input_ports: process(rd_n_buff)
  begin
    if  rd_n_buff = '1' then
usb_data_in<=usb_data;
end if;
end process;




--	Inst_ready_ff: ready_ff PORT MAP(
--		set =>rxf_n ,
--		reset => rd_n_buff,
--		rdyq => data_from_usb_rdy);
--




	Inst_PICO_OUT: PICO_OUT PORT MAP(
		strobe =>write_strobe ,
		OUT_PORT_NO =>out_port_no ,
		add =>port_id(3 downto 0) 
	);

--	Inst_PICO_in: PICO_OUT PORT MAP(
--		strobe =>read_strobe ,
--		OUT_PORT_NO =>in_port_no ,
--		add => port_id(3 downto 0) 
--	);



	Inst_rs_232: rs_232 PORT MAP(
		clk_12 =>clk_12 ,
		reset =>reset ,
		rx_232 =>rx_232 ,
		rx_strobe =>rx_strobe ,
		rd_pulse =>rd_pulse ,
		rx_data =>rx_data_o ,
		tx_232 =>tx_232 ,
		tx_strobe =>tx_strobe ,
		tx_data =>tx_data 
	);



--------------------------------------------for uart---------------------------------
	Inst_latch_1: latch PORT MAP(
		in_b =>out_port ,
		clk => clk_12,
		out_b => led_test,
		en => out_port_no(1)
	);

	Inst_latch_2: latch PORT MAP(
		in_b =>out_port ,
		clk => clk_12,
		out_b => tx_data,
		en => out_port_no(2)
	);


tx_strobe<=out_port_no(3);
rd_pulse<=out_port_no(4);




------------------------for bram--------------------------------------
	Inst_latch_5: latch PORT MAP(
		in_b =>out_port ,
		clk => clk_12,
		out_b => bram_data_out,
		en => out_port_no(5)
	);
	
	Bram_w_r<=out_port_no(5);
	


	Inst_latch_6: latch PORT MAP(
		in_b =>out_port ,
		clk => clk_12,
		out_b => address_7_0,
		en => out_port_no(6)
	);


	Inst_latch_7: latch PORT MAP(
		in_b =>out_port ,
		clk => clk_12,
		out_b => address_15_8,
		en => out_port_no(7)
	);





-- --FDE #(.INIT(1'b0))FDCE_f1(.Q(out_b[i]),.C(clk),.CE(en),.D(in_b[i]));
-- 
--    FDPE_inst_latch_8 : FDE
--   generic map (
--      INIT => '0') -- Initial value of register ('0' or '1')  
--   port map (
--      Q => Bram_w_r,      -- Data output
--      C => clk_12,      -- Clock input
--      CE => out_port_no(8),    -- Clock enable input      
--      D => out_port(0)       -- Data input
--   );
--	
	
	
	
	    FDPE_inst_latch_9 : FDE
   generic map (
      INIT => '0') -- Initial value of register ('0' or '1')  
   port map (
      Q => wr_n,      -- Data output
      C => clk_12,      -- Clock input
      CE => out_port_no(9),    -- Clock enable input      
      D => out_port(0)       -- Data input
   );
	
	
		    FDPE_inst_latch_10 : FDE
   generic map (
      INIT => '0') -- Initial value of register ('0' or '1')  
   port map (
      Q => usb_cntrl_rd_wr,      -- Data output
      C => clk_12,      -- Clock input
      CE => out_port_no(10),    -- Clock enable input      
      D => out_port(0)       -- Data input
   );
	
	
	
	
		Inst_latch_11: latch PORT MAP(
		in_b =>out_port ,
		clk => clk_12,
		out_b => usb_data_out,
		en => out_port_no(11)
	);
	
	
rd_n_buff<=NOT out_port_no(12);
	
	
	
	

-----------------------------------------------------------------------------------------------
--Inst_input_buff: input_buff PORT MAP(
--		in_b =>rx_data_o ,
--		out_b =>in_port ,
--		en =>in_port_no(3) 
--	);

--TEST<=("0000000"&rx_strobe);

--	Inst_input_buff1: input_buff PORT MAP(
--		in_b =>TEST,
--		out_b =>in_port ,
--		en =>in_port_no(2) 
--	);





  process(clk_12)
  begin
    if clk_12'event and clk_12 = '1' then
	-- if(read_strobe ='1') then
      case port_id(3 downto 0) is


        --when "0000" => in_port <= bram_data_in;
                      
       -- when "0001" => in_port <= bram_data_in;
        when "0010" => in_port <= usb_data_in;
		  when "0011" => in_port(0) <= txe_n;
 		  when "0100" => in_port(0) <= rxf_n;--data_from_usb_rdy;
        when "0101" => in_port <= bram_data_in;
 
        when others =>    in_port <= "XXXXXXXX";  

      end case;

      -- Generate 'buffer_read' pulse following read from port address 01

   --   if (read_strobe = '1') and (port_id(3 downto 0) = "0010") then
   ---     rd_n_buff <= '0';
   --    else
   --     rd_n_buff <= '1';
   --   end if;
 
    end if;
  end process ;


  
end Behavioral;

