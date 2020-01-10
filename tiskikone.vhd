---------------------------------------------------------------------------------------
--revision: 28.12.2019 started project, created file
--				10.1.2020 made the design more readable and removed logic gate components
--							 logic gate components were added straight to ouputs
--authors: Mirko Lindroth
--project:tiskikone.vhd
--Description: Top entity tiskikone, dishwasher logic
--					-Clock is inverted every 5 minutes
--					-The logic has states wash and rinse(0 and 1)
--					-Water filling valve and draining pump should start on the rising 
--					 edge of the clock and end by water level sensors
--					-In case of errors, valve and pump shouldn't last more than 5 min
---------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity tiskikone is
	port(
		vpAnturiEmpty	:in std_logic	:='0';--water level sensor, 1 when empty
		vpAnturiFull	:in std_logic	:='0';--water level sensor, 1 when full
		clk				:in std_logic;			--clock input
		vedenpoisto		:out std_logic;		--pump control, drains water, 1 to start
		vedenotto		:out std_logic;		--valve control, fills water, 1 to start
		tilaLed			:out std_logic;		--state led
		kelloLed			:out std_logic;		--clock led
		emptyLed			:out std_logic;		--water level sensor empty led
		fullLed			:out std_logic;		--water level sensor full led
		pesuaine			:out std_logic);		--detergent hatch control, 1 when open
end tiskikone;

architecture tkToiminta of tiskikone is

--Signals
signal one		:std_logic	:='1';
signal zero		:std_logic	:='0';
signal clk_sig	:std_logic	:='1';
signal tila		:std_logic	:='0';
signal empty	:std_logic	:='0';
signal full		:std_logic	:='0';

--components instantiations
component Tflipflop
   port( 
      t 		: in STD_LOGIC; 
      clk 	: in STD_LOGIC;
      reset : in STD_LOGIC; 
      dout 	: out STD_LOGIC
		);
end component;

component freqDivider
    Port (
        clk_in : in  STD_LOGIC;
        clk_out: out STD_LOGIC
		  );
end component;

begin
	--Dividing the clock to the needed frequency using frequency divider
	sys_freq:freqDivider
		port map(clk_in=>clk,clk_out=>clk_sig);
	
	--The DE2-115 board debounced buttons are inverted, so they are inverted back to correspond the design
	empty<=not vpAnturiEmpty;
	full<=not vpAnturiFull;
		
	--valve control
	vedenotto<=(not full) and clk_sig;
		
	--drain pump control
	vedenpoisto<=clk_sig nand empty;
		
	--detergent hatch control
	Tflipflop1:Tflipflop
		port map(t=>one,clk=>clk_sig,reset=>zero,dout=>tila);
	pesuaine<=((full nor empty) and clk_sig and (not tila));
	
	--attaching signals to outpu leds
	tilaLed<=tila;
	kelloLed<=clk_sig;
	emptyLed<=empty;
	fullLed<=full;
end tkToiminta;