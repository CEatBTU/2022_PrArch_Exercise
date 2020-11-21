--
-- VHDL Architecture work.instr_decoder.behavioral
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 10:15:45 10/ 1/2020
--
-- using Mentor Graphics HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

USE work.pkg_riscv_insts.all;
USE work.pkg_alu.all;

ENTITY instr_decoder IS
  	port(
	  i_encoded_instr : in std_logic_vector(31 downto 0);
		
	  o_decoded_instr : out t_riscv_inst;
	  o_branch : out std_logic;
	  o_memrd  : out std_logic;
	  o_memwr  : out std_logic;
	  o_mem2reg: out std_logic;
	  o_regwr  : out std_logic;
	  o_alusrc : out std_logic;
	  o_aluop  : out aluop);
END ENTITY instr_decoder;

--
ARCHITECTURE behavioral OF instr_decoder IS
  signal opcode : std_logic_vector(6 downto 0);
  signal funct3 : std_logic_vector(2 downto 0);
  signal funct7 : std_logic_vector(6 downto 0);
	
  signal s_decoded_instr : t_riscv_inst;
	
  signal s_branch : std_logic;
  signal s_memrd  : std_logic;
  signal s_memwr  : std_logic;
  signal s_mem2reg: std_logic;
  signal s_regwr  : std_logic;
  signal s_alusrc : std_logic;
  signal s_aluop  : aluop;
	
BEGIN
  
	opcode <= i_encoded_instr(6 downto 0);
	funct3 <= i_encoded_instr(14 downto 12);
	funct7 <= i_encoded_instr(31 downto 25);
    
  p_decode : process(opcode, funct3, funct7)
  begin
   	  if opcode = "0110111" then
   	    s_decoded_instr <= INST_LUI;
  		
      elsif opcode = "1100011" and funct3 = "000" then
    		  s_decoded_instr <= INST_BEQ;
    	 elsif opcode = "1100011" and funct3 = "100" then
    		  s_decoded_instr <= INST_BLT;
    		elsif opcode = "1100011" and funct3 = "101" then
    		  s_decoded_instr <= INST_BGE;
    		
    		elsif opcode = "0000011" and funct3 = "010" then
    		  s_decoded_instr <= INST_LW;
    		elsif opcode = "0100011" and funct3 = "010" then
    		  s_decoded_instr <= INST_SW;
    		
    		elsif opcode = "0010011" and funct3 = "000" then
    		  s_decoded_instr <= INST_ADDI;
    		elsif opcode = "0010011" and funct3 = "010" then
    		  s_decoded_instr <= INST_SLTI;
    		elsif opcode = "0010011" and funct3 = "011" then
    		  s_decoded_instr <= INST_SLTIU;
    		elsif opcode = "0010011" and funct3 = "100" then
    		  s_decoded_instr <= INST_XORI;
    		elsif opcode = "0010011" and funct3 = "110" then
    		  s_decoded_instr <= INST_ORI;
    		elsif opcode = "0010011" and funct3 = "111" then
    		  s_decoded_instr <= INST_ANDI;
    		
    		elsif opcode = "0010011" and funct3 = "001" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_SLLI;
    		elsif opcode = "0010011" and funct3 = "101" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_SRLI;
    		elsif opcode = "0010011" and funct3 = "101" and funct7 = "0100000" then
    		  s_decoded_instr <= INST_SRAI;
    		
    		elsif opcode = "0110011" and funct3 = "000" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_ADD;
    		elsif opcode = "0110011" and funct3 = "000" and funct7 = "0100000" then
    		  s_decoded_instr <= INST_SUB;
    		elsif opcode = "0110011" and funct3 = "001" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_SLL;
    		elsif opcode = "0110011" and funct3 = "010" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_SLT;
    		elsif opcode = "0110011" and funct3 = "011" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_SLTU;
    		elsif opcode = "0110011" and funct3 = "100" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_XOR;
    		elsif opcode = "0110011" and funct3 = "101" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_SRL;
    		elsif opcode = "0110011" and funct3 = "101" and funct7 = "0100000" then
    		  s_decoded_instr <= INST_SRA;
    		elsif opcode = "0110011" and funct3 = "110" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_OR;
    		elsif opcode = "0110011" and funct3 = "111" and funct7 = "0000000" then
    		  s_decoded_instr <= INST_AND;
  		  
  		  else
    		  s_decoded_instr <= INST_UNDEFINED;
		  end if;
	end process;
	
	output : process(s_decoded_instr)
	begin
	  s_branch  <= '0';
	  s_memrd   <= '0';
	  s_memwr   <= '0';
	  s_mem2reg <= '0';
	  s_regwr   <= '0';
	  s_alusrc  <= '0';
	  s_aluop   <= OP_A;
    
    
    if is_AL(s_decoded_instr) then
      s_regwr <= '1';
      
      if not is_AL_R(s_decoded_instr) then
        s_alusrc <= '1';
      end if;
    elsif s_decoded_instr = INST_LW then
      s_alusrc <= '1';
      s_memrd <= '1';
      s_mem2reg <= '1';
      s_regwr <= '1';
    elsif s_decoded_instr = INST_SW then
     s_alusrc <= '1';
    	s_memwr <= '1';
    elsif is_branch(s_decoded_instr) then
    	s_branch <= '1';
    end if;
    
    -- Assign s_aluop
    case s_decoded_instr is
			when INST_LUI =>
				s_aluop <= OP_B;

			when INST_BEQ =>
				s_aluop <= OP_SUB;
			when INST_BLT =>
				s_aluop <= OP_SUB;
			when INST_BGE =>
				s_aluop <= OP_SUB;

			-- Memory operations
			when INST_LW =>
				s_aluop <= OP_ADD;
			when INST_SW =>
				s_aluop <= OP_ADD;

			-- Immediate operations
			-- I-type
			when INST_ADD =>
				s_aluop <= OP_ADD;
			when INST_ADDI =>
				s_aluop <= OP_ADD;
			when INST_SUB =>
				s_aluop <= OP_SUB;
				
			when INST_AND =>
				s_aluop <= OP_AND;
			when INST_ANDI =>
				s_aluop <= OP_AND;
			when INST_OR =>
				s_aluop <= OP_OR;
			when INST_ORI =>
				s_aluop <= OP_OR;
			when INST_XOR =>
				s_aluop <= OP_XOR;
			when INST_XORI =>
				s_aluop <= OP_XOR;
				
			when INST_SLL =>
				s_aluop <= OP_SLL;
			when INST_SLLI =>
				s_aluop <= OP_SLL;
			when INST_SRA =>
				s_aluop <= OP_SRA;
			when INST_SRAI =>
				s_aluop <= OP_SRA;
			when INST_SRL =>
				s_aluop <= OP_SRL;
			when INST_SRLI =>
				s_aluop <= OP_SRL;
				
			when INST_SLT =>
				s_aluop <= OP_SUB;
			when INST_SLTI =>
				s_aluop <= OP_SUB;
			when INST_SLTU =>
				s_aluop <= OP_SUBU;
			when INST_SLTIU =>
				s_aluop <= OP_SUBU;

			when INST_UNDEFINED =>
				s_aluop <= OP_ADD;
		end case;
	end process;
	
	o_decoded_instr <= s_decoded_instr;
	o_branch  <= s_branch;
	o_memrd   <= s_memrd;
	o_memwr   <= s_memwr;
	o_mem2reg <= s_mem2reg;
	o_regwr   <= s_regwr;
	o_alusrc  <= s_alusrc;
	o_aluop   <= s_aluop;
	
END ARCHITECTURE behavioral;

