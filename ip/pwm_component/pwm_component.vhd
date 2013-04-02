--------------------------------------------------------------------------------
-- Project:         ECD Robot Arm
-- Engineer:        Dave Templeman    
--
-- Create Date:     Thursday 1st December 2012
-- Design Name:     Qsys Robot
-- Component Name:  pwm top
-- Target Device:   Cyclone III EP3C16F484
-- Tool versions:   Quartus II 12.1 (Service Pack 1)
-- Description:     
--  Top level for PWM, including Avalon bus interface
-- 
--  
-- Additional Comments:
--  Clock frequency = 50MHz (20ns)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_component is
	port(
		1_clk          : in    std_logic;
		s1_reset        : in    std_logic;
       		1_write        : in    std_logic;
        	1_address      : in    std_logic_vector(1 downto 0);
		s1_writedata    : in    std_logic_vector(31 downto 0);
        	wm_out_1       : out   std_logic;              
        	wm_out_2       : out   std_logic;
        	wm_out_3       : out   std_logic;
        	wm_out_4       : out   std_logic
    );
end entity pwm_component;

architecture struct of pwm_component is

signal reg0_data_int : std_logic_vector(31 downto 0);
signal reg1_data_int : std_logic_vector(31 downto 0);
signal reg2_data_int : std_logic_vector(31 downto 0);
signal reg3_data_int : std_logic_vector(31 downto 0);

component pwm 
	port(
		clk         : in    std_logic;
		rst         : in    std_logic;
		pwm_on_in   : in    std_logic_vector(31 downto 0);
        	wm_out     : out   std_logic              
    );
end component pwm;




begin

    proc_registers : process (s1_clk, s1_reset) begin
        if(s1_reset = '0') then
            reg0_data_int <= (others => '0');
            reg1_data_int <= (others => '0');
            reg2_data_int <= (others => '0');
            reg3_data_int <= (others => '0');
        elsif(rising_edge(s1_clk)) then
            if(s1_write = '1') then
                case s1_address is
                    when "00" =>
                        reg0_data_int <= s1_writedata;
                    when "01" =>
                        reg1_data_int <= s1_writedata;
                    when "10" =>
                        reg2_data_int <= s1_writedata;
                    when "11" =>
                        reg3_data_int <= s1_writedata;
                    when others =>
                        reg0_data_int <= (others => '0');
                        reg1_data_int <= (others => '0');
                        reg2_data_int <= (others => '0');
                        reg3_data_int <= (others => '0');
                end case;
            end if;
        end if;
    end process proc_registers;
    
   inst_channel_1   : pwm
	port map(
		clk         => s1_clk,
		rst         => s1_reset,
		pwm_on_in   => reg0_data_int,
        pwm_out     => pwm_out_1     
    );

   inst_channel_2   : pwm
	port map(
		clk         => s1_clk,
		rst         => s1_reset,
		pwm_on_in   => reg1_data_int,
        pwm_out     => pwm_out_2     
    );
    
   inst_channel_3   : pwm
	port map(
		clk         => s1_clk,
		rst         => s1_reset,
		pwm_on_in   => reg2_data_int,
        pwm_out     => pwm_out_3     
    );
    
   inst_channel_4   : pwm
	port map(
		clk         => s1_clk,
		rst         => s1_reset,
		pwm_on_in   => reg3_data_int,
        pwm_out     => pwm_out_4     
    );
    
end struct;
						
