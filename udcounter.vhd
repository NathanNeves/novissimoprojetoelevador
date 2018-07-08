library ieee;
use ieee.std_logic_1164.all;
entity udcounter is
	port (entrada: in std_logic_vector (3 downto 0);
			LED_out: out std_logic_vector (6 downto 0));
end udcounter;
architecture bcd of udcounter is
	BEGIN
	process(entrada)
		BEGIN
			
			end case;
	end process;
end bcd;