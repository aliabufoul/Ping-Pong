 library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity state_draw is
port 	(
	   	CLK  				: in std_logic;
		RESETn				: in std_logic;
		oCoord_X				: in integer;
		oCoord_Y				: in integer;
		waitMode				: in std_logic ;
		resultMode			: in std_logic;
		show					: in std_logic ;
		winner				: in std_logic ;
		
		drawing_request	: out std_logic ;
		mVGA_RGB 			: out std_logic_vector(7 downto 0) 
	);
end state_draw;

architecture behav of state_draw is 

constant object_X_size : integer := 300;
constant object_Y_size : integer := 300;

begin

process ( RESETn, CLK)
	begin
	if RESETn = '0' then
	    mVGA_RGB	<=  (others => '0') ; 	
		drawing_request	<=  '0' ;
	elsif rising_edge(CLK) then
		if resultMode = '1' then
			if show = '0' then
				drawing_request	<=  '0' ;
				mVGA_RGB	<=  "00000000" ;
			elsif winner = '0' then
			--show left
				if ((oCoord_Y+150>220 and oCoord_Y+150<285) and 
					((oCoord_Y+150>-oCoord_x+490 and oCoord_Y+150<-oCoord_x+510) or 
					(oCoord_Y+150>-oCoord_x+360 and oCoord_Y+150<-oCoord_x+380) or 
					(oCoord_Y+150>oCoord_x+60 and oCoord_Y+150<oCoord_x+80) or
					(oCoord_Y+150>oCoord_x+190 and oCoord_Y+150<oCoord_x+210))) then 
					drawing_request	<=  '1' ;
					mVGA_RGB	<=  "01010101" ; 
				else
					drawing_request	<=  '0' ;
					mVGA_RGB	<=  "00000000" ;
				end if;
			else
			--show right
				if ((oCoord_Y+150>220 and oCoord_Y+150<285) and 
					((oCoord_Y+150>-(oCoord_x-320)+490 and oCoord_Y+150<-(oCoord_x-320)+510) or 
					(oCoord_Y+150>-(oCoord_x-320)+360 and oCoord_Y+150<-(oCoord_x-320)+380) or 
					(oCoord_Y+150>(oCoord_x-320)+60 and oCoord_Y+150<(oCoord_x-320)+80) or
					(oCoord_Y+150>(oCoord_x-320)+190 and oCoord_Y+150<(oCoord_x-320)+210))) then 
					drawing_request	<=  '1' ;
					mVGA_RGB	<=  "01010101" ; 
				else
					drawing_request	<=  '0' ;
					mVGA_RGB	<=  "00000000" ;
				end if;
			end if;
		elsif waitMode = '0' and resultMode = '0' then
			if(((oCoord_X-320)*(oCoord_X-320)+(oCoord_Y-240)*(oCoord_Y-240)<32400 and (oCoord_X-320)*(oCoord_X-320)+(oCoord_Y-240)*(oCoord_Y-240)>28600) 
			or (oCoord_X>260 and oCoord_Y<550-2*oCoord_X/3 and oCoord_Y>-70+2*oCoord_X/3))  	then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "11111111" ; 
			elsif(((oCoord_X-320)*(oCoord_X-320)+(oCoord_Y-240)*(oCoord_Y-240)<28600) 
			and (oCoord_X<=260 or oCoord_Y>=550-2*oCoord_X/3 or oCoord_Y<=-70+2*oCoord_X/3))  	then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "00000000" ; 
			else
				drawing_request	<=  '0' ;
				mVGA_RGB	<=  "00000000" ;
			end if;
		elsif( waitMode = '1' and resultMode = '0') then 
			if(((oCoord_X-320)*(oCoord_X-320)+(oCoord_Y-240)*(oCoord_Y-240)<32400 and (oCoord_X-320)*(oCoord_X-320)+(oCoord_Y-240)*(oCoord_Y-240)>28600) 
			or (oCoord_X>310 and oCoord_X<330 and oCoord_Y>110 and oCoord_Y<240) 
			or (oCoord_X>310 and oCoord_X<410 and oCoord_Y>230 and oCoord_Y<250))  	then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "11111111" ; 
			elsif(((oCoord_X-320)*(oCoord_X-320)+(oCoord_Y-240)*(oCoord_Y-240)<28600) 
			and ( oCoord_Y<=140 or oCoord_Y>=240))  	then
				drawing_request	<=  '1' ;
				mVGA_RGB	<=  "00000000" ; 
			else
				drawing_request	<=  '0' ;
				mVGA_RGB	<=  "00000000" ;
			end if;			
		end if;	
	end if;
	end process;
end behav;