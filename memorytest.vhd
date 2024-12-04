library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memorytest is
    port
    (
        -- Input ports
        address: in std_logic_vector(7 downto 0);
        data_in: in std_logic_vector(7 downto 0);
        writes: in std_logic;
        clock: in std_logic;
        reset: in std_logic;
        port_in_00: in std_logic_vector(7 downto 0);
        port_in_01: in std_logic_vector(7 downto 0);

        -- Output ports
        data_out: out std_logic_vector(7 downto 0);
        port_out_00: out std_logic_vector(7 downto 0);
        port_out_01: out std_logic_vector(7 downto 0);
        H0, H1, H2, H3: out std_logic_vector(6 downto 0)
    );
end memorytest;

architecture arch_memorytest of memorytest is

    -- Component declaration for memory
    component memory
        port
        (
            address: in std_logic_vector(7 downto 0);
            data_in: in std_logic_vector(7 downto 0);
            writes: in std_logic;
            clock: in std_logic;
            reset: in std_logic;
            port_in_00: in std_logic_vector(7 downto 0);
            port_in_01: in std_logic_vector(7 downto 0);
            data_out: out std_logic_vector(7 downto 0);
            port_out_00: out std_logic_vector(7 downto 0);
            port_out_01: out std_logic_vector(7 downto 0)
        );
    end component;

    -- Component declaration for FullDecoBCD
    component FullDecoBCD
        port
        (
            A, B, C, D: in std_logic;
            S: out std_logic_vector(6 downto 0)
        );
    end component;

    -- Signal declarations
    signal X: std_logic_vector(7 downto 0);

begin

    -- Instance of memory
    U0: memory
        port map (
            address => address,
            data_in => data_in,
            writes => writes,
            clock => clock,
            reset => reset,
            port_in_00 => port_in_00,
            port_in_01 => port_in_01,
            data_out => X,
            port_out_00 => port_out_00,
            port_out_01 => port_out_01
        );

    -- Instances of FullDecoBCD
    U1: FullDecoBCD
        port map (
            A => X(7),
            B => X(6),
            C => X(5),
            D => X(4),
            S => H0
        );

    U2: FullDecoBCD
        port map (
            A => X(3),
            B => X(2),
            C => X(1),
            D => X(0),
            S => H1
        );

    U3: FullDecoBCD
        port map (
            A => address(7),
            B => address(6),
            C => address(5),
            D => address(4),
            S => H2
        );

    U4: FullDecoBCD
        port map (
            A => address(3),
            B => address(2),
            C => address(1),
            D => address(0),
            S => H3
        );

end arch_memorytest;
