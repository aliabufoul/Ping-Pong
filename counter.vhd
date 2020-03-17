library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;


entity counter is
port ( 
	resetN	 : in std_logic ;
	clk 			: in std_logic ;
	addPoint : in std_logic ;
	timer_done : in std_logic ;
	--Data : in std_logic_vector (7 downto 0) ;
	--LOAD : in std_logic ;
	--TC 	: out std_logic ;
	points : out std_logic_vector (3 downto 0) ;
	winner : out std_logic 
);
end counter;


architecture Counter_arch of counter is

begin
	process(clk,resetN)
	variable pointsV : integer := 0;
	begin
		if RESETN = '0' then
			 pointsV := 0 ; 
			 winner <= '0' ;
		 elsif rising_edge(clk) then
			--	winner <= '0';
				if timer_done = '1' and addPoint ='1' then
					pointsV := pointsV + 1 ;
					if (pointsV >= 5) then 
						winner <= '1';
						pointsV := 5;
					end if ;
				end if ;
		 end if ;
		 points <= conv_std_logic_vector(pointsV,4);
	end process;
end Counter_arch ;
