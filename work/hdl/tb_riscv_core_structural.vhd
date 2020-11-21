-- VHDL Entity work.tb_riscv_core.symbol
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 19:03:01 10/ 7/2020
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY tb_riscv_core IS
-- Declarations

END ENTITY tb_riscv_core ;

--
-- VHDL Architecture work.tb_riscv_core.structural
--
-- Created:
--          by - bmarc.UNKNOWN (LAPTOP-TS0CSSEU)
--          at - 17:04:30 10/ 9/2020
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2020.3 Built on 12 Jul 2020 at 11:01:26
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

LIBRARY work;

ARCHITECTURE structural OF tb_riscv_core IS

  -- Architecture declarations

  -- Internal signal declarations
  SIGNAL clk           : std_logic;
  SIGNAL data_addr     : std_logic_vector(31 DOWNTO 0);
  SIGNAL data_fromdmem : std_logic_vector(31 DOWNTO 0);
  SIGNAL data_rd       : std_logic;
  SIGNAL data_todmem   : std_logic_vector(31 DOWNTO 0);
  SIGNAL data_wr       : std_logic;
  SIGNAL instr_addr    : std_logic_vector(31 DOWNTO 0);
  SIGNAL instr_data    : std_logic_vector(31 DOWNTO 0);
  SIGNAL rst           : std_logic;


  -- ModuleWare signal declarations(v1.12) for instance 'u_clkgen' of 'clk'
  SIGNAL s_u_clkgenclk : std_logic;

  -- ModuleWare signal declarations(v1.12) for instance 'u_rstgen' of 'pulse'
  SIGNAL s_u_rstgenpulse : std_logic :='1';

  -- Component Declarations
  COMPONENT data_memory
  PORT (
    i_clk       : IN     std_logic;
    i_data_addr : IN     std_logic_vector (31 DOWNTO 0);
    i_data_data : IN     std_logic_vector (31 DOWNTO 0);
    i_data_rd   : IN     std_logic;
    i_data_wr   : IN     std_logic;
    i_rst       : IN     std_logic;
    o_data_data : OUT    std_logic_vector (31 DOWNTO 0)
  );
  END COMPONENT data_memory;
  COMPONENT instruction_memory
  PORT (
    i_clk        : IN     std_logic;
    i_rst        : IN     std_logic;
    o_instr_addr : IN     std_logic_vector (31 DOWNTO 0);
    i_instr_data : OUT    std_logic_vector (31 DOWNTO 0)
  );
  END COMPONENT instruction_memory;
  COMPONENT riscv_core
  PORT (
    clk_i        : IN     std_logic ;
    i_data_data  : IN     std_logic_vector (31 DOWNTO 0);
    i_instr_data : IN     std_logic_vector (31 DOWNTO 0);
    rst_i        : IN     std_logic ;
    o_data_addr  : OUT    std_logic_vector (31 DOWNTO 0);
    o_data_data  : OUT    std_logic_vector (31 DOWNTO 0);
    o_data_rd    : OUT    std_logic ;
    o_data_wr    : OUT    std_logic ;
    o_instr_addr : OUT    std_logic_vector (31 DOWNTO 0)
  );
  END COMPONENT riscv_core;

  -- Optional embedded configurations
  -- pragma synthesis_off
  FOR ALL : data_memory USE ENTITY work.data_memory;
  FOR ALL : instruction_memory USE ENTITY work.instruction_memory;
  FOR ALL : riscv_core USE ENTITY work.riscv_core;
  -- pragma synthesis_on


BEGIN

  -- ModuleWare code(v1.12) for instance 'u_clkgen' of 'clk'
  proc_u_clkgenclk: PROCESS
  BEGIN
    LOOP
      s_u_clkgenclk <= '0', '1' AFTER 50.00 ns;
      WAIT FOR 100 ns;
    END LOOP;
    WAIT;
  END PROCESS proc_u_clkgenclk;
  clk <= s_u_clkgenclk;

  -- ModuleWare code(v1.12) for instance 'u_rstgen' of 'pulse'
  rst <= s_u_rstgenpulse;
  proc_u_rstgenpulse: PROCESS
  BEGIN
    s_u_rstgenpulse <= 
      '1',
      '0' AFTER 2000 ns;
    WAIT;
   END PROCESS proc_u_rstgenpulse;

  -- Instance port mappings.
  u_data_memory : data_memory
    PORT MAP (
      i_data_addr => data_addr,
      i_data_data => data_todmem,
      i_data_rd   => data_rd,
      i_data_wr   => data_wr,
      o_data_data => data_fromdmem,
      i_rst       => rst,
      i_clk       => clk
    );
  u_instr_memory : instruction_memory
    PORT MAP (
      i_clk        => clk,
      o_instr_addr => instr_addr,
      i_rst        => rst,
      i_instr_data => instr_data
    );
  u_riscv_core : riscv_core
    PORT MAP (
      clk_i        => clk,
      i_data_data  => data_fromdmem,
      i_instr_data => instr_data,
      rst_i        => rst,
      o_data_addr  => data_addr,
      o_data_data  => data_todmem,
      o_data_rd    => data_rd,
      o_data_wr    => data_wr,
      o_instr_addr => instr_addr
    );

END ARCHITECTURE structural;