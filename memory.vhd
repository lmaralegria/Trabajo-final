library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity memory is
port (
address: in std_logic_vector(7 downto 0);
data_in: in std_logic_vector (7 downto 0);
writes: in std_logic;
clock: in std_logic;
reset: in std_logic;
port_in_00: in std_logic_vector(7 downto 0);
port_in_01: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector (7 downto 0);
port_out_00 : out std_logic_vector(7 downto 0);
port_out_01 : out std_logic_vector(7 downto 0));
end memory;
architecture arch_memory of memory is
component Output_Ports
  port (
    address     : in std_logic_vector(7 downto 0);
    data_in     : in std_logic_vector(7 downto 0);
    writes      : in std_logic;
    clock       : in std_logic;
    reset       : in std_logic;
    port_out_00 : out std_logic_vector(7 downto 0);
    port_out_01 : out std_logic_vector(7 downto 0)
  );
end component;
component rw_96x8_sync 
port (
        address   : in  std_logic_vector(7 downto 0);  
        data_in   : in  std_logic_vector(7 downto 0);  
        writes    : in  std_logic;                      
        clock     : in  std_logic;                   
        data_out  : out std_logic_vector(7 downto 0)    
    );
end component;
component rom_128x8_sync 
    port (
        address   : in  std_logic_vector(7 downto 0);  
        clock     : in  std_logic;                      
        data_out  : out std_logic_vector(7 downto 0)    
    );
end component;

signal data_out0,data_out1: std_logic_vector (7 downto 0);
begin
U0: rom_128x8_sync port map (address,clock,data_out0);
U1: rw_96x8_sync port map (address, data_in, writes,clock,data_out1);
U2: Output_Ports port map (address, data_in, writes,clock, reset, port_out_00,port_out_01);

MUX1 : process (address, data_out0, data_out1,

port_in_00, port_in_01)

begin
if ( (to_integer(unsigned(address)) >= 0) and
(to_integer(unsigned(address)) <= 127)) then
data_out <= data_out0;
elsif ( (to_integer(unsigned(address)) >= 128) and
(to_integer(unsigned(address)) <= 223)) then
data_out <= data_out1;
elsif (address = x"F0") then data_out <= port_in_00;
elsif (address = x"F1") then data_out <= port_in_01;

else data_out <= x"00";
end if;
end process;

end arch_memory;