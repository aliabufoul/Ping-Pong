library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun Apr 2017
-- Dudy Nov 13 2017

entity objects_mux is
port 	(
		CLK	: in std_logic; --						//	27 MHz
		b_drawing_request : in std_logic;
		b_mVGA_RGB 	: in std_logic_vector(7 downto 0);
		
		mahbet1_drawing_request : in std_logic;
		mahbet1_mVGA_RGB 	: in std_logic_vector(7 downto 0);
		
		mahbet2_drawing_request : in std_logic;
		mahbet2_mVGA_RGB 	: in std_logic_vector(7 downto 0);
		
		y_drawing_request : in std_logic; 
		y_mVGA_RGB 	: in std_logic_vector(7 downto 0);
		
		storm_drawing_request : in std_logic;
		storm_mVGA_RGB 	: in std_logic_vector(7 downto 0);
		
		state_drawing_request : in std_logic;
		state_mVGA_RGB 	: in std_logic_vector(7 downto 0);


		m_mVGA_R 		: out std_logic_vector(7 downto 0); --	,  
		m_mVGA_G 		: out std_logic_vector(7 downto 0); --	, 
		m_mVGA_B 		: out std_logic_vector(7 downto 0); --	, 
		
		hit 				: out std_logic;
		hit1 				: out std_logic;
		hit2				: out std_logic;
		RESETn 			: in std_logic;
		timer_done		: in std_logic;
		playEnable		: in std_logic
	);
end objects_mux;

architecture behav of objects_mux is 
signal m_mVGA_t 	: std_logic_vector(7 downto 0); --	,  

begin

-- priority encoder process
process ( RESETn, CLK)
variable hitV : std_logic := '0';
variable hit1V : std_logic := '0';
variable hit2V : std_logic := '0';

--variable hitVFlag : std_logic := '0';

begin 
	if RESETn = '0' then
			m_mVGA_t	<=  (others => '0') ; 	
	elsif rising_edge(CLK) then
		if (timer_done = '1') then
			hitV := '0' ;
			hit1V := '0' ;
			hit2V := '0' ;
		end if ;
		if (b_drawing_request = '1' and (mahbet1_drawing_request = '1' or mahbet2_drawing_request = '1')) then
			hitV := '1' ;
			if mahbet1_drawing_request = '1' then
				hit1V := '1' ;
			elsif mahbet2_drawing_request = '1' then
				hit2V := '1' ;
			end if;
		--elsif (timer_done = '0') then
		--	hit <= '0';
		end if;
		if (b_drawing_request = '1' ) then  
			m_mVGA_t <= b_mVGA_RGB;  --first priority from B 
		elsif  (mahbet1_drawing_request = '1' ) then  
			m_mVGA_t <= mahbet1_mVGA_RGB;  
		elsif  (mahbet2_drawing_request = '1' ) then  
			m_mVGA_t <= mahbet2_mVGA_RGB;
		elsif  (storm_drawing_request = '1' ) then  
			m_mVGA_t <= storm_mVGA_RGB;
		elsif  (state_drawing_request = '1' and playEnable = '0' ) then  
			m_mVGA_t <= state_mVGA_RGB;	
		else
			m_mVGA_t <= y_mVGA_RGB ; -- second priority from y
		end if;
	end if ; 
hit <= hitV ;
hit1 <= hit1V ;
hit2 <= hit2V ;

end process ;

m_mVGA_R	<= m_mVGA_t(7 downto 5)& "00000"; -- expand to 10 bits 
m_mVGA_G	<= m_mVGA_t(4 downto 2)& "00000";
m_mVGA_B	<= m_mVGA_t(1 downto 0)& "000000";


end behav;