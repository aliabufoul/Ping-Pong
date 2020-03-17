library ieee ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity admin is
	port ( 	clk:	in 	std_logic;
		resetN:		in 	std_logic;
		START:		in 	std_logic;
		WaitX:  	in	std_logic; --X addeed as "wait" might be a reserved word 
		OneHzPulse:	in	std_logic;  -- a narrow pulse every second 
 		gameOver: 		in	std_logic;   --we have a winner
		
		CounterEnable:  out	std_logic;  --enable('1')/disable('0')  
		waitMode:  out	std_logic;  --enable('1')/disable('0')  
--		CounterLoadN:  out	std_logic;  --/load ('0')  
		LampEnable: 	out	std_logic ;
				resultEnable:  out	std_logic ); -- on('1') off('0')
end admin;

architecture arc of admin is 

type state_type is (idle, run, pause, lamp_on, lamp_off, arm);
signal state : state_type;

begin
	process (clk, resetN)
	begin
		if resetN = '0' then
			state <= idle;
			CounterEnable <= '0' ;
			waitMode <= '0';
	--		CounterLoadN <= '0' ;
			LampEnable <= '1' ;
			resultEnable <= '0'; 

		elsif (rising_edge(clk)) then
		--	CounterLoadN <= '0' ;
		--	CounterEnable <= '0' ;
			case state is
				when idle=>
					if start = '0' then
						state <= arm;
					--	CounterLoadN <= '1' ; 
						LampEnable <= '1' ;
						CounterEnable <= '0' ;
						waitMode <= '0';
						resultEnable <= '0';
					end if;

				when arm=>
					if start = '1' then
						state <= run;
						LampEnable <= '1' ;
						CounterEnable <= '1' ;
						waitMode <= '0' ;
						resultEnable <= '0';
					end if;

				when run=>
					if gameOver = '1' then
						state <= lamp_on;
						CounterEnable <= '0' ;
						LampEnable <= '1' ;
						waitMode <= '0' ;
						resultEnable <= '1';
					elsif WaitX = '0' then
						state <= pause;
						LampEnable <= '1' ;
						CounterEnable <= '0' ;
						waitMode <= '1';
						resultEnable <= '0';
					--elsif OneHzPulse = '1' then
					--	CounterEnable <= '1' ;
					--	LampEnable <= '1' ;
					--	waitMode <= '0';
					--	resultEnable <= '0';
					end if;

				when pause => --..... to operate 3sec timer
					if WaitX = '1' then
						state <= run;
						LampEnable <= '1' ;
						CounterEnable <= '1' ;
						waitMode <= '0';
						resultEnable <= '0';
					end if ;

				when lamp_on => --..... to operate 1sec timer
					if OneHzPulse = '1' then
						state <= lamp_off;
						resultEnable <= '1'; 
						CounterEnable <= '0' ;
						LampEnable <= '0' ;
						waitMode <= '0';
					end if ;

				when lamp_off => --..... to operate 1sec timer
					if OneHzPulse = '1' then
						state <= lamp_on;
						LampEnable <= '1' ;
						CounterEnable <= '0' ;
						waitMode <= '0';
						resultEnable <= '1';
					end if ;
			end case;
		end if;
	end process;
end arc ; 
