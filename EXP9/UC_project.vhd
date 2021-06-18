----------------------------------------------------------------
--! @file UC_project.vhd
--! @author Antonio Lago Araújo Seixas <antonioseixas00@usp.br>
--! @author Lucas Moreira Oliveira <lucasmoreiraoliveira@usp.br>
--! @brief Control unity for the project
--! @date 2021-06-18
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity UC_project is
    port (
        Clock, Reset:               	            in std_logic;
        Sensor_presenca:                            in std_logic;
        Fim_cont:                                   in std_logic;
        Enable_cont:                                out std_logic;
        Liga_luminaria:                             out std_logic;
        db_state:                                    out std_logic_vector(1 downto 0)
        );                	            
end entity;

architecture comportamental of UC_project is
    type Tipo_estado is (desligado_st, ligado_st, contando_st);
    signal Eatual, Eprox: Tipo_estado;

    begin

        --proximo estado (reset, borda do clock)
        process( reset, clock)
        begin
            if reset='1' then
                Eatual<=desligado_st;
            elsif clock'event and clock='1' then
                Eatual<=Eprox;
            end if;
        end process;

        -- proximo estado
        process(Sensor_presenca, fim_cont, Eatual)
        begin
            case Eatual is
                when desligado_st =>        if Sensor_presenca='1'
                                            then Eprox <= ligado_st;
                                            else Eprox<= desligado_st;
                                            end if;
                
                when ligado_st =>           if Sensor_presenca='0'
                                            then Eprox <= contando_st;
                                            else Eprox <= ligado_st;
                                            end if;
                
                when contando_st =>         if Sensor_presenca='1' 
                                            then Eprox <= ligado_st;
                                            elsif fim_cont='1'
                                            then Eprox <= desligado_st;
											else Eprox <= contando_st;
                                            end if;
      

                when others =>              Eprox <= desligado_st;
                
            end case;
        end process;

        -- saidas

        with Eatual select
        Liga_luminaria <=   '1' when ligado_st,
                            '1' when contando_st,
                            '0' when  desligado_st,
                            '0' when others;

        with Eatual select
        Enable_cont <= '1' when contando_st, '0' when others;

        

        with Eatual select
        db_state <= "00" when desligado_st,
                     "01" when ligado_st,
                     "10" when contando_st,
                     "11" when others;
end architecture;