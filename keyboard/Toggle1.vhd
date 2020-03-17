library ieee ;
use ieee.std_logic_1164.all ;

entity Toggle1 is
port ( resetN : in std_logic ;
	clk : in std_logic ;
	din : in std_logic_vector(8 downto 0) ; 
	make : in std_logic ; 
	break : in std_logic;
	key_code : in std_logic_vector(8 downto 0);
	dout : out std_logic ) ;
end entity ;

architecture arc_Toggle1 of Toggle1 is
	signal shift_reg : std_logic_vector(9 downto 0) ;
	signal parity_ok : std_logic ;
	type state is (idle, pressed);
	
	signal tmpdout: std_logic;
	
	begin
	
	process ( resetN , clk )
	
	variable present_state : state;
	
	begin
	
	if resetN = '0' then
		tmpdout <= '0';
		present_state := idle;
	
	elsif rising_edge (clk) then
	case present_state is
		when idle =>
		if din = key_code and make = '1' then
			tmpdout <= not(tmpdout);
			present_state := pressed;
		end if;
		when pressed =>
		if din = key_code and break = '1' then
			tmpdout <= not(tmpdout);
			present_state := idle;
		end if;
	end case;
	end if;
	end process;
	dout <= tmpdout;
end architecture;