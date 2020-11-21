--
-- VHDL Architecture work.instruction_memory.behavioral
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 19:28:04 10/ 7/2020
--
-- using Mentor Graphics HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
USE ieee.numeric_std.all;

use std.textio.all;

use work.pkg_sim.all;

ENTITY instruction_memory IS
  PORT( 
    i_clk          : IN     std_logic;
    o_instr_addr : IN     std_logic_vector (31 DOWNTO 0);
    i_rst          : IN     std_logic;
    i_instr_data : OUT    std_logic_vector (31 DOWNTO 0)
  );

-- Declarations

END ENTITY instruction_memory ;

--
ARCHITECTURE behavioral OF instruction_memory IS
	type t_memory is array(1023 downto 0) of std_logic_vector(31 downto 0);
	signal s_instr_memory : t_memory;
BEGIN
	
  	-- simulates data memory
	proc_mem : process(i_rst, o_instr_addr, s_instr_memory)
		file dmem_init_file : text open read_mode is c_instr_memory_init_file;

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
	
					s_instr_memory(address) <= value_buf;
					address              := address + 1;
				end if;
			end loop;
			
		else
						
			-- assynchronous read
			i_instr_data <= s_instr_memory(to_integer(shift_right(unsigned(o_instr_addr), 2)));

		end if;
	end process;
END ARCHITECTURE behavioral;

