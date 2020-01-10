------------------------------------------------------------------------------
--date: 29.12.2019
--authors: Mirko Lindroth & Kaisa Möttönen
--project:tiskikone.vhd
--Description: T-kiikku, tiskikoneen logiikka harjoitustyö
------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.all;  

entity Tflipflop is 
   port( 
      t : in STD_LOGIC; 
      clk : in STD_LOGIC; 
      reset : in STD_LOGIC; 
      dout : out STD_LOGIC); 
end Tflipflop;  

architecture behavior of Tflipflop is 
begin 
   toggle:process (t,clk,reset) is 
	variable tila :std_logic :='0';   
   begin 
      if (reset='1') then 
         tila	:='0'; 
      elsif (rising_edge(clk)) then 
         if (t = '1') then 
            tila	:=not tila;        
         end if; 
      end if; 
      dout<=tila; 
   end process toggle; 
end behavior; 