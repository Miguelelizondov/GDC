  
library IEEE;
use IEEE.numeric_bit.all;
use ieee.std_logic_1164.all;

entity controller is 
port ( go_i, clk : in bit;
    x_gt_y, x_lt_y, x_eq_y : in bit := '0';
    x_sel, y_sel : out bit;
    x_ld, y_ld : out bit;
    x_sub, y_sub : out bit;
    o_en : out bit
);
end controller;

architecture eq of controller is 
signal state, nextstate: integer range 0 to 5 := 0;

begin 




process (state)
  begin
    case state is 
        when 0 => 
           x_sel <= '0';
           y_sel <= '0';
           x_ld <= '0';
           y_ld <= '0';
           x_sub <= '0';
           y_sub <= '0';
           o_en <= '0';
           nextstate <= 1;
        when 1 =>
            x_ld <= '1';
            y_ld <= '1';
            if x_gt_y = '1' then nextstate <= 2;
            elsif x_lt_y = '1' then nextstate <= 3;
            elsif x_eq_y = '1' then nextstate <= 4;
            end if;
        when 2 =>
          x_sub<='1';
          y_sub <= '0';
          x_sel <= '1';
          nextstate <= 5;
        when 3 =>
          x_sub<='0';
          y_sub <= '1';
          y_sel <= '1';
          nextstate <= 5;
        when 4 =>
          o_en <= '1';
          x_ld <= '1';
          y_ld <= '1';
          nextstate <= 0;
        when 5 =>
          x_ld <= '1';
          y_ld <= '1';
          nextstate <= 0;
      end case;

end process;

process (clk) 
begin 
  if go_i = '1' then
    if clk'event and clk = '1' then
    	
        state<= nextstate;end if;
   end if;
  end process;



end eq;