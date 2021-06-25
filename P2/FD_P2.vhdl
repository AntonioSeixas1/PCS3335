-- generated by Digital. Don't modify this file!
-- Any changes will be lost if this file is regenerated.

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DIG_JK_FF_AS is
  generic (Default : std_logic);  
  port (
    Q: out std_logic;
    notQ: out std_logic;
    Set: in std_logic;
    J: in std_logic;
    C: in std_logic;
    K: in std_logic;
    Clr: in std_logic );
end DIG_JK_FF_AS;

architecture Behavioral of DIG_JK_FF_AS is
  signal state: std_logic := Default;
begin
    process (C, Clr, Set)
    begin
        if (Set='1') then
            state <= '1';
        elsif (Clr='1') then
            state <= '0';
        elsif rising_edge(C) then
          if (J='0' and K='1') then
             state <= '0';
          elsif (J='1' and K='0') then
             state <= '1';
          elsif (J='1' and K='1') then
             state <= not (state);
          end if;
        end if;
    end process;

    Q <= state;
    notQ <= NOT( state );
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- Synchronous 4-Bit Up/Down Binary Counter with Dual Clock
entity n74193 is
  port (
    D0: in std_logic; -- Data Input 0
    DN: in std_logic; -- Down Count
    UP: in std_logic; -- Up Count
    D1: in std_logic; -- Data Input 1
    D2: in std_logic; -- Data Input 2
    D3: in std_logic; -- Data Input 3
    CLR: in std_logic; -- Clear
    notLD: in std_logic; -- Load
    VCC: in std_logic;
    GND: in std_logic;
    notBO: out std_logic; -- Borrow Output
    notCO: out std_logic; -- Carry Output
    Q0: out std_logic; -- Output Q0
    Q1: out std_logic; -- Output Q1
    Q2: out std_logic; -- Output Q2
    Q3: out std_logic -- Output Q3
    );
end n74193;

architecture Behavioral of n74193 is
  signal Q0_temp: std_logic;
  signal Q1_temp: std_logic;
  signal Q2_temp: std_logic;
  signal Q3_temp: std_logic;
  signal s0: std_logic;
  signal s1: std_logic;
  signal s2: std_logic;
  signal s3: std_logic;
  signal s4: std_logic;
  signal s5: std_logic;
  signal s6: std_logic;
  signal s7: std_logic;
  signal s8: std_logic;
  signal s9: std_logic;
  signal s10: std_logic;
  signal s11: std_logic;
  signal s12: std_logic;
  signal s13: std_logic;
  signal s14: std_logic;
  signal s15: std_logic;
  signal s16: std_logic;
  signal s17: std_logic;
  signal s18: std_logic;
  signal s19: std_logic;
  signal s20: std_logic;
  signal s21: std_logic;
  signal s22: std_logic;
  signal s23: std_logic;
begin
  s1 <= NOT DN;
  s0 <= NOT UP;
  s7 <= NOT CLR;
  s6 <= NOT notLD;
  s8 <= NOT (D0 AND s6 AND s7);
  s11 <= NOT (s1 OR s0);
  s12 <= NOT (D1 AND s6 AND s7);
  s16 <= NOT (D2 AND s6 AND s7);
  s20 <= NOT (D3 AND s6 AND s7);
  s9 <= (NOT s7 OR NOT (NOT (s8 AND s6)));
  s10 <= NOT s8;
  s13 <= (NOT s7 OR NOT (NOT (s12 AND s6)));
  s14 <= NOT s12;
  s17 <= (NOT s7 OR NOT (NOT (s16 AND s6)));
  s18 <= NOT s16;
  s21 <= (NOT s7 OR NOT (NOT (s20 AND s6)));
  s22 <= NOT s20;
  gate0: entity work.DIG_JK_FF_AS
    generic map (
      Default => '0')
    port map (
      Set => s10,
      J => '1',
      C => s11,
      K => '1',
      Clr => s9,
      Q => Q0_temp,
      notQ => s2);
  s15 <= NOT ((s1 AND s2) OR (Q0_temp AND s0));
  gate1: entity work.DIG_JK_FF_AS
    generic map (
      Default => '0')
    port map (
      Set => s14,
      J => '1',
      C => s15,
      K => '1',
      Clr => s13,
      Q => Q1_temp,
      notQ => s3);
  s19 <= NOT ((s1 AND s2 AND s3) OR (Q0_temp AND Q1_temp AND s0));
  gate2: entity work.DIG_JK_FF_AS
    generic map (
      Default => '0')
    port map (
      Set => s18,
      J => '1',
      C => s19,
      K => '1',
      Clr => s17,
      Q => Q2_temp,
      notQ => s4);
  s23 <= NOT ((s1 AND s2 AND s3 AND s4) OR (Q0_temp AND Q1_temp AND Q2_temp AND s0));
  gate3: entity work.DIG_JK_FF_AS
    generic map (
      Default => '0')
    port map (
      Set => s22,
      J => '1',
      C => s23,
      K => '1',
      Clr => s21,
      Q => Q3_temp,
      notQ => s5);
  notCO <= NOT (Q0_temp AND Q1_temp AND Q2_temp AND Q3_temp AND s0);
  notBO <= NOT (s1 AND s2 AND s3 AND s4 AND s5);
  Q0 <= Q0_temp;
  Q1 <= Q1_temp;
  Q2 <= Q2_temp;
  Q3 <= Q3_temp;
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- 4-bit comparator
entity n7485 is
  port (
    PleQ_i: in std_logic;
    PeqQ_i: in std_logic;
    PgrQ_i: in std_logic;
    P_0: in std_logic;
    P_1: in std_logic;
    P_2: in std_logic;
    P_3: in std_logic;
    Q_0: in std_logic;
    Q_1: in std_logic;
    Q_2: in std_logic;
    Q_3: in std_logic;
    VCC: in std_logic;
    GND: in std_logic;
    PleQ: out std_logic;
    PeqQ: out std_logic;
    PgrQ: out std_logic);
end n7485;

architecture Behavioral of n7485 is
  signal s0: std_logic;
  signal s1: std_logic;
  signal s2: std_logic;
  signal s3: std_logic;
  signal s4: std_logic;
  signal s5: std_logic;
  signal s6: std_logic;
  signal s7: std_logic;
begin
  s0 <= NOT (P_0 AND Q_0);
  s2 <= NOT (P_1 AND Q_1);
  s4 <= NOT (P_2 AND Q_2);
  s6 <= NOT (P_3 AND Q_3);
  s1 <= NOT ((P_0 AND s0) OR (s0 AND Q_0));
  s3 <= NOT ((P_1 AND s2) OR (s2 AND Q_1));
  s5 <= NOT ((P_2 AND s4) OR (s4 AND Q_2));
  s7 <= NOT ((P_3 AND s6) OR (s6 AND Q_3));
  PgrQ <= (NOT (Q_3 AND s6) AND NOT (Q_2 AND s4 AND s7) AND NOT (Q_1 AND s2 AND s7 AND s5) AND NOT (Q_0 AND s0 AND s7 AND s5 AND s3) AND NOT (s7 AND s5 AND s3 AND s1 AND PleQ_i) AND NOT (s7 AND s5 AND s3 AND s1 AND PeqQ_i));
  PeqQ <= (s7 AND s5 AND PeqQ_i AND s3 AND s1);
  PleQ <= (NOT (PeqQ_i AND s1 AND s3 AND s5 AND s7) AND NOT (PgrQ_i AND s1 AND s5 AND s3 AND s7) AND NOT (s3 AND s5 AND s7 AND s0 AND P_0) AND NOT (s5 AND s7 AND s2 AND P_1) AND NOT (s7 AND s4 AND P_2) AND NOT (s6 AND P_3));
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity main is
  port (
    Saida: in std_logic;
    Reset: in std_logic;
    Entra: in std_logic;
    Cheio: out std_logic;
    Presenca1: out std_logic;
    Presenca10: out std_logic);
end main;

architecture Behavioral of main is
  signal s0: std_logic;
  signal s1: std_logic;
  signal s2: std_logic;
  signal s3: std_logic;
  signal s4: std_logic;
  signal s5: std_logic;
  signal s6: std_logic;
  signal s7: std_logic;
begin
  s0 <= NOT Saida;
  s1 <= NOT Entra;
  gate0: entity work.n74193
    port map (
      D0 => '0',
      DN => s0,
      UP => s1,
      D1 => '0',
      D2 => '0',
      D3 => '0',
      CLR => Reset,
      notLD => '1',
      VCC => '1',
      GND => '0',
      Q0 => s2,
      Q1 => s3,
      Q2 => s4,
      Q3 => s5);
  gate1: entity work.n7485
    port map (
      PleQ_i => '0',
      PeqQ_i => '1',
      PgrQ_i => '1',
      P_0 => '0',
      P_1 => '1',
      P_2 => '0',
      P_3 => '1',
      Q_0 => s2,
      Q_1 => s3,
      Q_2 => s4,
      Q_3 => s5,
      VCC => '1',
      GND => '0',
      PeqQ => s6,
      PgrQ => s7);
  Cheio <= (s2 AND s3 AND s4 AND s5);
  Presenca1 <= (s2 OR s3 OR s4 OR s5);
  Presenca10 <= (s6 OR s7);
end Behavioral;
