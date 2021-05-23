----------------------------------------------------------------
--! @file circuito4.vhd
--! @brief circuito 4
--! @author Antonio Lago Araújo Seixas <antonioseixas00@usp.br>
--! @author Lucas Moreira Oliveira <lucasmoreiraoliveira@usp.br>
--! @date 2021-05-22
-----------------------------------------------------------------

-- Library declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity

entity circuito4 is
    port (
        clock, reset, iniciar:      in std_logic;
        pronto, fim:                out std_logic;
        saida:                      out std_logic_vector(3 downto 0);
        db_contagem1:               out std_logic_vector(3 downto 0);
        db_zera1, db_conta1:        out std_logic;
        db_conta2, db_carrega2:     out std_logic;
        db_condicao1, db_fim2:      out std_logic;
        db_estado:                  out std_logic_vector(2 downto 0)
    );
end entity;


architecture structural of circuito4 is
    
    component maquina_estados is
        port (
            clock, reset:               in std_logic;
            iniciar, condicao1, fim:    in std_logic;
            pronto:                     out std_logic;
            zera1, conta1:              out std_logic;
            conta2, carrega2:           out std_logic;
            db_estado:                  out std_logic_vector(2 downto 0)
        );
    end component;

    component fluxo_dados is
        port(
            clock:            in std_logic;
            zera1, conta1:    in std_logic;
            conta2, carrega2: in std_logic;
            fim1, condicao1:  out std_logic;
            saida:            out std_logic_vector(3 downto 0);
            db_fim2:          out std_logic;
            db_contagem1:     out std_logic_vector(3 downto 0)      
        );
    end component;

    signal s_zera1: std_logic;
    signal conta1: std_logic;
    signal s_carrega2: std_logic;
    signal s_conta2: std_logic;
    signal s_condicao1: std_logic;
    signal s_fim1: std_logic;

begin

    MQE: maquina_estados port map (
        clock => clock
        reset => reset
        iniciar => iniciar
        condicao1 => s_condicao1,
        fim => s_fim1,
        pronto => pronto,
        zera1 => s_zera1,
        conta1 => s_conta1,
        conta2 => s_conta2,
        carrega2 => s_carrega2,
        db_estado => db_estado
    );

    FLX: fluxo_dados port map (
        clock => clock
        zera1 => s_zera1,
        conta1 => s_conta1,
        conta2 => s_conta2,
        carrega2 => s_carrega2,
        fim1 => s_fim1,
        condicao1 => s_condicao1,
        saida => saida,
        db_fim2 => db_fim2,
        db_contagem1 => db_contagem1
    );

    fim <= s_fim1;
    db_zera1 <= s_zera1;
    db_conta1 <= s_conta1;
    db_conta2 <= s_conta2;
    

