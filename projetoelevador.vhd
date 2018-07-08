library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all ;

entity projetoelevador is
 port (clock,clear : in std_logic;
       bot0, bot1, bot2, bot3: in std_logic;
      fio_rosa    : out std_logic ;
		 q:out std_logic_vector(6 downto 0);
		 LEDG: out std_logic_vector(3 downto 0);
		 fio_laranja : out std_logic ;
		fio_azul    : out std_logic ;
		fio_amarelo : out std_logic );
end projetoelevador;

architecture comportamental of projetoelevador is
	type state_type is (a, b, c, d, e, f, g, h,j);
	signal state, next_state: state_type;
	signal numero : std_logic_vector(3 downto 0);
	signal clk_60hz: std_logic ;
	 signal sentido : std_logic ;
	 signal ctrl: std_logic_vector (1 downto 0);
	 signal andar: std_logic_vector(1 downto 0);
	shared variable andar2: integer range 0 to 2;
	 shared variable andar3: integer range 0 to 3;
shared variable rotacao: integer range 0 to 4096:=0;
 begin
	process(clock)
		 variable contagem: integer range 0 to 50000;
		 begin
		  if falling_edge(clock) then
			contagem := contagem + 1;
			 if (contagem = 30000 ) then
				 clk_60hz <= not clk_60hz;
				 contagem := 0;
				end if;
			end if;
		 end process;
		process(clk_60hz, clear)
		 begin
		  if(clear ='1') then
			  state <= a;
			  rotacao := 0;
			elsif (falling_edge(clk_60hz)) then
				if state<=j then 
					rotacao := rotacao+1;
				end if;
				if (rotacao = 4096) then
					state <= j;
					rotacao := 0;
				else
					state <= next_state;
				end if;
			end if;

		 end process;	
		 process (sentido, state, clear )
		 
		 begin
			case state is
			 when a =>
			  if ( clear ='1' or bot0='0' or bot1='0' or bot2='0' or bot3='0') then
					next_state <= a;
				elsif ( sentido = '1') then
					next_state <= h;
				else	 
					next_state <= b;
				end if;	 
			  
			 when b =>
				if ( clear ='1' or bot0='0' or bot1='0' or bot2='0' or bot3='0') then
					next_state <= a;
				elsif ( sentido = '1') then
					next_state <= a;
				else	 
					next_state <= c;
				end if; 	 
				
			 when c =>
			 if ( clear ='1' or bot0='0' or bot1='0' or bot2='0' or bot3='0') then
					next_state <= a;
				elsif( sentido = '1') then
					next_state <= b;
				else	 
					next_state <= d;
				end if ;	 
			
			 when d =>
			 if ( clear ='1' or bot0='0' or bot1='0' or bot2='0' or bot3='0') then
					next_state <= a;
				elsif( sentido = '1') then
					next_state <= c;
				else	 
					next_state <= e;	
				end if;
			
			 when e =>
			 if ( clear ='1' or bot0='0' or bot1='0' or bot2='0' or bot3='0') then
					next_state <= a;
				elsif( sentido = '1') then
					next_state <= d;
				else	 
					next_state <= f;	
				end if;
			
			 when f =>
			 if ( clear ='1' or bot0='0' or bot1='0' or bot2='0' or bot3='0') then
					next_state <= a;
				elsif ( sentido = '1') then
					next_state <= e;
				else	 
					next_state <= g;	
				end if;
			
			 when g =>
			 if ( clear ='1' or bot0='0' or bot1='0' or bot2='0' or bot3='0') then
					next_state <= a;
				elsif( sentido = '1') then
					next_state <= f;
				else	 
					next_state <= h;	
				end if;
			
			 when h =>
			 if (clear ='1' or bot0='0' or bot1='0' or bot2='0' or bot3='0') then
					next_state <= a;
				elsif( sentido = '1') then
					next_state <= g;
				else 
					next_state <= a;
				end if;
				
				when j=>
				if (clear ='1' or bot0='0' or bot1='0' or bot2='0' or bot3='0') then
					next_state <= a;
				else
					next_state<=j;
				end if;
			end case;	
		 end process;
			process(state)
		 begin
		  case state is
			when a =>	
				fio_rosa    <= '0';
				fio_laranja <= '1';
				fio_azul    <= '0';
				fio_amarelo <= '0';
			  
			when b =>
				
				fio_rosa    <= '0';
				fio_laranja <= '1';
				fio_azul    <= '0';
				fio_amarelo <= '1';
					 
			when c =>
				
				fio_rosa    <= '0';
				fio_laranja <= '0';
				fio_azul    <= '0';
				fio_amarelo <= '1';
			
			when d =>
				fio_rosa    <= '1';
				fio_laranja <= '0';
				fio_azul    <= '0';
				fio_amarelo <= '1';
				
		  when e =>
				fio_rosa    <= '1';
				fio_laranja <= '0';
				fio_azul    <= '0';
				fio_amarelo <= '0';
			  
			when f =>
				fio_rosa    <= '1';
				fio_laranja <= '0';
				fio_azul    <= '1';
				fio_amarelo <= '0';
					 
			when g =>
				fio_rosa    <= '0';
				fio_laranja <= '0';
				fio_azul    <= '1';
				fio_amarelo <= '0';
			
			when h =>
				fio_rosa    <= '0';
				fio_laranja <= '1';
				fio_azul    <= '1';
				fio_amarelo <= '0';	
			when j =>
				fio_rosa    <= '0';
				fio_laranja <= '0';
				fio_azul    <= '0';
				fio_amarelo <= '0';	
			
			end case;	
		 end process;
process (bot0, bot1, bot2, bot3, clear)
 begin
	if bot0 = '0' then
		if ctrl > "00" then
			ctrl<=ctrl-1;
			sentido <='0';
		else ctrl<="00";
		end if;
	end if;
	
	if bot1 = '0' then
		if ctrl > "01" then
			ctrl<=ctrl-1;
			sentido <='0';
		elsif ctrl<"01" then
			ctrl<=ctrl+1;
			sentido <='1';
		else ctrl<="01";
		end if;
	end if;
	
	if bot2 ='0' then
		if ctrl > "10" then
			ctrl<=ctrl-1;
			sentido <='0';
		elsif ctrl<"10" then
			ctrl<=ctrl+1;
			sentido <='1';
		else ctrl<="10";
		end if;
	end if;
	
	if bot3 = '0' then
		if ctrl < "11" then
			ctrl<=ctrl+1;
			sentido <='1';
		else ctrl<="11";	
		end if;
	end if;
 end process;
 process(ctrl)
 begin
  case ctrl is
   when "00" =>
	   q <= "0000001";
		LEDG <= "1111";
		
   when "01" =>
		q <= "1001111";
	 	LEDG<="1110";	 
   when "10" =>
	   q <= "0010010";
	   LEDG <= "1101";
   when "11" =>
	  	q <= "0000110";
		LEDG<= "1011";
 end case;
 end process;
end comportamental;



