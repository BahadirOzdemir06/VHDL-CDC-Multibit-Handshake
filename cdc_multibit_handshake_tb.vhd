library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity cdc_multibit_handshake_tb is
generic (
        DATA_WIDTH : natural := 4
		);
end cdc_multibit_handshake_tb;

architecture Behavioral of cdc_multibit_handshake_tb is

component cdc_multibit_handshake 
generic (
        DATA_WIDTH : natural := 4
    );
    Port (
        clk_in          : in  std_logic;
        clk_out         : in  std_logic;
        rst_n           : in  std_logic;
        data_in         : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        data_out        : out std_logic_vector(DATA_WIDTH-1 downto 0);
        request_in      : in  std_logic;
        acknowledge_out : out std_logic;
        acknowledge_in  : out std_logic
    );
end component;

signal clk_in          :  std_logic;
signal clk_out         :  std_logic;
signal rst_n           :  std_logic;
signal request_in      :  std_logic;
signal acknowledge_out :  std_logic;
signal acknowledge_in  :  std_logic;
signal data_in         :  std_logic_vector(DATA_WIDTH-1 downto 0);
signal data_out        :  std_logic_vector(DATA_WIDTH-1 downto 0);
constant clk_in_period :  time := 10ns; -- 100MHz 
constant clk_out_period:  time := 20ns; -- 50MHz
begin

dut: cdc_multibit_handshake
        generic map(
		          DATA_WIDTH => DATA_WIDTH
				  )
		port map(
		       
		        clk_in           => clk_in,    
		        clk_out          => clk_out,
		        rst_n            => rst_n,
		        data_in          => data_in,
                data_out         => data_out,
                request_in       => request_in,
                acknowledge_out  => acknowledge_out,
                acknowledge_in   => acknowledge_in
			   );
               
               
			clock_in_proc: process
                             begin 
                               clk_in <= '0';
							   wait for clk_in_period/2;
							   clk_in <= '1';
							   wait for clk_in_period/2;
							 end process;
			
			clock_out_proc: process
                             begin 
                               clk_out <= '0';
							   wait for clk_out_period/2;
							   clk_out <= '1';
							   wait for clk_out_period/2;
							 end process;
							 
							 
		  stimuli_proc: process 
		                 begin 
						  rst_n <= '0';
						  wait for 100ns;
						  rst_n <= '1';
						  --------------
						  wait until rising_edge(clk_in);
						  data_in <= "1010";
						  request_in <= '1';
						  wait until acknowledge_in = '1';
						  
						  wait until rising_edge(clk_in);
						  request_in <= '0';
						  wait until acknowledge_in = '0';
						  ---------------------
						   wait until rising_edge(clk_in);
						  data_in <= "1110";
						  request_in <= '1';
						  wait until acknowledge_in = '1';
						  
						  wait until rising_edge(clk_in);
						  request_in <= '0';
						  wait until acknowledge_in = '0';
						  
						  wait for 80ns;
						  wait;
						end process;
						     
			   
end Behavioral;
		
