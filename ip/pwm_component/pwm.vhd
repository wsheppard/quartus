--------------------------------------------------------------------------------
-- Project:         ECD Robot Arm
-- Engineer:        Dave Templeman    
--
-- Create Date:     Thursday 1st December 2012
-- Design Name:     Qsys Robot
-- Component Name:  pwm
-- Target Device:   Cyclone III EP3C16F484
-- Tool versions:   Quartus II 11.0 (Service Pack 1)
-- Description:     
--  Control PWM
-- 
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

architecture rtl of pwm is

-- Declare internal signals
signal num_clks     : unsigned(31 downto 0) := x"00000000"; --1073741824
signal pwm_width    : unsigned(31 downto 0) := x"0000C350"; --Default to 1ms=50000
signal pulse_period : unsigned(31 downto 0) := x"000F423F"; --Wait > 20ms 1000000


begin
pulse_period <= x"000F423F";        --20ms period
pwm_width <= unsigned(pwm_on_in);   

	process(clk, rst)
		begin
			if(rst = '0') then
                num_clks <= (others => '0');
                pwm_out <= '0';
            elsif(rising_edge(clk)) then
                if (num_clks < pwm_width) then
                    pwm_out <= '1';
                    else 
                    pwm_out <= '0';
                end if;
				
                if(num_clks >= pulse_period) then
					num_clks <= (others => '0');
				else
					num_clks <= num_clks + 1;
				end if;
			end if;
	end process;

end rtl;
