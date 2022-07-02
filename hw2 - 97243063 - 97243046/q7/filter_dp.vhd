library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity filter_dp is
port(
   a:in std_logic_vector(31 downto 0);
   r_out:out std_logic_vector(31 downto 0);
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
signal i:std_logic_vector(31 downto 0);
signal i_wire:std_logic_vector(31 downto 0);
signal r:std_logic_vector(31 downto 0);
signal r_wire:std_logic_vector(31 downto 0);
signal sig_0:std_logic_vector(31 downto 0);
signal sig_1:std_logic_vector(63 downto 0);
signal sig_2:std_logic_vector(63 downto 0);
signal sig_3:std_logic_vector(31 downto 0);
signal sig_4:std_logic_vector(31 downto 0);
signal sig_5:std_logic_vector(63 downto 0);
signal sig_6:std_logic_vector(63 downto 0);
signal sig_7:std_logic_vector(31 downto 0);
signal sig_8:std_logic_vector(31 downto 0);
signal sig_9:std_logic_vector(31 downto 0);
signal sig_10:std_logic_vector(31 downto 0);
signal sig_11:std_logic_vector(31 downto 0);
signal sig_12:std_logic_vector(31 downto 0);
signal sig_13:std_logic_vector(31 downto 0);
signal sig_14:std_logic_vector(31 downto 0);
signal sig_15:std_logic_vector(31 downto 0);
signal sig_16:std_logic_vector(31 downto 0);
signal sig_17:std_logic_vector(31 downto 0);
signal sig_18:std_logic_vector(31 downto 0);
signal sig_19:std_logic_vector(31 downto 0);
signal r_out_int:std_logic_vector(31 downto 0);
signal sig_20:std_logic;
signal sig_21:std_logic;
signal sig_22:std_logic;
signal sig_23:std_logic;
signal sig_24:std_logic;


--lookup table declaration
Type rom_table_0 is Array (Natural range <>) of std_logic_vector(31 downto 0);
constant c : rom_table_0 := (B"11111111111111111111111111111111",B"00000000000000000000000000000101",B"00000000000000000000000000001010",B"00000000000000000000000000000101",
        B"11111111111111111111111111111111");
type STATE_TYPE is (s0,s1,s2,s3,s4);
signal STATE:STATE_TYPE;
type CONTROL is (alwaysinit1
, alwaysloop1
, alwaysinit2
, alwaysop0
, alwaysop1
, alwaysop2
, alwaysop3
, alwaysop4
, alwaysdo_nothing
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
         i <= (others=>'0');
         r <= (others=>'0');
      elsif CLK' event and CLK = '1' then
         taps0 <= taps0_wire;
         taps1 <= taps1_wire;
         taps2 <= taps2_wire;
         taps3 <= taps3_wire;
         taps4 <= taps4_wire;
         i <= i_wire;
         r <= r_wire;

      end if;
   end process dpREG;

--combinational logics
dpCMB: process (taps0,taps1,taps2,taps3,taps4,i,r,sig_0,sig_1,sig_2
,sig_3,sig_4,sig_5,sig_6,sig_7,sig_8,sig_9,sig_10,sig_11,sig_12
,sig_13,sig_14,sig_15,sig_16,sig_17,sig_18,sig_19,r_out_int,a,cmd,STATE)
   begin
      taps0_wire <= taps0;
      taps1_wire <= taps1;
      taps2_wire <= taps2;
      taps3_wire <= taps3;
      taps4_wire <= taps4;
      i_wire <= i;
      r_wire <= r;
      sig_0 <= (others=>'0');
      sig_1 <= (others=>'0');
      sig_2 <= (others=>'0');
      sig_3 <= (others=>'0');
      sig_4 <= (others=>'0');
      sig_5 <= (others=>'0');
      sig_6 <= (others=>'0');
      sig_7 <= (others=>'0');
      sig_8 <= (others=>'0');
      sig_9 <= (others=>'0');
      sig_10 <= (others=>'0');
      sig_11 <= (others=>'0');
      sig_12 <= (others=>'0');
      sig_13 <= (others=>'0');
      sig_14 <= (others=>'0');
      sig_15 <= (others=>'0');
      sig_16 <= (others=>'0');
      sig_17 <= (others=>'0');
      sig_18 <= (others=>'0');
      sig_19 <= (others=>'0');
      r_out_int <= (others=>'0');
      r_out <= (others=>'0');



     case cmd is
         when alwaysinit1 =>
            r_out <= r_out_int;
            r_out_int <= r;
            i_wire <= conv_std_logic_vector(0,32);
         when alwaysloop1 =>
            r_out <= r_out_int;
            r_out_int <= r;
            taps0_wire <= taps1;
            taps1_wire <= taps2;
            taps2_wire <= taps3;
            taps3_wire <= taps4;
         when alwaysinit2 =>
            r_out <= r_out_int;
            r_out_int <= r;
            taps4_wire <= a;
            r_wire <= conv_std_logic_vector(0,32);
            i_wire <= conv_std_logic_vector(0,32);
         when alwaysop0 =>
            r_out <= r_out_int;
            r_out_int <= r;
            sig_0 <= c(conv_integer(unsigned(i)));
            sig_1 <= signed(taps0) * signed(sig_0);
            sig_2 <= signed(conv_std_logic_vector(signed(r),64)) + signed(sig_1);
            sig_3 <= signed(i) + signed(conv_std_logic_vector(1,32));
            r_wire <= sig_2(31 downto 0);
            i_wire <= sig_3;
         when alwaysop1 =>
            r_out <= r_out_int;
            r_out_int <= r;
            sig_4 <= c(conv_integer(unsigned(i)));
            sig_5 <= signed(taps1) * signed(sig_4);
            sig_6 <= signed(conv_std_logic_vector(signed(r),64)) + signed(sig_5);
            sig_7 <= signed(i) + signed(conv_std_logic_vector(1,32));
            r_wire <= sig_6(31 downto 0);
            i_wire <= sig_7;
         when alwaysop2 =>
            r_out <= r_out_int;
            r_out_int <= r;
            sig_8 <= signed(r) + signed(taps2);
            sig_9 <= c(conv_integer(unsigned(i)));
            sig_10 <= signed(sig_8) + signed(sig_9);
            sig_11 <= signed(i) + signed(conv_std_logic_vector(1,32));
            r_wire <= sig_10;
            i_wire <= sig_11;
         when alwaysop3 =>
            r_out <= r_out_int;
            r_out_int <= r;
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
                    STATE <= s1;
            when s1 =>
                    STATE <= s2;
            when s2 =>
                    STATE <= s3;
            when s3 =>
               if (sig_20 = '1') then
                       STATE <= s3;
               else
                  if (sig_21 = '1') then
                          STATE <= s3;
                  else
                     if (sig_22 = '1') then
                             STATE <= s3;
                     else
                        if (sig_23 = '1') then
                                STATE <= s3;
                        else
                           if (sig_24 = '1') then
                                   STATE <= s3;
                           else
                                   STATE <= s4;
                           end if;
                        end if;
                     end if;
                  end if;
               end if;
            when s4 =>
                    STATE <= s4;
            when others=>
         end case;
      end if;
   end process fsmREG;


--controller cmb
fsmCMB: process (taps0,taps1,taps2,taps3,taps4,i,r,sig_0,sig_1,sig_2
,sig_3,sig_4,sig_5,sig_6,sig_7,sig_8,sig_9,sig_10,sig_11,sig_12
,sig_13,sig_14,sig_15,sig_16,sig_17,sig_18,sig_19,r_out_int,sig_20,sig_21
,sig_22,sig_23,sig_24,a,cmd,STATE)
   begin
   sig_20 <= '0';
   sig_21 <= '0';
   sig_22 <= '0';
   sig_23 <= '0';
   sig_24 <= '0';
   if (signed(i) = 0) then
      sig_20 <= '1';
   else
      sig_20 <= '0';
   end if;
   if (signed(i) = 1) then
      sig_21 <= '1';
   else
      sig_21 <= '0';
   end if;
   if (signed(i) = 2) then
      sig_22 <= '1';
   else
      sig_22 <= '0';
   end if;
   if (signed(i) = 3) then
      sig_23 <= '1';
   else
      sig_23 <= '0';
   end if;
   if (signed(i) = 4) then
      sig_24 <= '1';
   else
      sig_24 <= '0';
   end if;
   cmd <= alwaysinit1;
   case STATE is
      when s0 =>
              cmd <= alwaysinit1;
      when s1 =>
              cmd <= alwaysloop1;
      when s2 =>
              cmd <= alwaysinit2;
      when s3 =>
         if (sig_20 = '1') then
                 cmd <= alwaysop0;
         else
            if (sig_21 = '1') then
                    cmd <= alwaysop1;
            else
               if (sig_22 = '1') then
                       cmd <= alwaysop2;
               else
                  if (sig_23 = '1') then
                          cmd <= alwaysop3;
                  else
                     if (sig_24 = '1') then
                             cmd <= alwaysop4;
                     else
                             cmd <= alwaysdo_nothing;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      when s4 =>
              cmd <= alwaysdo_nothing;
      when others=>
      end case;
end process fsmCMB;
end RTL;

