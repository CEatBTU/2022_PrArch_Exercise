--
-- VHDL Architecture work.alu.behavioral
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 08:42:53 10/ 1/2020
--
-- using Mentor Graphics HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

USE work.pkg_alu.all;
USE work.pkg_util.all;

ENTITY alu IS
  port(
		-- inputs
		i_A      : in  std_logic_vector(31 downto 0);
		i_B      : in  std_logic_vector(31 downto 0);
		alu_ctrl : in  aluop;
		
		-- outputs
		output   : out std_logic_vector(31 downto 0);
		cmp_lt   : out std_logic;
		cmp_eq   : out std_logic;
		cmp_gt   : out std_logic);
END ENTITY alu;

--
ARCHITECTURE behavioral OF alu IS
BEGIN
  
 	update_output : process(i_A, i_B, alu_ctrl)
		variable samt : natural range 0 to 31; -- This is the shift amount
	begin
		samt := to_integer(unsigned(i_B(4 downto 0)));

		cmp_lt <= '0';
		cmp_eq <= '0';
		cmp_gt <= '0';

		case alu_ctrl is

			when OP_ADD =>
				output <= std_logic_vector(signed(i_A) + signed(i_B));
				
			when OP_SUB =>
				output <= std_logic_vector(signed(i_A) - signed(i_B));

				if (signed(i_A) > signed(i_B)) then
					cmp_gt <= '1';
				elsif (signed(i_A) < signed(i_B)) then
					cmp_lt <= '1';
				else
					cmp_eq <= '1';
				end if;
				
			when OP_SUBU =>
				output <= std_logic_vector(unsigned(i_A) - unsigned(i_B));

				if (unsigned(i_A) > unsigned(i_B)) then
					cmp_gt <= '1';
				elsif (unsigned(i_A) < unsigned(i_B)) then
					cmp_lt <= '1';
				else
					cmp_eq <= '1';
				end if;
				
			when OP_AND =>
				output <= i_A and i_B;
				
			when OP_OR =>
				output <= i_A or i_B;
				
			when OP_XOR =>
				output <= i_A xor i_B;
				
			when OP_NOT =>
				output <= not (i_A);
				
			when OP_SRA =>
				output <= std_logic_vector(shift_right(signed(i_A), samt));
				
			when OP_SRL =>
				output <= std_logic_vector(shift_right(unsigned(i_A), samt));
				
			when OP_SLL =>
				output <= std_logic_vector(shift_left(unsigned(i_A), samt));

			when others =>
				output <= (others => '0');

		end case;
	end process;
  
END ARCHITECTURE behavioral;

