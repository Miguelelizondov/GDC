library ieee;
use ieee.numeric_bit.all;

entity datapath is
    port(
        x_i,y_i : in unsigned(3 downto 0);
        x_sel,y_sel : in bit;
        x_ld,y_ld : in bit;
        x_sub,y_sub : in bit;
        o_en : in bit;
        x_gt_y,x_eq_y,x_lt_y : out bit;
        data : out unsigned(3 downto 0)
    );
end datapath;

architecture arch of datapath is

signal x_m,y_m : unsigned (3 downto 0);
signal x_r,y_r : unsigned (3 downto 0);
signal x_s,y_s : unsigned (3 downto 0);
signal comp    : unsigned (3 downto 0);

begin 

-- Mux
x_m <= x_i when x_sel = '0' else x_s;
y_m <= y_i when y_sel = '0' else y_s;

-- Register
process (x_ld)
begin 
    if x_ld = '1' then x_r <= x_m; end if;
end process;

process (y_ld)
begin 
    if y_ld = '1' then y_r <= y_m; end if;
end process;

-- Comparator 
x_gt_y <= '1' when x_r > y_r else '0';
x_eq_y <= '1' when x_r = y_r else '0';
x_lt_y <= '1' when x_r < y_r else '0';
comp <= x_r when x_eq_y = '1';
-- Subtractor 
x_s <= x_r - y_r when x_sub = '1' else x_r;
y_s <= y_r - x_r when y_sub = '1' else y_r;

-- Output 

process (o_en)
begin
    if o_en = '1' then
        data <= comp;
    end if;
    end process;

    end arch;