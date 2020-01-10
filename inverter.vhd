------------------------------------------------------------------------------
--date: 29.12.2019
--authors: Mirko Lindroth & Kaisa Möttönen
--project:tiskikone.vhd
--Description: 1-sisääntuloinen NOT-portti, tiskikoneen logiikka harjoitustyö
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity inverter1In is
	port(
			A	:in std_logic;
			B	:out std_logic);
end inverter1In;

architecture behavior of inverter1In is
begin
	B<=not A;
end behavior;