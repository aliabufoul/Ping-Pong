library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mahbet_draw is
port 	(
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		oCoord_X	: in integer;
		oCoord_Y	: in integer;
		ObjectCentreX	: in integer;
		ObjectCentreY 	: in integer;
		miss				: in std_logic;
		drawing_request	: out std_logic ;
		mVGA_RGB 	: out std_logic_vector(7 downto 0) 
	);
end mahbet_draw;

architecture behav of mahbet_draw is 

constant object_X_size : integer := 80;
constant object_Y_size : integer := 16;
signal minimize : integer range 0 to 20;
signal miss_counter : integer :=3;


begin

process ( RESETn, CLK)
	begin
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		drawing_request	<=  '0' ;
		minimize <= 0;

		elsif rising_edge(CLK) then
			
			if (miss = '1') then
				miss_counter <= miss_counter-1;
				if (miss_counter = 0)then
					minimize <= minimize + 1;
					miss_counter <= 3;
				end if;
			end if;
			
			if(oCoord_X < ObjectCentreX+(40 -minimize) and oCoord_X > ObjectCentreX-(40-minimize) and oCoord_Y < ObjectCentreY+7 and oCoord_Y > ObjectCentreY-7) then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "00000011" ; 	
		
			else
				drawing_request	<=  '0' ;
				mVGA_RGB	<=  "00000011" ;
			end if;
				
			
	end if;

  end process;

		
end behav;