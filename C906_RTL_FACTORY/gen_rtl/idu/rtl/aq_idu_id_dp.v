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

// &Depend("aq_idu_cfig.h"); @26
// &Depend("aq_dtu_cfig.h"); @27
// &ModuleBeg; @28
module aq_idu_id_dp(
  cp0_idu_icg_en,
  cp0_idu_vlmul,
  cp0_idu_vsew,
  cp0_yy_clk_en,
  ctrl_dp_dis_int_inst_gateclk_vld,
  ctrl_dp_dis_vec_inst_gateclk_vld,
  ctrl_dp_ex1_stall,
  decd_dp_inst_data,
  dp_ctrl_dis_inst_cancel,
  dp_ctrl_dis_inst_cp0_fence,
  dp_ctrl_dis_inst_dst0_type,
  dp_ctrl_dis_inst_dst0_vld,
  dp_ctrl_dis_inst_dst1_type,
  dp_ctrl_dis_inst_dst1_vld,
  dp_ctrl_dis_inst_eu,
  dp_ctrl_dis_inst_expt_vld,
  dp_ctrl_dis_inst_func,
  dp_ctrl_dis_inst_src0_vld,
  dp_ctrl_dis_inst_src1_vld,
  dp_ctrl_dis_inst_src2_vld,
  dp_ctrl_dis_inst_src_type,
  dp_ctrl_dis_inst_store,
  dp_ctrl_dis_inst_vec,
  dp_ctrl_inst_amo,
  dp_ctrl_inst_csr,
  dp_ctrl_inst_ecall,
  dp_ctrl_inst_sync,
  dp_ctrl_src0_fwd_vld,
  dp_ctrl_src1_fwd_vld,
  dp_ctrl_src2_fwd_vld,
  dp_decd_inst,
  dp_decd_vlmul,
  dp_decd_vsew,
  dp_gpr_src0_reg,
  dp_gpr_src1_reg,
  dp_gpr_src2_reg,
  dp_gpr_wb0_vld,
  dp_gpr_wb1_vld,
  dp_split_inst,
  dp_wbt_dst0_reg,
  dp_wbt_dst0_type,
  dp_wbt_dst1_reg,
  dp_wbt_dst1_type,
  dp_wbt_inst_dst0_vld,
  dp_wbt_inst_dst1_vld,
  dp_wbt_src0_reg,
  dp_wbt_src1_reg,
  dp_wbt_src2_reg,
  dp_wbt_wb_vld,
  forever_cpuclk,
  gpr_dp_src0_data,
  gpr_dp_src1_data,
  gpr_dp_src2_data,
  idu_cp0_ex1_dst0_reg,
  idu_cp0_ex1_expt_acc_error,
  idu_cp0_ex1_expt_high,
  idu_cp0_ex1_expt_illegal,
  idu_cp0_ex1_expt_page_fault,
  idu_cp0_ex1_func,
  idu_cp0_ex1_halt_info,
  idu_cp0_ex1_length,
  idu_cp0_ex1_opcode,
  idu_cp0_ex1_split,
  idu_cp0_ex1_src0_data,
  idu_cp0_ex1_src1_data,
  idu_iu_ex1_bht_pred,
  idu_iu_ex1_dst0_reg,
  idu_iu_ex1_func,
  idu_iu_ex1_length,
  idu_iu_ex1_split,
  idu_iu_ex1_src0_data,
  idu_iu_ex1_src0_ready,
  idu_iu_ex1_src0_reg,
  idu_iu_ex1_src1_data,
  idu_iu_ex1_src1_ready,
  idu_iu_ex1_src1_reg,
  idu_iu_ex1_src2_data,
  idu_lsu_ex1_dst0_reg,
  idu_lsu_ex1_dst1_reg,
  idu_lsu_ex1_func,
  idu_lsu_ex1_halt_info,
  idu_lsu_ex1_length,
  idu_lsu_ex1_split,
  idu_lsu_ex1_src0_data,
  idu_lsu_ex1_src1_data,
  idu_lsu_ex1_src2_data,
  idu_lsu_ex1_src2_ready,
  idu_lsu_ex1_src2_reg,
  idu_lsu_ex1_vlmul,
  idu_lsu_ex1_vsew,
  idu_vidu_ex1_inst_data,
  ifu_idu_id_bht_pred,
  ifu_idu_id_expt_acc_error,
  ifu_idu_id_expt_high,
  ifu_idu_id_expt_page_fault,
  ifu_idu_id_halt_info,
  ifu_idu_id_inst,
  ifu_idu_warm_up,
  pad_yy_icg_scan_en,
  rtu_idu_fwd0_data,
  rtu_idu_fwd0_reg,
  rtu_idu_fwd0_vld,
  rtu_idu_fwd1_data,
  rtu_idu_fwd1_reg,
  rtu_idu_fwd1_vld,
  rtu_idu_fwd2_data,
  rtu_idu_fwd2_reg,
  rtu_idu_fwd2_vld,
  rtu_idu_wb0_data,
  rtu_idu_wb0_reg,
  rtu_idu_wb0_vld,
  rtu_idu_wb1_data,
  rtu_idu_wb1_reg,
  rtu_idu_wb1_vld,
  split_dp_inst_data,
  split_dp_inst_sel,
  wbt_ctrl_src0_info,
  wbt_ctrl_src1_info,
  wbt_ctrl_src2_info
);

// &Ports; @29
input            cp0_idu_icg_en;                  
input   [1  :0]  cp0_idu_vlmul;                   
input   [1  :0]  cp0_idu_vsew;                    
input            cp0_yy_clk_en;                   
input            ctrl_dp_dis_int_inst_gateclk_vld; 
input            ctrl_dp_dis_vec_inst_gateclk_vld; 
input            ctrl_dp_ex1_stall;               
input   [264:0]  decd_dp_inst_data;               
input            forever_cpuclk;                  
input   [63 :0]  gpr_dp_src0_data;                
input   [63 :0]  gpr_dp_src1_data;                
input   [63 :0]  gpr_dp_src2_data;                
input   [1  :0]  ifu_idu_id_bht_pred;             
input            ifu_idu_id_expt_acc_error;       
input            ifu_idu_id_expt_high;            
input            ifu_idu_id_expt_page_fault;      
input   [21 :0]  ifu_idu_id_halt_info;            
input   [31 :0]  ifu_idu_id_inst;                 
input            ifu_idu_warm_up;                 
input            pad_yy_icg_scan_en;              
input   [63 :0]  rtu_idu_fwd0_data;               
input   [5  :0]  rtu_idu_fwd0_reg;                
input            rtu_idu_fwd0_vld;                
input   [63 :0]  rtu_idu_fwd1_data;               
input   [5  :0]  rtu_idu_fwd1_reg;                
input            rtu_idu_fwd1_vld;                
input   [63 :0]  rtu_idu_fwd2_data;               
input   [5  :0]  rtu_idu_fwd2_reg;                
input            rtu_idu_fwd2_vld;                
input   [63 :0]  rtu_idu_wb0_data;                
input   [5  :0]  rtu_idu_wb0_reg;                 
input            rtu_idu_wb0_vld;                 
input   [63 :0]  rtu_idu_wb1_data;                
input   [5  :0]  rtu_idu_wb1_reg;                 
input            rtu_idu_wb1_vld;                 
input   [264:0]  split_dp_inst_data;              
input            split_dp_inst_sel;               
input   [6  :0]  wbt_ctrl_src0_info;              
input   [6  :0]  wbt_ctrl_src1_info;              
input   [6  :0]  wbt_ctrl_src2_info;              
output           dp_ctrl_dis_inst_cancel;         
output           dp_ctrl_dis_inst_cp0_fence;      
output  [2  :0]  dp_ctrl_dis_inst_dst0_type;      
output           dp_ctrl_dis_inst_dst0_vld;       
output  [2  :0]  dp_ctrl_dis_inst_dst1_type;      
output           dp_ctrl_dis_inst_dst1_vld;       
output  [9  :0]  dp_ctrl_dis_inst_eu;             
output           dp_ctrl_dis_inst_expt_vld;       
output  [19 :0]  dp_ctrl_dis_inst_func;           
output           dp_ctrl_dis_inst_src0_vld;       
output           dp_ctrl_dis_inst_src1_vld;       
output           dp_ctrl_dis_inst_src2_vld;       
output  [2  :0]  dp_ctrl_dis_inst_src_type;       
output           dp_ctrl_dis_inst_store;          
output           dp_ctrl_dis_inst_vec;            
output           dp_ctrl_inst_amo;                
output           dp_ctrl_inst_csr;                
output           dp_ctrl_inst_ecall;              
output           dp_ctrl_inst_sync;               
output           dp_ctrl_src0_fwd_vld;            
output           dp_ctrl_src1_fwd_vld;            
output           dp_ctrl_src2_fwd_vld;            
output  [31 :0]  dp_decd_inst;                    
output  [1  :0]  dp_decd_vlmul;                   
output  [1  :0]  dp_decd_vsew;                    
output  [5  :0]  dp_gpr_src0_reg;                 
output  [5  :0]  dp_gpr_src1_reg;                 
output  [5  :0]  dp_gpr_src2_reg;                 
output  [31 :0]  dp_gpr_wb0_vld;                  
output  [31 :0]  dp_gpr_wb1_vld;                  
output  [31 :0]  dp_split_inst;                   
output  [5  :0]  dp_wbt_dst0_reg;                 
output  [2  :0]  dp_wbt_dst0_type;                
output  [5  :0]  dp_wbt_dst1_reg;                 
output  [2  :0]  dp_wbt_dst1_type;                
output           dp_wbt_inst_dst0_vld;            
output           dp_wbt_inst_dst1_vld;            
output  [5  :0]  dp_wbt_src0_reg;                 
output  [5  :0]  dp_wbt_src1_reg;                 
output  [5  :0]  dp_wbt_src2_reg;                 
output  [31 :0]  dp_wbt_wb_vld;                   
output  [5  :0]  idu_cp0_ex1_dst0_reg;            
output           idu_cp0_ex1_expt_acc_error;      
output           idu_cp0_ex1_expt_high;           
output           idu_cp0_ex1_expt_illegal;        
output           idu_cp0_ex1_expt_page_fault;     
output  [19 :0]  idu_cp0_ex1_func;                
output  [21 :0]  idu_cp0_ex1_halt_info;           
output           idu_cp0_ex1_length;              
output  [31 :0]  idu_cp0_ex1_opcode;              
output           idu_cp0_ex1_split;               
output  [63 :0]  idu_cp0_ex1_src0_data;           
output  [63 :0]  idu_cp0_ex1_src1_data;           
output  [1  :0]  idu_iu_ex1_bht_pred;             
output  [5  :0]  idu_iu_ex1_dst0_reg;             
output  [19 :0]  idu_iu_ex1_func;                 
output           idu_iu_ex1_length;               
output           idu_iu_ex1_split;                
output  [63 :0]  idu_iu_ex1_src0_data;            
output           idu_iu_ex1_src0_ready;           
output  [5  :0]  idu_iu_ex1_src0_reg;             
output  [63 :0]  idu_iu_ex1_src1_data;            
output           idu_iu_ex1_src1_ready;           
output  [5  :0]  idu_iu_ex1_src1_reg;             
output  [63 :0]  idu_iu_ex1_src2_data;            
output  [5  :0]  idu_lsu_ex1_dst0_reg;            
output  [5  :0]  idu_lsu_ex1_dst1_reg;            
output  [19 :0]  idu_lsu_ex1_func;                
output  [21 :0]  idu_lsu_ex1_halt_info;           
output           idu_lsu_ex1_length;              
output           idu_lsu_ex1_split;               
output  [63 :0]  idu_lsu_ex1_src0_data;           
output  [63 :0]  idu_lsu_ex1_src1_data;           
output  [63 :0]  idu_lsu_ex1_src2_data;           
output           idu_lsu_ex1_src2_ready;          
output  [5  :0]  idu_lsu_ex1_src2_reg;            
output  [1  :0]  idu_lsu_ex1_vlmul;               
output  [1  :0]  idu_lsu_ex1_vsew;                
output  [179:0]  idu_vidu_ex1_inst_data;          

// &Regs; @30
reg     [63 :0]  dp_dis_int_inst_src1_data;       
reg     [63 :0]  dp_dis_int_inst_src2_data;       
reg     [63 :0]  dp_fwd_src0_data;                
reg     [63 :0]  dp_fwd_src1_data;                
reg     [63 :0]  dp_fwd_src2_data;                
reg     [310:0]  ex1_int_inst_data;               
reg     [179:0]  ex1_vec_inst_data;               

// &Wires; @31
wire             cp0_idu_icg_en;                  
wire    [1  :0]  cp0_idu_vlmul;                   
wire    [1  :0]  cp0_idu_vsew;                    
wire             cp0_yy_clk_en;                   
wire             ctrl_dp_dis_int_inst_gateclk_vld; 
wire             ctrl_dp_dis_vec_inst_gateclk_vld; 
wire             ctrl_dp_ex1_stall;               
wire    [264:0]  decd_dp_inst_data;               
wire             dp_ctrl_dis_inst_cancel;         
wire             dp_ctrl_dis_inst_cp0_fence;      
wire    [2  :0]  dp_ctrl_dis_inst_dst0_type;      
wire             dp_ctrl_dis_inst_dst0_vld;       
wire    [2  :0]  dp_ctrl_dis_inst_dst1_type;      
wire             dp_ctrl_dis_inst_dst1_vld;       
wire    [9  :0]  dp_ctrl_dis_inst_eu;             
wire             dp_ctrl_dis_inst_expt_vld;       
wire    [19 :0]  dp_ctrl_dis_inst_func;           
wire             dp_ctrl_dis_inst_src0_vld;       
wire             dp_ctrl_dis_inst_src1_vld;       
wire             dp_ctrl_dis_inst_src2_vld;       
wire    [2  :0]  dp_ctrl_dis_inst_src_type;       
wire             dp_ctrl_dis_inst_store;          
wire             dp_ctrl_dis_inst_vec;            
wire             dp_ctrl_inst_amo;                
wire             dp_ctrl_inst_csr;                
wire             dp_ctrl_inst_ecall;              
wire             dp_ctrl_inst_sync;               
wire             dp_ctrl_src0_fwd_vld;            
wire             dp_ctrl_src1_fwd_vld;            
wire             dp_ctrl_src2_fwd_vld;            
wire    [31 :0]  dp_decd_inst;                    
wire    [1  :0]  dp_decd_vlmul;                   
wire    [1  :0]  dp_decd_vsew;                    
wire    [310:0]  dp_dis_int_inst_data;            
wire    [179:0]  dp_dis_vec_inst_data;            
wire             dp_ex1_src0_match_wb0;           
wire             dp_ex1_src0_match_wb1;           
wire    [63 :0]  dp_ex1_src0_wb_data;             
wire             dp_ex1_src0_wb_vld;              
wire             dp_ex1_src1_match_wb0;           
wire             dp_ex1_src1_match_wb1;           
wire    [63 :0]  dp_ex1_src1_wb_data;             
wire             dp_ex1_src1_wb_vld;              
wire             dp_ex1_src2_match_wb0;           
wire             dp_ex1_src2_match_wb1;           
wire    [63 :0]  dp_ex1_src2_wb_data;             
wire             dp_ex1_src2_wb_vld;              
wire             dp_fwd_src0_fwd_vld;             
wire    [2  :0]  dp_fwd_src0_sel;                 
wire             dp_fwd_src1_fwd_vld;             
wire    [2  :0]  dp_fwd_src1_sel;                 
wire             dp_fwd_src2_fwd_vld;             
wire    [2  :0]  dp_fwd_src2_sel;                 
wire    [63 :0]  dp_gpr_src0_data;                
wire    [5  :0]  dp_gpr_src0_reg;                 
wire    [63 :0]  dp_gpr_src1_data;                
wire    [5  :0]  dp_gpr_src1_reg;                 
wire    [63 :0]  dp_gpr_src2_data;                
wire    [5  :0]  dp_gpr_src2_reg;                 
wire    [31 :0]  dp_gpr_wb0_vld;                  
wire    [31 :0]  dp_gpr_wb1_vld;                  
wire    [264:0]  dp_id_inst_data;                 
wire    [31 :0]  dp_split_inst;                   
wire             dp_srcvx_bank_mask;              
wire    [4  :0]  dp_wb0_reg;                      
wire    [31 :0]  dp_wb0_reg_expand;               
wire    [31 :0]  dp_wb0_vld;                      
wire    [4  :0]  dp_wb1_reg;                      
wire    [31 :0]  dp_wb1_reg_expand;               
wire    [31 :0]  dp_wb1_vld;                      
wire    [2  :0]  dp_wb_dst0_type;                 
wire    [2  :0]  dp_wb_dst1_type;                 
wire             dp_wb_inst_type_mask;            
wire    [5  :0]  dp_wbt_dst0_reg;                 
wire    [2  :0]  dp_wbt_dst0_type;                
wire    [5  :0]  dp_wbt_dst1_reg;                 
wire    [2  :0]  dp_wbt_dst1_type;                
wire             dp_wbt_inst_dst0_vld;            
wire             dp_wbt_inst_dst1_vld;            
wire    [5  :0]  dp_wbt_src0_reg;                 
wire    [5  :0]  dp_wbt_src1_reg;                 
wire    [5  :0]  dp_wbt_src2_reg;                 
wire    [31 :0]  dp_wbt_wb_vld;                   
wire             ex1_int_inst_clk;                
wire             ex1_int_inst_clk_en;             
wire             ex1_int_src0_clk;                
wire             ex1_int_src0_clk_en;             
wire             ex1_int_src1_clk;                
wire             ex1_int_src1_clk_en;             
wire             ex1_int_src2_clk;                
wire             ex1_int_src2_clk_en;             
wire             ex1_vec_inst_clk;                
wire             ex1_vec_inst_clk_en;             
wire             ex1_vec_src1_clk;                
wire             ex1_vec_src1_clk_en;             
wire             forever_cpuclk;                  
wire    [63 :0]  gpr_dp_src0_data;                
wire    [63 :0]  gpr_dp_src1_data;                
wire    [63 :0]  gpr_dp_src2_data;                
wire    [5  :0]  idu_cp0_ex1_dst0_reg;            
wire             idu_cp0_ex1_expt_acc_error;      
wire             idu_cp0_ex1_expt_high;           
wire             idu_cp0_ex1_expt_illegal;        
wire             idu_cp0_ex1_expt_page_fault;     
wire    [19 :0]  idu_cp0_ex1_func;                
wire    [21 :0]  idu_cp0_ex1_halt_info;           
wire             idu_cp0_ex1_length;              
wire    [31 :0]  idu_cp0_ex1_opcode;              
wire             idu_cp0_ex1_split;               
wire    [63 :0]  idu_cp0_ex1_src0_data;           
wire    [63 :0]  idu_cp0_ex1_src1_data;           
wire    [1  :0]  idu_iu_ex1_bht_pred;             
wire    [5  :0]  idu_iu_ex1_dst0_reg;             
wire    [19 :0]  idu_iu_ex1_func;                 
wire             idu_iu_ex1_length;               
wire             idu_iu_ex1_split;                
wire    [63 :0]  idu_iu_ex1_src0_data;            
wire             idu_iu_ex1_src0_ready;           
wire    [5  :0]  idu_iu_ex1_src0_reg;             
wire    [63 :0]  idu_iu_ex1_src1_data;            
wire             idu_iu_ex1_src1_ready;           
wire    [5  :0]  idu_iu_ex1_src1_reg;             
wire    [63 :0]  idu_iu_ex1_src2_data;            
wire    [5  :0]  idu_lsu_ex1_dst0_reg;            
wire    [5  :0]  idu_lsu_ex1_dst1_reg;            
wire    [19 :0]  idu_lsu_ex1_func;                
wire    [21 :0]  idu_lsu_ex1_halt_info;           
wire             idu_lsu_ex1_length;              
wire             idu_lsu_ex1_split;               
wire    [63 :0]  idu_lsu_ex1_src0_data;           
wire    [63 :0]  idu_lsu_ex1_src1_data;           
wire    [63 :0]  idu_lsu_ex1_src2_data;           
wire             idu_lsu_ex1_src2_ready;          
wire    [5  :0]  idu_lsu_ex1_src2_reg;            
wire    [1  :0]  idu_lsu_ex1_vlmul;               
wire    [1  :0]  idu_lsu_ex1_vsew;                
wire    [179:0]  idu_vidu_ex1_inst_data;          
wire    [1  :0]  ifu_idu_id_bht_pred;             
wire             ifu_idu_id_expt_acc_error;       
wire             ifu_idu_id_expt_high;            
wire             ifu_idu_id_expt_page_fault;      
wire    [21 :0]  ifu_idu_id_halt_info;            
wire    [31 :0]  ifu_idu_id_inst;                 
wire             ifu_idu_warm_up;                 
wire             pad_yy_icg_scan_en;              
wire    [63 :0]  rtu_idu_fwd0_data;               
wire    [5  :0]  rtu_idu_fwd0_reg;                
wire             rtu_idu_fwd0_vld;                
wire    [63 :0]  rtu_idu_fwd1_data;               
wire    [5  :0]  rtu_idu_fwd1_reg;                
wire             rtu_idu_fwd1_vld;                
wire    [63 :0]  rtu_idu_fwd2_data;               
wire    [5  :0]  rtu_idu_fwd2_reg;                
wire             rtu_idu_fwd2_vld;                
wire    [63 :0]  rtu_idu_wb0_data;                
wire    [5  :0]  rtu_idu_wb0_reg;                 
wire             rtu_idu_wb0_vld;                 
wire    [63 :0]  rtu_idu_wb1_data;                
wire    [5  :0]  rtu_idu_wb1_reg;                 
wire             rtu_idu_wb1_vld;                 
wire    [264:0]  split_dp_inst_data;              
wire             split_dp_inst_sel;               
wire    [6  :0]  wbt_ctrl_src0_info;              
wire    [6  :0]  wbt_ctrl_src1_info;              
wire    [6  :0]  wbt_ctrl_src2_info;              


//==========================================================
//                Input Instruction Data
//==========================================================
//----------------------------------------------------------
//                   Decoder Input
//----------------------------------------------------------
assign dp_decd_inst[31:0] = ifu_idu_id_inst[31:0];
assign dp_decd_vsew[1:0]  = cp0_idu_vsew[1:0];
assign dp_decd_vlmul[1:0] = cp0_idu_vlmul[1:0];

//----------------------------------------------------------
//                    Split Input
//----------------------------------------------------------
assign dp_split_inst[31:0] = ifu_idu_id_inst[31:0];

//==========================================================
//              Dispatch Instruction Data
//==========================================================
//----------------------------------------------------------
//             MUX between Decoder and Spliter
//----------------------------------------------------------
assign dp_id_inst_data[`IDU_WIDTH-1:0] = split_dp_inst_sel
                                        ? split_dp_inst_data[`IDU_WIDTH-1:0]
                                        : decd_dp_inst_data[`IDU_WIDTH-1:0];

//----------------------------------------------------------
//         Dispatch Integer Instruction Information
//----------------------------------------------------------
assign dp_dis_int_inst_data[`DIS_INT_OPCODE:`DIS_INT_OPCODE-31]        = dp_id_inst_data[`IDU_OPCODE:`IDU_OPCODE-31];
assign dp_dis_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1] = dp_id_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1];
assign dp_dis_int_inst_data[`DIS_INT_LENGTH]                           = dp_id_inst_data[`IDU_LENGTH];
assign dp_dis_int_inst_data[`DIS_INT_SPLIT]                            = dp_id_inst_data[`IDU_SPLIT];
assign dp_dis_int_inst_data[`DIS_INT_VLMUL:`DIS_INT_VLMUL-1]           = cp0_idu_vlmul[1:0];
assign dp_dis_int_inst_data[`DIS_INT_VSEW:`DIS_INT_VSEW-1]             = cp0_idu_vsew[1:0];

assign dp_dis_int_inst_data[`DIS_INT_DST0_REG:`DIS_INT_DST0_REG-5]     = dp_id_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5];
assign dp_dis_int_inst_data[`DIS_INT_DST1_REG:`DIS_INT_DST1_REG-5]     = dp_id_inst_data[`IDU_DST1_REG:`IDU_DST1_REG-5];
assign dp_dis_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5]     = dp_id_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5];
assign dp_dis_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5]     = dp_id_inst_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5];
assign dp_dis_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5]     = dp_id_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5];

//----------------------------------------------------------
//         Dispatch Vector Instruction Information
//----------------------------------------------------------
assign dp_dis_vec_inst_data[`DIS_VEC_FUNC:`DIS_VEC_FUNC-`FUNC_WIDTH+1] = dp_id_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1];
assign dp_dis_vec_inst_data[`DIS_VEC_EU:`DIS_VEC_EU-`EU_WIDTH+1]       = dp_id_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1];
assign dp_dis_vec_inst_data[`DIS_VEC_SPLIT_TYPE:`DIS_VEC_SPLIT_TYPE-3] = dp_id_inst_data[`IDU_VEC_SPLIT_TYPE:`IDU_VEC_SPLIT_TYPE-3];
assign dp_dis_vec_inst_data[`DIS_VEC_VLMUL:`DIS_VEC_VLMUL-1]           = cp0_idu_vlmul[1:0];
assign dp_dis_vec_inst_data[`DIS_VEC_VSEW:`DIS_VEC_VSEW-1]             = cp0_idu_vsew[1:0];

assign dp_dis_vec_inst_data[`DIS_VEC_DSTF_VLD]                         = dp_id_inst_data[`IDU_DSTF_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_DSTE_VLD]                         = dp_id_inst_data[`IDU_DSTE_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_DSTV_LATE_VLD]                    = dp_id_inst_data[`IDU_DSTV_LATE_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_DSTV_VLD]                         = dp_id_inst_data[`IDU_DSTV_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_DST0_VLD]                         = dp_id_inst_data[`IDU_DST0_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_SRCF0_VLD]                        = dp_id_inst_data[`IDU_SRCF0_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_SRCF1_VLD]                        = dp_id_inst_data[`IDU_SRCF1_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_SRCF2_VLD]                        = dp_id_inst_data[`IDU_SRCF2_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_SRCV0_VLD]                        = dp_id_inst_data[`IDU_SRCV0_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_SRCV1_VLD]                        = dp_id_inst_data[`IDU_SRCV1_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_SRCV2_VLD]                        = dp_id_inst_data[`IDU_SRCV2_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_SRCVM_VLD]                        = dp_id_inst_data[`IDU_SRCVM_VLD];
assign dp_dis_vec_inst_data[`DIS_VEC_DST0_REG:`DIS_VEC_DST0_REG-5]     = dp_id_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5];
//vector reg is extended to 6 bits, MSB will be used to indicate vector gpr bank
assign dp_srcvx_bank_mask                                               = 1'b1;  
assign dp_dis_vec_inst_data[`DIS_VEC_DSTV_REG:`DIS_VEC_DSTV_REG-12]    = {8'b1,dp_id_inst_data[`IDU_DSTV_REG:`IDU_DSTV_REG-4]}
                                                                       | {6'b0,!dp_srcvx_bank_mask,1'b0,5'b0};
assign dp_dis_vec_inst_data[`DIS_VEC_SRCV0_REG:`DIS_VEC_SRCV0_REG-12]  = {8'b1,dp_id_inst_data[`IDU_SRCV0_REG:`IDU_SRCV0_REG-4]}
                                                                       | {6'b0,!dp_srcvx_bank_mask,1'b0,5'b0};
assign dp_dis_vec_inst_data[`DIS_VEC_SRCV1_REG:`DIS_VEC_SRCV1_REG-12]  = {8'b1,dp_id_inst_data[`IDU_SRCV1_REG:`IDU_SRCV1_REG-4]}
                                                                       | {6'b0,!dp_srcvx_bank_mask,1'b0,5'b0};
assign dp_dis_vec_inst_data[`DIS_VEC_SRCV2_REG:`DIS_VEC_SRCV2_REG-12]  = {8'b1,dp_id_inst_data[`IDU_SRCV2_REG:`IDU_SRCV2_REG-4]}
                                                                       | {6'b0,!dp_srcvx_bank_mask,1'b0,5'b0};
assign dp_dis_vec_inst_data[`DIS_VEC_SRCVM_REG:`DIS_VEC_SRCVM_REG-7]   = 8'b1 | {6'b0,!dp_srcvx_bank_mask,1'b0};

//----------------------------------------------------------
//                Output Control Logic
//----------------------------------------------------------
assign dp_ctrl_dis_inst_eu[`EU_WIDTH-1:0]                              = dp_id_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1];
assign dp_ctrl_dis_inst_func[`FUNC_WIDTH-1:0]                          = dp_id_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1];
assign dp_ctrl_dis_inst_cp0_fence                                      = dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_CP0_SEL]
                                                                         && !(|dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_VEC_SEL:`IDU_EU-`EU_WIDTH+1+`EU_FP_SEL])
                                                                         && !dp_id_inst_data[`IDU_FUNC-`FUNC_WIDTH+1+`FUNC_NO_FENCE_SEL];
assign dp_ctrl_dis_inst_store                                          = dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_LSU_SEL]
                                                                         && dp_id_inst_data[`IDU_FUNC-`FUNC_WIDTH+1+`FUNC_STORE_SEL];
assign dp_ctrl_dis_inst_vec                                            = dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_VEC_SEL];
assign dp_ctrl_dis_inst_cancel                                         = ifu_idu_id_halt_info[`TDT_HINFO_CANCEL];

assign dp_ctrl_dis_inst_dst0_vld                                       = dp_id_inst_data[`IDU_DST0_VLD];
assign dp_ctrl_dis_inst_dst1_vld                                       = dp_id_inst_data[`IDU_DST1_VLD];
assign dp_ctrl_dis_inst_src0_vld                                       = dp_id_inst_data[`IDU_SRC0_VLD];
assign dp_ctrl_dis_inst_src1_vld                                       = dp_id_inst_data[`IDU_SRC1_VLD];
assign dp_ctrl_dis_inst_src2_vld                                       = dp_id_inst_data[`IDU_SRC2_VLD];

//----------------------------------------------------------
//                     Exceptions
//----------------------------------------------------------
//timing optimization: split inst do not generate exception
assign dp_ctrl_dis_inst_expt_vld                                       = ifu_idu_id_expt_acc_error
                                                                         || ifu_idu_id_expt_page_fault
                                                                         || decd_dp_inst_data[`IDU_ILLEGAL];

assign dp_dis_int_inst_data[`DIS_INT_EXPT_ACC]                         = ifu_idu_id_expt_acc_error;
assign dp_dis_int_inst_data[`DIS_INT_EXPT_PAGE]                        = ifu_idu_id_expt_page_fault;
assign dp_dis_int_inst_data[`DIS_INT_EXPT_HIGH]                        = ifu_idu_id_expt_high;
assign dp_dis_int_inst_data[`DIS_INT_EXPT_ILLE]                        = decd_dp_inst_data[`IDU_ILLEGAL]
                                                                         && !ifu_idu_id_expt_acc_error
                                                                         && !ifu_idu_id_expt_page_fault;

//----------------------------------------------------------
//                     Debug and PC
//----------------------------------------------------------
assign dp_dis_int_inst_data[`DIS_INT_HINFO_MSB:`DIS_INT_HINFO_LSB] = ifu_idu_id_halt_info[`TDT_HINFO_WIDTH-1:0];
assign dp_dis_int_inst_data[`DIS_INT_BHT_PRED:`DIS_INT_BHT_PRED-1] = ifu_idu_id_bht_pred[1:0];

//==========================================================
//                     Access WBT
//==========================================================
assign dp_wbt_src0_reg[5:0] = dp_id_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5];
assign dp_wbt_src1_reg[5:0] = dp_id_inst_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5];
assign dp_wbt_src2_reg[5:0] = dp_id_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5];
assign dp_wbt_dst0_reg[5:0] = dp_id_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5];
assign dp_wbt_dst1_reg[5:0] = dp_id_inst_data[`IDU_DST1_REG:`IDU_DST1_REG-5];

assign dp_wb_inst_type_mask = !(dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_VEC_SEL]
                             || dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_FP_SEL]);
//if not special type, inst type is 0
assign dp_wb_dst0_type[2:0] =
    {3{dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_ALU_SEL]}}  & `WB_INT_TYPE_ALU
  | {3{dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_BJU_SEL]}}  & `WB_INT_TYPE_BJU
  | {3{dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_MULT_SEL]}} & `WB_INT_TYPE_MULT
  | {3{dp_id_inst_data[`IDU_EU-`EU_WIDTH+1+`EU_LSU_SEL]}}  & `WB_INT_TYPE_LSU;
//dst1 can only be alu from indexed load
assign dp_wb_dst1_type[2:0] = `WB_INT_TYPE_ALU;

assign dp_wbt_dst0_type[2:0]           = dp_wb_dst0_type[2:0] & {3{dp_wb_inst_type_mask}};
assign dp_wbt_dst1_type[2:0]           = dp_wb_dst1_type[2:0] & {3{dp_wb_inst_type_mask}};

assign dp_ctrl_dis_inst_dst0_type[2:0] = dp_wb_dst0_type[2:0] & {3{dp_wb_inst_type_mask}};
assign dp_ctrl_dis_inst_dst1_type[2:0] = dp_wb_dst1_type[2:0] & {3{dp_wb_inst_type_mask}};
//src type is same with dst0
assign dp_ctrl_dis_inst_src_type[2:0]  = dp_wb_dst0_type[2:0] & {3{dp_wb_inst_type_mask}};

assign dp_wbt_inst_dst0_vld            = dp_id_inst_data[`IDU_DST0_VLD];
assign dp_wbt_inst_dst1_vld            = dp_id_inst_data[`IDU_DST1_VLD];

//==========================================================
//                     Access GPR
//==========================================================
//----------------------------------------------------------
//                   Write Back Valid
//----------------------------------------------------------
// &Force("bus","rtu_idu_wb0_reg",5,0); @191
// &Force("bus","rtu_idu_wb1_reg",5,0); @192
assign dp_wb0_reg[4:0] = rtu_idu_wb0_reg[4:0];
assign dp_wb1_reg[4:0] = rtu_idu_wb1_reg[4:0];
// &ConnRule(s/^x_num/dp_wb0_reg/); @195
// &Instance("aq_idu_expand_32","x_aq_idu_expand_32_dp_wb0_reg"); @196
aq_idu_expand_32  x_aq_idu_expand_32_dp_wb0_reg (
  .x_num             (dp_wb0_reg       ),
  .x_num_expand      (dp_wb0_reg_expand)
);

// &ConnRule(s/^x_num/dp_wb1_reg/); @197
// &Instance("aq_idu_expand_32","x_aq_idu_expand_32_dp_wb1_reg"); @198
aq_idu_expand_32  x_aq_idu_expand_32_dp_wb1_reg (
  .x_num             (dp_wb1_reg       ),
  .x_num_expand      (dp_wb1_reg_expand)
);


assign dp_wb0_vld[31:0] = dp_wb0_reg_expand[31:0] & {32{rtu_idu_wb0_vld}};
assign dp_wb1_vld[31:0] = dp_wb1_reg_expand[31:0] & {32{rtu_idu_wb1_vld}};

assign dp_gpr_wb0_vld[31:0] = dp_wb0_vld[31:0];
assign dp_gpr_wb1_vld[31:0] = dp_wb1_vld[31:0];

assign dp_wbt_wb_vld[31:0]  = dp_wb0_vld[31:0]
                            | dp_wb1_vld[31:0];

//----------------------------------------------------------
//                Source and Dest Index
//----------------------------------------------------------
assign dp_gpr_src0_reg[5:0] = dp_id_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5] & {6{dp_id_inst_data[`IDU_SRC0_VLD]}};
assign dp_gpr_src1_reg[5:0] = dp_id_inst_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5] & {6{dp_id_inst_data[`IDU_SRC1_VLD]}};
assign dp_gpr_src2_reg[5:0] = dp_id_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5] & {6{dp_id_inst_data[`IDU_SRC2_VLD]}};

//----------------------------------------------------------
//                    GPR Read Data
//----------------------------------------------------------
assign dp_gpr_src0_data[63:0] = gpr_dp_src0_data[63:0];
assign dp_gpr_src1_data[63:0] = gpr_dp_src1_data[63:0];
assign dp_gpr_src2_data[63:0] = gpr_dp_src2_data[63:0];

//==========================================================
//                      Forward
//==========================================================
//----------------------------------------------------------
//                   src0 forward
//----------------------------------------------------------
assign dp_fwd_src0_sel[0] = rtu_idu_fwd0_vld
                            && (dp_id_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]
                                == rtu_idu_fwd0_reg[5:0]);
assign dp_fwd_src0_sel[1] = rtu_idu_fwd1_vld
                            && (dp_id_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]
                                == rtu_idu_fwd1_reg[5:0]);
assign dp_fwd_src0_sel[2] = rtu_idu_fwd2_vld
                            && (dp_id_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]
                                == rtu_idu_fwd2_reg[5:0]);
// &CombBeg; @238
always @( rtu_idu_fwd0_data[63:0]
       or rtu_idu_fwd1_data[63:0]
       or rtu_idu_fwd2_data[63:0]
       or dp_fwd_src0_sel[2:0])
begin
  case (dp_fwd_src0_sel[2:0])
    3'b001  : dp_fwd_src0_data[63:0] = rtu_idu_fwd0_data[63:0];
    3'b010  : dp_fwd_src0_data[63:0] = rtu_idu_fwd1_data[63:0];
    3'b100  : dp_fwd_src0_data[63:0] = rtu_idu_fwd2_data[63:0];
    default : dp_fwd_src0_data[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @245
end

assign dp_fwd_src0_fwd_vld  = (|dp_fwd_src0_sel[2:0])
                              && (dp_id_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5] != 6'b0);
assign dp_ctrl_src0_fwd_vld = dp_fwd_src0_fwd_vld;

//----------------------------------------------------------
//                   src1 forward
//----------------------------------------------------------
assign dp_fwd_src1_sel[0] = rtu_idu_fwd0_vld
                            && (dp_id_inst_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5]
                                == rtu_idu_fwd0_reg[5:0]);
assign dp_fwd_src1_sel[1] = rtu_idu_fwd1_vld
                            && (dp_id_inst_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5]
                                == rtu_idu_fwd1_reg[5:0]);
assign dp_fwd_src1_sel[2] = rtu_idu_fwd2_vld
                            && (dp_id_inst_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5]
                                == rtu_idu_fwd2_reg[5:0]);
// &CombBeg; @263
always @( rtu_idu_fwd0_data[63:0]
       or rtu_idu_fwd1_data[63:0]
       or rtu_idu_fwd2_data[63:0]
       or dp_fwd_src1_sel[2:0])
begin
  case (dp_fwd_src1_sel[2:0])
    3'b001  : dp_fwd_src1_data[63:0] = rtu_idu_fwd0_data[63:0];
    3'b010  : dp_fwd_src1_data[63:0] = rtu_idu_fwd1_data[63:0];
    3'b100  : dp_fwd_src1_data[63:0] = rtu_idu_fwd2_data[63:0];
    default : dp_fwd_src1_data[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @270
end

assign dp_fwd_src1_fwd_vld  = (|dp_fwd_src1_sel[2:0])
                              && (dp_id_inst_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5] != 6'b0);
assign dp_ctrl_src1_fwd_vld = dp_fwd_src1_fwd_vld;

//----------------------------------------------------------
//                   src2 forward
//----------------------------------------------------------
assign dp_fwd_src2_sel[0] = rtu_idu_fwd0_vld
                            && (dp_id_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]
                                == rtu_idu_fwd0_reg[5:0]);
assign dp_fwd_src2_sel[1] = rtu_idu_fwd1_vld
                            && (dp_id_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]
                                == rtu_idu_fwd1_reg[5:0]);
assign dp_fwd_src2_sel[2] = rtu_idu_fwd2_vld
                            && (dp_id_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]
                                == rtu_idu_fwd2_reg[5:0]);
// &CombBeg; @288
always @( rtu_idu_fwd0_data[63:0]
       or rtu_idu_fwd1_data[63:0]
       or dp_fwd_src2_sel[2:0]
       or rtu_idu_fwd2_data[63:0])
begin
  case (dp_fwd_src2_sel[2:0])
    3'b001  : dp_fwd_src2_data[63:0] = rtu_idu_fwd0_data[63:0];
    3'b010  : dp_fwd_src2_data[63:0] = rtu_idu_fwd1_data[63:0];
    3'b100  : dp_fwd_src2_data[63:0] = rtu_idu_fwd2_data[63:0];
    default : dp_fwd_src2_data[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @295
end

assign dp_fwd_src2_fwd_vld  = (|dp_fwd_src2_sel[2:0])
                              && (dp_id_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5] != 6'b0);
assign dp_ctrl_src2_fwd_vld = dp_fwd_src2_fwd_vld;

//==========================================================
//              Dispatch Instruction Operands
//==========================================================
//mux between GPR and forward bus and imm and opcode (cp0)
//----------------------------------------------------------
//                   src0 operand mux
//----------------------------------------------------------
// &Force("bus","wbt_ctrl_src0_info",`WB_INT_WIDTH-1,0); @308
assign dp_dis_int_inst_data[`DIS_INT_SRC0_DATA:`DIS_INT_SRC0_DATA-63] =
         dp_fwd_src0_fwd_vld ? dp_fwd_src0_data[63:0] : dp_gpr_src0_data[63:0];
//may forward data in exe unit, so indicate src vld
assign dp_dis_int_inst_data[`DIS_INT_SRC0_RDY] = wbt_ctrl_src0_info[`WB_INT_VLD]
                                                 || dp_fwd_src0_fwd_vld
                                                 || !dp_id_inst_data[`IDU_SRC0_VLD];

//----------------------------------------------------------
//                   src1 operand mux
//----------------------------------------------------------
// &Force("bus","wbt_ctrl_src1_info",`WB_INT_WIDTH-1,0); @319
// &CombBeg; @320
always @( dp_fwd_src1_data[63:0]
       or dp_id_inst_data[131:68]
       or dp_id_inst_data[1]
       or dp_fwd_src1_fwd_vld
       or dp_gpr_src1_data[63:0])
begin
  if(!dp_id_inst_data[`IDU_SRC1_VLD])
    dp_dis_int_inst_src1_data[63:0] = dp_id_inst_data[`IDU_SRC1_IMM:`IDU_SRC1_IMM-63];
  else if (dp_fwd_src1_fwd_vld)
    dp_dis_int_inst_src1_data[63:0] = dp_fwd_src1_data[63:0];
  else
    dp_dis_int_inst_src1_data[63:0] = dp_gpr_src1_data[63:0];
// &CombEnd; @327
end
//for dc syntax
assign dp_dis_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63] = dp_dis_int_inst_src1_data[63:0];
//may forward data in exe unit, so indicate src vld
assign dp_dis_int_inst_data[`DIS_INT_SRC1_RDY] = wbt_ctrl_src1_info[`WB_INT_VLD]
                                                 || dp_fwd_src1_fwd_vld
                                                 || !dp_id_inst_data[`IDU_SRC1_VLD];
//vec gpr source use src1
assign dp_dis_vec_inst_data[`DIS_VEC_SRC1_DATA:`DIS_VEC_SRC1_DATA-63] =
       dp_dis_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63];

//----------------------------------------------------------
//                   src2 operand mux
//----------------------------------------------------------
// &Force("bus","wbt_ctrl_src2_info",`WB_INT_WIDTH-1,0); @341
// &CombBeg; @342
always @( dp_fwd_src2_fwd_vld
       or dp_gpr_src2_data[63:0]
       or dp_id_inst_data[2]
       or dp_fwd_src2_data[63:0]
       or dp_id_inst_data[195:132])
begin
  if(!dp_id_inst_data[`IDU_SRC2_VLD])
    dp_dis_int_inst_src2_data[63:0] = dp_id_inst_data[`IDU_SRC2_IMM:`IDU_SRC2_IMM-63];
  else if (dp_fwd_src2_fwd_vld)
    dp_dis_int_inst_src2_data[63:0] = dp_fwd_src2_data[63:0];
  else
    dp_dis_int_inst_src2_data[63:0] = dp_gpr_src2_data[63:0];
// &CombEnd; @349
end
//for dc syntax
assign dp_dis_int_inst_data[`DIS_INT_SRC2_DATA:`DIS_INT_SRC2_DATA-63] = dp_dis_int_inst_src2_data[63:0];
//may forward data in exe unit, so indicate src vld
assign dp_dis_int_inst_data[`DIS_INT_SRC2_RDY] = wbt_ctrl_src2_info[`WB_INT_VLD]
                                                 || dp_fwd_src2_fwd_vld
                                                 || !dp_id_inst_data[`IDU_SRC2_VLD];

//==========================================================
//                EX1 Integer Pipeline Register
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign ex1_int_inst_clk_en = ifu_idu_warm_up
                             || ctrl_dp_dis_int_inst_gateclk_vld;
// &Instance("gated_clk_cell", "x_ex1_int_inst_gated_clk"); @365
gated_clk_cell  x_ex1_int_inst_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (ex1_int_inst_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (ex1_int_inst_clk_en),
  .module_en           (cp0_idu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in      (forever_cpuclk), @366
//          .external_en (1'b0), @367
//          .global_en   (cp0_yy_clk_en), @368
//          .module_en   (cp0_idu_icg_en), @369
//          .local_en    (ex1_int_inst_clk_en), @370
//          .clk_out     (ex1_int_inst_clk)); @371

assign ex1_int_src0_clk_en = ifu_idu_warm_up
                             || ctrl_dp_dis_int_inst_gateclk_vld
                                && dp_id_inst_data[`IDU_SRC0_VLD]
                             || dp_ex1_src0_wb_vld;
// &Instance("gated_clk_cell", "x_ex1_int_src0_gated_clk"); @377
gated_clk_cell  x_ex1_int_src0_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (ex1_int_src0_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (ex1_int_src0_clk_en),
  .module_en           (cp0_idu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in      (forever_cpuclk), @378
//          .external_en (1'b0), @379
//          .global_en   (cp0_yy_clk_en), @380
//          .module_en   (cp0_idu_icg_en), @381
//          .local_en    (ex1_int_src0_clk_en), @382
//          .clk_out     (ex1_int_src0_clk)); @383

assign ex1_int_src1_clk_en = ifu_idu_warm_up
                             || ctrl_dp_dis_int_inst_gateclk_vld
                                && (dp_id_inst_data[`IDU_SRC1_VLD]
                                 || dp_id_inst_data[`IDU_SRC1_IMM_VLD])
                             || dp_ex1_src1_wb_vld;
// &Instance("gated_clk_cell", "x_ex1_int_src1_gated_clk"); @390
gated_clk_cell  x_ex1_int_src1_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (ex1_int_src1_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (ex1_int_src1_clk_en),
  .module_en           (cp0_idu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in      (forever_cpuclk), @391
//          .external_en (1'b0), @392
//          .global_en   (cp0_yy_clk_en), @393
//          .module_en   (cp0_idu_icg_en), @394
//          .local_en    (ex1_int_src1_clk_en), @395
//          .clk_out     (ex1_int_src1_clk)); @396

assign ex1_int_src2_clk_en = ifu_idu_warm_up
                             || ctrl_dp_dis_int_inst_gateclk_vld
                                && (dp_id_inst_data[`IDU_SRC2_VLD]
                                 || dp_id_inst_data[`IDU_SRC2_IMM_VLD])
                             || dp_ex1_src2_wb_vld;
// &Instance("gated_clk_cell", "x_ex1_int_src2_gated_clk"); @403
gated_clk_cell  x_ex1_int_src2_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (ex1_int_src2_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (ex1_int_src2_clk_en),
  .module_en           (cp0_idu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in      (forever_cpuclk), @404
//          .external_en (1'b0), @405
//          .global_en   (cp0_yy_clk_en), @406
//          .module_en   (cp0_idu_icg_en), @407
//          .local_en    (ex1_int_src2_clk_en), @408
//          .clk_out     (ex1_int_src2_clk)); @409

//----------------------------------------------------------
//              EX1 Pipeline Source Forward
//----------------------------------------------------------
//when inst is stalled in ex1 stage with source not ready
//ex1 pipeline should forward when write back
assign dp_ex1_src0_match_wb0 = rtu_idu_wb0_vld
                               && (ex1_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5]
                                   == rtu_idu_wb0_reg[5:0]);
assign dp_ex1_src0_match_wb1 = rtu_idu_wb1_vld
                               && (ex1_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5]
                                   == rtu_idu_wb1_reg[5:0]);
assign dp_ex1_src1_match_wb0 = rtu_idu_wb0_vld
                               && (ex1_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5]
                                   == rtu_idu_wb0_reg[5:0]);
assign dp_ex1_src1_match_wb1 = rtu_idu_wb1_vld
                               && (ex1_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5]
                                   == rtu_idu_wb1_reg[5:0]);
assign dp_ex1_src2_match_wb0 = rtu_idu_wb0_vld
                               && (ex1_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5]
                                   == rtu_idu_wb0_reg[5:0]);
assign dp_ex1_src2_match_wb1 = rtu_idu_wb1_vld
                               && (ex1_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5]
                                   == rtu_idu_wb1_reg[5:0]);

assign dp_ex1_src0_wb_vld    = !ex1_int_inst_data[`DIS_INT_SRC0_RDY]
                               && (dp_ex1_src0_match_wb0 || dp_ex1_src0_match_wb1);
assign dp_ex1_src1_wb_vld    = !ex1_int_inst_data[`DIS_INT_SRC1_RDY]
                               && (dp_ex1_src1_match_wb0 || dp_ex1_src1_match_wb1);
assign dp_ex1_src2_wb_vld    = !ex1_int_inst_data[`DIS_INT_SRC2_RDY]
                               && (dp_ex1_src2_match_wb0 || dp_ex1_src2_match_wb1);

assign dp_ex1_src0_wb_data[63:0] = dp_ex1_src0_match_wb0 ? rtu_idu_wb0_data[63:0]
                                                         : rtu_idu_wb1_data[63:0];
assign dp_ex1_src1_wb_data[63:0] = dp_ex1_src1_match_wb0 ? rtu_idu_wb0_data[63:0]
                                                         : rtu_idu_wb1_data[63:0];
assign dp_ex1_src2_wb_data[63:0] = dp_ex1_src2_match_wb0 ? rtu_idu_wb0_data[63:0]
                                                         : rtu_idu_wb1_data[63:0];

//----------------------------------------------------------
//           Integer Inst EX1 Pipeline Registers
//----------------------------------------------------------
always @(posedge ex1_int_inst_clk)
begin
  if(ifu_idu_warm_up || !ctrl_dp_ex1_stall)
    ex1_int_inst_data[`DIS_INT_WIDTH-1:`DIS_INT_SRC2_RDY+1] <= dp_dis_int_inst_data[`DIS_INT_WIDTH-1:`DIS_INT_SRC2_RDY+1];
  else
    ex1_int_inst_data[`DIS_INT_WIDTH-1:`DIS_INT_SRC2_RDY+1] <= ex1_int_inst_data[`DIS_INT_WIDTH-1:`DIS_INT_SRC2_RDY+1];
end

always @(posedge ex1_int_src0_clk)
begin
  if(ifu_idu_warm_up || !ctrl_dp_ex1_stall) begin
    ex1_int_inst_data[`DIS_INT_SRC0_RDY]                        <= dp_dis_int_inst_data[`DIS_INT_SRC0_RDY];
    ex1_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5]    <= dp_dis_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5];
    ex1_int_inst_data[`DIS_INT_SRC0_DATA:`DIS_INT_SRC0_DATA-63] <= dp_dis_int_inst_data[`DIS_INT_SRC0_DATA:`DIS_INT_SRC0_DATA-63];
  end
  else if(dp_ex1_src0_wb_vld) begin
    ex1_int_inst_data[`DIS_INT_SRC0_RDY]                        <= 1'b1;
    ex1_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5]    <= dp_dis_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5];
    ex1_int_inst_data[`DIS_INT_SRC0_DATA:`DIS_INT_SRC0_DATA-63] <= dp_ex1_src0_wb_data[63:0];
  end
  else begin
    ex1_int_inst_data[`DIS_INT_SRC0_RDY]                        <= ex1_int_inst_data[`DIS_INT_SRC0_RDY];
    ex1_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5]    <= ex1_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5];
    ex1_int_inst_data[`DIS_INT_SRC0_DATA:`DIS_INT_SRC0_DATA-63] <= ex1_int_inst_data[`DIS_INT_SRC0_DATA:`DIS_INT_SRC0_DATA-63];
  end
end

always @(posedge ex1_int_src1_clk)
begin
  if(ifu_idu_warm_up || !ctrl_dp_ex1_stall) begin
    ex1_int_inst_data[`DIS_INT_SRC1_RDY]                        <= dp_dis_int_inst_data[`DIS_INT_SRC1_RDY];
    ex1_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5]    <= dp_dis_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5];
    ex1_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63] <= dp_dis_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63];
  end
  else if(dp_ex1_src1_wb_vld) begin
    ex1_int_inst_data[`DIS_INT_SRC1_RDY]                        <= 1'b1;
    ex1_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5]    <= dp_dis_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5];
    ex1_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63] <= dp_ex1_src1_wb_data[63:0];
  end
  else begin
    ex1_int_inst_data[`DIS_INT_SRC1_RDY]                        <= ex1_int_inst_data[`DIS_INT_SRC1_RDY];
    ex1_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5]    <= ex1_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5];
    ex1_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63] <= ex1_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63];
  end
end

always @(posedge ex1_int_src2_clk)
begin
  if(ifu_idu_warm_up || !ctrl_dp_ex1_stall) begin
    ex1_int_inst_data[`DIS_INT_SRC2_RDY]                        <= dp_dis_int_inst_data[`DIS_INT_SRC2_RDY];
    ex1_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5]    <= dp_dis_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5];
    ex1_int_inst_data[`DIS_INT_SRC2_DATA:`DIS_INT_SRC2_DATA-63] <= dp_dis_int_inst_data[`DIS_INT_SRC2_DATA:`DIS_INT_SRC2_DATA-63];
  end
  else if(dp_ex1_src2_wb_vld) begin
    ex1_int_inst_data[`DIS_INT_SRC2_RDY]                        <= 1'b1;
    ex1_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5]    <= dp_dis_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5];
    ex1_int_inst_data[`DIS_INT_SRC2_DATA:`DIS_INT_SRC2_DATA-63] <= dp_ex1_src2_wb_data[63:0];
  end
  else begin
    ex1_int_inst_data[`DIS_INT_SRC2_RDY]                        <= ex1_int_inst_data[`DIS_INT_SRC2_RDY];
    ex1_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5]    <= ex1_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5];
    ex1_int_inst_data[`DIS_INT_SRC2_DATA:`DIS_INT_SRC2_DATA-63] <= ex1_int_inst_data[`DIS_INT_SRC2_DATA:`DIS_INT_SRC2_DATA-63];
  end
end

//==========================================================
//                EX1 Vector Pipeline Register
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign ex1_vec_inst_clk_en = ifu_idu_warm_up
                             || ctrl_dp_dis_vec_inst_gateclk_vld;
// &Instance("gated_clk_cell", "x_ex1_vec_inst_gated_clk"); @525
gated_clk_cell  x_ex1_vec_inst_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (ex1_vec_inst_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (ex1_vec_inst_clk_en),
  .module_en           (cp0_idu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in      (forever_cpuclk), @526
//          .external_en (1'b0), @527
//          .global_en   (cp0_yy_clk_en), @528
//          .module_en   (cp0_idu_icg_en), @529
//          .local_en    (ex1_vec_inst_clk_en), @530
//          .clk_out     (ex1_vec_inst_clk)); @531

assign ex1_vec_src1_clk_en = ifu_idu_warm_up
                              || ctrl_dp_dis_vec_inst_gateclk_vld
                                 && (dp_id_inst_data[`IDU_SRC1_VLD]
                                  || dp_id_inst_data[`IDU_SRC1_IMM_VLD]);
// &Instance("gated_clk_cell", "x_ex1_vec_src1_gated_clk"); @537
gated_clk_cell  x_ex1_vec_src1_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (ex1_vec_src1_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (ex1_vec_src1_clk_en),
  .module_en           (cp0_idu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in      (forever_cpuclk), @538
//          .external_en (1'b0), @539
//          .global_en   (cp0_yy_clk_en), @540
//          .module_en   (cp0_idu_icg_en), @541
//          .local_en    (ex1_vec_src1_clk_en), @542
//          .clk_out     (ex1_vec_src1_clk)); @543

//----------------------------------------------------------
//           Vector Inst EX1 Pipeline Registers
//----------------------------------------------------------
always @(posedge ex1_vec_inst_clk)
begin
  if(ifu_idu_warm_up || !ctrl_dp_ex1_stall)
    ex1_vec_inst_data[`DIS_VEC_WIDTH-1:`DIS_VEC_SRC1_DATA+1] <= dp_dis_vec_inst_data[`DIS_VEC_WIDTH-1:`DIS_VEC_SRC1_DATA+1];
  else
    ex1_vec_inst_data[`DIS_VEC_WIDTH-1:`DIS_VEC_SRC1_DATA+1] <= ex1_vec_inst_data[`DIS_VEC_WIDTH-1:`DIS_VEC_SRC1_DATA+1];
end

always @(posedge ex1_vec_src1_clk)
begin
  if(ifu_idu_warm_up || !ctrl_dp_ex1_stall)
    ex1_vec_inst_data[`DIS_VEC_SRC1_DATA:`DIS_VEC_SRC1_DATA-63] <= dp_dis_vec_inst_data[`DIS_VEC_SRC1_DATA:`DIS_VEC_SRC1_DATA-63];
  else
    ex1_vec_inst_data[`DIS_VEC_SRC1_DATA:`DIS_VEC_SRC1_DATA-63] <= ex1_vec_inst_data[`DIS_VEC_SRC1_DATA:`DIS_VEC_SRC1_DATA-63];
end

//==========================================================
//                Output to Execute Units
//==========================================================
//----------------------------------------------------------
//                  IDU IU EX1 Outputs
//----------------------------------------------------------
assign idu_iu_ex1_func[`FUNC_WIDTH-1:0]  = ex1_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1];
assign idu_iu_ex1_dst0_reg[5:0]          = ex1_int_inst_data[`DIS_INT_DST0_REG:`DIS_INT_DST0_REG-5];
assign idu_iu_ex1_src0_reg[5:0]          = ex1_int_inst_data[`DIS_INT_SRC0_REG:`DIS_INT_SRC0_REG-5];
assign idu_iu_ex1_src1_reg[5:0]          = ex1_int_inst_data[`DIS_INT_SRC1_REG:`DIS_INT_SRC1_REG-5];
assign idu_iu_ex1_src0_data[63:0]        = ex1_int_inst_data[`DIS_INT_SRC0_DATA:`DIS_INT_SRC0_DATA-63];
assign idu_iu_ex1_src1_data[63:0]        = ex1_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63];
assign idu_iu_ex1_src2_data[63:0]        = ex1_int_inst_data[`DIS_INT_SRC2_DATA:`DIS_INT_SRC2_DATA-63];
assign idu_iu_ex1_length                 = ex1_int_inst_data[`DIS_INT_LENGTH];
assign idu_iu_ex1_bht_pred[1:0]          = ex1_int_inst_data[`DIS_INT_BHT_PRED:`DIS_INT_BHT_PRED-1];
assign idu_iu_ex1_split                  = ex1_int_inst_data[`DIS_INT_SPLIT];
assign idu_iu_ex1_src0_ready             = ex1_int_inst_data[`DIS_INT_SRC0_RDY];
assign idu_iu_ex1_src1_ready             = ex1_int_inst_data[`DIS_INT_SRC1_RDY];

//----------------------------------------------------------
//                  IDU CP0 EX1 Outputs
//----------------------------------------------------------
assign idu_cp0_ex1_func[`FUNC_WIDTH-1:0] = ex1_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1];
assign idu_cp0_ex1_opcode[31:0]          = ex1_int_inst_data[`DIS_INT_OPCODE:`DIS_INT_OPCODE-31];
assign idu_cp0_ex1_dst0_reg[5:0]         = ex1_int_inst_data[`DIS_INT_DST0_REG:`DIS_INT_DST0_REG-5];
assign idu_cp0_ex1_src0_data[63:0]       = ex1_int_inst_data[`DIS_INT_SRC0_DATA:`DIS_INT_SRC0_DATA-63];
assign idu_cp0_ex1_src1_data[63:0]       = ex1_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63];
assign idu_cp0_ex1_expt_illegal          = ex1_int_inst_data[`DIS_INT_EXPT_ILLE];
assign idu_cp0_ex1_expt_acc_error        = ex1_int_inst_data[`DIS_INT_EXPT_ACC];
assign idu_cp0_ex1_expt_page_fault       = ex1_int_inst_data[`DIS_INT_EXPT_PAGE];
assign idu_cp0_ex1_expt_high             = ex1_int_inst_data[`DIS_INT_EXPT_HIGH];
assign idu_cp0_ex1_split                 = ex1_int_inst_data[`DIS_INT_SPLIT];
assign idu_cp0_ex1_length                = ex1_int_inst_data[`DIS_INT_LENGTH];
assign idu_cp0_ex1_halt_info[`TDT_HINFO_WIDTH-1:0] =
  ex1_int_inst_data[`DIS_INT_HINFO_MSB:`DIS_INT_HINFO_LSB];

//----------------------------------------------------------
//                  IDU LSU EX1 Outputs
//----------------------------------------------------------
assign idu_lsu_ex1_func[`FUNC_WIDTH-1:0] = ex1_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1];
assign idu_lsu_ex1_dst0_reg[5:0]         = ex1_int_inst_data[`DIS_INT_DST0_REG:`DIS_INT_DST0_REG-5];
assign idu_lsu_ex1_dst1_reg[5:0]         = ex1_int_inst_data[`DIS_INT_DST1_REG:`DIS_INT_DST1_REG-5];
assign idu_lsu_ex1_src2_reg[5:0]         = ex1_int_inst_data[`DIS_INT_SRC2_REG:`DIS_INT_SRC2_REG-5];
assign idu_lsu_ex1_src0_data[63:0]       = ex1_int_inst_data[`DIS_INT_SRC0_DATA:`DIS_INT_SRC0_DATA-63];
assign idu_lsu_ex1_src1_data[63:0]       = ex1_int_inst_data[`DIS_INT_SRC1_DATA:`DIS_INT_SRC1_DATA-63];
assign idu_lsu_ex1_src2_data[63:0]       = ex1_int_inst_data[`DIS_INT_SRC2_DATA:`DIS_INT_SRC2_DATA-63];
assign idu_lsu_ex1_src2_ready            = ex1_int_inst_data[`DIS_INT_SRC2_RDY];
assign idu_lsu_ex1_split                 = ex1_int_inst_data[`DIS_INT_SPLIT];
assign idu_lsu_ex1_length                = ex1_int_inst_data[`DIS_INT_LENGTH];
assign idu_lsu_ex1_vsew[1:0]             = ex1_int_inst_data[`DIS_INT_VSEW:`DIS_INT_VSEW-1];
assign idu_lsu_ex1_vlmul[1:0]            = ex1_int_inst_data[`DIS_INT_VLMUL:`DIS_INT_VLMUL-1];
assign idu_lsu_ex1_halt_info[`TDT_HINFO_WIDTH-1:0] =
  ex1_int_inst_data[`DIS_INT_HINFO_MSB:`DIS_INT_HINFO_LSB];

//----------------------------------------------------------
//                  IDU LSU EX1 Outputs
//----------------------------------------------------------
assign idu_vidu_ex1_inst_data[`DIS_VEC_WIDTH-1:0] = ex1_vec_inst_data[`DIS_VEC_WIDTH-1:0];

assign dp_ctrl_inst_csr   = ex1_int_inst_data[`DIS_INT_FUNC-`FUNC_WIDTH+1];
assign dp_ctrl_inst_ecall = ex1_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1] == `FUNC_ECALL;    
assign dp_ctrl_inst_sync  = (ex1_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1] == `FUNC_FENCEI)
                         || (ex1_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1] == `FUNC_SFENCE)
                         || (ex1_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1] == `FUNC_FENCE)
                         || (ex1_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1] == `FUNC_SYNC)
                         || (ex1_int_inst_data[`DIS_INT_FUNC:`DIS_INT_FUNC-`FUNC_WIDTH+1] == `FUNC_SYNCI);
assign dp_ctrl_inst_amo   = ex1_int_inst_data[`DIS_INT_FUNC-`FUNC_WIDTH+6];                           

//==========================================================
//                      ASSERTION
//==========================================================
// &Force("nonport","flag"); @647
// &Force("nonport","clk"); @648
// &Force("nonport","rst"); @649
// &Force("output","idu_cp0_ex1_expt_illegal"); @715


// &ModuleEnd; @719
endmodule


