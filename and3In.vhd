------------------------------------------------------------------------------
--date: 28.12.2019
--authors: Mirko Lindroth & Kaisa Möttönen
--project:tiskikone.vhd
--Description: 3-sisääntuloinen AND-portti,harjoitustyö tiskikoneen logiikasta
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity and3In is
	port(
			A	:in std_logic;
			B	:in std_logic;
			C	:in std_logic;
			D	:out std_logic);
end and3In;

architecture behavior of and3In is
begin
	D<=(A and B and C);
end behavior;