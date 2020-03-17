library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity toggle_button is
	port ( 
		resetN : in std_logic ;
		clk : in std_logic ;
		din : in std_logic_vector (8 downto 0);
		make : in std_logic ;
		break : in std_logic ;
		key_code : in std_logic_vector (7 downto 0);
		dout : out std_logic );
end toggle_button ;

architecture behavior of toggle_button is
	type state is (idle, pressed);
	signal present_state : state;
	
	signal out_led: std_logic;
	begin
		dout <= out_led;
		process (resetN , clk) begin
			if resetN = '0' then 
				out_led <= '0';
				present_state <= idle;
			elsif rising_edge(clk) then
				case present_state is
					when idle =>	
						if (din = key_code) and (make = '1') then
							present_state <= pressed;
							out_led <= not(out_led);
						end if;
					when pressed =>
						if (din /= key_code) or (break = '1') then
							present_state <= idle; 
						end if;
				end case;
			end if;
		end process;
end architecture;