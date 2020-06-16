library ieee;
use ieee.numeric_bit.all;

entity GDC_tb is
end GDC_tb;

architecture arch of GDC_tb is
    component GDC is
        port(
            clk : in bit;
        x,y : in unsigned(3 downto 0);
        data1 : out unsigned(3 downto 0)
        );
    end component;
    signal clk : bit := '0';
    signal x,y,data1 : unsigned(3 downto 0) := "0000";
begin
    G0: GDC port map(clk,x,y,data1);
	
    clk<= not clk after 5 ns;
        
    process
    begin
    wait for 10 ns;
        x <= "1001";
        y <= "0110";
        wait for 150 ns;
        x <= "1100";
        y <= "0010";
        wait for 100 ns;
        x <= "1101";
        y <= "0001";
    
        wait;
    end process;
        
end arch;