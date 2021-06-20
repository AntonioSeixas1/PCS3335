-----------------------------------------------------------------------
--! @file UC_project.vhd
--! @author Antonio Lago Araújo Seixas <antonioseixas00@usp.br>
--! @author Lucas Moreira Oliveira <lucasmoreiraoliveira@usp.br>
--! @brief Control unity for the project Autonumus ilumination System
--! @date 2021-06-18
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity UC_project is
    port (
        Clock, Reset:               	            in std_logic;
        Sensor_presenca:                            in std_logic;
        Confirma:                                   in std_logic;
        Fim_cont:                                   in std_logic;
        Luminosidade:                               in std_logic_vector(1 downto 0);
        Reset_cont:                                 out std_logic;
        Enable_reg:                                 out std_logic;
        Enable_cont:                                out std_logic;
        Liga_luminaria:                             out std_logic;
        db_state:                                   out std_logic_vector(2 downto 0)
        );                	            
end entity;

architecture comportamental of UC_project is
    type Tipo_estado is (inicial_st, carrega_st, desligado_st, ligado_st, contando_st);
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
        process(Sensor_presenca, Fim_cont, Confirma, Eatual)
        begin
            case Eatual is
                when inicial_st =>          Eprox <= carrega_st;

                when carrega_st =>            if confirma = '1'
                                            then Eprox <= desligado_st;
                                            else Eprox <= carrega_st;
                                            end if;

                when desligado_st =>        if Sensor_presenca='1' and Luminosidade /= "00"
                                            then Eprox <= ligado_st;
                                            else Eprox<= desligado_st;
                                            end if;
                
                when ligado_st =>           if Luminosidade = "00"
											then Eprox <= desligado_st;
										    elsif Sensor_presenca='0'
                                            then Eprox <= contando_st;
                                            else Eprox <= ligado_st;
                                            end if;
                
                when contando_st =>         if Sensor_presenca='1' 
                                            then Eprox <= ligado_st;
                                            elsif fim_cont='1'
                                            then Eprox <= desligado_st;
											else Eprox <= contando_st;
                                            end if;
      

                when others =>              Eprox <= inicial_st;
                
            end case;
        end process;

        -- saidas

        with Eatual select
        Liga_luminaria <=   '1' when ligado_st,
                            '1' when contando_st,
                            '0' when  desligado_st,
                            '0' when others;

        with Eatual select
        Enable_reg <= '1' when carrega_st,
                      '0' when others;

        with Eatual select
        Reset_cont <= '0' when contando_st,
                      '1' when others;              

        with Eatual select
        Enable_cont <= '1' when contando_st, '0' when others;

        

        with Eatual select
        db_state <= "000" when inicial_st,
                    "001" when carrega_st,
                    "010" when desligado_st,
                    "011" when ligado_st,
                    "100" when contando_st,
                    "111" when others;
end architecture;