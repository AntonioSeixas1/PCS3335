-----------------------------------------------------------------------
--! @file UC_P2.vhd
--! @author Antonio Lago Araújo Seixas <antonioseixas00@usp.br>
--! @author Lucas Moreira Oliveira <lucasmoreiraoliveira@usp.br>
--! @brief Control unity for meeting's room control - P2
--! @date 2021-06-18
------------------------------------------------------------------------
 
library ieee;
use ieee.std_logic_1164.all;

entity UC_P2 is
    port (
        Clock, Reset:                            in std_logic;
        Presenca_1, Presenca_10, Presenca_15:    in std_logic;
        Cheio, Vazio:                            out std_logic;
        liga_luz, liga_ac:                       out std_logic;
        db_state:                                out std_logic_vector(2 downto 0)

    );
end entity;


architecture behavioral of UC_P2 is

    type Tipo_estado is (inicial_st, vazio_st, pelomenos_1_st, pelomenos_10_st, cheio_st);
    signal Eatual, Eprox: Tipo_estado;

    begin

        --proximo estado (reset, borda do clock)
        process( reset, clock)
        begin
            if reset='1' then
                Eatual<=inicial_st;
            elsif clock'event and clock='1' then
                Eatual<=Eprox;
            end if;
        end process;

        -- proximo estado
        process(Presenca_1, Presenca_10, Presenca_15, Eatual)
        begin
            case Eatual is
                when inicial_st =>              Eprox <= vazio_st;

                when vazio_st =>                if Presenca_1 = '1'
                                                then Eprox <= pelomenos_1_st;
                                                else Eprox <= vazio_st;
                                                end if;

                when pelomenos_1_st =>          if Presenca_1 = '0'
                                                then Eprox <= vazio_st;
                                                elsif Presenca_10 = '1'
                                                then Eprox <= pelomenos_10_st;
                                                else Eprox <= pelomenos_1_st;
                                                end if;
                                        
                when pelomenos_10_st =>         if Presenca_10 = '0'
                                                then Eprox <=  pelomenos_1_st;
                                                elsif Presenca_15 = '1'
                                                then Eprox <= cheio_st;
                                                else Eprox <= pelomenos_10_st;
                                                end if;

                when cheio_st =>                if Presenca_15 = '0'
                                                then Eprox <= pelomenos_10_st;
                                                else Eprox <= cheio_st;
                                                end if;

                when others =>                  Eprox <= inicial_st;


            end case;
        end process;

    --saidas

    with Eatual select 

    liga_luz <= '1' when pelomenos_1_st,
                '1' when pelomenos_10_st,
                '1' when cheio_st,
                '0' when others;
                
    with Eatual select
    
    liga_ac <=  '1' when pelomenos_10_st,
                '1' when cheio_st,
                '0' when others;

    with Eatual select

    cheio <=    '1' when cheio_st,
                '0' when others;

    with Eatual select

    vazio <=    '1' when inicial_st,
                '1' when vazio_st,
                '0' when others;

    with Eatual select

    db_state <=     "000" when inicial_st,
                    "001" when vazio_st,
                    "010" when pelomenos_1_st,
                    "011" when pelomenos_10_st,
                    "100" when cheio_st,
                    "111" when others;
                        
end architecture;
                

    




