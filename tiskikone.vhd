------------------------------------------------------------------------------
--date: 28.12.2019
--authors: Mirko Lindroth & Kaisa Möttönen
--project:tiskikone.vhd
--Description: top entity tiskikone, tiskikonelogiikka harjoitustyö
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity tiskikone is
	port(
			vpAnturiEmpty	:in std_logic	:='0';
			vpAnturiFull	:in std_logic	:='0';
			clk				:in std_logic;
			vedenpoisto		:out std_logic;
			vedenotto		:out std_logic;
			tilaLed			:out std_logic;
			kelloLed			:out std_logic;
			emptyLed			:out std_logic;
			fullLed			:out std_logic;
			pesuaine			:out std_logic);
end tiskikone;

architecture tkToiminta of tiskikone is

--Signals
constant one	:std_logic	:='1';
constant zero	:std_logic	:='0';
signal clk_sig	:std_logic	:='1';
signal V			:std_logic	:='0';
signal W			:std_logic	:='0';
signal Z			:std_logic	:='0';
signal inv1Out	:std_logic	:='0';
signal nor1Out	:std_logic	:='0';
signal tila		:std_logic	:='0';
signal invTila	:std_logic	:='0';
signal empty	:std_logic	:='0';
signal full		:std_logic	:='0';

--components instantiations
component inverter1In
		port(
			A	:in std_logic;
			B	:out std_logic);
end component;

component and2In
	port(
			A		:in std_logic;
			B		:in std_logic;
			C		:out std_logic);
end component;

component nand2In
		port(
			A	:in std_logic;
			B	:in std_logic;
			C	:out std_logic);
end component;

component nor2In
	port(
			A	:in std_logic;
			B	:in std_logic;
			C	:out std_logic);
end component;

component Tflipflop
   port( 
      t : in STD_LOGIC; 
      clk : in STD_LOGIC; 
      reset : in STD_LOGIC; 
      dout : out STD_LOGIC);
end component;

component and3In
	port(
			A	:in std_logic;
			B	:in std_logic;
			C	:in std_logic;
			D	:out std_logic);
end component;

component freqDivider
    Port (
        clk_in : in  STD_LOGIC;
        clk_out: out STD_LOGIC);
end component;

begin
	--oskillaattorin kellon jakaminen järjestelmälle sopivaksi
	kellojakaja:freqDivider
		port map(clk,clk_sig);
	--painikkeiden invertointi oikein päin
	sw1:inverter1In
		port map(vpAnturiEmpty,empty);
	sw2:inverter1In
		port map(vpAnturiFull,full);
	--vedenottoventtiilin ohjauksen reititys
	inv1In1:inverter1In
		port map(full,inv1Out);
	and2In1:and2In
		port map(inv1Out,clk_sig,W);
	--tyhjennyspumpun ohjauksen reititys
	nand2In1:nand2In
		port map(empty,clk_sig,V);
	--pesuaineluukun ohjauksen reititys
	nor2In1:nor2In
		port map(empty,full,nor1Out);
	Tflipflop1:Tflipflop
		port map(one,clk_sig,zero,tila);
	inv1In2:inverter1In
		port map(tila,invTila);
	and3In1:and3In
		port map(nor1Out,clk_sig,invTila,Z);
		
	--ledien liittäminen signaaleihin
	vedenpoisto<=V;
	vedenotto<=W;
	pesuaine<=Z;
	tilaLed<=tila;
	kelloLed<=clk_sig;
	emptyLed<=empty;
	fullLed<=full;
end tkToiminta;