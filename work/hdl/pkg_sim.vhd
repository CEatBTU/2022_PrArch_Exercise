--
-- VHDL Package Header work.pkg_sim
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 10:04:29 10/ 8/2020
--
-- using Mentor Graphics HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;


PACKAGE pkg_sim IS
	constant c_data_memory_init_file : string := 
		"C:\Users\bmarc\OneDrive\Desktop\PR_ProcArch_RISCV\work\sim\mem_files\vector_add\data_mem.mem";
	constant c_instr_memory_init_file : string := 
		"C:\Users\bmarc\OneDrive\Desktop\PR_ProcArch_RISCV\work\sim\mem_files\vector_add\instr_mem.mem";
END pkg_sim;
