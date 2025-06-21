library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity cdc_multibit_handshake is
generic (
        DATA_WIDTH : natural := 4
    );
    Port (
        clk_in        : in  std_logic;
        clk_out       : in  std_logic;
        rst_n         : in  std_logic;
        data_in       : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        data_out      : out std_logic_vector(DATA_WIDTH-1 downto 0);
        request_in     : in  std_logic;
        acknowledge_out : out std_logic;
        acknowledge_in : out std_logic
    );
end cdc_multibit_handshake;

architecture Behavioral of cdc_multibit_handshake is
    signal request_b1, request_b2     : std_logic := '0';
    signal acknowledge_b_r            : std_logic := '0';
    signal data_out_r                 : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal acknowledge_b_sync1, acknowledge_b_sync2 : std_logic := '0';

begin

    
    process(clk_out, rst_n)
    begin
        if rst_n = '0' then
            request_b1 <= '0';
            request_b2 <= '0';
        elsif rising_edge(clk_out) then
            request_b1 <= request_in;
            request_b2 <= request_b1;
        end if;
    end process;

   
    process(clk_out, rst_n)
    begin
        if rst_n = '0' then
            acknowledge_b_r <= '0';
            data_out_r      <= (others => '0');
        elsif rising_edge(clk_out) then
            if (request_b2 = '1' and acknowledge_b_r = '0') then
                data_out_r      <= data_in;
                acknowledge_b_r <= '1';
            elsif (request_b2 = '0') then
                acknowledge_b_r <= '0';
            end if;
        end if;
    end process;

    
    process(clk_in, rst_n)
    begin
        if rst_n = '0' then
            acknowledge_b_sync1 <= '0';
            acknowledge_b_sync2 <= '0';
        elsif rising_edge(clk_in) then
            acknowledge_b_sync1 <= acknowledge_b_r;
            acknowledge_b_sync2 <= acknowledge_b_sync1;
        end if;
    end process;


    data_out        <= data_out_r;
    acknowledge_out <= acknowledge_b_r;
    acknowledge_in  <= acknowledge_b_sync2;

end Behavioral;
