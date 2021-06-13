----------------------------------------------------------------
--! @file UC.vhd
--! @author Antonio Lago Araújo Seixas <antonioseixas00@usp.br>
--! @author Lucas Moreira Oliveira <lucasmoreiraoliveira@usp.br>
--! @brief Control unity
--! @date 2021-06-06
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity UC is
    port (
        clock, reset:               	            in std_logic;
        reset_cont:                                 in std_logic;
        pause:                                      in std_logic;
        carga, fim_cont_quant, fim_cont_prod:	    in std_logic;
        pulso:                                      in std_logic;
        pronto:                     	            out std_logic;
        zera_quant, zera_prod:                      out std_logic;
        conta_quant, conta_prod:                    out std_logic;
        inicia,avanca, interrompe:                  out std_logic;
        db_estado:                  	            out std_logic_vector(3 downto 0)
    );
end entity;

architecture comportamental of UC is
    type Tipo_estado is (inicial_st, carrega_st, reset_cont_st, testa_fim_quant_st, conta_prod_st, conta_quant_st, testafim_st, pause_st, final_st);
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
        process(carga, reset_cont, pulso, fim_cont_quant,pause, fim_cont_prod, Eatual)
        begin
            case Eatual is
                when inicial_st =>          if carga='1'
                                            then Eprox <= carrega_st;
                                            else Eprox<= inicial_st;
                                            end if;
                
                when carrega_st =>               if reset_cont ='1'
                                            then Eprox <= reset_cont_st;
                                            else Eprox <= carrega_st;
                                            end if;
                
                
                when reset_cont_st =>       Eprox <= testa_fim_quant_st;
                
                when testa_fim_quant_st =>  if pause='1' 
                                            then Eprox <= pause_st;
                                            elsif fim_cont_quant='1'
                                            then Eprox <= conta_prod_st;
                                            elsif pulso='1'
											then Eprox <= conta_quant_st;
											else Eprox <= testa_fim_quant_st;
                                            end if;

                when pause_st =>            if pause = '1'
                                            then Eprox <= testa_fim_quant_st;
                                            else Eprox <= pause_st;
                                            end if;                
                
                when conta_prod_st =>       Eprox <= testafim_st;

                when conta_quant_st =>      Eprox <= testa_fim_quant_st;

				when testafim_st =>            if fim_cont_prod='1'
                                            then Eprox <= final_st;
                                            else Eprox <= testa_fim_quant_st;
                                            end if;
                
                when final_st =>               Eprox <= inicial_st;

                when others =>              Eprox <= inicial_st;
                
            end case;
        end process;

        -- saidas

        with Eatual select
        zera_quant <= '1' when carrega_st,
                      '1' when conta_prod_st,  '0' when others;

        with Eatual select
        zera_prod <= '1' when carrega_st, '0' when others;

        with Eatual select
        inicia <= '1' when reset_cont_st,
                  '1' when  testa_fim_quant_st, '0' when others;

        with Eatual select
        conta_prod <= '1' when conta_prod_st, '0' when others;

        with Eatual select
        avanca <= '1' when conta_prod_st, '0' when others;

        with Eatual select
        conta_quant <= '1' when conta_quant_st, '0' when others;

        with Eatual select
        interrompe <= '1' when pause_st, '0' when others;

        with Eatual select
        pronto <= '1' when final_st, '0' when others;

        with Eatual select
        db_estado <= "0000" when inicial_st,
                     "0001" when carrega_st,
                     "0010" when reset_cont_st,
                     "0011" when testa_fim_quant_st,
                     "0100" when conta_quant_st,
                     "0101" when conta_prod_st,
                     "0110" when pause_st,
                     "0111" when testafim_st,
                     "1000" when final_st,
                     "1111" when others;
end architecture;