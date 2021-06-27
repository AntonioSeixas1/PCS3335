-----------------------------------------------------------------------
--! @file CSR.vhd
--! @author Antonio Lago Araújo Seixas <antonioseixas00@usp.br>
--! @author Lucas Moreira Oliveira <lucasmoreiraoliveira@usp.br>
--! @brief meeting's room control  circuit- P2
--! @date 2021-06-18
------------------------------------------------------------------------
 
library ieee;
use ieee.std_logic_1164.all;

entity CSR is
    port (
        Clock, Reset:       in std_logic;
        Entrou, Saiu:       in std_logic;
        Cheio, Vazio:       out std_logic;
        Liga_luz:           out std_logic;
        Liga_ac:            out std_logic;
        db_state:           out std_logic_vector(2 downto 0)
    );
end entity;

architecture structural of CSR is

    component FD_P2 is
        port (
          Saida: in std_logic;
          Reset: in std_logic;
          Entra: in std_logic;
          Cheio: out std_logic;
          Presenca1: out std_logic;
          Presenca10: out std_logic);
      end component;


      component UC_P2 is
        port (
            Clock, Reset:                            in std_logic;
            Presenca_1, Presenca_10, Presenca_15:    in std_logic;
            Cheio, Vazio:                            out std_logic;
            liga_luz, liga_ac:                       out std_logic;
            db_state:                                out std_logic_vector(2 downto 0)
    
        );
    end component;

    signal presenca1_s, presenca10_s,presenca15_s: std_logic;

    begin

        FDP2: FD_P2 port map (
            Saida => Saiu,
            Reset => Reset,
            Entra => Entrou,
            Cheio => presenca15_s,
            Presenca1 => presenca1_s,
            Presenca10 => presenca10_s
        );


        UCP2: UC_P2 port map (
            Clock => Clock,
            Reset => Reset,
            Presenca_1 => presenca1_s,
            Presenca_10 => presenca10_s,
            Presenca_15 => presenca15_s,
            Cheio => Cheio,
            Vazio => Vazio,
            liga_luz => Liga_luz,
            liga_ac => Liga_ac,
            db_state => db_state
        );

end architecture;

