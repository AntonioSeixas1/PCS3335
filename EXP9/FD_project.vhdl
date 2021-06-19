-- generated by Digital. Don't modify this file!
-- Any changes will be lost if this file is regenerated.

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DIG_D_FF is
  generic (
    Default: std_logic ); 
  port ( D  : in std_logic;
         C  : in std_logic;
         Q  : out std_logic;
         notQ : out std_logic );
end DIG_D_FF;

architecture Behavioral of DIG_D_FF is
   signal state : std_logic := Default;
begin
   Q    <= state;
   notQ <= NOT( state );

   process(C)
   begin
      if rising_edge(C) then
        state  <= D;
      end if;
   end process;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- Octal D Flip-Flop with enable
entity n74377 is
  port (
    D0: in std_logic;
    VCC: in std_logic;
    GND: in std_logic;
    D1: in std_logic;
    D2: in std_logic;
    D3: in std_logic;
    notE: in std_logic;
    D4: in std_logic;
    D5: in std_logic;
    D6: in std_logic;
    D7: in std_logic;
    CLK: in std_logic;
    Q0: out std_logic;
    Q1: out std_logic;
    Q2: out std_logic;
    Q3: out std_logic;
    Q4: out std_logic;
    Q5: out std_logic;
    Q6: out std_logic;
    Q7: out std_logic);
end n74377;

architecture Behavioral of n74377 is
  signal s0: std_logic;
  signal s1: std_logic;
  signal Q0_temp: std_logic;
  signal s2: std_logic;
  signal Q1_temp: std_logic;
  signal s3: std_logic;
  signal Q2_temp: std_logic;
  signal s4: std_logic;
  signal Q3_temp: std_logic;
  signal s5: std_logic;
  signal Q4_temp: std_logic;
  signal s6: std_logic;
  signal Q5_temp: std_logic;
  signal s7: std_logic;
  signal Q6_temp: std_logic;
  signal s8: std_logic;
  signal Q7_temp: std_logic;
begin
  s1 <= NOT notE;
  s0 <= ((Q0_temp AND notE) OR (D0 AND s1));
  s2 <= ((Q1_temp AND notE) OR (D1 AND s1));
  s3 <= ((Q2_temp AND notE) OR (D2 AND s1));
  s4 <= ((Q3_temp AND notE) OR (D3 AND s1));
  s5 <= ((Q4_temp AND notE) OR (D4 AND s1));
  s6 <= ((Q5_temp AND notE) OR (D5 AND s1));
  s7 <= ((Q6_temp AND notE) OR (D6 AND s1));
  s8 <= ((Q7_temp AND notE) OR (D7 AND s1));
  gate0: entity work.DIG_D_FF
    generic map (
      Default => '0')
    port map (
      D => s0,
      C => CLK,
      Q => Q0_temp);
  gate1: entity work.DIG_D_FF
    generic map (
      Default => '0')
    port map (
      D => s2,
      C => CLK,
      Q => Q1_temp);
  gate2: entity work.DIG_D_FF
    generic map (
      Default => '0')
    port map (
      D => s3,
      C => CLK,
      Q => Q2_temp);
  gate3: entity work.DIG_D_FF
    generic map (
      Default => '0')
    port map (
      D => s4,
      C => CLK,
      Q => Q3_temp);
  gate4: entity work.DIG_D_FF
    generic map (
      Default => '0')
    port map (
      D => s5,
      C => CLK,
      Q => Q4_temp);
  gate5: entity work.DIG_D_FF
    generic map (
      Default => '0')
    port map (
      D => s6,
      C => CLK,
      Q => Q5_temp);
  gate6: entity work.DIG_D_FF
    generic map (
      Default => '0')
    port map (
      D => s7,
      C => CLK,
      Q => Q6_temp);
  gate7: entity work.DIG_D_FF
    generic map (
      Default => '0')
    port map (
      D => s8,
      C => CLK,
      Q => Q7_temp);
  Q0 <= Q0_temp;
  Q1 <= Q1_temp;
  Q2 <= Q2_temp;
  Q3 <= Q3_temp;
  Q4 <= Q4_temp;
  Q5 <= Q5_temp;
  Q6 <= Q6_temp;
  Q7 <= Q7_temp;
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

entity MUX_GATE_BUS_1 is
  generic ( Bits : integer ); 
  port (
    p_out: out std_logic_vector ((Bits-1) downto 0);
    sel: in std_logic;
    
    in_0: in std_logic_vector ((Bits-1) downto 0);
    in_1: in std_logic_vector ((Bits-1) downto 0) );
end MUX_GATE_BUS_1;

architecture Behavioral of MUX_GATE_BUS_1 is
begin
  with sel select
    p_out <=
      in_0 when '0',
      in_1 when '1',
      (others => '0') when others;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity DIG_D_FF_BUS is
  generic (
    Default: integer; 
    Bits: integer );
  port ( D  : in std_logic_vector ((Bits-1) downto 0);
         C  : in std_logic;
         Q  : out std_logic_vector ((Bits-1) downto 0);
         notQ : out std_logic_vector ((Bits-1) downto 0) );
end DIG_D_FF_BUS;

architecture Behavioral of DIG_D_FF_BUS is
   signal state : std_logic_vector ((Bits-1) downto 0) := std_logic_vector(to_unsigned(Default, Bits));
begin
   Q    <= state;
   notQ <= NOT( state );

   process(C)
   begin
      if rising_edge(C) then
        state  <= D;
      end if;
   end process;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity DIG_Add is
  generic ( Bits: integer ); 
  port (
    s: out std_logic_vector((Bits-1) downto 0);
    c_o: out std_logic;
    a: in std_logic_vector((Bits-1) downto 0);
    b: in std_logic_vector((Bits-1) downto 0);
    c_i: in std_logic );
end DIG_Add;

architecture Behavioral of DIG_Add is
   signal temp : std_logic_vector(Bits downto 0);
begin
   temp <= ('0' & a) + b + c_i;

   s    <= temp((Bits-1) downto 0);
   c_o  <= temp(Bits);
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- hex synchronous counter
entity n74163 is
  port (
    notPE: in std_logic;
    notSR: in std_logic;
    CP: in std_logic;
    CET: in std_logic;
    CEP: in std_logic;
    P0: in std_logic;
    P1: in std_logic;
    P2: in std_logic;
    P3: in std_logic;
    VCC: in std_logic;
    GND: in std_logic;
    TC: out std_logic;
    Q0: out std_logic;
    Q1: out std_logic;
    Q2: out std_logic;
    Q3: out std_logic);
end n74163;

architecture Behavioral of n74163 is
  signal s0: std_logic_vector(3 downto 0);
  signal s1: std_logic_vector(3 downto 0);
  signal s2: std_logic_vector(3 downto 0);
  signal s3: std_logic;
  signal s4: std_logic;
  signal s5: std_logic_vector(3 downto 0);
  signal s6: std_logic_vector(3 downto 0);
  signal s7: std_logic_vector(3 downto 0);
begin
  s4 <= (CEP AND CET);
  s6(0) <= P0;
  s6(1) <= P1;
  s6(2) <= P2;
  s6(3) <= P3;
  gate0: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 4)
    port map (
      sel => s4,
      in_0 => s1,
      in_1 => s2,
      p_out => s5);
  TC <= (s3 AND CET);
  gate1: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 4)
    port map (
      sel => notPE,
      in_0 => s6,
      in_1 => s5,
      p_out => s7);
  gate2: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 4)
    port map (
      sel => notSR,
      in_0 => "0000",
      in_1 => s7,
      p_out => s0);
  gate3: entity work.DIG_D_FF_BUS -- Q
    generic map (
      Default => 0,
      Bits => 4)
    port map (
      D => s0,
      C => CP,
      Q => s1);
  gate4: entity work.DIG_Add
    generic map (
      Bits => 4)
    port map (
      a => s1,
      b => "0001",
      c_i => '0',
      s => s2,
      c_o => s3);
  Q0 <= s1(0);
  Q1 <= s1(1);
  Q2 <= s1(2);
  Q3 <= s1(3);
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity FD_project is
  port (
    Clock: in std_logic;
    Enable_Cont: in std_logic;
    Enable_Reg: in std_logic;
    Tempo: in std_logic_vector(3 downto 0);
    Reset: in std_logic;
    Luminosidade: in std_logic_vector(1 downto 0);
    Liga: in std_logic;
    Igual: out std_logic;
    Potencia: out std_logic_vector(1 downto 0));
end FD_project;

architecture Behavioral of FD_project is
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
begin
  s15 <= NOT Reset;
  s9 <= NOT Enable_Reg;
  Potencia(0) <= (NOT Luminosidade(0) AND Liga);
  Potencia(1) <= (Liga AND NOT Luminosidade(1));
  s5 <= Tempo(0);
  s6 <= Tempo(1);
  s7 <= Tempo(2);
  s8 <= Tempo(3);
  gate0: entity work.n74377
    port map (
      D0 => s5,
      VCC => '1',
      GND => '0',
      D1 => s6,
      D2 => s7,
      D3 => s8,
      notE => s9,
      D4 => '0',
      D5 => '0',
      D6 => '0',
      D7 => '0',
      CLK => Clock,
      Q0 => s10,
      Q1 => s11,
      Q2 => s12,
      Q3 => s13);
  s14 <= NOT (s4 OR Reset);
  gate1: entity work.n7485
    port map (
      PleQ_i => '0',
      PeqQ_i => '1',
      PgrQ_i => '0',
      P_0 => s16,
      P_1 => s17,
      P_2 => s18,
      P_3 => s19,
      Q_0 => s10,
      Q_1 => s11,
      Q_2 => s12,
      Q_3 => s13,
      VCC => '1',
      GND => '0',
      PeqQ => Igual);
  gate2: entity work.n74163
    port map (
      notSR => s14,
      CP => Clock,
      P0 => '0',
      P1 => '0',
      P2 => '0',
      P3 => '0',
      CEP => Enable_Cont,
      GND => '0',
      notPE => '1',
      CET => '1',
      VCC => '1',
      Q3 => s3,
      Q2 => s2,
      Q1 => s1,
      Q0 => s0);
  gate3: entity work.n74163
    port map (
      notSR => s15,
      CP => Clock,
      P0 => '0',
      P1 => '0',
      P2 => '0',
      P3 => '0',
      CEP => s4,
      GND => '0',
      notPE => '1',
      CET => Enable_Cont,
      VCC => '1',
      Q3 => s19,
      Q2 => s18,
      Q1 => s17,
      Q0 => s16);
  gate4: entity work.n7485
    port map (
      PleQ_i => '0',
      PeqQ_i => '1',
      PgrQ_i => '0',
      P_0 => s0,
      P_1 => s1,
      P_2 => s2,
      P_3 => s3,
      Q_0 => '0',
      Q_1 => '0',
      Q_2 => '1',
      Q_3 => '0',
      VCC => '1',
      GND => '0',
      PeqQ => s4);
end Behavioral;
