library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun March 24 2017 
-- Dudy Nov 13 2017


entity smileyfacemove is
port 	(
		CLK				: in std_logic; --						//	27 MHz
		RESETn			: in std_logic; --			//	50 MHz
		timer_done		: in std_logic;
		hit				: in std_logic;
		enableMove		: in std_logic ;
		
		ObjectStartX	: out integer ;
		ObjectStartY	: out integer ;
		miss1				: out std_logic;
		miss2				: out std_logic;
		rightDir			: out std_logic;
		storm				: out std_logic
	);
end smileyfacemove;

architecture behav of smileyfacemove is 

constant StartX : integer := 580;   -- starting point
constant StartY : integer := 80;   


signal ObjectStartX_t : integer range 0 to 640;  --vga screen size 
signal ObjectStartY_t : integer range 0 to 480;
signal XSpeed : integer := -3;
signal YSpeed : integer := 8;

begin
		process ( RESETn,CLK)
		variable toChangeSpeed : integer := 0;
		variable toChangeSpeedOnHit : integer := 0;
		variable rightStorm : integer := 450;
		variable leftStorm : integer := 600;
		variable timeView : integer := 0;

		--variable hit2V : std_logic := '0';
		begin
		  if RESETn = '0' then
				ObjectStartX_t	<= StartX;
				ObjectStartY_t	<= StartY ;
				miss1 <= '0';
				miss2 <= '0';
				rightDir	<= '0';
				storm <= '0';
				timeView := 0 ;
		elsif rising_edge(CLK) then
			if timer_done = '1' and enableMove='1' then
				if timeView <= 0 then
					storm <= '0';
				end if;
				
			-- update the velocity after storm
				if (rightStorm = 0) then
						XSpeed <= XSpeed + 2;
						rightStorm := 450;
						rightDir	<= '1';
						storm	<= '1';
						timeView := 20 ;
				end if ;
				if (leftStorm = 0) then
						XSpeed <= XSpeed - 2;
						leftStorm := 600;
						rightDir	<= '0';
						storm	<= '1';
						timeView := 20 ;
				end if ;
				leftStorm := leftStorm -1;
				rightStorm := rightStorm -1;
				timeView := timeView - 1 ;
				
				miss1 <= '0';
				miss2 <= '0';
				
				ObjectStartY_t  <= ObjectStartY_t + YSpeed; 
				ObjectStartX_t  <= ObjectStartX_t + XSpeed; 
				
				-- gravity acceleration
				if (toChangeSpeed = 0) then
					YSpeed <= YSpeed + 1;
						toChangeSpeed := 10 ;
				end if ;
				toChangeSpeed := toChangeSpeed - 1; 
				
				-- velocity update after hit
				if (hit = '1') then
					YSpeed <= -8;
					if (toChangeSpeedOnHit = 0) then
						if ((XSpeed < 0 and objectStartX_t >320 ) or(XSpeed > 0 and objectStartX_t < 320))then
							if (XSpeed > 0) then 
								XSpeed <= 3;
							else 
								XSpeed <= -3;
							end if;
						else
							if (XSpeed > 0) then 
								XSpeed <= -3;
							else 
								XSpeed <= 3;
							end if;
						end if;
						toChangeSpeedOnHit := 3 ;
					end if ;
					toChangeSpeedOnHit := toChangeSpeedOnHit - 1; 
					
				-- hit with walls
				elsif(ObjectStartY_t < 30) then
					YSpeed <= 8;
				elsif (ObjectStartX_t > 590) then
					XSpeed <= -3;					
				elsif (ObjectStartX_t < 30) then
					XSpeed <= 3;					
				elsif (ObjectStartY_t > 440) then
					YSpeed <= 1;
					if (ObjectStartX_t < 320) then 
						miss1 <= '1' ;
						ObjectStartY_t <= 50;
						ObjectStartX_t <=ObjectStartX_t;
					else 
						miss2 <= '1' ;
						ObjectStartY_t <= 50;
						ObjectStartX_t <=ObjectStartX_t;
					end if ;
				end if;
			end if;			
		end if;
		end process ;

ObjectStartX	<= ObjectStartX_t;		-- copy to outputs 	
ObjectStartY	<= ObjectStartY_t;	


end behav;