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
  
  constant c_data_lower  : integer := 16#1000000#;
  constant c_data_upper  : integer := c_data_lower+127;
  
  constant c_stack_lower : integer := 16#1000#;
  constant c_stack_upper : integer := c_stack_lower+127;
  
	type t_data_segment  is array(c_data_upper downto c_data_lower)   of std_logic_vector(31 downto 0);
	type t_stack_segment is array(c_stack_upper downto c_stack_lower) of std_logic_vector(31 downto 0);
	
	signal s_data_segment  : t_data_segment;
	signal s_stack_segment : t_stack_segment;
BEGIN
  
  	-- simulates data memory
	proc_mem : process(i_rst, i_clk, i_data_addr, s_data_segment, s_stack_segment, i_data_rd, i_data_wr)
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
	
					s_data_segment(c_data_lower+address) <= value_buf;
					address              := address + 1;
				end if;
			end loop;
			
		else
		  
			assert not(i_data_rd = '1' and i_data_wr = '1') severity failure;
			  
			
			-- assynchronous read
			if i_data_rd = '1' then
			  
     			if (c_data_lower <= unsigned(i_data_addr) and unsigned(i_data_addr) < c_data_upper) then
				  o_data_data <= s_data_segment(to_integer(shift_right(unsigned(i_data_addr), 2)));
			  elsif (c_stack_lower <= unsigned(i_data_addr) and unsigned(i_data_addr) < c_stack_upper) then
				  o_data_data <= s_stack_segment(to_integer(shift_right(unsigned(i_data_addr), 2)));
			  else
			      assert false report "Data Address not a valid range in the data memory." severity failure;
			  end if;
			  
				
			-- syncrhonous write
			elsif rising_edge(i_clk) and i_data_wr = '1' then
			  
     			if (c_data_lower <= unsigned(i_data_addr) and unsigned(i_data_addr) < c_data_upper) then				
     			  s_data_segment(to_integer(shift_right(unsigned(i_data_addr), 2))) <= i_data_data;
			  elsif (c_stack_lower <= unsigned(i_data_addr) and unsigned(i_data_addr) < c_stack_upper) then		
     			  s_stack_segment(to_integer(shift_right(unsigned(i_data_addr), 2))) <= i_data_data;
			  else
			      assert false report "Data Address not a valid range in the data memory." severity failure;
			  end if;			  			  

			end if;
		end if;
	end process;
  
END ARCHITECTURE behavioral;

