LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;


ENTITY data_conversion IS
PORT (
			clk_in			:	IN	STD_LOGIC;	
			resetN			:	IN	STD_LOGIC;
			mux				: 	in  std_logic_vector (2 downto 0) ;
			data_in			: 	in  std_logic_vector (15 downto 0) ;
			data_out			: 	out std_logic_vector (15 downto 0)
		);

END data_conversion ;

	
architecture arch of data_conversion is
begin
	process(clk_in,resetN)
	variable tmp : integer ;
	begin
		if resetN = '0' then
			data_out <=  (others => '0')  ;
		elsif rising_edge(clk_in) then
			case mux is
				when "000" =>
					data_out <= data_in ;
				when "001" =>
					if data_in(15) = '1' then
						data_out <= "0000000000000000" ;
					else
						data_out <= data_in ;
					end if ;
				when "010" =>
					data_out <= (data_in xor "1111111111111111") + 1 ;
				when "011" =>
					if data_in < 0 then
						data_out <= (data_in xor "1111111111111111") + 1 ;
					else
						data_out <= data_in ;
					end if ;
				when "100" =>
						data_out <= data_in ;
						data_out(1) <= '0' ;
						data_out(0) <= '0' ;
				when "101" =>
					data_out <= data_in ;
						data_out(10 downto 0) <= "00000000000" ;
				when "110" =>
					tmp := conv_integer(data_in);
					tmp := tmp / 2 ;
					data_out <=  conv_std_logic_vector(tmp, 16) ;
				when "111" =>
					tmp := conv_integer(data_in);
					tmp := 3*tmp / 2 ;
					data_out <=  conv_std_logic_vector(tmp, 16) ;
				end case ;
		end if ;
	end process;
end arch ;