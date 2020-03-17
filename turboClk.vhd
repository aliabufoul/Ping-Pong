library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;

entity turboClk is
	port( CLK : in bit;
	RESETN, Turbo : in bit;
	outd : out bit);
end turboClk;

architecture Turbo_counter_arch of turboClk is
	begin
	process(CLK, RESETN)
	variable one_sec : integer;
   constant sec: integer := 50000000 ; -- for Real operation
	-- constant sec : integer := 5;-- for simulation
	constant turbo_sec : integer := 5000000;-- for simulation
	begin
	if RESETN = '0' then
		one_sec := 0;
		outd <= '0';
	elsif (CLK'event and CLK ='1') then
		one_sec := one_sec +1;
		if(((one_sec > sec) and (Turbo = '0'))
		or ((one_sec > turbo_sec) and (Turbo = '1'))
		) then
			one_sec := 0;
			outd <= '1';
		else
			outd <= '0';
		end if;
		
	end if;
	end process;
end Turbo_counter_arch;