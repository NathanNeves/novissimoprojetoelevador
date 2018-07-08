library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all ;
 
entity contador is
 port (bot0,bot1,bot2,bot3, clock : in std_logic;
       q:out std_logic_vector(6 downto 0);
         LEDG: out std_logic_vector(3 downto 0);
          fio_rosa    : out std_logic ;
         fio_laranja : out std_logic ;
        fio_azul    : out std_logic ;
        fio_amarelo : out std_logic );
end contador;
 
architecture comportamental of contador is
type state_type is (a, b, c, d, e, f, g, h);
 signal state, next_state: state_type;
    signal numero : std_logic_vector(3 downto 0);
     signal clk_60hz: std_logic ;
     signal atraso : INTEGER RANGE 0 TO 4096:=0;
begin
    process(clock)
   
        Begin
           
            if rising_edge(clock) then
                    if atraso<4096 then
                        atraso<= atraso+1;
                    else
                        atraso<=0;
                end if;
                if atraso = 3000  then
                    numero<= numero + 1;
                    if numero = "1010" then
                        numero<="0000";
                        clk_60hz <= not clk_60hz ;
                end if;
            end if;
            end if;
   
   
            case numero is
                when "0000" => q <= "1000000";    
                when "0001" => q <= "1111001";  
                when "0010" => q <= "0100100";
                when "0011" => q <= "0110000";  
                when "0100" => q <= "0011001";  
                when "0101" => q <= "0010010";  
                when "0110" => q <= "0000010";  
                when "0111" => q <= "1111000";  
                when "1000" => q <= "0000000";
                when "1001" => q <= "0010000";             
                when others => q <= "0001001";
    end case;
end process;
    process(clk_60hz, bot0)
        begin
            if(bot0 ='0') then
                state <= a ;
            elsif (clk_60hz'event and clk_60hz = '0') then
                state <= next_state;
            end if;
    end process;
 process (state, bot0 )
 begin
   case state is
     when a =>
      if ( bot0 ='0') then
          next_state <= a;
       else  
          next_state <= b;
    end if;  
     
     when b =>
     if ( bot0 ='0') then
          next_state <= a;
       else  
          LEDG<="1110";
            next_state <= c;
       end if;  
       
     when c =>
     if ( bot0 ='0') then
          next_state <= a;
       else  
            LEDG<= "1100";
          next_state <= d;
    end if ;     
   
     when d =>
     if ( bot0 ='0') then
          next_state <= a;
       else  
            LEDG<="1000";
          next_state <= e; 
    end if;
   
     when e =>
     if ( bot0 ='0') then
          next_state <= a;
       else  
            LEDG<="0000";
          next_state <= f; 
    end if;
   
     when f =>
     if ( bot0 ='0') then
          next_state <= a;
       else  
            LEDG<="1111";
          next_state <= g; 
    end if;
   
     when g =>
     if ( bot0 ='0') then
          next_state <= a;
       else  
            LEDG<="1111";
            next_state <= h;   
    end if;
   
     when h =>
        if ( bot0 ='0') then
          next_state <= a;
       else  
            LEDG<="1111";
            next_state <= a;   
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
		  LEDG<= "1111";
     
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
   
   end case;   
 end process;
end comportamental;