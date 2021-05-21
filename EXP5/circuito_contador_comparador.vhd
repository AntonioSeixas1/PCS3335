----------------------------------------------------------------
--! @file circuito_estrutural.vhd
--! @brief counter and comparator circuit
--! @author Antonio Lago Araújo Seixas <antonioseixas00@usp.br>
--! @author Lucas Moreira Oliveira <lucasmoreiraoliveira@usp.br>
--! @date 2021-05-15
-----------------------------------------------------------------

-- Library declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Structual circuit

entity circuito_contador_comparador is
    port(
        Clock, Carrega, Envia, Zera: in std_logic;
        Entrada: in std_logic_vector (3 downto 0);
        Igual, RCO: out std_logic
    );
end entity;

architecture structural of circuito_contador_comparador is 

    component comparador_2bits is 
        port (
        A, B: in std_logic_vector (1 downto 0);
        igual: out std_logic 
        );
    end component;

    component contador_hexadecimal is
        port (
        clock, zera, conta, carrega: in std_logic;
        entrada: in std_logic_vector (3 downto 0);
        contagem: out std_logic_vector (3 downto 0);
        fim: out std_logic
        );
    end component;

    signal count: std_logic_vector ( 3 downto 0);

begin
    counter: contador_hexadecimal port map (
        clock => clock,
        carrega => Carrega,
        conta => Envia,
        zera => Zera,
        entrada => Entrada,
        contagem => count,
        fim => RCO
    );

    comparator: comparador_2bits port map (
        A => count( 3 downto 2),
        B => count (1 downto 0),
        igual => Igual
    );


end architecture;













    