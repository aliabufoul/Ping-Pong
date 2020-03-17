library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity parser is
   port ( CLK :in std_logic;
	resetN : in std_logic;
          dinA     : in std_logic                    ;
			 dinD    : in std_logic  ;
			 din4		: in std_logic;
			 din6		: in std_logic;
			 mov1Flag			: out std_logic;
			 mov2Flag			: out std_logic;
			 dir1Flag			: out std_logic;
			 dir2Flag			: out std_logic );
end parser ;


architecture arc_parser of parser is
signal mov1Flag_t : std_logic := '0';
signal mov2Flag_t : std_logic := '0';
signal dir1Flag_t : std_logic := '0';
signal dir2Flag_t : std_logic := '0';

begin
   process ( CLK,resetN )
	begin
	if (resetN = '0') then
		mov1Flag_t <= '0';
		mov2Flag_t <= '0';
		dir1Flag_t <= '0';
		dir2Flag_t <= '0';
	elsif (rising_edge(CLK)) then
			if din6 = '1' then
				mov1Flag_t <= '1';
				dir1Flag_t <= '1';
			elsif din4 = '1' then
				mov1Flag_t <= '1';
				dir1Flag_t <= '0';
			end if;
			
			if dinD = '1' then
				mov2Flag_t <= '1';
				dir2Flag_t <= '1';
			elsif dinA='1' then
				mov2Flag_t <= '1';
				dir2Flag_t <= '0';
			end if;
			if (dinA = '0' and dinD = '0' and din4 = '0' and din6 = '0') then 
				mov1Flag_t <= '0';
				mov2Flag_t <= '0';
			end if;
	mov1Flag <= mov1Flag_t;
	dir1Flag <= dir1Flag_t;
	mov2Flag <= mov2Flag_t;
	dir2Flag <= dir2Flag_t;
	end if;
end process;
end arc_parser;

