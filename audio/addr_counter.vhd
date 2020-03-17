LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY addr_counter IS
GENERIC ( COUNT_SIZE		: INTEGER := 8);
PORT (
			CLK_IN			:	IN	STD_LOGIC;	
			resetN			:	IN	STD_LOGIC;
			en					: 	in  std_logic ;
			en1				: 	in  std_logic ;
			addr				: 	out std_logic_vector(COUNT_SIZE - 1 downto 0)
		);

END addr_counter;


	
architecture addr_counter_arch of 		addr_counter is
constant count_limit : std_logic_vector(COUNT_SIZE - 1 downto 0) := ( others => '1'); -- max value 
begin
	process (CLK_IN, resetN)
	variable countint : integer;
	begin
	if (resetN = '0') then
		countint := 0;
	else
		if rising_edge(CLK_IN) then
			if en = '1' and en1 = '1' then
				countint := countint +1;
				if (countint > conv_integer(count_limit)) then
					countint := 0;
				end if;
			end if;
		end if;
	end if;
	addr <=  conv_std_logic_vector(countint, COUNT_SIZE);
	end process;
end addr_counter_arch ;