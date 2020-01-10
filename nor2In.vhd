------------------------------------------------------------------------------
--date: 29.12.2019
--authors: Mirko Lindroth & Kaisa Möttönen
--project:tiskikone.vhd
--Description: 2-sisääntuloinen NOR-portti, tiskikoneen logiikka harjoitustyö
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity nor2In is
	port(
			A	:in std_logic;
			B	:in std_logic;
			C	:out std_logic);
end nor2In;

architecture behavior of nor2In is
begin
	C<=(not A) or (not B);
end behavior;