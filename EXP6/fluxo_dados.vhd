----------------------------------------------------------------
--! @file fluxo_dados.vhd
--! @brief data flow circuit for EXP 6
--! @author Antonio Lago Araújo Seixas <antonioseixas00@usp.br>
--! @author Lucas Moreira Oliveira <lucasmoreiraoliveira@usp.br>
--! @date 2021-05-22
-----------------------------------------------------------------

-- Library declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Structural circuit

entity fluxo_dados is
    port(
        clock:            in std_logic;
        zera1, conta1:    in std_logic;
        conta2, carrega2: in std_logic;
        fim1, condicao1:  out std_logic;
        saida:            out std_logic_vector(3 downto 0);
        db_fim2:          out std_logic;
        db_contagem1:     out std_logic_vector(3 downto 0)      
    );
end entity;

architecture structural of fluxo_dados is 

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

    signal count: std_logic_vector( 3 downto 0);
    

begin
    counter1: contador_hexadecimal port map (
        clock => clock,
        carrega => '0',
        conta => conta1,
        zera => zera1,
        entrada => "0000",
        contagem => count,
        fim => fim1
    );

    counter2: contador_hexadecimal port map (
        clock => clock,
        carrega => carrega2,
        conta => conta2,
        zera => '0',
        entrada => "0000",
        contagem => saida,
        fim => db_fim2
    );

    comparator: comparador_2bits port map (
        A => count( 3 downto 2),
        B => count (1 downto 0),
        igual => condicao1
    );

    db_contagem1 <= count;

end architecture;













    