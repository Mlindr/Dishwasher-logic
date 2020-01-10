------------------------------------------------------------------------------
--date: 29.12.2019
--authors: Mirko Lindroth & Kaisa Möttönen
--project:tiskikone.vhd
--Description: 2-sisääntuloinen NAND-portti, tiskikoneen logiikka harjoitustyö
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity nand2In is
	port(
			A	:in std_logic;
			B	:in std_logic;
			C	:out std_logic);
end nand2In;

architecture behavior of nand2In is
begin
	C<=(not A) and (not B);
end behavior;