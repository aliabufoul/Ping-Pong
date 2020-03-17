library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity mahbetmove is
port 	(
		CLK				: in std_logic; 					
		RESETn			: in std_logic; 		
		timer_done		: in std_logic;
		mahbetId			: in std_logic;
		movFlag			: in std_logic;
		dirFlag     	: in std_logic; -- 1 = right , 0 = left
		ObjectStartX	: out integer ;
		ObjectStartY	: out integer
		
	);
end mahbetmove;

architecture behav of mahbetmove is 

-- starting point
signal StartX : integer := 160  ;   
signal StartY : integer := 450 ;


signal ObjectStartX_t : integer range 0 to 640;  --vga screen size 
signal ObjectStartY_t : integer range 0 to 480;
begin


		process ( RESETn,CLK)
		begin
		  if RESETn = '0' then
				if(mahbetId = '1') then
					StartX <= 160;
				else
					StartX <= 460;
				end if;	
				ObjectStartX_t	<= StartX ;
				ObjectStartY_t	<= StartY ;
		elsif rising_edge(CLK) then
				if(mahbetId = '1') then
					StartX <= 160;
				else 
					StartX <= 460;
				end if;
			if timer_done = '1' and movFlag = '1' then
				if(dirFlag = '1') then
					ObjectStartX_t <= ObjectStartX_t + 4;
					if(ObjectStartX_t > 583 and mahbetId = '0')then
						ObjectStartX_t <= 583;
					elsif(ObjectStartX_t > 264 and mahbetId = '1')then
						ObjectStartX_t <= 264;
					end if;
				else
					ObjectStartX_t <= ObjectStartX_t - 4;
					if(ObjectStartX_t < 54 and mahbetId = '1') then
						ObjectStartX_t <= 54;
					elsif(ObjectStartX_t < 376 and mahbetId = '0') then
					ObjectStartX_t <= 376;
					end if;
				end if;
			end if;
			
		end if;
		end process ;
ObjectStartX	<= ObjectStartX_t;		-- copy to outputs 	
ObjectStartY	<= ObjectStartY_t;	


end behav;