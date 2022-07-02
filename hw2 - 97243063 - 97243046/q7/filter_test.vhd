library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity filter_test is
port(
   a:out std_logic_vector(31 downto 0)
);
end filter_test;


--signal declaration
architecture RTL of filter_test is
signal a_int:std_logic_vector(31 downto 0);


begin


--combinational logics
dpCMB: process (a_int)
   begin
      a_int <= (others=>'0');
      a <= (others=>'0');

      a <= a_int;
      a_int <= conv_std_logic_vector(10,32);
   end process dpCMB;
end RTL;

