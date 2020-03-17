library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity result_draw is
port 	(
	   	CLK  				: in std_logic;
		RESETn				: in std_logic;
		oCoord_X				: in integer;
		oCoord_Y				: in integer;
		resultMode			: in std_logic;
		show					: in std_logic ;
		winner				: in std_logic ;
		
		drawing_request	: out std_logic ;
		mVGA_RGB 			: out std_logic_vector(7 downto 0) 
	);
end result_draw;

architecture behav of result_draw is 

constant object_X_size : integer := 300;
constant object_Y_size : integer := 80;

begin

process ( RESETn, CLK)
	begin
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		drawing_request	<=  '0' ;
	elsif rising_edge(CLK) then
		if resultMode = '1' then
			if winner = '1' then
			--show left
				if (oCoord_X>100 and oCoord_X<220 and oCoord_Y>200 and oCoord_Y<280) then 
					drawing_request	<=  '1' ;
					mVGA_RGB	<=  "01010101" ; 
				else
					drawing_request	<=  '0' ;
					mVGA_RGB	<=  "00000000" ;
				end if;
			else
			--show right
				if (oCoord_X>460 and oCoord_X<580 and oCoord_Y>230 and oCoord_Y<250) then 
					drawing_request	<=  '1' ;
					mVGA_RGB	<=  "01010101" ; 
				else
					drawing_request	<=  '0' ;
					mVGA_RGB	<=  "00000000" ;
				end if;
			end if;
		else
			drawing_request	<=  '0' ;
			mVGA_RGB	<=  "00000000" ;
		end if;
	end if;
	end process;
end behav;