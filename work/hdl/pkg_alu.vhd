--
-- VHDL Package Body work.pkg_alu
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 08:44:41 10/ 1/2020
--
-- using Mentor Graphics HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
PACKAGE pkg_alu IS
  type aluop is (
  	 OP_A, -- outputs A
  	 OP_B, -- outputs B
  	
    OP_ADD, -- outputs A + B
    OP_SUB, -- outputs A - B
    OP_SUBU, -- outputs A - B, where A and B are unsigned

    OP_AND,
    OP_OR,
    OP_XOR,
    OP_NOT, -- outputs not(A)
    
    OP_SRA,
    OP_SRL,
    OP_SLL,
    
    OP_UNDEFINED);
END PACKAGE;

PACKAGE BODY pkg_alu IS
END pkg_alu;
