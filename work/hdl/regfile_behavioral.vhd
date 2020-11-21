--
-- VHDL Architecture work.regfile.behavioral
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 08:48:11 10/ 1/2020
--
-- using Mentor Graphics HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY regfile IS
 	port(
    clk_i : in std_logic;
    rst_i : in std_logic;
      
    rd_addr1_i : in std_logic_vector(4 downto 0);
    rd_addr2_i : in std_logic_vector(4 downto 0);

    wr_data_i : in std_logic_vector(31 downto 0);
    wr_addr_i : in std_logic_vector(4 downto 0);
    wr_en_i   : in std_logic;

    reg_data1_o : out std_logic_vector(31 downto 0);
    reg_data2_o : out std_logic_vector(31 downto 0));
END ENTITY regfile;

--
ARCHITECTURE behavioral OF regfile IS
  type register_bank32 is array (31 downto 0) of std_logic_vector(31 downto 0);
	
	signal register_bank : register_bank32;
BEGIN
  
  process(clk_i)
	begin
		if (rising_edge(clk_i)) then
			if rst_i = '1' then
				for i in 31 downto 0 loop
					register_bank(i) <= (others => '0');
				end loop;
			else
				if ((wr_en_i = '1') and (to_integer(unsigned(wr_addr_i)) /= 0)) then
					register_bank(to_integer(unsigned(wr_addr_i))) <= wr_data_i;
				end if;
			end if;
		end if;
	end process;

	reg_data1_o <= register_bank(to_integer(unsigned(rd_addr1_i)));
	reg_data2_o <= register_bank(to_integer(unsigned(rd_addr2_i)));
	
END ARCHITECTURE behavioral;
-- 3.55us bug ADDI

