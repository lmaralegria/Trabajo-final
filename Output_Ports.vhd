library ieee;
use ieee.std_logic_1164.all;

entity Output_Ports is
  port (
    address     : in std_logic_vector(7 downto 0);
    data_in     : in std_logic_vector(7 downto 0);
    writes      : in std_logic;
    clock       : in std_logic;
    reset       : in std_logic;
    port_out_00 : out std_logic_vector(7 downto 0);
    port_out_01 : out std_logic_vector(7 downto 0)
  );
end Output_Ports;

architecture arch_output_ports of Output_Ports is
begin 
  -- port_out_00 description: ADDRESS x"E0"
  U3: process (clock, reset)
  begin
    if (reset = '0') then
      port_out_00 <= x"00";  
    elsif (clock'event and clock = '1') then
      if (address = x"E0" and writes = '1') then
        port_out_00 <= data_in;  
      end if;
    end if;
  end process;

  -- port_out_01 description: ADDRESS x"E1"
  U4: process (clock, reset)
  begin
    if (reset = '0') then
      port_out_01 <= x"00";  
    elsif (clock'event and clock = '1') then
      if (address = x"E1" and writes = '1') then
        port_out_01 <= data_in;  
      end if;
    end if;
  end process;

end arch_output_ports;
