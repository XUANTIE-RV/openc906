/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
`define TDT_DM_CORE_RV64
`define TDT_DM_PB_SIZE 2

`ifndef JTAG_DRV
`define JTAG_DRV

//signal renaming
//-----------------------------------------------

//jtag interface
//-clk,rst
`define jtag_tclk       tb.jclk
`define jtag_trst_b     tb.jrst_b
//-control signals
//-5 line
`define jtag_tdi        tb.jtg_tdi
`define jtag_tms_i      tb.jtg_tms//_i
`define jtag_tdo        tb.jtg_tdo
//-2line
`define jtag_tms_o      tb.jtg_tms


`define cpuclk          tb.clk
`define jtag2_sel       1'b0
`define cpu_rst         tb.rst_b

//CORE0
// `define core0_cpu_retire_pc     tb.x_soc.x_cpu_sub_system_ahb.rtu_pad_retire_pc[31:0]
// `define core0_cpu_retire0       tb.x_soc.x_cpu_sub_system_ahb.rtu_pad_inst_retire
// `define mstatus                 tb.x_soc.x_cpu_sub_system_ahb.cp0_pad_mstatus
`define core0_cpu_retire_pc    tb.x_soc.x_cpu_sub_system_axi.x_c906_wrapper.x_cpu_top.core0_pad_retire_pc[39:0]
`define core0_cpu_retire0       tb.x_soc.x_cpu_sub_system_axi.x_c906_wrapper.x_cpu_top.core0_pad_retire
// `define mstatus                 tb.x_soc.x_cpu_sub_system_axi.x_c906_wrapper.core0_pad_mstatus
`define mstatus                 tb.x_soc.x_cpu_sub_system_axi.x_c906_wrapper.x_cpu_top.x_aq_top_0.x_aq_core.x_aq_cp0_top.x_aq_cp0_regs.mstatus_value


//CORE0 insterrupt related
// `define s_lpmd_mt_int          tb.x_soc.x_cpu_sub_system_ahb.x_e907_top.x_pa_tcipif_top.clint_cpu_mt_int
// `define s_lpmd_me_int          tb.x_soc.x_cpu_sub_system_ahb.x_e907_top.x_pa_tcipif_top.clint_cpu_me_int
// `define s_lpmd_ms_int          tb.x_soc.x_cpu_sub_system_ahb.x_e907_top.x_pa_tcipif_top.clint_cpu_ms_int
// tb.x_soc.x_cpu_sub_system_axi.x_c906_wrapper.x_cpu_top.core0_pad_lpmd_b[1:0]



//-----------------------------------------------
//define the instructions opcodes
`define EBREAK          32'h00100073
`define MV_X0_X0        32'h00000013
`define MV_X1_X1        16'h8086
`define MV_X2_X2        16'h810a
`define MV_X3_X3        16'h818e
`define MV_X4_X4        16'h8212
`define MV_X5_X5        16'h8296
`define MV_X6_X6        16'h831a
`define MV_X7_X7        16'h839e
`define MV_X8_X8        16'h8422
`define MV_X9_X9        16'h84a6
`define MV_X10_X10      16'h852a
`define MV_X11_X11      16'h85ae
`define MV_X12_X12      16'h8632
`define MV_X13_X13      16'h86b6
`define MV_X14_X14      16'h873a
`define MV_X15_X15      16'h87be
`define MV_X16_X16      16'h8842
`define MV_X17_X17      16'h88c6
`define MV_X18_X18      16'h894a
`define MV_X19_X19      16'h89ce
`define MV_X20_X20      16'h8a52
`define MV_X21_X21      16'h8ad6
`define MV_X22_X22      16'h8b5a
`define MV_X23_X23      16'h8bde
`define MV_X24_X24      16'h8c62
`define MV_X25_X25      16'h8ce6
`define MV_X26_X26      16'h8d6a
`define MV_X27_X27      16'h8dee
`define MV_X28_X28      16'h8e72
`define MV_X29_X29      16'h8ef6
`define MV_X30_X30      16'h8f7a
`define MV_X31_X31      16'h8ffe

// FMV instructions
// Single
`define FMV_W_X_X9_F1   32'he00084d3
`define FMV_X_W_F1_X8   32'hf00400d3


`define	FMV_X_W_X8_F16  32'he0080453
`define	FMV_X_W_X8_F17  32'he0088453
`define	FMV_X_W_X8_F18  32'he0090453
`define	FMV_X_W_X8_F19  32'he0098453
`define	FMV_X_W_X8_F20  32'he00a0453
`define	FMV_X_W_X8_F21  32'he00a8453
`define	FMV_X_W_X8_F22  32'he00b0453
`define	FMV_X_W_X8_F23  32'he00b8453
`define	FMV_X_W_X8_F24  32'he00c0453
`define	FMV_X_W_X8_F25  32'he00c8453
`define	FMV_X_W_X8_F26  32'he00d0453
`define	FMV_X_W_X8_F27  32'he00d8453
`define	FMV_X_W_X8_F28  32'he00e0453
`define	FMV_X_W_X8_F29  32'he00e8453
`define	FMV_X_W_X8_F30  32'he00f0453
`define	FMV_X_W_X8_F31  32'he00f8453

// Double
`define	FMV_X_D_X8_F0   32'he2000453
`define	FMV_X_D_X8_F1   32'he2008453
`define	FMV_X_D_X8_F2   32'he2010453
`define	FMV_X_D_X8_F3   32'he2018453
`define	FMV_X_D_X8_F4   32'he2020453
`define	FMV_X_D_X8_F5   32'he2028453
`define	FMV_X_D_X8_F6   32'he2030453
`define	FMV_X_D_X8_F7   32'he2038453
`define	FMV_X_D_X8_F8   32'he2040453
`define	FMV_X_D_X8_F9   32'he2048453
`define	FMV_X_D_X8_F10  32'he2050453
`define	FMV_X_D_X8_F11  32'he2058453
`define	FMV_X_D_X8_F12  32'he2060453
`define	FMV_X_D_X8_F13  32'he2068453
`define	FMV_X_D_X8_F14  32'he2070453
`define	FMV_X_D_X8_F15  32'he2078453
`define	FMV_X_D_X8_F16  32'he2080453
`define	FMV_X_D_X8_F17  32'he2088453
`define	FMV_X_D_X8_F18  32'he2090453
`define	FMV_X_D_X8_F19  32'he2098453
`define	FMV_X_D_X8_F20  32'he20a0453
`define	FMV_X_D_X8_F21  32'he20a8453
`define	FMV_X_D_X8_F22  32'he20b0453
`define	FMV_X_D_X8_F23  32'he20b8453
`define	FMV_X_D_X8_F24  32'he20c0453
`define	FMV_X_D_X8_F25  32'he20c8453
`define	FMV_X_D_X8_F26  32'he20d0453
`define	FMV_X_D_X8_F27  32'he20d8453
`define	FMV_X_D_X8_F28  32'he20e0453
`define	FMV_X_D_X8_F29  32'he20e8453
`define	FMV_X_D_X8_F30  32'he20f0453
`define	FMV_X_D_X8_F31  32'he20f8453
`define	FMV_D_X_F0_X8   32'hf2040053
`define	FMV_D_X_F1_X8   32'hf20400d3
`define	FMV_D_X_F2_X8   32'hf2040153
`define	FMV_D_X_F3_X8   32'hf20401d3
`define	FMV_D_X_F4_X8   32'hf2040253
`define	FMV_D_X_F5_X8   32'hf20402d3
`define	FMV_D_X_F6_X8   32'hf2040353
`define	FMV_D_X_F7_X8   32'hf20403d3
`define	FMV_D_X_F8_X8   32'hf2040453
`define	FMV_D_X_F9_X8   32'hf20404d3
`define	FMV_D_X_F10_X8  32'hf2040553
`define	FMV_D_X_F11_X8  32'hf20405d3
`define	FMV_D_X_F12_X8  32'hf2040653
`define	FMV_D_X_F13_X8  32'hf20406d3
`define	FMV_D_X_F14_X8  32'hf2040753
`define	FMV_D_X_F15_X8  32'hf20407d3
`define	FMV_D_X_F16_X8  32'hf2040853
`define	FMV_D_X_F17_X8  32'hf20408d3
`define	FMV_D_X_F18_X8  32'hf2040953
`define	FMV_D_X_F19_X8  32'hf20409d3
`define	FMV_D_X_F20_X8  32'hf2040a53
`define	FMV_D_X_F21_X8  32'hf2040ad3
`define	FMV_D_X_F22_X8  32'hf2040b53
`define	FMV_D_X_F23_X8  32'hf2040bd3
`define	FMV_D_X_F24_X8  32'hf2040c53
`define	FMV_D_X_F25_X8  32'hf2040cd3
`define	FMV_D_X_F26_X8  32'hf2040d53
`define	FMV_D_X_F27_X8  32'hf2040dd3
`define	FMV_D_X_F28_X8  32'hf2040e53
`define	FMV_D_X_F29_X8  32'hf2040ed3
`define	FMV_D_X_F30_X8  32'hf2040f53
`define	FMV_D_X_F31_X8  32'hf2040fd3


// Arithmetic Instructions
`define NOP             32'h00000013
`define C_NOP           16'h0001
`define ADDI_X5_X5_4    32'h00428293
`define ADDI_X6_X6_4    32'h00430313
`define SUBI_X5_X5_4    32'hffc28293
`define ADD_X1_X0_X0    32'h000000b3
`define ADD_X1_X1_1     32'h00108093

// Vector instructions
`define VMV_X_S_X0_X1             32'h32102057
`define VSLIDE1DOWN_VX_V1_V1_X0   32'h3e1060d7


// CSR R/W instructions
`define CSRW_HARTID_S0      32'hf1441073
`define CSRR_X5_MCAUSE      32'h342022f3
`define CSRR_X5_MSTATUS     32'h300022f3
`define CSRR_X5_MXSTATUS    32'h7c0022f3
`define CSRR_X0_MSTATUS     32'h30002073
`define CSRW_MSTATUS_X0     32'h30001073
`define CSRR_X0_SSTATUS     32'h10002073
`define CSRW_SSTATUS_X0     32'h10001073
`define CSRR_X0_SMCIR   32'h9c302073
`define CSRW_SMCIR_X0   32'h9c301073
`define CSRR_X0_MRVBR   32'h7c702073
`define CSRW_MRVBR_X0   32'h7c701073
`define CSRR_X0_MTVAL   32'h34302073
`define CSRW_MTVAL_X0   32'h34301073

`define CSRW_PMPADDR0_X1    32'h3b009073
`define CSRW_PMPADDR1_X1    32'h3b109073
`define CSRW_PMPADDR2_X1    32'h3b209073
`define CSRW_PMPADDR3_X1    32'h3b309073
`define CSRW_PMPADDR4_X1    32'h3b409073
`define CSRW_PMPADDR5_X1    32'h3b509073
`define CSRW_PMPADDR6_X1    32'h3b609073
`define CSRR_X1_PMPADDR0    32'h3b0020f3
`define CSRR_X1_PMPADDR1    32'h3b1020f3
`define CSRR_X1_PMPADDR2    32'h3b2020f3
`define CSRR_X1_PMPADDR3    32'h3b3020f3
`define CSRR_X1_PMPADDR4    32'h3b4020f3
`define CSRR_X1_PMPADDR5    32'h3b5020f3
`define CSRR_X1_PMPADDR6    32'h3b6020f3

`define CSRW_MEPC_X1        32'h34109073
`define CSRR_X1_MEPC        32'h341020f3
`define CSRW_MEPC_X8        32'h34141073
`define CSRR_X8_MEPC        32'h34102473

`define CSRR_X3_MCPUID      32'hfc0021f3


// CACHE instructions
`define DCACHE_IALL         32'h0020000b
`define DCACHE_CIALL        32'h0030000b
`define DCACHE_IPA_X5       32'h02a2800b
`define DCACHE_IVA_X5       32'h0262800b
`define DCACHE_CALL         32'h0010000b

// LD/ST instructions
`define LD_X5_0_X6          32'h00033283
`define LD_X5_0_X7          32'h0003b283
`define LD_X5_0_X8          32'h00043283
`define SD_X5_0_X6          32'h00533023
`define SD_X5_0_X7          32'h0053b023
`define SD_X5_0_X8          32'h00543023

`define LW_X7_0_X6      32'h00032383
`define LW_X7_4_X6      32'h00432383
`define LW_X7_8_X6      32'h00832383
`define LW_X7_12_X6     32'h00C32383
`define LW_X7_16_X6     32'h01032383
`define LW_X7_24_X6     32'h01832383
`define LW_X7_64_X6     32'h04032383
`define LW_X7_0_X8      32'h00042383
`define LW_X7_64_X8     32'h04042383
`define SW_X7_0_X6      32'h00732023
`define SW_X7_8_X6      32'h00732423
`define SW_X7_16_X6     32'h00732823
`define SW_X7_24_X6     32'h00732c23

`define LD_X7_0_X6      32'h00033383
`define LD_X7_8_X6      32'h00833383
`define LD_X7_16_X6     32'h01033383
`define LD_X7_24_X6     32'h01833383
`define SD_X7_0_X6      32'h00733023
`define SD_X7_8_X6      32'h00733423
`define SD_X7_16_X6     32'h00733823
`define SD_X7_24_X6     32'h00733c23

`define LW_X6_0_X5      32'h0002a303
// `define MFCR_R1_CR0     32'hc0006021
// `define MFCR_R5_CR0     32'hc0006025
// `define MFCR_R6_CR0_B3  32'hc0606026
// `define MFCR_R1_CR1     32'hc0016021
// `define MFCR_R1_CR1_B1  32'hc0216021
// `define MFCR_R1_CR1_B3  32'hc0616021
// `define MFCR_R1_CR2     32'hc0026021
// `define MFCR_R1_CR2_B3  32'hc0626021
// `define MFCR_R1_CR3     32'hc0036021
// `define MFCR_R1_CR4     32'hc0046021
// `define MFCR_R1_CR4_B3  32'hc0646021
// `define MFCR_R1_CR5     32'hc0056021
// `define MFCR_R1_CR6     32'hc0066021
// `define MFCR_R1_CR6_B3  32'hc0666021
// `define MFCR_R1_CR7     32'hc0076021
// `define MFCR_R1_CR7_B3  32'hc0676021
// `define MFCR_R1_CR8     32'hc0086021
// `define MFCR_R1_CR8_B3  32'hc0686021
// `define MFCR_R1_CR9     32'hc0096021
// `define MFCR_R1_CR10    32'hc00a6021
// `define MFCR_R1_CR10_B3 32'hc06a6021
// `define MFCR_R1_CR11    32'hc00b6021
// `define MFCR_R1_CR12    32'hc00c6021
// `define MFCR_R1_CR13    32'hc00d6021
// `define MFCR_R1_CR14    32'hc00e6021
// `define MFCR_R1_CR14_B1 32'hc02e6021
// `define MFCR_R1_CR15    32'hc00f6021
// `define MFCR_R1_CR16    32'hc0106021
// `define MFCR_R1_CR17    32'hc0116021
// `define MFCR_R1_CR18    32'hc0126021
// `define MFCR_R1_CR19    32'hc0136021
// `define MFCR_R1_CR20    32'hc0146021
// `define MFCR_R1_CR21    32'hc0156021
//
// `define MTCR_R1_CR0     32'hc0016420
// `define MTCR_R4_CR0     32'hc0046420
// `define MTCR_R7_CR0     32'hc0076420
// `define MTCR_R7_CR0_B3  32'hc0676420
// `define MTCR_R1_CR1     32'hc0016421
// `define MTCR_R11_CR1    32'hc00b6421
// `define MTCR_R11_CR1_B1 32'hc02b6421
// `define MTCR_R11_CR1_B3 32'hc06b6421
// `define MTCR_R5_CR1_B3  32'hc0656421
// `define MTCR_R6_CR1_B3  32'hc0666421
// `define MTCR_R1_CR2     32'hc0016422
// `define MTCR_R10_CR2    32'hc00a6422
// `define MTCR_R9_CR2_B3  32'hc0696422
// `define MTCR_R9_CR2     32'hc0096422
// `define MTCR_R1_CR3     32'hc0016423
// `define MTCR_R1_CR4     32'hc0016424
// `define MTCR_R10_CR4    32'hc00a6424
// `define MTCR_R9_CR4_B3  32'hc0696424
// `define MTCR_R9_CR4     32'hc0096424
// `define MTCR_R1_CR5     32'hc0016425
// `define MTCR_R1_CR6     32'hc0016426
// `define MTCR_R9_CR6_B3  32'hc0696426
// `define MTCR_R1_CR7     32'hc0016427
// `define MTCR_R12_CR7_B3 32'hc06c6427
// `define MTCR_R1_CR8     32'hc0016428
// `define MTCR_R1_CR9     32'hc0016429
// `define MTCR_R1_CR10    32'hc001642a
// `define MTCR_R11_CR10_B3 32'hc06b642a
// `define MTCR_R1_CR11    32'hc001642b
// `define MTCR_R1_CR12    32'hc001642c
// `define MTCR_R1_CR13     32'hc001642d
// `define MTCR_R10_CR14_B1 32'hc02a642e
// `define MTCR_R12_CR14_B1 32'hc02c642e
//
// `define MTCR_R1_CR17    32'hc0016431
// `define MTCR_R13_CR19   32'hc00d6433
// `define MTCR_R1_CR31    32'hc001643f

// `define MFCR_R1_CR0     32'hc0006021
// `define MFCR_R5_CR0     32'hc0006025
// `define MFCR_R6_CR0_B3  32'hc0606026
// `define MFCR_R1_CR1     32'hc0016021
// `define MFCR_R1_CR1_B1  32'hc0216021
// `define MFCR_R1_CR1_B3  32'hc0616021
// `define MFCR_R1_CR2     32'hc0026021
// `define MFCR_R1_CR2_B3  32'hc0626021
// `define MFCR_R1_CR3     32'hc0036021
// `define MFCR_R1_CR4     32'hc0046021
// `define MFCR_R1_CR4_B3  32'hc0646021
// `define MFCR_R1_CR5     32'hc0056021
// `define MFCR_R1_CR6     32'hc0066021
// `define MFCR_R1_CR6_B3  32'hc0666021
// `define MFCR_R1_CR7     32'hc0076021
// `define MFCR_R1_CR7_B3  32'hc0676021
// `define MFCR_R1_CR8     32'hc0086021
// `define MFCR_R1_CR8_B3  32'hc0686021
// `define MFCR_R1_CR9     32'hc0096021
// `define MFCR_R1_CR10    32'hc00a6021
// `define MFCR_R1_CR10_B3 32'hc06a6021
// `define MFCR_R1_CR11    32'hc00b6021
// `define MFCR_R1_CR12    32'hc00c6021
// `define MFCR_R1_CR13    32'hc00d6021
// `define MFCR_R1_CR14    32'hc00e6021
// `define MFCR_R1_CR14_B1 32'hc02e6021
// `define MFCR_R1_CR15    32'hc00f6021
// `define MFCR_R1_CR16    32'hc0106021
// `define MFCR_R1_CR17    32'hc0116021
// `define MFCR_R1_CR18    32'hc0126021
// `define MFCR_R1_CR19    32'hc0136021
// `define MFCR_R1_CR20    32'hc0146021
// `define MFCR_R1_CR21    32'hc0156021
//
// `define MTCR_R1_CR0     32'hc0016420
// `define MTCR_R4_CR0     32'hc0046420
// `define MTCR_R7_CR0     32'hc0076420
// `define MTCR_R7_CR0_B3  32'hc0676420
// `define MTCR_R1_CR1     32'hc0016421
// `define MTCR_R11_CR1    32'hc00b6421
// `define MTCR_R11_CR1_B1 32'hc02b6421
// `define MTCR_R11_CR1_B3 32'hc06b6421
// `define MTCR_R5_CR1_B3  32'hc0656421
// `define MTCR_R6_CR1_B3  32'hc0666421
// `define MTCR_R1_CR2     32'hc0016422
// `define MTCR_R10_CR2    32'hc00a6422
// `define MTCR_R9_CR2_B3  32'hc0696422
// `define MTCR_R9_CR2     32'hc0096422
// `define MTCR_R1_CR3     32'hc0016423
// `define MTCR_R1_CR4     32'hc0016424
// `define MTCR_R10_CR4    32'hc00a6424
// `define MTCR_R9_CR4_B3  32'hc0696424
// `define MTCR_R9_CR4     32'hc0096424
// `define MTCR_R1_CR5     32'hc0016425
// `define MTCR_R1_CR6     32'hc0016426
// `define MTCR_R9_CR6_B3  32'hc0696426
// `define MTCR_R1_CR7     32'hc0016427
// `define MTCR_R12_CR7_B3 32'hc06c6427
// `define MTCR_R1_CR8     32'hc0016428
// `define MTCR_R1_CR9     32'hc0016429
// `define MTCR_R1_CR10    32'hc001642a
// `define MTCR_R11_CR10_B3 32'hc06b642a
// `define MTCR_R1_CR11    32'hc001642b
// `define MTCR_R1_CR12    32'hc001642c
// `define MTCR_R1_CR13     32'hc001642d
// `define MTCR_R10_CR14_B1 32'hc02a642e
// `define MTCR_R12_CR14_B1 32'hc02c642e
//
// `define MTCR_R1_CR17    32'hc0016431
// `define MTCR_R13_CR19   32'hc00d6433
// `define MTCR_R1_CR31    32'hc001643f

`define MRET            32'h30200073
`define SRET            32'h10200073
`define INS_DRET        32'h7b200073
`define INS_WFI         32'h10500073
`define INS_ECALL       32'h00000073

`define LW_X7_0_X6      32'h00032383
`define LW_X7_4_X6      32'h00432383
`define LW_X7_8_X6      32'h00832383
`define LW_X7_12_X6     32'h00C32383
`define LW_X7_16_X6     32'h01032383
`define LW_X7_24_X6     32'h01832383
`define LW_X7_64_X6     32'h04032383
`define LW_X7_0_X8      32'h00042383
`define LW_X7_64_X8     32'h04042383
`define SW_X7_0_X6      32'h00732023
`define SW_X7_8_X6      32'h00732423
`define SW_X7_16_X6     32'h00732823
`define SW_X7_24_X6     32'h00732c23

`define LD_X7_0_X6      32'h00033383
`define LD_X7_8_X6      32'h00833383
`define LD_X7_16_X6     32'h01033383
`define LD_X7_24_X6     32'h01833383
`define SD_X7_0_X6      32'h00733023
`define SD_X7_8_X6      32'h00733423
`define SD_X7_16_X6     32'h00733823
`define SD_X7_24_X6     32'h00733c23

`define LUI_T0_4        32'h000042b7
`define LW_X0_0_T0      32'h0002a003


//-----------------------------------------------
//define the DEBUG registers

//-------------------------------------------------
`define DTM_BYPASS  5'h0
`define DTM_IDCODE  5'h01
`define DTM_DMIACC  5'h02
`define DTM_DTMCS   5'h10
`define DTM_DMI     5'h11
`define DTM_BYPASS1 5'h1f
`define DTM_DTMCS_ABIT    5'd10
`define DTM_DTMCS_VERSION 4'd1

`define DMI_NOP   2'b00
`define DMI_READ  2'b01
`define DMI_WRITE 2'b10

//Data0-11        0x04-0x0f	Abstract data
//dmcontrol	    0x10	Debug module control
//dmstatus	    0x11	Debug module status
//hartinfo	    0x12	Harts information
//hawindow	    0x15	Hart array window
//abstractcs	    0x16	Abstract command control and status
//command	        0x17	Abstract command
//Abstractauto	0x18	Abstract command autoexec
//nextdm	        0x1d	Next debug module base address
//Progbuf0-15	    0x20-0x2f	Program buffer
//Dmcs2	        0x32	Debug module control and status 2
//Sbcs	        0x38	System bus access control and status
//Sbaddress0	    0x39	System bus access address 0
//Sbaddress1	    0x3a	System bus access address 1
//Sbdata0	        0x3c	System bus access data 0
//Sbdata1	        0x3d	System bus access data 1
//Sbdata2	        0x3e	System bus access data 2
//Sbdata3	        0x3f	System bus access data 3
//Haltsum0	    0x40	Halts summary 0
`define DM_DATA0          10'h4
`define DM_DATA1          10'h5
`define DM_DATA2          10'h6
`define DM_DATA3          10'h7
`define DM_DATA4          10'h8
`define DM_DATA5          10'h9
`define DM_DATA6          10'ha
`define DM_DATA7          10'hb
`define DM_DATA8          10'hc
`define DM_DATA9          10'hd
`define DM_DATA10         10'he
`define DM_DATA11         10'hf
`define DM_DMCONTROL      10'h10
`define DM_DMSTATUS       10'h11
`define DM_HARTINFO       10'h12
`define DM_HAWINDOWSEL       10'h14
`define DM_HAWINDOW       10'h15
`define DM_ABSTRACTCS     10'h16
`define DM_COMMAND        10'h17
`define DM_ABSTRACTAUTO   10'h18
`define DM_NEXTDM         10'h1d
`define DM_PROGBUF0        10'h20
`define DM_PROGBUF1        10'h21
`define DM_PROGBUF2        10'h22
`define DM_PROGBUF3        10'h23
`define DM_PROGBUF4        10'h24
`define DM_PROGBUF5        10'h25
`define DM_PROGBUF6        10'h26
`define DM_PROGBUF7        10'h27
`define DM_PROGBUF8        10'h28
`define DM_PROGBUF9        10'h29
`define DM_PROGBUF10       10'h2a
`define DM_PROGBUF11       10'h2b
`define DM_PROGBUF12       10'h2c
`define DM_PROGBUF13       10'h2d
`define DM_PROGBUF14       10'h2e
`define DM_PROGBUF15       10'h2f
`define DM_DMCS2          10'h32
`define DM_SBCS           10'h38
`define DM_SBADDRESS0     10'h39
`define DM_SBADDRESS1     10'h3a
`define DM_SBADDRESS2     10'h3b
`define DM_SBADDRESS3     10'h37
`define DM_SBDATA0        10'h3c
`define DM_SBDATA1        10'h3d
`define DM_SBDATA2        10'h3e
`define DM_SBDATA3        10'h3f
`define DM_HALTSUM0       10'h40
`define DM_ITR            10'h1f
`define DM_CUSTOMCS       10'h70
`define DM_CUSTOMCMD      10'h71
`define DM_CUSTOMBUF0     10'h72
`define DM_CUSTOMBUF1     10'h73
`define DM_CUSTOMBUF2     10'h74
`define DM_CUSTOMBUF3     10'h75
`define DM_CUSTOMBUF4     10'h76
`define DM_CUSTOMBUF5     10'h77
`define DM_CUSTOMBUF6     10'h78
`define DM_CUSTOMBUF7     10'h79
`define DM_COMPID         10'h7f

`define REG_CSR           2'd0
`define REG_GPR           2'd1
`define REG_FPR           2'd2

import "DPI-C" function void update_isa_trigger_csr(int tselect, int csr_num, longint csr_data);
//----------------------------------------------------

//jtag reset, for example: jtag_rst(100)
task jtag_rst;
input[31:0] rst_cycle;
integer i;
begin
  //$display("%0t jtag reset starts", $time);
  force `jtag_trst_b = 1'b1;
  if (`jtag2_sel)
    force `jtag_tms_i = 1'b1;
  else
    force `jtag_tms_i  = 1'b0;
  //wait until posedge tclk
  @(negedge `jtag_tclk);
  force `jtag_trst_b = 1'b0;

  //wait for user specified cycles
  for(i=0; i<rst_cycle; i=i+1)
    @(negedge `jtag_tclk);
  force `jtag_trst_b = 1'b1;

  //drive TAP state machine into IDLE state
  @(negedge `jtag_tclk);
  @(negedge `jtag_tclk);
  if (`jtag2_sel)
    force `jtag_tms_i = 1'b1;
  else
    force `jtag_tms_i = 1'b0;

  //$display("%0t jtag reset is done", $time);
end
endtask

//write IR
task write_ir;
input [4:0] ir_value;
input [2:0] idle_cycles;
integer i;
reg  parity;
begin
  //$display("%0t jtag shift_ir[%0h] starts...", $time, ir_value);
  if (`jtag2_sel) begin
    //=================================================
    // JTAG_2 interface Driver
    parity = 1'b1;
    @(negedge `jtag_tclk); // start
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // read/write
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // RS[0]
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // RS[1]
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk);
    for(i=0; i<5; i=i+1)begin
      force `jtag_tms_i = ir_value[i];
      parity = parity ^ ir_value[i];
      @(negedge `jtag_tclk); // Shift IR
    end
    force `jtag_tms_i = parity;
    @(negedge `jtag_tclk); // Parity
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // IDLE
  end
  else begin
    //=================================================
    // JTAG_5 interface Driver
    @(negedge `jtag_tclk); //drive to Select DR Scan
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); //drive to Select IR Scan
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); //drive to Capture IR
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); //drive to Shift IR
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk);
    for(i=0;i<4;i=i+1)begin
      force `jtag_tms_i = 1'b0;
      force `jtag_tdi = ir_value[i];
      @(negedge `jtag_tclk); //stay at Shift IR cycle
    end
    force `jtag_tms_i = 1'b1; //stay at Shift IR cycle 8,drive to EXIT IR
    force `jtag_tdi = ir_value[4];
    @(negedge `jtag_tclk); //drive to Update IR
    force `jtag_tms_i = 1'b1;
    for(i=0;i<idle_cycles;i=i+1)begin
      @(negedge `jtag_tclk); //drive to IDLE
      force `jtag_tms_i = 1'b0;
    end
  end
  //$display("%0t jtag shift_ir ends", $time);
//=================================================
end
endtask

//shift DR
//TODO: update jtag2 logic
task shift_dr;
input  [8:0]   jtag_data_len;
output [63:0]  jtag_data_out;
input  [63:0]  jtag_data_in;
input [2:0]    idle_cycles;
reg [63:0]     jtag_data_out;
reg [2:0]      idle_cycles;
integer i;
reg  parity;
begin
  //$display("%0t jtag shift_dr starts...", $time);
  jtag_data_out = 64'b0;
  if (`jtag2_sel) begin
    //==================================================
    // JTAG_2 interface driver
    parity = 1'b1;
    @(negedge `jtag_tclk); // start
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // read/write
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // RS[0]
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // RS[1]
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(posedge `jtag_tclk);
    @(posedge `jtag_tclk); // Sync cycle
    for(i=0; i<32; i=i+1)begin
      @(posedge `jtag_tclk); // Shift DR
      // jtag_data_out[i] = `jtag_tms_o;
    end
    @(posedge `jtag_tclk); // Parity
    // parity = `jtag_tms_o;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // to IDLE
    force `jtag_tms_i = 1'b1;
  end
  else begin
    //==================================================
    // JTAG_5 interface driver
    @(negedge `jtag_tclk); //drive to Select DR Scan
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); //drive to Capture DR
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); //drive to Shift DR
    force `jtag_tms_i = 1'b0;
    for(i=0;i<jtag_data_len-1;i=i+1)begin
      @(negedge `jtag_tclk); //stay at Shift DR cycle i
      force `jtag_tms_i = 1'b0;
      force `jtag_tdi = jtag_data_in[i];
      @(posedge `jtag_tclk);
      jtag_data_out[i] = `jtag_tdo;
    end
    @(negedge `jtag_tclk); //stay at Shift DR last cycle
    force `jtag_tms_i = 1'b1;
    @(posedge `jtag_tclk);
    jtag_data_out[i] = `jtag_tdo;
    @(negedge `jtag_tclk); //drive to Update DR
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); //drive to IDLE
    force `jtag_tms_i = 1'b0;
    for(i=0;i<idle_cycles;i=i+1)begin
      @(negedge `jtag_tclk); //drive to IDLE
      force `jtag_tms_i = 1'b0;
    end
  end
//==================================================
  //$display("%0t jtag shift_dr ends with jtag_data_len[%0h], jtag_data_in[%0h], jtag_data_out[%0h]", $time, jtag_data_len, jtag_data_in, jtag_data_out);
end
endtask

//this task wait cpu0's retire_pc equal expected
task wait_pc_core0(input bit[39:0] retire_pc);
  wait(`core0_cpu_retire_pc == retire_pc);
endtask: wait_pc_core0

task wait_mstatus();
  wait(`mstatus[3] == 1'b1);
endtask: wait_mstatus;

//this task trigger testbench error finish
//TODO: check why it doesn't work
task trigger_tb_error_finish();
//  force `core0_cpu_retire_pc = `__fail;
//  force `core0_cpu_retire0 = 1'b1;
endtask: trigger_tb_error_finish

//this task trigger testbench pass finish
task trigger_tb_pass_finish();
//  force `core0_cpu_retire_pc = `__exit;
//  force `core0_cpu_retire0 = 1'b1;
endtask: trigger_tb_pass_finish

//this task trigger testbench pass finish
task trigger_tb_bypass_finish();
//  force `core0_cpu_retire_pc = `__exit;
//  force `core0_cpu_retire0 = 1'b1;
endtask: trigger_tb_bypass_finish

// task trigger_mt_int();
//   force `s_lpmd_mt_int=1'b1;
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   force `s_lpmd_mt_int=1'b0;
// endtask: trigger_mt_int
// task trigger_me_int();
//   force `s_lpmd_me_int=1'b1;
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   force `s_lpmd_me_int=1'b0;
// endtask: trigger_me_int
// task trigger_ms_int();
//   force `s_lpmd_ms_int=1'b1;
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   force `s_lpmd_ms_int=1'b0;
// endtask: trigger_ms_int

// task trigger_st_int();
//   force `s_lpmd_st_int=1'b1;
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   force `s_lpmd_st_int=1'b0;
// endtask: trigger_st_int
// task trigger_se_int();
//   force `s_lpmd_se_int=1'b1;
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   force `s_lpmd_se_int=1'b0;
// endtask: trigger_se_int
// task trigger_ss_int();
//   force `s_lpmd_ss_int=1'b1;
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   @(posedge `cpuclk);
//   force `s_lpmd_ss_int=1'b0;
// endtask: trigger_ss_int

// task force_all_interrupt();
//   force `s_lpmd_mt_int  = 1'b1;
//   force `s_lpmd_me_int  = 1'b1;
//   force `s_lpmd_ms_int  = 1'b1;
//   // force `s_lpmd_st_int  = 1'b1;
//   // force `s_lpmd_se_int  = 1'b1;
//   // force `s_lpmd_ss_int  = 1'b1;
// endtask: force_all_interrupt
// 
// task release_all_interrupt();
//   release `s_lpmd_mt_int;
//   release `s_lpmd_me_int;
//   release `s_lpmd_ms_int;
//   // release `s_lpmd_st_int;
//   // release `s_lpmd_se_int;
//   // release `s_lpmd_ss_int;
// endtask: release_all_interrupt



class instruction;
  rand bit[31:0] opcode;
  string name;
  function new();
  endfunction: new

  function display();
    $display("%s, opcode: %b", this.name, this.opcode);
  endfunction: display
endclass: instruction

`define INS_INSTANCE(ins) \
``ins`` ``ins``_inst;

instruction ins_queue[string];
function void push_ins_type(string ins_name, instruction ins_type);
  ins_queue[ins_name] = ins_type;
endfunction: push_ins_type

class ins_auipc extends instruction;

  constraint op {
    /*  solve order constraints  */
  
    /*  rand variable constraints  */
    this.opcode[6:0] == 7'b0010111;
    
  }

  function new();
    super.new();
    this.name="ins_auipc";
  endfunction: new
endclass: ins_auipc
`INS_INSTANCE(ins_auipc)

class ins_branch extends instruction;

  constraint op {
    /*  solve order constraints  */
  
    /*  rand variable constraints  */
    this.opcode[6:0] == 7'b1100011;
    this.opcode[14:12] inside {3'b000, 3'b101, 3'b111, 3'b100, 3'b110, 3'b001};
    
  }

  function new();
    super.new();
    this.name="ins_branch";
  endfunction: new
endclass: ins_branch
`INS_INSTANCE(ins_branch)
class ins_jump extends instruction;

  constraint op {
    /*  solve order constraints  */
  
    /*  rand variable constraints  */
    this.opcode[6:0] inside {7'b1101111, 7'b1100111};
    if (this.opcode[6:0] == 7'b1100111) {
      this.opcode[14:12] == 3'b000;
    }
    
  }

  function new();
    super.new();
    this.name="ins_jump";
  endfunction: new
endclass: ins_jump
`INS_INSTANCE(ins_jump)


class ins_cjump extends instruction;

  constraint op {
    /*  solve order constraints  */
  
    /*  rand variable constraints  */
    this.opcode[31:16] == 16'b0;
    this.opcode[1:0] == 2'b10;
    this.opcode[6:2] == 5'b00000;
    this.opcode[15:13] == 3'b100;
  }

  function new();
    super.new();
    this.name="ins_cjump";
  endfunction: new
endclass: ins_cjump
`INS_INSTANCE(ins_cjump)

class ins_cj extends instruction;

  constraint op {
    /*  solve order constraints  */
  
    /*  rand variable constraints  */
    this.opcode[31:16] == 16'b0;
    this.opcode[1:0] == 2'b01;
    this.opcode[15:13] == 3'b101;
  }

  function new();
    super.new();
    this.name="ins_cj";
  endfunction: new
endclass: ins_cj
`INS_INSTANCE(ins_cj)


//ext_debug encapsulate all functions/tasks to access DTM with jtag interface
class ext_debug;

  bit[7:0] dtm_reg_jtaglen_map[bit[4:0]];
  bit[2:0] dtm_dtmcs_idle;
  bit[5:0] dtm_dtmcs_abits;
  bit[2:0] idle_cycle_num;
  bit[3:0] dtm_dtmcs_version;
  int      part_num = 0;
  int      max_poll_round_num;
`ifdef TDT_DM_PB_SIZE
  bit[31:0] progbuf_list[`TDT_DM_PB_SIZE];
`else
  bit[31:0] progbuf_list[2];
`endif

  //abscmd register number base
  bit[15:0] abscmd_regno_base_map[bit[1:0]];

  int error_num = 0;


  extern function new(string name);

  extern task initDTM();

  extern task automatic rwDTMReg(bit[4:0] address, output longint rd_value, input longint wr_value, output bit error);
  extern task automatic rwMemorybyDMI(inout bit[1:0] op, inout bit[`DTM_DTMCS_ABIT-1:0] address, inout int data, output bit error);
  extern task rwMemorybyDMIwithCheck(input bit[1:0] op, input bit[`DTM_DTMCS_ABIT-1:0] address, inout int data , output bit error);

  extern task automatic readDebugReg(input int hartId, input int regId, output int value, output int error);
  extern task automatic writeDebugReg(input int hartId, input int regId, int value, output int error);

  extern function automatic void part_start(string description);

  // hart wait info
  extern task wait_pc_hart0(input bit[39:0] retire_pc);
  // wait next retire, return retire pc & retire instruction number
  extern task wait_retire_hart0(output bit[39:0] retire_pc, output int retire_num);

  extern function void tb_info(string msg);
  extern function void tb_error(string msg);
  extern task tb_fatal(string msg);

  extern task trigger_tb_error_finish();
  extern task trigger_tb_pass_finish();
  extern task trigger_tb_bypass_finish(); 


  // hart0 running control
  extern task hart0_async_halt_req();
  extern task hart0_sync_halt_req();
  extern task hart0_resume();
  extern task hart0_resume_without_check();
  //hart select
  extern task select_hart(bit[19:0] hart_id);
  //register access
  //rw=0-read,1-write
  //regno: 0x0000-0x0fff csr
  //       0x1000-0x101f gpr
  //       0x1020-0x103f fpr
  //data:  if rv32, data[63:32] = 32'b0
  extern task write_register_by_abscmd(bit[1:0] reg_type, bit[15:0] reg_id, input bit[31:0] data_high, input bit[31:0] data_low, output bit[2:0] cmderr);
  extern task read_register_by_abscmd(bit[1:0] reg_type, bit[15:0] reg_id, output bit[31:0] data_high, output bit[31:0] data_low, output bit[2:0] cmderr);
  extern task access_register_by_abscmd(bit[2:0] aarsize, bit aarpostincrement, bit postexec, bit transfer, bit write, bit[15:0] regno, output bit[2:0] cmderr);
  extern task access_abscmd_data(bit rw, int data_id, inout bit[31:0] value, output bit error);

  //system bus access
  extern task access_memory_by_sb(bit[2:0] sbaccess, bit sbreadonaddr=0, bit sbreadondata=0, bit sbautoincrement=0, output bit[2:0] sberror);
  extern task access_memory_by_sb_poll_busy(output bit[2:0] sberror);
  extern task access_sb_address(bit rw, int sbadd_id, inout bit[31:0] address);
  extern task access_sb_data(bit rw, int sbdata_id, inout bit[31:0] data);

  //pb
  extern task execute_pb(output bit[2:0] cmderr);
  extern task execute_pb_without_check();
  extern task write_word_by_pb(bit[63:0] address, bit[31:0] value);
  extern task read_word_by_pb(bit[63:0] address, output bit[31:0] value);
  extern task write_block_by_pb(bit[63:0] address, int block_size, bit[31:0] value[$]);
  extern task read_block_by_pb(bit[63:0] address, int block_size, output bit[31:0] value[$]);
  extern task access_progbuf(bit rw, int id, inout bit[31:0] value, output bit error);

  extern task read_word_by_pb_without_fatal(bit[63:0] address, output bit[31:0] value, output bit[2:0] cmderr);
  extern task write_word_by_pb_without_fatal(bit[63:0] address, bit[31:0] value, output bit[2:0] cmderr);

  //itr
  extern task execute_itr(input bit[31:0] itr, output bit[2:0] cmderr);
  extern task execute_itr_without_check(input bit[31:0] itr);
  //custom
  extern task hart0_pc_sample(output bit[63:0] pc, bit[2:0] cmderr);
  extern task hart0_debuginfo(output bit[63:0] info, bit[2:0] cmderr);

endclass : ext_debug

class pb_opcodes;
    bit[31:0] opcodes[];

    function new();

    endfunction: new
endclass: pb_opcodes

// execute jtag reset logic
function ext_debug::new(string name);
    this.dtm_reg_jtaglen_map[`DTM_BYPASS] = 8'd32;
    this.dtm_reg_jtaglen_map[`DTM_IDCODE] = 8'd32;
    this.dtm_reg_jtaglen_map[`DTM_DTMCS] = 8'd32;
    this.dtm_reg_jtaglen_map[`DTM_BYPASS1] = 8'd32;
    //TODO: update address
    this.dtm_reg_jtaglen_map[`DTM_DMI] = `DTM_DTMCS_ABIT + 34;
    this.dtm_reg_jtaglen_map[`DTM_DMIACC] = 8'd1;
    this.idle_cycle_num = 3'b1;
    this.max_poll_round_num = 32'd30;

    //abscmd regno base map
    this.abscmd_regno_base_map[`REG_CSR] = 16'h0;
    this.abscmd_regno_base_map[`REG_GPR] = 16'h1000;
    this.abscmd_regno_base_map[`REG_FPR] = 16'h1020;

    //progbuf_list initilization
    foreach (this.progbuf_list[i]) begin
      this.progbuf_list[i] = `EBREAK;
    end

endfunction: new

task ext_debug::initDTM();
    longint dtmcs_rd_value;
    longint dtmcs_wr_value;
    bit error;
    dtmcs_wr_value = 64'b0;

    jtag_rst(32'd10);
    this.rwDTMReg(`DTM_DTMCS, dtmcs_rd_value, dtmcs_wr_value, error);
    this.dtm_dtmcs_abits = dtmcs_rd_value[9:4];
    this.dtm_dtmcs_version = dtmcs_rd_value[3:0];
    if (this.dtm_dtmcs_abits != `DTM_DTMCS_ABIT) begin
        this.tb_fatal($sformatf("error: dtm.dtmcs.abits[0x%h] != hardware abit[0x%h]", this.dtm_dtmcs_abits, `DTM_DTMCS_ABIT));
    end
    if (this.dtm_dtmcs_version != `DTM_DTMCS_VERSION) begin
        this.tb_fatal($sformatf("error: dtm.dtmcs.version[0x%h] != hardware version[0x%h]", this.dtm_dtmcs_version, `DTM_DTMCS_VERSION));
    end
    this.idle_cycle_num = dtmcs_rd_value[14:12];
    //TODO: check idle_cycle_num equals expected
endtask: initDTM

// rwDTMReg steps:
// write_ir(DTM_REG_ID, temp) to select IR
// write_dr(value) to write value to the register
task ext_debug::rwDTMReg(bit[4:0] address, output longint rd_value, input longint wr_value, output bit error);
    bit[7:0] jtag_data_len;
    write_ir(address, 3'd0);
    jtag_data_len = this.dtm_reg_jtaglen_map[address];
    shift_dr(jtag_data_len, rd_value, wr_value, this.idle_cycle_num);
    error = 1'b0;
    //$display("jtag_drv::rwDTMReg: address[%0h], rd_value[%0h], wr_value[%0h], error[%0h] @%t", address, rd_value, wr_value, error, $time);
endtask: rwDTMReg

// steps:
// op: 0-nop, 1-read from address, 2-write from address, 3-reserved
// res_op: 0-success of previous op 1-reserved 2-previous op failed 3-previous
// op is progress when new one comes
task ext_debug::rwMemorybyDMI(inout bit[1:0] op, inout bit[`DTM_DTMCS_ABIT-1:0] address, inout int data, output bit error);
  bit[`DTM_DTMCS_ABIT+33:0] rd_value, wr_value;
  bit[1:0] wr_op = op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address = address;
  int wr_data = data;

  wr_value = {dmi_address, wr_data, wr_op};
  this.rwDTMReg(`DTM_DMI, rd_value, wr_value, error);
  op = rd_value[1:0];
  data = rd_value[33:2];
  address = rd_value[`DTM_DTMCS_ABIT-1:0];

  if (rd_value[1:0] == 2'd2)
      error = 1;
  else
      error = 0;
  //$display("jtag_drv::rwMemorybyDMI: wr_op[%0b], wr_address[%0h], wr_value[%0h], rd_op[%0b], rd_address[%0h], rd_value[%0h], error[%0h] @%t",
  //                        wr_op, dmi_address, wr_data, op, address, data, error, $time);
  if (error == 1'b1) begin
    this.tb_error("rwMemorybyDMI execute error");
  end
endtask: rwMemorybyDMI

//send op by dmi, and look up the return status recursively
task ext_debug::rwMemorybyDMIwithCheck(input bit[1:0] op, input bit[`DTM_DTMCS_ABIT-1:0] address, inout int data , output bit error);
  bit[1:0] exe_op = op;
  bit[`DTM_DTMCS_ABIT-1:0] exe_address = address;
  int exe_data = data;
  error = 0;

  this.rwMemorybyDMI(exe_op, exe_address, exe_data, error);
  for (int i=0; i<this.max_poll_round_num; i++) begin
    exe_op = 2'd0;
    exe_address = address;
    this.rwMemorybyDMI(exe_op, exe_address, exe_data, error);
    if ((exe_op == 2'd0) || (error == 1'b1)) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("status poll error");
    end
  end
  data = exe_data;
  this.tb_info($sformatf("rwMemmorybyDMIwithCheck:: input_op[%0h], input_address[%0h], output_data[%0h], output_error[%0b]",
   op, address, data, error));
  if (error == 1'b1) begin
    this.tb_error("rwMemorybyDMIwithCheck execute error");
  end
endtask: rwMemorybyDMIwithCheck

function void ext_debug::part_start(string description);
  this.part_num ++;
  $display("=================================================");
  $display("jtag_drv:: test part[%0h] starts: @%0t\n\t%s", this.part_num, $time, description);
endfunction: part_start

// hart wait info
task ext_debug::wait_pc_hart0(input bit[39:0] retire_pc);
  wait(`core0_cpu_retire_pc == retire_pc);
endtask: wait_pc_hart0

// wait next retire, return retire pc & retire instruction number
task ext_debug::wait_retire_hart0(output bit[39:0] retire_pc, output int retire_num);
  while (1) begin
    @(posedge `cpuclk);
    if (`core0_cpu_retire0 == 1'b1) begin
      retire_pc = `core0_cpu_retire_pc;
      retire_num = 1;
      break;
    end
  end
endtask: wait_retire_hart0

function void ext_debug::tb_info(string msg);
  msg = $sformatf("TB_INFO:: %s @ %0t", msg, $time);
  $display(msg);
endfunction: tb_info

function void ext_debug::tb_error(string msg);
  msg = $sformatf("TB_ERROR:: %s @ %0t", msg, $time);
  this.error_num ++;
  $display(msg);
endfunction: tb_error

task ext_debug::tb_fatal(string msg);
  msg = $sformatf("TB_ERROR:: %s @ %0t", msg, $time);
  $display(msg);
  wait(1ns);
  trigger_tb_error_finish();
endtask: tb_fatal

task ext_debug::trigger_tb_error_finish();
  integer FILE;
  $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
  $display("$                  Sorry, <<< CORE 0 >>> DEBUG:Simulation Failed! @_@       $");
  $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
  FILE = $fopen("run_case.report","w");    
  $fdisplay(FILE,"TEST FAIL");
  $finish;

endtask: trigger_tb_error_finish

//this task trigger testbench pass finish
task ext_debug::trigger_tb_pass_finish();
  integer FILE;
  if (this.error_num > 0) begin
    $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    $display("$                  Sorry, <<< CORE 0 >>> Simulation Failed! @_@       $");
    $display("$               You can have some tea and try again ^_^               $");
    $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    FILE = $fopen("run_case.report","w");    
    $fdisplay(FILE,"TEST FAIL");
    $finish;
  end else begin
      // exit 
    $display("#######################################################################");
    $display("#                Congratulations, Simulation PASS!                    #");
    $display("#######################################################################");
    FILE = $fopen("run_case.report","w");
    $fdisplay(FILE,"TEST PASS");
    $finish;
  end
endtask: trigger_tb_pass_finish

//this task trigger testbench pass finish
task ext_debug::trigger_tb_bypass_finish();
  integer FILE;
  if (this.error_num > 0) begin
    $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    $display("$                  Sorry, <<< CORE 0 >>> Simulation Failed! @_@       $");
    $display("$               You can have some tea and try again ^_^               $");
    $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    FILE = $fopen("run_case.report","w");    
    $fdisplay(FILE,"TEST FAIL");
    $finish;
  end else begin
      // exit 
    $display("#######################################################################");
    $display("#        This case was byPASSed because of feature not support!       #");
    $display("#######################################################################");
    FILE = $fopen("run_case.report","w");
    $fdisplay(FILE,"TEST PASS");
    $finish;
  end
endtask: trigger_tb_bypass_finish

task ext_debug::hart0_async_halt_req();
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  this.tb_info("hart0: async halt request starts...");
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_CUSTOMCMD;
  dmi_value = 32'h0; //dmcontrol.haltreq=1, dmcontrol.dmactive=1
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("customcmd set error!");
  end

  //check haltsum0
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_op = `DMI_READ;
    dmi_address = `DM_HALTSUM0;
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
    if (dmi_value==1'b1) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("haltsum0==1 poll error");
    end
  end
  //check dmstatus
  dmi_op = `DMI_READ;
  dmi_address = `DM_DMSTATUS;
  dmi_value = 32'd0;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (dmi_value[8]!=1'b1) begin
    this.tb_fatal($sformatf("dmstatus[%0h].anyhalted shoule be 1", dmi_value));
  end
  this.tb_info("hart0: async halt request succeed.");
endtask: hart0_async_halt_req

task ext_debug::hart0_sync_halt_req();
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  this.tb_info("hart0: sync halt request starts...");
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_DMCONTROL;
  dmi_value = 32'h80000001; //dmcontrol.haltreq=1, dmcontrol.dmactive=1
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (error == 1'b1) begin
      this.tb_fatal("dmcontrol set error!");
  end

  //check haltsum0
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_op = `DMI_READ;
    dmi_address = `DM_HALTSUM0;
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
    if (dmi_value==1'b1) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("haltsum0==1 poll error");
    end
  end
  //check dmstatus
  dmi_op = `DMI_READ;
  dmi_address = `DM_DMSTATUS;
  dmi_value = 32'd0;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (dmi_value[8]!=1'b1) begin
    this.tb_fatal($sformatf("dmstatus[%0h].anyhalted shoule be 1", dmi_value));
  end
  this.tb_info("hart0: sync halt request succeed.");
endtask: hart0_sync_halt_req

task ext_debug::hart0_resume();
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  this.tb_info("hart0: resume starts...");
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_DMCONTROL;
  dmi_value = 32'h40000001; //dmcontrol.resumereq=1, dmcontrol.dmactive=1
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (error == 1'b1) begin
      this.tb_fatal("dmcontrol set error!");
  end

  //check dmstatus.anyresumeack
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_op = `DMI_READ;
    dmi_address = `DM_DMSTATUS;
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
    if (dmi_value[16]==1'b1 || dmi_value[17]==1'b1) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("status poll error");
    end
  end
  this.tb_info("hart0: resume succeed.");
endtask: hart0_resume

task ext_debug::hart0_resume_without_check();
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_DMCONTROL;
  dmi_value = 32'h40000001; //dmcontrol.resumereq=1, dmcontrol.dmactive=1
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (error == 1'b1) begin
      this.tb_fatal("dmcontrol set error!");
  end
  this.tb_info("hart0: send resume request.");
endtask: hart0_resume_without_check


task ext_debug::write_register_by_abscmd(bit[1:0] reg_type, bit[15:0] reg_id, input bit[31:0] data_high, input bit[31:0] data_low, output bit[2:0] cmderr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[15:0] regno;
  regno = reg_id +  this.abscmd_regno_base_map[reg_type];
  //write data0, data1=gpr_idx
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_DATA0;
  dmi_value = data_low;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
`ifdef TDT_DM_CORE_RV64
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_DATA1;
  dmi_value = data_high;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
`endif
  //command.aarsize=3, transfer=1, write=1, regno=0x1008+gpr_idx
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_COMMAND;
  dmi_value = 32'd0;
  dmi_value[31:24] = 8'd0; //cmdtype
  //aarsize
`ifdef TDT_DM_CORE_RV64
  dmi_value[22:20] = 3'd3;
`else
  dmi_value[22:20] = 3'd2;
`endif
  dmi_value[19] = 1'b0; //aarpostincrement
  dmi_value[18] = 1'b0; //postexec
  dmi_value[17] = 1'b1; //transfer
  dmi_value[16] = 1'b1; //write
  dmi_value[15:0] = regno; //regno
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  //check abstractcs.busy and abstractcs.cmderr
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_op = `DMI_READ;
    dmi_address = `DM_ABSTRACTCS;
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
    if (dmi_value[12]==1'b0) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("status poll error");
    end
  end
  cmderr = dmi_value[10:8];
  if (dmi_value[10:8] != 3'd0)  begin
      this.tb_info($sformatf("warning:cmderr[%0h] != 0", dmi_value[10:8]));
  end
  this.tb_info($sformatf("write_register_by_abscmd:: regno[%0h], data_high[%0h], data_low[%0h], cmderr[%0h]", regno, data_high, data_low, cmderr));
endtask: write_register_by_abscmd

task ext_debug::read_register_by_abscmd(bit[1:0] reg_type, bit[15:0] reg_id, output bit[31:0] data_high, output bit[31:0] data_low, output bit[2:0] cmderr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[15:0] regno;
  regno = reg_id +  this.abscmd_regno_base_map[reg_type];
  //command.aarsize=3, transfer=1, write=0, regno=0x1008+gpr_idx
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_COMMAND;
  dmi_value = 32'd0;
  dmi_value[31:24] = 8'd0; //cmdtype
  //aarsize
`ifdef TDT_DM_CORE_RV64
  dmi_value[22:20] = 3'd3;
`else
  dmi_value[22:20] = 3'd2;
`endif
  dmi_value[19] = 1'b0; //aarpostincrement
  dmi_value[18] = 1'b0; //postexec
  dmi_value[17] = 1'b1; //transfer
  dmi_value[16] = 1'b0; //write
  dmi_value[15:0] = regno; //regno
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  //check abstractcs.busy and abstractcs.cmderr
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_op = `DMI_READ;
    dmi_address = `DM_ABSTRACTCS;
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
    if (dmi_value[12]==1'b0) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("status poll error");
    end
  end
  cmderr = dmi_value[10:8];
  if (dmi_value[10:8] != 3'd0)  begin
      this.tb_info($sformatf("warning:cmderr[%0h] != 0", dmi_value[10:8]));
  end
  //read data0
  dmi_value = 32'd0;
  dmi_op = `DMI_READ;
  dmi_address = `DM_DATA0;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  data_low = dmi_value;
`ifdef TDT_DM_CORE_RV64
  dmi_op = `DMI_READ;
  dmi_address = `DM_DATA1;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  data_high = dmi_value;
`else
  data_high = 32'd0;
`endif
  this.tb_info($sformatf("read_register_by_abscmd:: regno[%0h], data_high[%0h], data_low[%0h], cmderr[%0h]", regno, data_high, data_low, cmderr));
endtask: read_register_by_abscmd

task ext_debug::access_register_by_abscmd(bit[2:0] aarsize, bit aarpostincrement, bit postexec, bit transfer, bit write, bit[15:0] regno, output bit[2:0] cmderr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_COMMAND;
  dmi_value = 32'd0;
  dmi_value[31:24] = 8'd0; //cmdtype
  //aarsize
  dmi_value[22:20] = aarsize;
  dmi_value[19] = aarpostincrement; //aarpostincrement
  dmi_value[18] = postexec; //postexec
  dmi_value[17] = transfer; //transfer
  dmi_value[16] = write; //write
  dmi_value[15:0] = regno; //regno
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  //check abstractcs.busy and abstractcs.cmderr
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_op = `DMI_READ;
    dmi_address = `DM_ABSTRACTCS;
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
    if (dmi_value[12]==1'b0) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("status poll error");
    end
  end
  cmderr = dmi_value[10:8];
  if (dmi_value[10:8] != 3'd0)  begin
      this.tb_info($sformatf("warning:cmderr[%0h] != 0", dmi_value[10:8]));
  end
  this.tb_info($sformatf("access_register_by_abscmd:: regno[%0h], cmderr[%0h], aarsize[%0h], aarpostincrement[%0h], postexec[%0h], transfer[%0h], write[%0h]",
   regno, cmderr, aarsize, aarpostincrement, postexec, transfer, write));
endtask: access_register_by_abscmd

task ext_debug::access_abscmd_data(bit rw, int data_id, inout bit[31:0] value, output bit error);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  //write data0, data1=gpr_idx
  if (rw==0) begin
    dmi_op = `DMI_READ;
  end else begin
    dmi_op = `DMI_WRITE;
  end
  case (data_id)
    32'd0: dmi_address = `DM_DATA0; 
    32'd1: dmi_address = `DM_DATA1; 
    32'd2: dmi_address = `DM_DATA2; 
    32'd3: dmi_address = `DM_DATA3; 
    32'd4: dmi_address = `DM_DATA4; 
    32'd5: dmi_address = `DM_DATA5; 
    32'd6: dmi_address = `DM_DATA6; 
    32'd7: dmi_address = `DM_DATA7; 
    32'd8: dmi_address = `DM_DATA8; 
    32'd9: dmi_address = `DM_DATA9; 
    32'd10: dmi_address = `DM_DATA10; 
    32'd11: dmi_address = `DM_DATA11; 
    default: dmi_address = `DM_DATA0;
  endcase
  dmi_value = value;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (rw==0) begin
    value = dmi_value;
  end
  this.tb_info($sformatf("access_abscmd_data:: rw[%0h], data_id[%0h], value[%0h], error[%0h]", rw, data_id, value, error));
endtask: access_abscmd_data

task ext_debug::access_progbuf(bit rw, int id, inout bit[31:0] value, output bit error);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  //write data0, data1=gpr_idx
  if (rw==0) begin
    dmi_op = `DMI_READ;
  end else begin
    dmi_op = `DMI_WRITE;
  end
  case (id)
    32'd0: dmi_address = `DM_PROGBUF0; 
    32'd1: dmi_address = `DM_PROGBUF1; 
    32'd2: dmi_address = `DM_PROGBUF2; 
    32'd3: dmi_address = `DM_PROGBUF3; 
    32'd4: dmi_address = `DM_PROGBUF4; 
    32'd5: dmi_address = `DM_PROGBUF5; 
    32'd6: dmi_address = `DM_PROGBUF6; 
    32'd7: dmi_address = `DM_PROGBUF7; 
    32'd8: dmi_address = `DM_PROGBUF8; 
    32'd9: dmi_address = `DM_PROGBUF9; 
    32'd10: dmi_address = `DM_PROGBUF10; 
    32'd11: dmi_address = `DM_PROGBUF11; 
    32'd12: dmi_address = `DM_PROGBUF12; 
    32'd13: dmi_address = `DM_PROGBUF13; 
    32'd14: dmi_address = `DM_PROGBUF14; 
    32'd15: dmi_address = `DM_PROGBUF15; 
    default: dmi_address = `DM_PROGBUF0;
  endcase
  dmi_value = value;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (rw==0) begin
    value = dmi_value;
  end
  this.tb_info($sformatf("access_progbuf:: rw[%0h], id[%0h], value[%0h], error[%0h]", rw, id, value, error));
endtask: access_progbuf

task ext_debug::access_memory_by_sb(bit[2:0] sbaccess, bit sbreadonaddr=0, bit sbreadondata=0, bit sbautoincrement=0, output bit[2:0] sberror);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit sbbusy;
  dmi_op = `DMI_WRITE;
  dmi_address = `DM_SBCS;
  dmi_value = 32'd0;
  dmi_value[19:17] = sbaccess;
  dmi_value[20] = sbreadonaddr;
  dmi_value[15] = sbreadondata;
  dmi_value[16] = sbautoincrement;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  sberror = dmi_value[14:12];
  if (sberror != 3'd0)  begin
      this.tb_info($sformatf("warning:sberror[%0h] != 0", sberror));
  end
  this.tb_info($sformatf("access_memory_by_sb:: sbversion[%0h], sbbusyerror[%0h], sbbusy[%0h], sbreadonaddr[%0h], sbaccess[%0h], sbautoincrement[%0h], sbreadondata[%0h], sberror[%0h], sbasize[%0h], sbaccess128[%0h], sbaccess64[%0h], sbaccess32[%0h], sbaccess16[%0h], sbaccess8[%0h]",
   dmi_value[31:29], dmi_value[22], dmi_value[21], dmi_value[20], dmi_value[19:17], dmi_value[16], dmi_value[15], dmi_value[14:12], dmi_value[11:5], dmi_value[4], dmi_value[3], dmi_value[2], dmi_value[1], dmi_value[0]));
endtask: access_memory_by_sb

task ext_debug::access_memory_by_sb_poll_busy(output bit[2:0] sberror);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit sbbusy;
  //check busy
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_op = `DMI_READ;
    dmi_address = `DM_SBCS;
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
    sbbusy = dmi_value[21];
    if (sbbusy==1'b0) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("status poll error");
    end
  end
  sberror = dmi_value[14:12];
  if (sberror != 3'd0)  begin
      this.tb_info($sformatf("warning:sberror[%0h] != 0", sberror));
  end
  this.tb_info($sformatf("access_memory_by_sb_poll_busy:: sbversion[%0h], sbbusyerror[%0h], sbbusy[%0h], sbreadonaddr[%0h], sbaccess[%0h], sbautoincrement[%0h], sbreadondata[%0h], sberror[%0h], sbasize[%0h], sbaccess128[%0h], sbaccess64[%0h], sbaccess32[%0h], sbaccess16[%0h], sbaccess8[%0h]",
   dmi_value[31:29], dmi_value[22], dmi_value[21], dmi_value[20], dmi_value[19:17], dmi_value[16], dmi_value[15], dmi_value[14:12], dmi_value[11:5], dmi_value[4], dmi_value[3], dmi_value[2], dmi_value[1], dmi_value[0]));
endtask: access_memory_by_sb_poll_busy

task ext_debug::access_sb_address(bit rw, int sbadd_id, inout bit[31:0] address);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  //write data0, data1=gpr_idx
  if (rw==0) begin
    dmi_op = `DMI_READ;
  end else begin
    dmi_op = `DMI_WRITE;
  end
  case (sbadd_id)
    32'd0: dmi_address = `DM_SBADDRESS0; 
    32'd1: dmi_address = `DM_SBADDRESS1; 
    32'd2: dmi_address = `DM_SBADDRESS2; 
    32'd3: dmi_address = `DM_SBADDRESS3; 
    default: dmi_address = `DM_SBADDRESS0;
  endcase
  dmi_value = address;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (rw==0) begin
    address = dmi_value;
  end
  this.tb_info($sformatf("access_sb_address:: rw[%0h], sbadd_id[%0h], address[%0h], error[%0h]", rw, sbadd_id, address, error));
  if (error==1'b1) begin
    this.tb_error($sformatf("access_sb_address execute error"));
  end
endtask: access_sb_address

task ext_debug::access_sb_data(bit rw, int sbdata_id, inout bit[31:0] data);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  //write data0, data1=gpr_idx
  if (rw==0) begin
    dmi_op = `DMI_READ;
  end else begin
    dmi_op = `DMI_WRITE;
  end
  case (sbdata_id)
    32'd0: dmi_address = `DM_SBDATA0; 
    32'd1: dmi_address = `DM_SBDATA1; 
    32'd2: dmi_address = `DM_SBDATA2; 
    32'd3: dmi_address = `DM_SBDATA3; 
    default: dmi_address = `DM_SBDATA0;
  endcase
  dmi_value = data;
  this.rwMemorybyDMIwithCheck(dmi_op, dmi_address, dmi_value, error);
  if (rw==0) begin
    data = dmi_value;
  end
  this.tb_info($sformatf("access_sb_data: rw[%0h], sbdata_id[%0h], value[%0h], error[%0h]", rw, sbdata_id, data, error));
  if (error==1'b1) begin
    this.tb_error($sformatf("access_sb_data execute error"));
  end
endtask: access_sb_data

//execute opcodes in opcodes list
task ext_debug::execute_pb(output bit[2:0] cmderr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] cmderr;
  bit[2:0] aarsize;
`ifdef TDT_DM_CORE_RV64
  aarsize=3;
`else
  aarsize=2;
`endif

  //-write program buffer
  foreach (this.progbuf_list[i]) begin
    dmi_address = `DM_PROGBUF0 + i;
    this.rwMemorybyDMIwithCheck(`DMI_WRITE, dmi_address, this.progbuf_list[i], error);
    if (error == 1'b1) begin
      this.tb_fatal($sformatf("progranbuffer%0h write[%0h] error", i, this.progbuf_list[i]));
    end
  end
  //lauch pb
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b1, 1'b0, 1'b1, 16'h1008, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_info($sformatf("warning:abscmd pb execute error with cmderr[%0h]", cmderr));
  end

endtask: execute_pb


//execute opcodes in opcodes list
task ext_debug::execute_pb_without_check();
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] cmderr;
  bit[2:0] aarsize;
`ifdef TDT_DM_CORE_RV64
  aarsize=3;
`else
  aarsize=2;
`endif

  //-write program buffer
  foreach (this.progbuf_list[i]) begin
    dmi_address = `DM_PROGBUF0 + i;
    this.rwMemorybyDMIwithCheck(`DMI_WRITE, dmi_address, this.progbuf_list[i], error);
    if (error == 1'b1) begin
      this.tb_fatal($sformatf("progranbuffer%0h write[%0h] error", i, this.progbuf_list[i]));
    end
  end
  //lauch pb
  dmi_value = 32'd0;
  dmi_value[31:24] = 8'd0; //cmdtype
  //aarsize
  dmi_value[22:20] = aarsize;
  dmi_value[19] = 1'b0; //aarpostincrement
  dmi_value[18] = 1'b1; //postexec
  dmi_value[17] = 1'b0; //transfer
  dmi_value[16] = 1'b0; //write
  dmi_value[15:0] = 16'h1008; //regno
  this.rwMemorybyDMIwithCheck(`DMI_WRITE , `DM_COMMAND, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("command set error!");
  end

endtask: execute_pb_without_check

//execute opcodes by itr
task ext_debug::execute_itr(input bit[31:0] itr, output bit[2:0] cmderr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] cmderr;
  bit[2:0] aarsize;

  //-write itr
  //lauch pb
  dmi_value = itr;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_ITR, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("itr write error");
  end
  //poll itr result
  //check abstractcs.busy and abstractcs.cmderr
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_ABSTRACTCS, dmi_value, error);
    if (dmi_value[12]==1'b0) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("status poll error");
    end
  end
  cmderr = dmi_value[10:8];
  if (cmderr != 3'd0)  begin
      this.tb_info($sformatf("warning:cmderr[%0h] != 0", dmi_value[10:8]));
  end
  this.tb_info($sformatf("itr execution:: itr[%0h], cmderr[%0h]", itr, cmderr));

endtask: execute_itr

//execute opcodes by itr
task ext_debug::execute_itr_without_check(input bit[31:0] itr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] cmderr;
  bit[2:0] aarsize;

  //-write itr
  //lauch pb
  dmi_value = itr;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_ITR, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("itr write error");
  end
  this.tb_info($sformatf("itr execution:: itr[%0h]", itr));

endtask: execute_itr_without_check

task ext_debug::hart0_pc_sample(output bit[63:0] pc, bit[2:0] cmderr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  this.tb_info("hart0: pc sample starts...");
  dmi_value = 32'h0; 
  dmi_value[31:24] = 8'd2;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_CUSTOMCMD, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("customcmd set error!");
  end

  //check customcs 
  //poll itr result
  //check abstractcs.busy and abstractcs.cmderr
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_CUSTOMCS, dmi_value, error);
    if (dmi_value[17]==1'b0) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("custombusy poll error");
    end
  end
  cmderr = dmi_value[31:29];
  if (cmderr != 3'd0)  begin
      this.tb_info($sformatf("warning:cmderr[%0h] != 0", dmi_value[10:8]));
  end

  //read back value
  dmi_value = 32'h0; 
  this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("custombuf0 read error!");
  end
  pc[31:0] = dmi_value;
`ifdef TDT_DM_CORE_RV64
  dmi_value = 32'h0; 
  this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_DATA1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("custombuf1 read error!");
  end
  pc[63:32] = dmi_value;
`else
  pc[63:32] = 32'd0;
`endif
  this.tb_info($sformatf("sample_pc=%0h", pc));
endtask: hart0_pc_sample

task ext_debug::hart0_debuginfo(output bit[63:0] info, bit[2:0] cmderr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  this.tb_info("hart0: debug info starts...");
  dmi_value = 32'h0; 
  dmi_value[31:24] = 8'd3;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_CUSTOMCMD, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("customcmd set error!");
  end

  //check customcs 
  for (int i=0; i<this.max_poll_round_num; i++) begin
    dmi_value = 32'd0;
    this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_CUSTOMCS, dmi_value, error);
    if (dmi_value[17]==1'b0) break;
    if (i == this.max_poll_round_num-1) begin
      this.tb_fatal("custombusy poll error");
    end
  end
  cmderr = dmi_value[31:29];
  if (cmderr != 3'd0)  begin
      this.tb_info($sformatf("warning:cmderr[%0h] != 0", dmi_value[10:8]));
  end

  //read back value
  dmi_value = 32'h0; 
  this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 read error!");
  end
  info[31:0] = dmi_value;
`ifdef TDT_DM_CORE_RV64
  dmi_value = 32'h0; 
  this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_DATA1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data1 read error!");
  end
  info[63:32] = dmi_value;
`else
  info[63:32] = 32'd0;
`endif
  this.tb_info($sformatf("debug_info=%0h", info));
endtask: hart0_debuginfo

task ext_debug::read_word_by_pb_without_fatal(bit[63:0] address, output bit[31:0] value, output bit[2:0] cmderr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] aarsize;
`ifdef TDT_DM_CORE_RV64
  aarsize=3;
`else
  aarsize=2;
`endif

  //-write program buffer
  dmi_value=`LW_X7_0_X6;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  dmi_value=`EBREAK;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  //write address to data0
  dmi_value = address[31:0]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
`ifdef TDT_DM_CORE_RV64
  dmi_value = address[63:32]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data1 write error!");
  end
`endif
  //lauch pb
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b1, 1'b1, 1'b1, 16'h1006, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_info($sformatf("warning:abscmd pb execute error with cmderr[%0h]", cmderr));
    value =0;
    return;
  end
  //read back x7 with abscmd
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b0, 1'b1, 1'b0, 16'h1007, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_info($sformatf("warning:abscmd pb execute error with cmderr[%0h]", cmderr));
    value =0;
    return;
  end
  //read back data0
  this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
  value = dmi_value;
  this.tb_info($sformatf("read_word_by_pb with address[%0h], value[%0h]", address, value));
endtask: read_word_by_pb_without_fatal

task ext_debug::read_word_by_pb(bit[63:0] address, output bit[31:0] value);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] cmderr;
  bit[2:0] aarsize;
`ifdef TDT_DM_CORE_RV64
  aarsize=3;
`else
  aarsize=2;
`endif

  //-write program buffer
  dmi_value=`LW_X7_0_X6;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  dmi_value=`EBREAK;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  //write address to data0
  dmi_value = address[31:0]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
`ifdef TDT_DM_CORE_RV64
  dmi_value = address[63:32]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data1 write error!");
  end
`endif
  //lauch pb
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b1, 1'b1, 1'b1, 16'h1006, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_fatal($sformatf("abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  //read back x7 with abscmd
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b0, 1'b1, 1'b0, 16'h1007, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_fatal($sformatf("abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  //read back data0
  this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
  value = dmi_value;
  this.tb_info($sformatf("read_word_by_pb with address[%0h], value[%0h]", address, value));
endtask: read_word_by_pb

task ext_debug::write_word_by_pb_without_fatal(bit[63:0] address, bit[31:0] value, output bit[2:0] cmderr);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] aarsize;
`ifdef TDT_DM_CORE_RV64
  aarsize=3;
`else
  aarsize=2;
`endif

  //-write program buffer
  dmi_value=`SW_X7_0_X6;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  dmi_value=`EBREAK;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  //write address to data0
  dmi_value = address[31:0]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
`ifdef TDT_DM_CORE_RV64
  dmi_value = address[63:32]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data1 write error!");
  end
`endif
  //write x6 with abscmd
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b0, 1'b1, 1'b1, 16'h1006, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_info($sformatf("warning:abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  //write x7 with value
  dmi_value = value;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
  //lauch pb
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b1, 1'b1, 1'b1, 16'h1007, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_info($sformatf("warning:abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  this.tb_info($sformatf("write_word_by_pb with address[%0h], value[%0h]", address, value));

endtask: write_word_by_pb_without_fatal

task ext_debug::write_word_by_pb(bit[63:0] address, bit[31:0] value);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] cmderr;
  bit[2:0] aarsize;
`ifdef TDT_DM_CORE_RV64
  aarsize=3;
`else
  aarsize=2;
`endif

  //-write program buffer
  dmi_value=`SW_X7_0_X6;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  dmi_value=`EBREAK;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  //write address to data0
  dmi_value = address[31:0]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
`ifdef TDT_DM_CORE_RV64
  dmi_value = address[63:32]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data1 write error!");
  end
`endif
  //write x6 with abscmd
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b0, 1'b1, 1'b1, 16'h1006, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_fatal($sformatf("abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  //write x7 with value
  dmi_value = value;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
  //lauch pb
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b1, 1'b1, 1'b1, 16'h1007, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_fatal($sformatf("abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  this.tb_info($sformatf("write_word_by_pb with address[%0h], value[%0h]", address, value));

endtask: write_word_by_pb

task ext_debug::read_block_by_pb(bit[63:0] address, int block_size, output bit[31:0] value[$]);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] cmderr;
  bit[2:0] aarsize;
`ifdef TDT_DM_CORE_RV64
  aarsize=3;
`else
  aarsize=2;
`endif
  //-write program buffer
  dmi_value=`LW_X7_0_X6;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  dmi_value=`ADDI_X6_X6_4;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  dmi_value=`EBREAK;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF2, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  //write address to data0
  dmi_value = address[31:0]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
`ifdef TDT_DM_CORE_RV64
  dmi_value = address[63:32]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data1 write error!");
  end
`endif
  //lauch pb
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b1, 1'b1, 1'b1, 16'h1006, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_fatal($sformatf("abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  //read back x7 with abscmd
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b1, 1'b1, 1'b0, 16'h1007, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_fatal($sformatf("abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  //set autoexecdata
  dmi_value = 32'b1;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_ABSTRACTAUTO, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("abstractauto write error");
  end

  //read back data0
  for(int idx=0; idx<block_size; idx++) begin
    //clear autoexecdata before last transfer
    if (idx==block_size-1) begin
      dmi_value = 32'b0;
      this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_ABSTRACTAUTO, dmi_value, error);
      if (error == 1'b1) begin
        this.tb_fatal("abstractauto write error");
      end
    end
    this.rwMemorybyDMIwithCheck(`DMI_READ, `DM_DATA0, dmi_value, error);
    if (error == 1'b1) begin
      this.tb_fatal("data0 write error!");
    end
    value.push_back(dmi_value);
    this.tb_info($sformatf("read_block_by_pb with address[%0h], value[%0h]", address, dmi_value));
  end
  this.tb_info($sformatf("read_block_by_pb with address[%0h], block_size[%0h] is done", address, block_size));

endtask: read_block_by_pb

task ext_debug::write_block_by_pb(bit[63:0] address, int block_size, bit[31:0] value[$]);
  bit[1:0] dmi_op;
  bit[`DTM_DTMCS_ABIT-1:0] dmi_address;
  int dmi_value;
  bit error;
  bit[2:0] cmderr;
  bit[2:0] aarsize;
`ifdef TDT_DM_CORE_RV64
  aarsize=3;
`else
  aarsize=2;
`endif

  //-write program buffer
  dmi_value=`SW_X7_0_X6;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  dmi_value=`ADDI_X6_X6_4;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  dmi_value=`EBREAK;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_PROGBUF2, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal($sformatf("progranbuffer write error"));
  end
  //write address to data0
  dmi_value = address[31:0]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
`ifdef TDT_DM_CORE_RV64
  dmi_value = address[63:32]; 
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA1, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data1 write error!");
  end
`endif
  //write x6 with abscmd
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b0, 1'b1, 1'b1, 16'h1006, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_fatal($sformatf("abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  //write x7 with value
  dmi_value = value.pop_front();
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("data0 write error!");
  end
  //lauch pb
  this.access_register_by_abscmd(aarsize, 1'b0, 1'b1, 1'b1, 1'b1, 16'h1007, cmderr);
  if (cmderr != 3'b0) begin
    this.tb_fatal($sformatf("abscmd pb execute error with cmderr[%0h]", cmderr));
  end
  //set autoexecdata
  dmi_value = 32'b1;
  this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_ABSTRACTAUTO, dmi_value, error);
  if (error == 1'b1) begin
    this.tb_fatal("abstractauto write error");
  end
  for(int idx=1; idx<block_size; idx++) begin
    dmi_value = value.pop_front();
    this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_DATA0, dmi_value, error);
    if (error == 1'b1) begin
      this.tb_fatal("data0 write error!");
    end
    //clear autoexecdata before last transfer
    if (idx==block_size-1) begin
      dmi_value = 32'b0;
      this.rwMemorybyDMIwithCheck(`DMI_WRITE, `DM_ABSTRACTAUTO, dmi_value, error);
      if (error == 1'b1) begin
        this.tb_fatal("abstractauto write error");
      end
    end
  end
  this.tb_info($sformatf("write_block_by_pb with address[%0h], block_size[%0h] is done", address, block_size));

endtask: write_block_by_pb


`endif //JTAG_DRV


