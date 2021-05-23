library ieee;
use ieee.std_logic_1164.all;

entity comparador_2bits is 
    port (
        A, B: in std_logic_vector (1 downto 0);
        igual : out std_logic 
    );
end entity;

architecture arch of comparador_2bits is
begin
    igual <= '1' when A=B else '0'; 
end architecture;