library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity storm_draw is
port 	(
	   	CLK  				: in std_logic;
		RESETn				: in std_logic;
		oCoord_X				: in integer;
		oCoord_Y				: in integer;
		rightDir				: in std_logic ;
		storm				: in std_logic ;
		drawing_request	: out std_logic ;
		mVGA_RGB 			: out std_logic_vector(7 downto 0) 
	);
end storm_draw;

architecture behav of storm_draw is 

constant object_X_size : integer := 300;
constant object_Y_size : integer := 80;

begin

process ( RESETn, CLK)
	begin
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		drawing_request	<=  '0' ;
	elsif rising_edge(CLK) then
		if storm = '0' then
			drawing_request	<=  '0' ;
			mVGA_RGB	<=  "00000000" ;
		elsif rightDir = '1' then
			if(oCoord_X>360 and oCoord_Y<550-2*oCoord_X/3 and oCoord_Y>-70+2*oCoord_X/3)  	then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "01010101" ; 
			elsif(oCoord_X>310 and oCoord_X<410 and oCoord_Y>230 and oCoord_Y<250)  	then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "01010101" ; 
			else
				drawing_request	<=  '0' ;
				mVGA_RGB	<=  "00000000" ;
			end if;
		else---(oCoord_X-640)>360 and
			--if( oCoord_Y<550+2*(oCoord_X-640)/3 and oCoord_Y>-70-2*(oCoord_X-640)/3)  	then
			--	drawing_request	<=  '1' ;
			--	mVGA_RGB	<=  "11111111" ; 
			if (oCoord_X<280 and oCoord_Y>360-2*oCoord_X/3 and oCoord_Y<120+2*oCoord_X/3) then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "01010101" ;
			elsif(oCoord_X>230 and oCoord_X<330 and oCoord_Y>230 and oCoord_Y<250)  	then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "01010101" ; 
			else
				drawing_request	<=  '0' ;
				mVGA_RGB	<=  "00000000" ;
			end if;
		end if;	
	end if;
	end process;
end behav;