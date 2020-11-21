--
-- VHDL Architecture work.imm_generator.behavioral
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 17:55:42 10/ 1/2020
--
-- using Mentor Graphics HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

USE work.pkg_alu.all;
USE work.pkg_util.all;
USE work.pkg_riscv_insts.all;

ENTITY imm_generator IS
   PORT( 
      i_encoded_instr : IN     std_logic_vector(31 downto 0);
      i_decoded_instr : IN     t_riscv_inst;
      o_immediate     : OUT    std_logic_vector(31 downto 0));

-- Declarations

END imm_generator ;

--
ARCHITECTURE behavioral OF imm_generator IS
 	signal s_immediate_B : std_logic_vector(31 downto 0);
	signal s_immediate_I : std_logic_vector(31 downto 0);
	signal s_immediate_U : std_logic_vector(31 downto 0);
	signal s_immediate_S : std_logic_vector(31 downto 0);

	signal s_immediate   : std_logic_vector(31 downto 0);
BEGIN
  
  update_immediates: process(i_encoded_instr)
	begin

		-- Update immediate_B
		if (i_encoded_instr(31) = '0') then 
			s_immediate_B(31 downto 12) <= (others => '0');
		else
			s_immediate_B(31 downto 12) <= (others => '1');
		end if;
		s_immediate_B(11) <= i_encoded_instr(7);
		s_immediate_B(10 downto 5) <= i_encoded_instr(30 downto 25);
		s_immediate_B(4 downto 1) <= i_encoded_instr(11 downto 8);
		s_immediate_B(0) <= '0';
		
		-- Update immediate_I
		if (i_encoded_instr(31) = '0') then 
			s_immediate_I(31 downto 11) <= (others => '0');
		else
			s_immediate_I(31 downto 11) <= (others => '1');
		end if;
		s_immediate_I(10 downto 0) <= i_encoded_instr(30 downto 20);
		
		-- Update immediate_U
		s_immediate_U(31 downto 12) <= i_encoded_instr(31 downto 12);
		s_immediate_U(11 downto 0)  <= (others => '0');
		
		-- Update immediate_S
		if (i_encoded_instr(31) = '0') then 
			s_immediate_S(31 downto 11) <= (others => '0');
		else
			s_immediate_S(31 downto 11) <= (others => '1');
		end if;
		s_immediate_S(10 downto 5) <= i_encoded_instr(30 downto 25);
		s_immediate_S(4  downto 1) <= i_encoded_instr(11 downto 8);
		s_immediate_S(0)           <= i_encoded_instr(7);
	end process;

	s_immediate <= 
	  s_immediate_I when is_itype(i_decoded_instr) else
	  s_immediate_S when is_stype(i_decoded_instr) else
	  s_immediate_U when i_decoded_instr = INST_LUI else
	  s_immediate_B;

	o_immediate <= s_immediate;

END ARCHITECTURE behavioral;

