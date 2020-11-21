--
-- VHDL Package Header work.riscv_insts
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 08:35:17 10/ 1/2020
--
-- using Mentor Graphics HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE pkg_riscv_insts IS

  -- This type represents an instruction from the RISC-V ISA
  type t_riscv_inst is (
    -- Load (upper) immediate operation
    -- U-type
    INST_LUI,

    -- Control operations
    -- B-type
    INST_BEQ, 
    INST_BLT,
    INST_BGE,

    -- Memory operations
    INST_LW, -- I-type
    INST_SW, -- S-type

    -- Immediate operations
    -- I-type
    INST_ADDI,
    INST_SLTI,
    INST_SLTIU,
    INST_XORI,
    INST_ORI,
    INST_ANDI,

    -- Shifts
    -- R-type
    INST_SLLI,
    INST_SRLI,
    INST_SRAI,

    -- Register-to-Register
    -- R-type
    INST_ADD,
    INST_SUB,
    INST_SLL,
    INST_SLT,
    INST_SLTU,
    INST_XOR,
    INST_SRL,
    INST_SRA,
    INST_OR,
    INST_AND,
    
    INST_UNDEFINED);
    
  function is_itype(instr : t_riscv_inst) return boolean;
  function is_stype(instr : t_riscv_inst) return boolean;
	-- Functions for which the register write signal will
	-- be set to the ALU output.
	function is_AL(instr : t_riscv_inst) return boolean;
	function is_AL_R(instr : t_riscv_inst) return boolean;
	function is_SET(instr : t_riscv_inst) return boolean;
	function is_branch(instr : t_riscv_inst) return boolean;
END pkg_riscv_insts;

PACKAGE BODY pkg_riscv_insts IS
  	function is_itype(instr : t_riscv_inst) return boolean is
	begin
		if (instr = INST_ADDI) or (instr = INST_XORI) or (instr = INST_ORI) or (instr = INST_ANDI) or 
	 	   (instr = INST_SLTI) or (instr = INST_SLTIU) or 
	     (instr = INST_SLLI) or (instr = INST_SRLI) or (instr = INST_SRAI) or 
	     (instr = INST_LW) then
			return true;
		else
			return false;
		end if;
	end function;
	
	function is_stype(instr : t_riscv_inst) return boolean is
	begin
	  if (instr = INST_SW) then
	    return true;
	  else
	    return false;
	  end if;
	end function;
	
	-- Functions for which the register write signal will
	-- be set to the ALU output.
	function is_AL(instr : t_riscv_inst) return boolean is
	begin
		if (instr = INST_ADDI) or (instr = INST_LUI) or (instr = INST_ADDI) or (instr = INST_SLTI) or (instr = INST_SLTIU) or (instr = INST_XORI) or (instr = INST_ORI) or (instr = INST_ANDI) or (instr = INST_SLLI) or (instr = INST_SRLI) or (instr = INST_SRAI) or
			(instr = INST_ADD) or (instr = INST_SLL) or (instr = INST_XOR) or (instr = INST_SRL) or (instr = INST_SRA) or (instr = INST_OR) or (instr = INST_AND) then
			return true;
		else
			return false;
		end if;
	end function;
	
	function is_AL_R(instr : t_riscv_inst) return boolean is
	begin
		if (instr = INST_ADD) or (instr = INST_SLL) or (instr = INST_XOR) or (instr = INST_SRL) or (instr = INST_SRA) 
		or (instr = INST_OR) or (instr = INST_AND) then
			return true;
		else
			return false;
		end if;
	end function;
	
	function is_SET(instr : t_riscv_inst) return boolean is
	begin
		if (instr = INST_SLT) or (instr = INST_SLTI) or (instr = INST_SLTIU) or (instr = INST_SLTU) then
			return true;
		else
			return false;
		end if;
	end function;
	
	function is_branch(instr : t_riscv_inst) return boolean is
	begin
		if (instr = INST_BEQ) or (instr = INST_BGE) or (instr = INST_BLT) then
			return true;
		else
			return false;
		end if;
	end function;
	
END PACKAGE BODY;
