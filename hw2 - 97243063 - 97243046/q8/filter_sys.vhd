ibrary ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity filter_sys is
port(
   RST : in std_logic;
   CLK : in std_logic

);
end filter_sys;


--signal declaration
architecture RTL of filter_sys is
signal a:std_logic_vector(31 downto 0);
signal finish:std_logic;
signal r:std_logic_vector(31 downto 0);


--component map declaration
component filter_dp
port(
   a:in std_logic_vector(32 downto 0);
   r:out std_logic_vector(31 downto 0);
   RST : in std_logic;
   CLK : in std_logic
);
end component;
component filter_test
port(
   a:out std_logic_vector(31 downto 0));
end component;


begin


--portmap
label_filter_dp : filter_dp port map (
      a => a,
      r => r,
      RST => RST,
      CLK => CLK
   );
label_filter_test : filter_test port map (
      a => a   );
end RTL;
