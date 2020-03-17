library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
-- Alex Grinshpun April 2017
-- Dudy Nov 13 2017


entity smileyface_object is
port 	(
		--////////////////////	Clock Input	 	////////////////////	
	   	CLK  		: in std_logic;
		RESETn		: in std_logic;
		oCoord_X	: in integer;
		oCoord_Y	: in integer;
		ObjectCentreX	: in integer;
		ObjectCentreY 	: in integer;
		drawing_request	: out std_logic ;
		mVGA_RGB 	: out std_logic_vector(7 downto 0) 
	);
end smileyface_object;

architecture behav of smileyface_object is 

constant object_X_size : integer := 26;
constant object_Y_size : integer := 26;

begin

process ( RESETn, CLK)
  		
   begin
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		drawing_request	<=  '0' ;

		elsif rising_edge(CLK) then
			if((ObjectCentreX-oCoord_X)*(ObjectCentreX-oCoord_X)+(ObjectCentreY-oCoord_Y)*(ObjectCentreY-oCoord_Y))<200 then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "10100000" ; 	
		
			else
				drawing_request	<=  '0' ;
				mVGA_RGB	<=  "10100000" ;
			end if;
	end if;

  end process;

end behav;		
		