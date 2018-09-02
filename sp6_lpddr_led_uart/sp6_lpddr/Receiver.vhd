----------------------------------------------------------------------------------
-- COMPANY      : FPGATECHSOLUTION
-- MODULE NAME  : UART_RECEIVER
-- URL     		 : WWW.FPGATECHSOLUTION.COM
----------------------------------------------------------------------------------
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY UART_RECEIVER IS
	GENERIC
	(
		FREQUENCY		: INTEGER;
		BAUD			: INTEGER
	);
	PORT
	(
		CLK				: IN STD_LOGIC;
		RXD				: IN STD_LOGIC;
		RXD_DATA		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		RXD_DATA_READY	: OUT STD_LOGIC
	);
END ENTITY UART_RECEIVER;

ARCHITECTURE RECEIVER_BEH OF UART_RECEIVER IS

		CONSTANT OVERSAMPLING 	: INTEGER :=7;
		CONSTANT BIT_SPACE 		: INTEGER := 10; 
		CONSTANT DIVISOR 		: INTEGER := 1600;
		CONSTANT FREQ_INC 		: INTEGER := (OVERSAMPLING + 1) * BAUD / DIVISOR;
		CONSTANT FREQ_DIV 		: INTEGER := FREQUENCY / DIVISOR;
		CONSTANT FREQ_MAX 		: INTEGER := FREQ_DIV + FREQ_INC - 1;

TYPE STATE_TYPE IS (IDLE, BIT0, BIT1, BIT2, BIT3, BIT4, BIT5, BIT6, BIT7, STOP);

		SIGNAL STATE : STATE_TYPE := IDLE; 
		SIGNAL RXD_SYNC_INV : STD_LOGIC_VECTOR(1 DOWNTO 0);
		SIGNAL RXD_CNT_INV 	: STD_LOGIC_VECTOR(1 DOWNTO 0);
		SIGNAL RXD_BIT_INV 	: STD_LOGIC;
		SIGNAL BAUD_DIVIDER : INTEGER RANGE 0 TO FREQ_MAX := 0;
		SIGNAL DATA 		: STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL BIT_SPACING 	: INTEGER RANGE 0 TO 15;
		SIGNAL NEXT_BIT 	: STD_LOGIC := '0';
		SIGNAL BAUDOVER_TICK : STD_LOGIC := '0';
BEGIN

	NEXT_BIT <= '1' WHEN BIT_SPACING = BIT_SPACE ELSE '0';

	BAUD_GEN : PROCESS(CLK)
	BEGIN
		IF CLK'EVENT AND CLK = '1' THEN
			BAUD_DIVIDER <= BAUD_DIVIDER + FREQ_INC;
			IF BAUD_DIVIDER >= FREQ_DIV THEN
				BAUD_DIVIDER <= 0;
				BAUDOVER_TICK <= '1';
			ELSE
				BAUDOVER_TICK <= '0';
			END IF;
		END IF;
	END PROCESS BAUD_GEN;

	RXD_SYNC_INVERTED : PROCESS(CLK) 
	BEGIN
		IF CLK'EVENT AND CLK = '1' THEN
			IF BAUDOVER_TICK = '1' THEN
				RXD_SYNC_INV <= RXD_SYNC_INV(0) & NOT RXD;
			END IF;
		END IF;
	END PROCESS RXD_SYNC_INVERTED;

	RXD_COUNTER_INVERTED : PROCESS(CLK)
	BEGIN
		IF CLK'EVENT AND CLK = '1' THEN
			IF BAUDOVER_TICK = '1' THEN
				IF RXD_SYNC_INV(1) = '1' AND RXD_CNT_INV /= "11" THEN
					RXD_CNT_INV <= UNSIGNED(RXD_CNT_INV) + 1;
				ELSIF RXD_SYNC_INV(1) = '0' AND RXD_CNT_INV /= "00" THEN
					RXD_CNT_INV <= UNSIGNED(RXD_CNT_INV) - 1;
				END IF;
				
				IF RXD_CNT_INV = "00" THEN
					RXD_BIT_INV <= '0';
				ELSIF RXD_CNT_INV = "11" THEN
					RXD_BIT_INV <= '1';
				END IF;
			END IF;
		END IF;
	END PROCESS RXD_COUNTER_INVERTED;

	STATE_PROC : PROCESS(CLK)
	BEGIN
		IF CLK'EVENT AND CLK = '1' THEN
			IF BAUDOVER_TICK = '1' THEN
				CASE STATE IS
					WHEN IDLE =>
						IF RXD_BIT_INV = '1' THEN
							STATE <= BIT0;
						END IF;
					WHEN BIT0 =>
						IF NEXT_BIT = '1' THEN
							STATE <= BIT1;
						END IF;
					WHEN BIT1 =>
						IF NEXT_BIT = '1' THEN
							STATE <= BIT2;
						END IF;
					WHEN BIT2 =>
						IF NEXT_BIT = '1' THEN
							STATE <= BIT3;
						END IF;
					WHEN BIT3 =>
						IF NEXT_BIT = '1' THEN
							STATE <= BIT4;
						END IF;
					WHEN BIT4 =>
						IF NEXT_BIT = '1' THEN
							STATE <= BIT5;
						END IF;
					WHEN BIT5 =>
						IF NEXT_BIT = '1' THEN
							STATE <= BIT6;
						END IF;
					WHEN BIT6 =>
						IF NEXT_BIT = '1' THEN
							STATE <= BIT7;
						END IF;
					WHEN BIT7 =>
						IF NEXT_BIT = '1' THEN
							STATE <= STOP;
						END IF;
					WHEN STOP =>
						IF NEXT_BIT = '1' THEN
							STATE <= IDLE;
						END IF;
				END CASE;
			END IF;
		END IF;
	END PROCESS STATE_PROC;

	BIT_SPACING_PROC : PROCESS(CLK)
	BEGIN
		IF CLK'EVENT AND CLK = '1' THEN
			IF STATE = IDLE THEN
				BIT_SPACING <= 0;
			ELSIF BAUDOVER_TICK = '1' THEN
				IF BIT_SPACING < 15 THEN
					BIT_SPACING <= BIT_SPACING + 1;
				ELSE
					BIT_SPACING <= 8;
				END IF;
			END IF;
		END IF;
	END PROCESS BIT_SPACING_PROC;

	SHIFT_DATA_PROC : PROCESS(CLK)
	BEGIN
		IF CLK'EVENT AND CLK = '1' THEN
			IF BAUDOVER_TICK = '1' AND NEXT_BIT = '1' AND
			STATE /= IDLE AND STATE /= STOP THEN
				DATA <= NOT RXD_BIT_INV & DATA(7 DOWNTO 1);
			END IF;
		END IF;
	END PROCESS SHIFT_DATA_PROC;

	OUTPUT_DATA_PROC : PROCESS(CLK)
	BEGIN
		IF CLK'EVENT AND CLK = '1' THEN
			IF BAUDOVER_TICK = '1' AND NEXT_BIT = '1' AND
			STATE = STOP AND RXD_BIT_INV = '0' THEN
				RXD_DATA <= DATA;
				RXD_DATA_READY <= '1';
			ELSE
				RXD_DATA_READY <= '0';
			END IF;
		END IF;
	END PROCESS OUTPUT_DATA_PROC;
	
END RECEIVER_BEH;

