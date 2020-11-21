--
-- VHDL Architecture work.data_memory.behavioral
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 19:26:48 10/ 7/2020
--
-- using Mentor Graphics HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
USE ieee.numeric_std.all;

use std.textio.all;

use work.pkg_sim.all;

ENTITY data_memory IS
  PORT( 
    i_data_addr : IN     std_logic_vector (31 DOWNTO 0);
    i_data_data : IN     std_logic_vector (31 DOWNTO 0);
    i_data_rd   : IN     std_logic;
    i_data_wr   : IN     std_logic;
    o_data_data : OUT    std_logic_vector (31 DOWNTO 0);
    i_rst       : IN     std_logic;
    i_clk       : IN     std_logic
  );

-- Declarations

END ENTITY data_memory ;

ARCHITECTURE behavioral OF data_memory IS
	type t_memory is array(1023 downto 0) of std_logic_vector(31 downto 0);
	signal s_data_memory : t_memory;
BEGIN
  
  	-- simulates data memory
	proc_mem : process(i_rst, i_clk, i_data_addr, s_data_memory, i_data_rd, i_data_wr)
		file dmem_init_file : text open read_mode is c_data_memory_init_file;

		variable line_buf   : line;      -- Line buffers
		variable str_buf    : string(1 to 10); -- string to modify
		variable value_buf  : std_logic_vector(31 downto 0);
		variable address    : integer := 0;
	begin
		if i_rst = '1' then
			-- Initialize the data memory
			address := 0;
			loop
				if endfile(dmem_init_file) then
					exit;
				else
					readline(dmem_init_file, line_buf);
					read(line_buf, str_buf);
					str_buf := str_buf(str_buf'left + 2 to str_buf'right) & "  ";
					write(line_buf, str_buf);
	
					hread(line_buf, value_buf);
	
					s_data_memory(address) <= value_buf;
					address              := address + 1;
				end if;
			end loop;
		else
			
			assert not(i_data_rd = '1' and i_data_wr = '1') severity failure; 
			
			-- assynchronous read
			if i_data_rd = '1' then
				o_data_data <= s_data_memory(to_integer(shift_right(unsigned(i_data_addr), 2)));
				
			-- syncrhonous write
			elsif rising_edge(i_clk) and i_data_wr = '1' then
				s_data_memory(to_integer(shift_right(unsigned(i_data_addr), 2))) <= i_data_data;
			end if;
		end if;
	end process;
  
END ARCHITECTURE behavioral;

