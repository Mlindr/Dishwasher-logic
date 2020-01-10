------------------------------------------------------------------------------
--date: 28.12.2019
--authors: Mirko Lindroth & Kaisa Möttönen
--project:tiskikone.vhd
--Description: 2-sisääntuloinen AND-portti,harjoitustyö tiskikoneen logiikasta
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity and2In is
	port(
			A	:in std_logic;
			B	:in std_logic;
			C	:out std_logic);
end and2In;

architecture behavior of and2In is
begin
	C<=A and B;
end behavior;