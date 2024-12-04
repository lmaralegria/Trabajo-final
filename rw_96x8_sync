library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

entity rw_96x8_sync is
port (
        address   : in  std_logic_vector(7 downto 0);  
        data_in   : in  std_logic_vector(7 downto 0);  
        writes    : in  std_logic;                      
        clock     : in  std_logic;                   
        data_out  : out std_logic_vector(7 downto 0)    
    );
end rw_96x8_sync;

architecture arch_rw_96x8_sync of rw_96x8_sync is
    type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);
    signal RW : rw_type;  

begin

process(clock)
begin
if rising_edge(clock) then
          
   if (to_integer(unsigned(address)) >= 128) and (to_integer(unsigned(address)) <= 223) then
       
      if writes = '1' then
         RW(to_integer(unsigned(address))) <= data_in;
       elsif writes = '0' then
             data_out <= RW(to_integer(unsigned(address)));
       end if;
   end if;
end if;
end process;

end arch_rw_96x8_sync;
