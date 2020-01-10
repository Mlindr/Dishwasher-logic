------------------------------------------------------------------------------
--date: 30.12.2019
--authors: Mirko Lindroth & Kaisa Möttönen
--project:tiskikone.vhd
--Description: taajuusjakaja, tiskikonelogiikka harjoitustyö
------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

--frequency for 300 s (5 min) is 0.003333 Hz
--internal clock is 50 MHz
--clock cycles to run for 0.00333 Hz is 1.5*10^10
--is 15 000 000 000 cycles
--15 000 000 000 in unsigned binary is 1101111110000100011101011000000000
--34 bits needed to represent it in binary
entity freqDivider is
    Port (
        clk_in : in  STD_LOGIC;
        clk_out: out STD_LOGIC);
end freqDivider;

architecture behavior of freqDivider is

	constant clk_divider	:std_logic_vector(35 downto 0)	:=x"37E11D600";--37E11D600 on 5 min, 00EE6B280 on 5 sec
	signal clk_counter	:std_logic_vector(35 downto 0)	:=(others=>'0');
	signal out_clk			:std_logic	:='1';
	
begin
	frequency_divider: process (clk_in) is
	begin
		if(rising_edge(clk_in)) then
			if clk_counter=clk_divider then
				out_clk<= not out_clk;
				clk_counter<=(others=>'0');
			else
				clk_counter<=std_logic_vector(unsigned(clk_counter)+1);
			end if;
		end if;
	end process frequency_divider;
	clk_out<=out_clk;
end behavior;