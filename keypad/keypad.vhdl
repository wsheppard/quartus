library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;   

entity keypad_entity is
  port (
         --		sys_clk : in std_logic;
         cols : out std_logic_vector(3 downto 0) :="ZZZZ";
         rows : in std_logic_vector(3 downto 0);

         -- Will eventually need this stuff for integration into QSYS
         s1_clk          : in    std_logic;
         s1_reset        : in    std_logic;
         s1_read         : in    std_logic;
         s1_address      : in    std_logic_vector(1 downto 0);
         s1_readdata     : out    std_logic_vector(31 downto 0)

       );
end;


architecture keypad_behaviour of keypad_entity is
  signal cols_counter : unsigned(1 downto 0) := "00";
  signal internal_keys : std_logic_vector(15 downto 0) := "0000000000000000";
  signal keystate : std_logic_vector(15 downto 0) := "0000000000000000";

begin

  -- These are hardwired states I guess!
  cols(0) <= '0' when cols_counter = "00" else 'Z';
  cols(1) <= '0' when cols_counter = "01" else 'Z';
  cols(2) <= '0' when cols_counter = "10" else 'Z';
  cols(3) <= '0' when cols_counter = "11" else 'Z';

  keystate <= internal_keys when cols_counter = "00";

  process(s1_clk)
  begin
    if(rising_edge(s1_clk)) then 

      case cols_counter is
        when "00" =>
          internal_keys(15 downto 12) <= not rows;
        when "01" =>	
          internal_keys(11 downto 8) <= not rows;
        when "10" =>
          internal_keys(7 downto 4) <= not rows;
        when "11" =>
          internal_keys(3 downto 0) <= not rows;
        when others =>
          internal_keys(15 downto 0) <= "0000000000000000";
      end case;

      cols_counter <= cols_counter + 1;

    end if;


  end process;


proc_registers : process (s1_clk, s1_reset) begin
  --    if(s1_reset = '0') then
  --      reg0_data_int <= (others => '0');

  if(rising_edge(s1_clk)) then
    if(s1_read = '1') then
      case s1_address is
        when "00" =>
          s1_readdata <= X"ADD00000"; 
        when "01" =>
          s1_readdata <= X"ADD10000";
        when "10" =>
          s1_readdata <= X"BEEF" & keystate;
        when others =>
          s1_readdata <= X"DEADDEAD";	-- do nothing here
      end case;
    end if;
  end if;
end process proc_registers;


        end;
