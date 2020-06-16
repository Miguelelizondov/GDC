library ieee;
use ieee.numeric_bit.all;

entity GDC is
    port(
        clk : in bit;
        x,y : in unsigned(3 downto 0);
        data1 : out unsigned(3 downto 0)
    );
end GDC;

architecture arch of GDC is

    component controller is
        port(
            go_i, clk : in bit;
    x_gt_y, x_lt_y, x_eq_y : in bit := '0';
    x_sel, y_sel : out bit;
    x_ld, y_ld : out bit;
    x_sub, y_sub : out bit;
    o_en : out bit);
    end component;

    component datapath is
        port(
            x_i,y_i : in unsigned(3 downto 0);
            x_sel,y_sel : in bit;
            x_ld,y_ld : in bit;
            x_sub,y_sub : in bit;
            o_en : in bit;
            x_gt_y,x_eq_y,x_lt_y : out bit;
            data : out unsigned(3 downto 0));

    end component;
    signal go_i: bit := '1';
    signal x_gt_y, x_eq_y, x_lt_y : bit := '0';
    signal x_sel,y_sel : bit;
    signal x_ld,y_ld : bit;
    signal x_sub,y_sub : bit;
    signal o_en: bit;
begin
    Controller0: controller port map (go_i,clk,x_gt_y,x_lt_y,x_eq_y,x_sel,y_sel,x_ld,y_ld,x_sub,y_sub,o_en);
    data0: datapath port map (x,y,x_sel,y_sel,x_ld,y_ld,x_sub,y_sub,o_en,x_gt_y,x_eq_y,x_lt_y,data1);
end arch;