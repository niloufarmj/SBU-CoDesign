library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity filter_dp is
port(
   a:in std_logic_vector(32 downto 0);
   r:out std_logic_vector(31 downto 0);
   RST : in std_logic;
   CLK : in std_logic

);
end filter_dp;


--signal declaration
architecture RTL of filter_dp is
signal taps0:std_logic_vector(31 downto 0);
signal taps0_wire:std_logic_vector(31 downto 0);
signal taps1:std_logic_vector(31 downto 0);
signal taps1_wire:std_logic_vector(31 downto 0);
signal taps2:std_logic_vector(31 downto 0);
signal taps2_wire:std_logic_vector(31 downto 0);
signal taps3:std_logic_vector(31 downto 0);
signal taps3_wire:std_logic_vector(31 downto 0);
signal taps4:std_logic_vector(31 downto 0);
signal taps4_wire:std_logic_vector(31 downto 0);
signal sig_0:std_logic_vector(31 downto 0);
signal sig_1:std_logic_vector(34 downto 0);
signal sig_2:std_logic_vector(34 downto 0);
signal sig_3:std_logic_vector(35 downto 0);
signal sig_4:std_logic_vector(35 downto 0);
signal sig_5:std_logic_vector(34 downto 0);
signal sig_6:std_logic_vector(35 downto 0);
signal sig_7:std_logic_vector(35 downto 0);
signal r_int:std_logic_vector(31 downto 0);
type STATE_TYPE is (s0);
signal STATE:STATE_TYPE;
type CONTROL is (alwaysdo_nothing
);
signal cmd : CONTROL;


begin
--register updates
dpREG: process (CLK,RST)
   begin
      if (RST = '1') then
         taps0 <= (others=>'0');
         taps1 <= (others=>'0');
         taps2 <= (others=>'0');
         taps3 <= (others=>'0');
         taps4 <= (others=>'0');
      elsif CLK' event and CLK = '1' then
         taps0 <= taps0_wire;
         taps1 <= taps1_wire;
         taps2 <= taps2_wire;
         taps3 <= taps3_wire;
         taps4 <= taps4_wire;

      end if;
   end process dpREG;


--combinational logics
dpCMB: process (taps0,taps1,taps2,taps3,taps4,sig_0,sig_1,sig_2,sig_3,sig_4
,sig_5,sig_6,sig_7,r_int,a,cmd,STATE)
   begin
      taps0_wire <= taps0;
      taps1_wire <= taps1;
      taps2_wire <= taps2;
      taps3_wire <= taps3;
      taps4_wire <= taps4;
      sig_0 <= (others=>'0');
      sig_1 <= (others=>'0');
      sig_2 <= (others=>'0');
      sig_3 <= (others=>'0');
      sig_4 <= (others=>'0');
      sig_5 <= (others=>'0');
      sig_6 <= (others=>'0');
      sig_7 <= (others=>'0');
      r_int <= (others=>'0');
      r <= (others=>'0');



      case cmd is
         when alwaysdo_nothing =>
            sig_0 <=  -signed(taps0);
            sig_1 <= conv_std_logic_vector(5,35) * signed(taps1);
            sig_2 <= signed(conv_std_logic_vector(signed(sig_0),35)) + signed(sig_1);
            sig_3 <= conv_std_logic_vector(10,36) * signed(taps2);
            sig_4 <= signed(conv_std_logic_vector(signed(sig_2),36)) + signed(sig_3);
            sig_5 <= conv_std_logic_vector(5,35) * signed(taps3);
            sig_6 <= signed(sig_4) + signed(conv_std_logic_vector(signed(sig_5),36));
            sig_7 <= signed(sig_6) - signed(conv_std_logic_vector(signed(taps4),36));
            r <= r_int;
            r_int <= sig_7(31 downto 0);
            taps4_wire <= a(31 downto 0);
            taps3_wire <= taps4;
            taps2_wire <= taps3;
            taps1_wire <= taps2;
            taps0_wire <= taps1;
         when others=>
      end case;
   end process dpCMB;


--controller reg
fsmREG: process (CLK,RST)
   begin
      if (RST = '1') then
         STATE <= s0;
      elsif CLK' event and CLK = '1' then
         STATE <= STATE;
         case STATE is
            when s0 =>
                    STATE <= s0;
            when others=>
         end case;
      end if;
   end process fsmREG;


--controller cmb
fsmCMB: process (taps0,taps1,taps2,taps3,taps4,sig_0,sig_1,sig_2,sig_3,sig_4
,sig_5,sig_6,sig_7,r_int,a,cmd,STATE)
   begin
   cmd <= alwaysdo_nothing;
   case STATE is
      when s0 =>
              cmd <= alwaysdo_nothing;
      when others=>
      end case;
end process fsmCMB;
end RTL;
 	                                                                                                                                                                            

