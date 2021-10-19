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

// &Depend("aq_dtu_cfig.h"); @23
// &Depend("cpu_cfig.h"); @24
// &ModuleBeg; @25
module aq_cp0_iui(
  cp0_dtu_addr,
  cp0_dtu_rreg,
  cp0_dtu_wdata,
  cp0_dtu_wreg,
  cp0_hpcp_index,
  cp0_hpcp_wdata,
  cp0_hpcp_wreg,
  cp0_idu_issue_stall,
  cp0_idu_vsetvl_dis_stall,
  cp0_mmu_addr,
  cp0_mmu_wdata,
  cp0_mmu_wreg,
  cp0_pmp_addr,
  cp0_pmp_wdata,
  cp0_pmp_wreg,
  cp0_rtu_ex1_chgflw,
  cp0_rtu_ex1_chgflw_pc,
  cp0_rtu_ex1_cmplt,
  cp0_rtu_ex1_cmplt_dp,
  cp0_rtu_ex1_expt_tval,
  cp0_rtu_ex1_expt_vec,
  cp0_rtu_ex1_expt_vld,
  cp0_rtu_ex1_flush,
  cp0_rtu_ex1_halt_info,
  cp0_rtu_ex1_inst_dret,
  cp0_rtu_ex1_inst_ebreak,
  cp0_rtu_ex1_inst_len,
  cp0_rtu_ex1_inst_mret,
  cp0_rtu_ex1_inst_split,
  cp0_rtu_ex1_inst_sret,
  cp0_rtu_ex1_vs_dirty,
  cp0_rtu_ex1_vs_dirty_dp,
  cp0_rtu_ex1_wb_data,
  cp0_rtu_ex1_wb_dp,
  cp0_rtu_ex1_wb_preg,
  cp0_rtu_ex1_wb_vld,
  cpurst_b,
  idu_cp0_ex1_dp_sel,
  idu_cp0_ex1_dst0_reg,
  idu_cp0_ex1_expt_acc_error,
  idu_cp0_ex1_expt_high,
  idu_cp0_ex1_expt_illegal,
  idu_cp0_ex1_expt_page_fault,
  idu_cp0_ex1_func,
  idu_cp0_ex1_gateclk_sel,
  idu_cp0_ex1_halt_info,
  idu_cp0_ex1_length,
  idu_cp0_ex1_opcode,
  idu_cp0_ex1_sel,
  idu_cp0_ex1_split,
  idu_cp0_ex1_src0_data,
  idu_cp0_ex1_src1_data,
  ifu_cp0_warm_up,
  iu_cp0_ex1_cur_pc,
  iui_inst_rs2,
  iui_inst_vsetvl_decd,
  iui_regs_csr_en,
  iui_regs_csr_wen,
  iui_regs_csr_wen_no_imm_ill,
  iui_regs_csr_write,
  iui_regs_csr_write_no_imm_ill,
  iui_regs_imm,
  iui_regs_inst_mret,
  iui_regs_inst_sret,
  iui_regs_wdata,
  iui_special_cache,
  iui_special_cache_func,
  iui_special_fence,
  iui_special_fencei,
  iui_special_rs1,
  iui_special_rs1_x0,
  iui_special_rs2,
  iui_special_rs2_x0,
  iui_special_sfence,
  iui_special_sync,
  iui_special_synci,
  iui_special_vsetvl,
  iui_special_vsetvl_dp,
  iui_special_vsetvl_rs1,
  iui_special_vsetvl_rs2,
  iui_special_wfi,
  iui_vsetvl_bypass,
  iui_vsetvl_data,
  regs_clk,
  regs_iui_csr_inv,
  regs_iui_mcins_stall,
  regs_iui_mcor_stall,
  regs_iui_mepc,
  regs_iui_pm,
  regs_iui_rdata,
  regs_iui_rdata_for_w,
  regs_iui_sepc,
  regs_iui_smcir_stall,
  regs_iui_trigger_mro,
  regs_iui_trigger_smode,
  regs_iui_tsr,
  regs_iui_tvm,
  regs_iui_tw,
  rtu_yy_xx_dbgon,
  special_iui_stall,
  special_iui_vsetvl_wdata,
  vidu_cp0_vid_fof_vld
);


// &Ports; @27
input           cpurst_b;                     
input           idu_cp0_ex1_dp_sel;           
input   [5 :0]  idu_cp0_ex1_dst0_reg;         
input           idu_cp0_ex1_expt_acc_error;   
input           idu_cp0_ex1_expt_high;        
input           idu_cp0_ex1_expt_illegal;     
input           idu_cp0_ex1_expt_page_fault;  
input   [19:0]  idu_cp0_ex1_func;             
input           idu_cp0_ex1_gateclk_sel;      
input   [21:0]  idu_cp0_ex1_halt_info;        
input           idu_cp0_ex1_length;           
input   [31:0]  idu_cp0_ex1_opcode;           
input           idu_cp0_ex1_sel;              
input           idu_cp0_ex1_split;            
input   [63:0]  idu_cp0_ex1_src0_data;        
input   [63:0]  idu_cp0_ex1_src1_data;        
input           ifu_cp0_warm_up;              
input   [39:0]  iu_cp0_ex1_cur_pc;            
input           iui_inst_vsetvl_decd;         
input           regs_clk;                     
input           regs_iui_csr_inv;             
input           regs_iui_mcins_stall;         
input           regs_iui_mcor_stall;          
input   [39:0]  regs_iui_mepc;                
input   [1 :0]  regs_iui_pm;                  
input   [63:0]  regs_iui_rdata;               
input   [63:0]  regs_iui_rdata_for_w;         
input   [39:0]  regs_iui_sepc;                
input           regs_iui_smcir_stall;         
input           regs_iui_trigger_mro;         
input           regs_iui_trigger_smode;       
input           regs_iui_tsr;                 
input           regs_iui_tvm;                 
input           regs_iui_tw;                  
input           rtu_yy_xx_dbgon;              
input           special_iui_stall;            
input   [63:0]  special_iui_vsetvl_wdata;     
input           vidu_cp0_vid_fof_vld;         
output  [11:0]  cp0_dtu_addr;                 
output          cp0_dtu_rreg;                 
output  [63:0]  cp0_dtu_wdata;                
output          cp0_dtu_wreg;                 
output  [11:0]  cp0_hpcp_index;               
output  [63:0]  cp0_hpcp_wdata;               
output          cp0_hpcp_wreg;                
output          cp0_idu_issue_stall;          
output          cp0_idu_vsetvl_dis_stall;     
output  [11:0]  cp0_mmu_addr;                 
output  [63:0]  cp0_mmu_wdata;                
output          cp0_mmu_wreg;                 
output  [11:0]  cp0_pmp_addr;                 
output  [63:0]  cp0_pmp_wdata;                
output          cp0_pmp_wreg;                 
output          cp0_rtu_ex1_chgflw;           
output  [39:0]  cp0_rtu_ex1_chgflw_pc;        
output          cp0_rtu_ex1_cmplt;            
output          cp0_rtu_ex1_cmplt_dp;         
output  [39:0]  cp0_rtu_ex1_expt_tval;        
output  [4 :0]  cp0_rtu_ex1_expt_vec;         
output          cp0_rtu_ex1_expt_vld;         
output          cp0_rtu_ex1_flush;            
output  [21:0]  cp0_rtu_ex1_halt_info;        
output          cp0_rtu_ex1_inst_dret;        
output          cp0_rtu_ex1_inst_ebreak;      
output          cp0_rtu_ex1_inst_len;         
output          cp0_rtu_ex1_inst_mret;        
output          cp0_rtu_ex1_inst_split;       
output          cp0_rtu_ex1_inst_sret;        
output          cp0_rtu_ex1_vs_dirty;         
output          cp0_rtu_ex1_vs_dirty_dp;      
output  [63:0]  cp0_rtu_ex1_wb_data;          
output          cp0_rtu_ex1_wb_dp;            
output  [5 :0]  cp0_rtu_ex1_wb_preg;          
output          cp0_rtu_ex1_wb_vld;           
output  [63:0]  iui_inst_rs2;                 
output          iui_regs_csr_en;              
output          iui_regs_csr_wen;             
output          iui_regs_csr_wen_no_imm_ill;  
output          iui_regs_csr_write;           
output          iui_regs_csr_write_no_imm_ill; 
output  [11:0]  iui_regs_imm;                 
output          iui_regs_inst_mret;           
output          iui_regs_inst_sret;           
output  [63:0]  iui_regs_wdata;               
output          iui_special_cache;            
output  [5 :0]  iui_special_cache_func;       
output          iui_special_fence;            
output          iui_special_fencei;           
output  [63:0]  iui_special_rs1;              
output          iui_special_rs1_x0;           
output  [63:0]  iui_special_rs2;              
output          iui_special_rs2_x0;           
output          iui_special_sfence;           
output          iui_special_sync;             
output          iui_special_synci;            
output          iui_special_vsetvl;           
output          iui_special_vsetvl_dp;        
output  [63:0]  iui_special_vsetvl_rs1;       
output  [11:0]  iui_special_vsetvl_rs2;       
output          iui_special_wfi;              
output          iui_vsetvl_bypass;            
output  [4 :0]  iui_vsetvl_data;              

// &Regs; @28
reg             iui_csr_wen_f;                
reg     [39:0]  iui_expt_tval;                
reg     [3 :0]  iui_expt_vec;                 

// &Wires; @29
wire    [11:0]  cp0_dtu_addr;                 
wire            cp0_dtu_rreg;                 
wire    [63:0]  cp0_dtu_wdata;                
wire            cp0_dtu_wreg;                 
wire    [11:0]  cp0_hpcp_index;               
wire    [63:0]  cp0_hpcp_wdata;               
wire            cp0_hpcp_wreg;                
wire            cp0_idu_issue_stall;          
wire            cp0_idu_vsetvl_dis_stall;     
wire    [11:0]  cp0_mmu_addr;                 
wire    [63:0]  cp0_mmu_wdata;                
wire            cp0_mmu_wreg;                 
wire    [11:0]  cp0_pmp_addr;                 
wire    [63:0]  cp0_pmp_wdata;                
wire            cp0_pmp_wreg;                 
wire            cp0_rtu_ex1_chgflw;           
wire    [39:0]  cp0_rtu_ex1_chgflw_pc;        
wire            cp0_rtu_ex1_cmplt;            
wire            cp0_rtu_ex1_cmplt_dp;         
wire    [39:0]  cp0_rtu_ex1_expt_tval;        
wire    [4 :0]  cp0_rtu_ex1_expt_vec;         
wire            cp0_rtu_ex1_expt_vld;         
wire            cp0_rtu_ex1_flush;            
wire    [21:0]  cp0_rtu_ex1_halt_info;        
wire            cp0_rtu_ex1_inst_dret;        
wire            cp0_rtu_ex1_inst_ebreak;      
wire            cp0_rtu_ex1_inst_len;         
wire            cp0_rtu_ex1_inst_mret;        
wire            cp0_rtu_ex1_inst_split;       
wire            cp0_rtu_ex1_inst_sret;        
wire            cp0_rtu_ex1_vs_dirty;         
wire            cp0_rtu_ex1_vs_dirty_dp;      
wire    [63:0]  cp0_rtu_ex1_wb_data;          
wire            cp0_rtu_ex1_wb_dp;            
wire    [5 :0]  cp0_rtu_ex1_wb_preg;          
wire            cp0_rtu_ex1_wb_vld;           
wire            cpurst_b;                     
wire            idu_cp0_ex1_dp_sel;           
wire    [5 :0]  idu_cp0_ex1_dst0_reg;         
wire            idu_cp0_ex1_expt_acc_error;   
wire            idu_cp0_ex1_expt_high;        
wire            idu_cp0_ex1_expt_illegal;     
wire            idu_cp0_ex1_expt_page_fault;  
wire    [19:0]  idu_cp0_ex1_func;             
wire            idu_cp0_ex1_gateclk_sel;      
wire    [21:0]  idu_cp0_ex1_halt_info;        
wire            idu_cp0_ex1_length;           
wire    [31:0]  idu_cp0_ex1_opcode;           
wire            idu_cp0_ex1_sel;              
wire            idu_cp0_ex1_split;            
wire    [63:0]  idu_cp0_ex1_src0_data;        
wire    [63:0]  idu_cp0_ex1_src1_data;        
wire    [39:0]  iu_cp0_ex1_cur_pc;            
wire            iui_accflt_expt;              
wire            iui_cancel;                   
wire    [39:0]  iui_chgflw_pc;                
wire            iui_csr_expt_vld;             
wire            iui_csr_expt_vld_no_imm_ill;  
wire    [63:0]  iui_csr_rdata;                
wire    [63:0]  iui_csr_rs1;                  
wire            iui_csr_stall;                
wire    [63:0]  iui_csr_wdata;                
wire            iui_csr_wen;                  
wire            iui_csr_wen_vld;              
wire            iui_csr_wen_vld_no_imm_ill;   
wire            iui_csr_write_inv;            
wire            iui_csr_write_no_imm_ill;     
wire    [63:0]  iui_csrrc_rs1;                
wire    [63:0]  iui_csrrs_rs1;                
wire    [63:0]  iui_csrrw_rs1;                
wire    [39:0]  iui_ex1_expt_pc;              
wire    [39:0]  iui_ex1_pc;                   
wire            iui_expt_vld;                 
wire            iui_idu_expt_vld;             
wire            iui_ifu_expt_vld;             
wire            iui_illegal_expt;             
wire            iui_inst_cache;               
wire    [5 :0]  iui_inst_cache_func;          
wire            iui_inst_chgflw;              
wire            iui_inst_cmplt;               
wire            iui_inst_csr;                 
wire    [2 :0]  iui_inst_csr_func;            
wire            iui_inst_dis_stall;           
wire            iui_inst_dret;                
wire    [5 :0]  iui_inst_dst_idx;             
wire            iui_inst_dst_vld;             
wire            iui_inst_dst_vld_dp;          
wire            iui_inst_ebreak;              
wire            iui_inst_ecall;               
wire            iui_inst_fence;               
wire            iui_inst_fencei;              
wire            iui_inst_flush;               
wire    [19:0]  iui_inst_func;                
wire    [21:0]  iui_inst_halt_info;           
wire    [11:0]  iui_inst_imm;                 
wire            iui_inst_issue_stall;         
wire            iui_inst_mret;                
wire            iui_inst_nop;                 
wire    [31:0]  iui_inst_opcode;              
wire    [63:0]  iui_inst_rs1;                 
wire            iui_inst_rs1_x0;              
wire    [63:0]  iui_inst_rs2;                 
wire            iui_inst_rs2_x0;              
wire            iui_inst_sel;                 
wire            iui_inst_sel_dp;              
wire            iui_inst_sfence;              
wire            iui_inst_sret;                
wire            iui_inst_sync;                
wire            iui_inst_synci;               
wire            iui_inst_vld;                 
wire            iui_inst_vld_no_brir;         
wire            iui_inst_vsetvl;              
wire            iui_inst_vsetvl_decd;         
wire            iui_inst_vsetvl_dp;           
wire            iui_inst_vsetvl_raw;          
wire            iui_inst_wfi;                 
wire            iui_mecall_expt;              
wire            iui_mmode;                    
wire            iui_pageflt_expt;             
wire            iui_regs_csr_en;              
wire            iui_regs_csr_wen;             
wire            iui_regs_csr_wen_no_imm_ill;  
wire            iui_regs_csr_write;           
wire            iui_regs_csr_write_no_imm_ill; 
wire    [11:0]  iui_regs_imm;                 
wire            iui_regs_inst_mret;           
wire            iui_regs_inst_sret;           
wire    [63:0]  iui_regs_wdata;               
wire            iui_secall_expt;              
wire            iui_smode;                    
wire            iui_smode_csr_inv;            
wire            iui_smode_special_inv;        
wire            iui_special_cache;            
wire    [5 :0]  iui_special_cache_func;       
wire            iui_special_expt_vld;         
wire            iui_special_fence;            
wire            iui_special_fencei;           
wire    [63:0]  iui_special_rs1;              
wire            iui_special_rs1_x0;           
wire    [63:0]  iui_special_rs2;              
wire            iui_special_rs2_x0;           
wire            iui_special_sfence;           
wire            iui_special_sync;             
wire            iui_special_synci;            
wire            iui_special_vsetvl;           
wire            iui_special_vsetvl_dp;        
wire    [63:0]  iui_special_vsetvl_rs1;       
wire    [11:0]  iui_special_vsetvl_rs2;       
wire            iui_special_wfi;              
wire            iui_uecall_expt;              
wire            iui_umode;                    
wire            iui_umode_csr_inv;            
wire            iui_umode_special_inv;        
wire            iui_vsetvl_bypass;            
wire    [4 :0]  iui_vsetvl_data;              
wire    [63:0]  iui_vsetvl_rs1;               
wire    [11:0]  iui_vsetvl_rs2;               
wire            iui_vsetvl_stall;             
wire    [63:0]  iui_wdata;                    
wire            regs_clk;                     
wire            regs_iui_csr_inv;             
wire            regs_iui_mcins_stall;         
wire            regs_iui_mcor_stall;          
wire    [39:0]  regs_iui_mepc;                
wire    [1 :0]  regs_iui_pm;                  
wire    [63:0]  regs_iui_rdata;               
wire    [63:0]  regs_iui_rdata_for_w;         
wire    [39:0]  regs_iui_sepc;                
wire            regs_iui_smcir_stall;         
wire            regs_iui_trigger_mro;         
wire            regs_iui_trigger_smode;       
wire            regs_iui_tsr;                 
wire            regs_iui_tvm;                 
wire            regs_iui_tw;                  
wire            rtu_yy_xx_dbgon;              
wire            special_iui_stall;            
wire    [63:0]  special_iui_vsetvl_wdata;     
wire            vidu_cp0_vid_fof_vld;         


//==========================================================
// CP0 IUI Module
// 1. Prepare CSR and Special Inst Information
// 2. Generate Retire and Exception Signals
//==========================================================

//==========================================================
//             Generate Instruction Information
//==========================================================
// Prepare CSR and Special Inst Information
//   1. Get the instruction functions
//   2. Generate CSR Inst Information
//   3. Generate Special Inst Information
//------------------------------------------------

//----------------------------------------------------------
//                  Instruction Functions
//----------------------------------------------------------
// &Force("input", "ifu_cp0_warm_up"); @49
assign iui_inst_sel          = idu_cp0_ex1_gateclk_sel && !iui_idu_expt_vld && !iui_cancel;
assign iui_inst_sel_dp       = idu_cp0_ex1_dp_sel && !iui_idu_expt_vld && !iui_cancel;
assign iui_inst_vld          = iui_inst_sel;
assign iui_inst_vld_no_brir  = idu_cp0_ex1_sel && !iui_idu_expt_vld && !iui_cancel;
assign iui_inst_func[19:0]   = {20{iui_inst_sel}} & idu_cp0_ex1_func[19:0];
assign iui_inst_dst_vld      = iui_inst_csr || iui_inst_vsetvl;
assign iui_inst_dst_vld_dp   = iui_inst_csr || iui_inst_vsetvl_dp;
assign iui_inst_dst_idx[5:0] = {6{iui_inst_sel}} & idu_cp0_ex1_dst0_reg[5:0];
assign iui_inst_rs1[63:0]    = {64{iui_inst_sel}} & idu_cp0_ex1_src0_data[63:0];
assign iui_inst_rs2[63:0]    = {64{iui_inst_sel}} & idu_cp0_ex1_src1_data[63:0];
assign iui_inst_imm[11:0]    = {12{iui_inst_sel}} & idu_cp0_ex1_src1_data[11:0];
assign iui_vsetvl_data[4:0]  = iui_inst_func[3] && iui_inst_func[9] ? idu_cp0_ex1_opcode[24:20]
                                                                    : idu_cp0_ex1_src0_data[4:0];
assign iui_vsetvl_bypass     = idu_cp0_ex1_gateclk_sel && iui_inst_vsetvl_decd;                                                                    
// &Force("bus", "idu_cp0_ex1_src1_data", 63, 0); @64
assign iui_inst_opcode[31:0] = {32{idu_cp0_ex1_gateclk_sel}} & idu_cp0_ex1_opcode[31:0];
assign iui_inst_halt_info[`TDT_HINFO_WIDTH-1:0] =
  {`TDT_HINFO_WIDTH{idu_cp0_ex1_gateclk_sel}} & idu_cp0_ex1_halt_info[`TDT_HINFO_WIDTH-1:0];

assign iui_inst_rs1_x0 = iui_inst_sel && iui_inst_opcode[19:15] == 5'b0;
assign iui_inst_rs2_x0 = iui_inst_sel && iui_inst_opcode[24:20] == 5'b0;
//----------------------------------------------------------
//                    Generate CSR Inst
//----------------------------------------------------------
// Func[0]: CSR operation
// Func[4]: CSRRW
// Func[5]: CSRRS
// Func[6]: CSRRC
assign iui_inst_csr = iui_inst_vld && iui_inst_func[0];
assign iui_csr_wen  = iui_inst_csr && (iui_inst_csr_func[0]
                                    || iui_inst_csr_func[1] && !iui_inst_rs1_x0
                                    || iui_inst_csr_func[2] && !iui_inst_rs1_x0);

always @ (posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    iui_csr_wen_f <= 1'b0;
  else if (iui_csr_wen && iui_csr_stall)
    iui_csr_wen_f <= 1'b1;
  else
    iui_csr_wen_f <= 1'b0;
end

assign iui_csr_wen_vld = iui_csr_wen && !iui_csr_wen_f
                                     && !iui_csr_expt_vld;
assign iui_csr_wen_vld_no_imm_ill = iui_csr_wen && !iui_csr_wen_f
                                                && !iui_csr_expt_vld_no_imm_ill;
assign iui_csr_write_no_imm_ill   = iui_csr_wen && !iui_csr_expt_vld_no_imm_ill;

// csr_func[0]: CSRRW
// csr_func[1]: CSRRS
// csr_func[2]: CSRRC
assign iui_inst_csr_func[2:0] = {3{iui_inst_func[0]}}
                              & idu_cp0_ex1_func[6:4];

//----------- CSR write data -----------
assign iui_csr_rdata[63:0] = regs_iui_rdata_for_w[63:0];
assign iui_csr_rs1[63:0] = iui_inst_func[0] && iui_inst_func[9] ? {59'b0, iui_inst_opcode[19:15]}
                                                                : iui_inst_rs1[63:0];

assign iui_csrrw_rs1[63:0] = iui_csr_rs1[63:0];
assign iui_csrrs_rs1[63:0] = iui_csr_rdata[63:0] |   iui_csr_rs1[63:0];
assign iui_csrrc_rs1[63:0] = iui_csr_rdata[63:0] & (~iui_csr_rs1[63:0]);

assign iui_csr_wdata[63:0] = {64{iui_inst_csr_func[0]}} & iui_csrrw_rs1[63:0]
                           | {64{iui_inst_csr_func[1]}} & iui_csrrs_rs1[63:0]
                           | {64{iui_inst_csr_func[2]}} & iui_csrrc_rs1[63:0];

//----------------------------------------------------------
//                  Generate Special Inst
//----------------------------------------------------------
//------------- Fence Inst -------------
assign iui_inst_fence  = iui_inst_vld && iui_inst_func[3]
                      && iui_inst_func[5];
assign iui_inst_fencei = iui_inst_vld && iui_inst_func[2]
                      && iui_inst_func[5];
assign iui_inst_sfence = iui_inst_vld && iui_inst_func[2]
                      && iui_inst_func[6];
assign iui_inst_sync   = iui_inst_vld && iui_inst_func[2]
                      && iui_inst_func[7];
assign iui_inst_synci  = iui_inst_vld && iui_inst_func[2]
                      && iui_inst_func[8];
assign iui_inst_cache  = iui_inst_vld && iui_inst_func[2]
                      && iui_inst_func[9];

assign iui_inst_cache_func[5:0] = {6{iui_inst_func[2]}}
                                 & idu_cp0_ex1_func[15:10];
//------------ Special Inst ------------
assign iui_inst_ecall  = iui_inst_vld && iui_inst_func[1]
                      && iui_inst_func[4] && !rtu_yy_xx_dbgon;
assign iui_inst_ebreak = iui_inst_vld && iui_inst_func[1]
                      && iui_inst_func[5];
assign iui_inst_mret   = iui_inst_vld && iui_inst_func[1]
                      && iui_inst_func[6] && !rtu_yy_xx_dbgon;
assign iui_inst_sret   = iui_inst_vld && iui_inst_func[1]
                      && iui_inst_func[7] && !rtu_yy_xx_dbgon;
assign iui_inst_wfi    = iui_inst_vld && iui_inst_func[1]
                      && iui_inst_func[8] && !rtu_yy_xx_dbgon;
assign iui_inst_dret   = iui_inst_vld && iui_inst_func[1]
                      && iui_inst_func[9] && rtu_yy_xx_dbgon;

//------------ Vector Inst -------------
// &Force("nonport", "iui_inst_vld_no_brir"); @160
// &Force("nonport", "iui_inst_sel_dp"); @161
assign iui_inst_vsetvl = 1'b0;
assign iui_inst_vsetvl_raw = 1'b0;
assign iui_inst_vsetvl_dp = 1'b0;
// &Force("output","iui_inst_rs2"); @166
// vector inst rs1 in src1, rs2 in src0
assign iui_vsetvl_rs1[63:0]  = iui_inst_rs2[63:0];
assign iui_vsetvl_rs2[11:0]  = iui_inst_func[3] && iui_inst_func[9] ?
                                            {1'b0, iui_inst_opcode[30:20]}
                                          : iui_inst_rs1[11:0];

//-------------- NOP Inst --------------
assign iui_inst_nop    = iui_inst_vld && !(|iui_inst_func[2:0]);

//==========================================================
//                  Cmplt and Expt Signal
//==========================================================
assign iui_mmode = regs_iui_pm[1:0] == 2'b11;
assign iui_smode = regs_iui_pm[1:0] == 2'b01;
assign iui_umode = regs_iui_pm[1:0] == 2'b00;

//----------------------------------------------------------
//                           Expt
//----------------------------------------------------------
//--------- Special Inst Expt ----------
// 1. s mode inv
//   a. mret
//   b. sret && tsr
//   c. wfi && tw
//   d. sfence && tvm
// 2. U mode inv
//   1. mret
//   2. sret
//   3. wfi
//   4. sfence
// 3. ecall
// 4. vsetvl && !vs (in idu)
assign iui_smode_special_inv = iui_smode
                           && (iui_inst_mret
                            || iui_inst_sret   && regs_iui_tsr
                            || iui_inst_wfi    && regs_iui_tw
                            || iui_inst_sfence && regs_iui_tvm);

assign iui_umode_special_inv = iui_umode
                           && (iui_inst_mret
                            || iui_inst_sret
                            || iui_inst_wfi
                            || iui_inst_sfence);

assign iui_special_expt_vld = iui_umode_special_inv
                           || iui_smode_special_inv
                           || iui_inst_ecall;


//----------- CSR Inst Expt ------------
// 1. access M csr in Smode
// 2. access M, S csr in Umode
// 3. write read only CSR
// 4. regs_iui_expt
//   a. csr addr inv
//   b. !FS && float csr
//   c. !VS && vector_csr
//   d. S mode stap && tvm
//   e. scounter ucounter inv.

assign iui_csr_write_inv = iui_csr_wen && (iui_inst_imm[11:10] == 2'b11
                                           || regs_iui_trigger_mro);

assign iui_smode_csr_inv = iui_smode
                        && iui_inst_csr && (iui_inst_imm[9:8] == 2'b11
                                            && !regs_iui_trigger_smode);

assign iui_umode_csr_inv = iui_umode
                        && iui_inst_csr && iui_inst_imm[9:8] != 2'b00;

assign iui_csr_expt_vld = iui_smode_csr_inv
                       || iui_umode_csr_inv
                       || regs_iui_csr_inv && iui_inst_csr
                       || iui_csr_write_inv;

assign iui_csr_expt_vld_no_imm_ill = iui_smode_csr_inv
                                  || iui_umode_csr_inv
                                  || iui_csr_write_inv;

// Expt Source:
//   1. expt from idu
//   2. special inst expt
//   3. CSR inst expt

assign iui_ifu_expt_vld = idu_cp0_ex1_expt_page_fault
                       || idu_cp0_ex1_expt_acc_error;

assign iui_idu_expt_vld = iui_ifu_expt_vld
                       || idu_cp0_ex1_expt_illegal;

assign iui_cancel   = iui_inst_halt_info[`TDT_HINFO_CANCEL]
                      && idu_cp0_ex1_gateclk_sel;

assign iui_expt_vld = (iui_idu_expt_vld
                    || iui_special_expt_vld
                    || iui_csr_expt_vld)
                    && idu_cp0_ex1_gateclk_sel;

assign iui_pageflt_expt = idu_cp0_ex1_expt_page_fault;
assign iui_accflt_expt  = idu_cp0_ex1_expt_acc_error;
assign iui_illegal_expt = idu_cp0_ex1_expt_illegal
                       || iui_special_expt_vld
                       || iui_csr_expt_vld;
assign iui_mecall_expt  = iui_inst_ecall && iui_mmode;
assign iui_secall_expt  = iui_inst_ecall && iui_smode;
assign iui_uecall_expt  = iui_inst_ecall && iui_umode;

// &CombBeg; @278
always @( iui_accflt_expt
       or iui_illegal_expt
       or iui_pageflt_expt
       or iui_secall_expt
       or iui_idu_expt_vld
       or iui_uecall_expt
       or iui_mecall_expt)
begin
  if (iui_pageflt_expt)
    iui_expt_vec[3:0] = 4'd12;
  else if (iui_accflt_expt)
    iui_expt_vec[3:0] = 4'd1;
  else if(iui_idu_expt_vld)
    iui_expt_vec[3:0] = 4'd2;
  else if(iui_mecall_expt)
    iui_expt_vec[3:0] = 4'd11;
  else if(iui_secall_expt)
    iui_expt_vec[3:0] = 4'd9;
  else if(iui_uecall_expt)
    iui_expt_vec[3:0] = 4'd8;
  else if(iui_illegal_expt)
    iui_expt_vec[3:0] = 4'd2;
  else
    iui_expt_vec[3:0] = 4'd0;
// &CombEnd; @295
end

assign iui_ex1_pc[`PA_WIDTH-1:0] = {`PA_WIDTH{idu_cp0_ex1_gateclk_sel}} & iu_cp0_ex1_cur_pc[`PA_WIDTH-1:0];
assign iui_ex1_expt_pc[`PA_WIDTH-1:0] = iui_ex1_pc[`PA_WIDTH-1:0]
                                      + {{(`PA_WIDTH-2){1'b0}}, idu_cp0_ex1_expt_high, 1'b0};

// &CombBeg; @301
always @( iui_accflt_expt
       or iui_pageflt_expt
       or iui_cancel
       or iui_ex1_expt_pc[39:0]
       or iui_inst_opcode[31:0])
begin
  if (iui_pageflt_expt || iui_accflt_expt || iui_cancel)
    iui_expt_tval[`PA_WIDTH-1:0] = iui_ex1_expt_pc[`PA_WIDTH-1:0];
  else
    iui_expt_tval[`PA_WIDTH-1:0] = {{`PA_WIDTH-32{1'b0}}, iui_inst_opcode[31:0]};
// &CombEnd; @306
end

//----------------------------------------------------------
//                          Stall
//----------------------------------------------------------
// Stall Source:
//   special stall:
//     1. cache inst stall
//     2. fence inst stall
//     2. lpmd stall
//   vsetvl stall
//   csr Stall
//     1. MMU
//     2. MCOR
assign iui_vsetvl_stall = iui_inst_vsetvl_raw && vidu_cp0_vid_fof_vld;

assign iui_csr_stall = regs_iui_smcir_stall
                    || regs_iui_mcor_stall
                    || regs_iui_mcins_stall;

assign iui_inst_issue_stall = special_iui_stall
                           || iui_vsetvl_stall
                           || iui_csr_stall;
//assign iui_inst_dis_stall   = iui_inst_vsetvl_raw;
assign iui_inst_dis_stall   = 1'b0;


//----------------------------------------------------------
//                          Flush
//----------------------------------------------------------
// Not Flush inst:
//   1. CSRR
//   2. SYNC
//   3. FENCE
//   3. expt
assign iui_inst_flush = !(iui_inst_csr && !iui_csr_wen
                       || iui_inst_fence
                       || iui_inst_sfence
                       || iui_inst_sync
                       || iui_inst_vsetvl_raw
                       || iui_inst_nop)
                       && iui_inst_sel && !iui_expt_vld && !iui_cancel;


//----------------------------------------------------------
//                        Changeflow
//----------------------------------------------------------
// Chgflow inst:
//  1. mret
//  2. sret
assign iui_inst_chgflw = (iui_inst_mret || iui_inst_sret)
                      && !iui_expt_vld && !iui_cancel;
assign iui_chgflw_pc[39:0] = iui_inst_mret ? regs_iui_mepc[39:0]
                                           : regs_iui_sepc[39:0];


//----------------------------------------------------------
//                          Cmplt
//----------------------------------------------------------
assign iui_inst_cmplt = idu_cp0_ex1_sel && !iui_inst_issue_stall;

//----------------------------------------------------------
//                         WB Data
//----------------------------------------------------------
// 1. CSR rdata
// 2. vsetvl wdata
assign iui_wdata[63:0] = iui_inst_csr ? regs_iui_rdata[63:0]
                                      : special_iui_vsetvl_wdata[63:0];

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
// &Force("output","iui_regs_csr_en"); @381
assign iui_regs_imm[11:0]   = iui_inst_imm[11:0];
assign iui_regs_csr_wen     = iui_csr_wen_vld;
assign iui_regs_csr_wen_no_imm_ill = iui_csr_wen_vld_no_imm_ill;
assign iui_regs_csr_write   = iui_csr_wen;
assign iui_regs_csr_write_no_imm_ill = iui_csr_write_no_imm_ill;
assign iui_regs_csr_en      = iui_inst_csr && !iui_csr_expt_vld;
assign iui_regs_wdata[63:0] = iui_csr_wdata[63:0];

assign iui_regs_inst_mret   = iui_inst_mret && !iui_special_expt_vld;
assign iui_regs_inst_sret   = iui_inst_sret && !iui_special_expt_vld;

assign iui_special_fence    = iui_inst_fence  && !iui_special_expt_vld;
assign iui_special_fencei   = iui_inst_fencei && !iui_special_expt_vld;
assign iui_special_sfence   = iui_inst_sfence && !iui_special_expt_vld;
assign iui_special_sync     = iui_inst_sync   && !iui_special_expt_vld;
assign iui_special_synci    = iui_inst_synci  && !iui_special_expt_vld;
assign iui_special_wfi      = iui_inst_wfi    && !iui_special_expt_vld;
assign iui_special_cache    = iui_inst_cache  && !iui_special_expt_vld;
assign iui_special_vsetvl   = iui_inst_vsetvl;
assign iui_special_vsetvl_dp = iui_inst_vsetvl_raw;

// assign iui_special_imm[11:0] = iui_inst_imm[11:0];
assign iui_special_rs1[63:0] = iui_inst_rs1[63:0];
assign iui_special_rs1_x0 = iui_inst_rs1_x0;
assign iui_special_rs2[63:0] = iui_inst_rs2[63:0];
assign iui_special_rs2_x0 = iui_inst_rs2_x0;

assign iui_special_vsetvl_rs1[63:0] = iui_vsetvl_rs1[63:0];
assign iui_special_vsetvl_rs2[11:0] = iui_vsetvl_rs2[11:0];

assign iui_special_cache_func[5:0] = iui_inst_cache_func[5:0];

//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign cp0_rtu_ex1_cmplt           = iui_inst_cmplt;
assign cp0_rtu_ex1_cmplt_dp        = idu_cp0_ex1_dp_sel;
assign cp0_rtu_ex1_inst_len        = idu_cp0_ex1_length;
assign cp0_rtu_ex1_inst_split      = idu_cp0_ex1_split;
assign cp0_rtu_ex1_wb_dp           = iui_inst_dst_vld_dp;
assign cp0_rtu_ex1_wb_vld          = iui_inst_dst_vld && iui_inst_cmplt && !iui_expt_vld && !iui_cancel;
assign cp0_rtu_ex1_wb_preg[5:0]    = iui_inst_dst_idx[5:0];
assign cp0_rtu_ex1_wb_data[63:0]   = iui_wdata[63:0];
assign cp0_rtu_ex1_chgflw          = iui_inst_chgflw;
assign cp0_rtu_ex1_flush           = iui_inst_flush;
assign cp0_rtu_ex1_chgflw_pc[39:0] = iui_chgflw_pc[39:0];
assign cp0_rtu_ex1_inst_ebreak     = iui_inst_ebreak;
assign cp0_rtu_ex1_inst_dret       = iui_inst_dret;
assign cp0_rtu_ex1_inst_mret       = iui_inst_mret;
assign cp0_rtu_ex1_inst_sret       = iui_inst_sret;
assign cp0_rtu_ex1_vs_dirty        = iui_inst_vsetvl;
assign cp0_rtu_ex1_vs_dirty_dp     = iui_inst_vsetvl_raw;

assign cp0_rtu_ex1_expt_vld                      = iui_expt_vld && idu_cp0_ex1_dp_sel;
assign cp0_rtu_ex1_expt_vec[4:0]                 = {1'b0, iui_expt_vec[3:0]};
assign cp0_rtu_ex1_expt_tval[`PA_WIDTH-1:0]      = iui_expt_tval[`PA_WIDTH-1:0];

assign cp0_rtu_ex1_halt_info[`TDT_HINFO_WIDTH-1:0] = iui_inst_halt_info[`TDT_HINFO_WIDTH-1:0];

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign cp0_idu_vsetvl_dis_stall = iui_inst_dis_stall;
assign cp0_idu_issue_stall      = iui_inst_issue_stall;

//----------------------------------------------------------
//                         For HPCP
//----------------------------------------------------------
assign cp0_hpcp_index[11:0] = iui_inst_imm[11:0];
assign cp0_hpcp_wreg        = iui_csr_wen_vld;
assign cp0_hpcp_wdata[63:0] = iui_csr_wdata[63:0];

//----------------------------------------------------------
//                         For PMP
//----------------------------------------------------------
assign cp0_pmp_addr[11:0]  = iui_inst_imm[11:0];
assign cp0_pmp_wreg        = iui_csr_wen_vld;
assign cp0_pmp_wdata[63:0] = iui_csr_wdata[63:0];

//----------------------------------------------------------
//                         For MMU
//----------------------------------------------------------
assign cp0_mmu_addr[11:0]  = iui_inst_imm[11:0];
assign cp0_mmu_wreg        = iui_csr_wen_vld;
assign cp0_mmu_wdata[63:0] = iui_csr_wdata[63:0];

//----------------------------------------------------------
//                         For DTU
//----------------------------------------------------------
assign cp0_dtu_wreg        = iui_csr_wen_vld;
assign cp0_dtu_rreg        = iui_regs_csr_en;
assign cp0_dtu_addr[11:0]  = iui_inst_imm[11:0];
assign cp0_dtu_wdata[63:0] = iui_csr_wdata[63:0];



// &ModuleEnd; @503
endmodule



