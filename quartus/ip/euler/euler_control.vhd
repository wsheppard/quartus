library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;   

entity euler_control is
  port (
       
         s1_clk          : in    std_logic;
         s1_reset        : in    std_logic;
			
			-- Four addressses
         s1_address      : in    std_logic_vector(1 downto 0);
         
			-- Read
			s1_read         : in    std_logic;
         s1_readdata     : out    std_logic_vector(31 downto 0);
         
			-- Write
			s1_write			: in std_logic;
			s1_writedata     : in    std_logic_vector(31 downto 0);

			-- Comms with the euler block
			euler_out	: out std_logic_vector(31 downto 0) := (others =>'0');
			euler_in		: in std_logic_vector(31 downto 0);
			euler_status : in std_logic;
			euler_enable : out std_logic := '0'
			
       );
end;


architecture euler_behaviour of euler_control is

	-- This is the counter for the euler block to do it's work.
	signal euler_counter : unsigned(7 downto 0) := to_unsigned(18,8);
	signal local_result : std_logic_vector(31 downto 0) := (others =>'0');
	signal local_data : std_logic_vector(31 downto 0) := (others =>'0');
	signal euler_ready: std_logic := '0';
	signal local_enable: std_logic := '0';
	
	
	begin
	
	euler_enable <= '1' when local_enable = '1' else '0';
		
		
		
	-- The process looking after READING only.
	process (s1_clk, s1_reset) 
	
	begin
	
		if(rising_edge(s1_clk)) then
							
		if(s1_read = '1') then
				case s1_address is
					when "00" =>
						-- Reading this address should just give back the value that was 
						--	set before hand.
						s1_readdata <= local_data; 
						
						-- When ready, this should give back the new result, other wise it
						-- gives the old result.
					when "01" =>
						s1_readdata <= local_result;
					
					when "10" =>
						-- This tells whether the answer is ready
						if euler_ready = '1' then
							s1_readdata <= std_logic_vector(to_unsigned(1,32));
						else
							s1_readdata <= std_logic_vector(to_unsigned(0,32));
						end if;
						
					when "11" =>
						s1_readdata <= X"ADD30000";
					when others =>
						s1_readdata <= X"DEADDEAD";	-- do nothing here
		      end case;
		end if;
		
		end if;
		end process;
	
	
	
		proc_registers : process (s1_clk, s1_reset) 
		
		begin
		  --    if(s1_reset = '0') then
		
		if(rising_edge(s1_clk)) then
		
			if ((local_enable='1') and (euler_counter > 0)) then
							
				euler_counter <= euler_counter - 1;
			
			elsif (local_enable='1') and (euler_counter = 0) then
			
				-- Set data
				local_result <= euler_in;
				
				-- Reset counter
				euler_counter <= to_unsigned(18,8);

				-- Turn off euler
				local_enable <= '0';
				
				-- Set readiness
				euler_ready <= '1';
		
			end if;
		
			-- Only do anything on a WRITE if we aren't already in a euler process.
		   if (s1_write = '1') and (local_enable='0') then
				case s1_address is
				
					-- The first address represents the incoming data address
					when "00" =>
						-- Get buffered copy of input data
						local_data <= s1_writedata;
						
						-- Give data to euler block
						euler_out <= s1_writedata;
						
						-- Set it off at next clock cycle.
						local_enable <= '1';
						
						-- Data is not ready yet!
						euler_ready <= '0';
						
					-- The other addresses are not going to be writeable.
					when others =>
						-- do nothing here
		      end case;
				
				end if;
				
			 end if;

			 end process proc_registers;	
			
			
	
	
	
	

	end;


	
	
	

--
--architecture keypad_behaviour of keypad_entity is
--  signal cols_counter : unsigned(1 downto 0) := "00";
--  signal internal_keys : std_logic_vector(15 downto 0) := "0000000000000000";
--  signal keystate : std_logic_vector(15 downto 0) := "0000000000000000";
--
--begin
--
--  -- These are hardwired states I guess!
--  cols(0) <= '0' when cols_counter = "00" else 'Z';
--  cols(1) <= '0' when cols_counter = "01" else 'Z';
--  cols(2) <= '0' when cols_counter = "10" else 'Z';
--  cols(3) <= '0' when cols_counter = "11" else 'Z';
--
--  keystate <= internal_keys when cols_counter = "00";
--
--  process(s1_clk)
--  begin
--    if(rising_edge(s1_clk)) then 
--
--      case cols_counter is
--        when "00" =>
--          internal_keys(15 downto 12) <= not rows;
--        when "01" =>	
--          internal_keys(11 downto 8) <= not rows;
--        when "10" =>
--          internal_keys(7 downto 4) <= not rows;
--        when "11" =>
--          internal_keys(3 downto 0) <= not rows;
--        when others =>
--          internal_keys(15 downto 0) <= "0000000000000000";
--      end case;
--
--      cols_counter <= cols_counter + 1;
--
--    end if;
--
--
--  end process;
--
--
--proc_registers : process (s1_clk, s1_reset) begin
--  --    if(s1_reset = '0') then
--  --      reg0_data_int <= (others => '0');
--
--  if(rising_edge(s1_clk)) then
--    if(s1_read = '1') then
--      case s1_address is
--        when "00" =>
--          s1_readdata <= X"ADD00000"; 
--        when "01" =>
--          s1_readdata <= X"ADD10000";
--        when "10" =>
--          s1_readdata <= X"BEEF" & keystate;
--        when others =>
--          s1_readdata <= X"DEADDEAD";	-- do nothing here
--      end case;
--    end if;
--  end if;
--end process proc_registers;
--
--
--        end;
