add wave -divider "CLK & RST"
add wave \
	sim:/tb_riscv_core/u_riscv_core/rst_i \
	sim:/tb_riscv_core/u_riscv_core/clk_i

add wave -divider "RISCV Core"
add wave \
	sim:/tb_riscv_core/u_riscv_core/i_instr_data \
	sim:/tb_riscv_core/u_riscv_core/o_instr_addr \
	\
	sim:/tb_riscv_core/u_riscv_core/i_data_data \
	sim:/tb_riscv_core/u_riscv_core/o_data_addr \
	sim:/tb_riscv_core/u_riscv_core/o_data_data \
	sim:/tb_riscv_core/u_riscv_core/o_data_rd \
	sim:/tb_riscv_core/u_riscv_core/o_data_wr

add wave -divider "Inst. Decoder"
add wave sim:/tb_riscv_core/u_riscv_core/u_inst_dec/o_decoded_instr

add wave -divider "Reg. File"
add wave \
	sim:/tb_riscv_core/u_riscv_core/u_reg_file/rd_addr1_i \
	sim:/tb_riscv_core/u_riscv_core/u_reg_file/rd_addr2_i \
	sim:/tb_riscv_core/u_riscv_core/u_reg_file/reg_data1_o \
	sim:/tb_riscv_core/u_riscv_core/u_reg_file/reg_data2_o \
	\
	sim:/tb_riscv_core/u_riscv_core/u_reg_file/wr_addr_i \
	sim:/tb_riscv_core/u_riscv_core/u_reg_file/wr_data_i \
	sim:/tb_riscv_core/u_riscv_core/u_reg_file/wr_en_i \
	\
	sim:/tb_riscv_core/u_riscv_core/u_reg_file/register_bank

add wave -divider "ALU"
add wave \
	sim:/tb_riscv_core/u_riscv_core/u_alu/i_A \
	sim:/tb_riscv_core/u_riscv_core/u_alu/i_B \
	sim:/tb_riscv_core/u_riscv_core/u_alu/alu_ctrl \
	sim:/tb_riscv_core/u_riscv_core/u_alu/output

