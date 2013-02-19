--------------------------------------------------------------------------------
-- Company:         STFC
-- Engineer:    	Dave Templeman    
--
-- Create Date:     Thursday 27st Septempber 2012
-- Design Name:     lcd
-- Component Name:  pwm
-- Target Device:   Cyclone III EP3C120F780C7
-- Tool versions:   Quartus II 11.0 (Service Pack 1)
-- Description:     
--  Control PWM
-- 
--  
-- Dependencies:
--  
--  
-- Revision:
--  Version 0.1 - file created
--  Version 1.0
--  
-- Additional Comments:
--  Clock frequency = 50MHz (20ns)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is
	port(
		clk         : in    std_logic;
		rst         : in    std_logic;
		pwm_on_in   : in    std_logic_vector(31 downto 0);
      pwm_out     : out   std_logic              
    );
end entity pwm;

architecture fsm of pwm is

-- Build an enumerated type for the state machine
type state_type is(
		pulse_on,       -- pusle starts
        pulse_off       -- off period of pulse
	);

-- Declare current state signal
signal current_state : state_type;

-- Declare internal signals
signal num_clks     : unsigned(31 downto 0) := x"00000000"; --1073741824
signal pwm_width    : unsigned(31 downto 0) := x"0000C350";     -- Default to 1ms=50000
signal pulse_period : unsigned(31 downto 0) := x"000F423F"  ; -- Wait > 20ms 1000000


-- Quartus II Synthesis Attributes
attribute syn_encoding : string;
attribute syn_encoding of state_type : type is "safe";


begin

	pwm_out <= '1' when current_state = pulse_on else '0';
		
	pwm_width <= unsigned(pwm_on_in);
		
	current_state <= pulse_on when (num_clks < pwm_width) else pulse_off;
		
	-- This process keeps the num_clks going
	process(clk)
		begin
			if(rising_edge(clk)) then
				if(num_clks >= pulse_period) then
					num_clks <= x"00000000";
				else
					num_clks <= num_clks + 1;
				end if;
			
			end if;
		
	end process;


end fsm;
						
