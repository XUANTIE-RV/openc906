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
// &ModuleBeg; @27
module aq_idu_id_ctrl(
  cp0_idu_dis_fence_in_dbg,
  cp0_idu_icg_en,
  cp0_idu_issue_stall,
  cp0_idu_vsetvl_dis_stall,
  cp0_yy_clk_en,
  cpurst_b,
  ctrl_dp_dis_int_inst_gateclk_vld,
  ctrl_dp_dis_vec_inst_gateclk_vld,
  ctrl_dp_ex1_stall,
  ctrl_top_eu_sel,
  ctrl_wbt_dis_inst_vld,
  ctrl_xx_dis_stall,
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
  forever_cpuclk,
  hpcp_idu_cnt_en,
  idu_alu_ex1_gateclk_sel,
  idu_bju_ex1_gateclk_sel,
  idu_cp0_ex1_dp_sel,
  idu_cp0_ex1_gateclk_sel,
  idu_cp0_ex1_sel,
  idu_div_ex1_gateclk_sel,
  idu_hpcp_backend_stall,
  idu_hpcp_frontend_stall,
  idu_hpcp_inst_type,
  idu_ifu_id_stall,
  idu_iu_ex1_alu_dp_sel,
  idu_iu_ex1_alu_sel,
  idu_iu_ex1_bju_br_sel,
  idu_iu_ex1_bju_dp_sel,
  idu_iu_ex1_bju_sel,
  idu_iu_ex1_div_dp_sel,
  idu_iu_ex1_div_sel,
  idu_iu_ex1_inst_vld,
  idu_iu_ex1_mult_dp_sel,
  idu_iu_ex1_mult_sel,
  idu_iu_ex1_pipedown_vld,
  idu_lsu_ex1_dp_sel,
  idu_lsu_ex1_gateclk_sel,
  idu_lsu_ex1_sel,
  idu_mult_ex1_gateclk_sel,
  idu_vidu_ex1_fp_dp_sel,
  idu_vidu_ex1_fp_gateclk_sel,
  idu_vidu_ex1_fp_sel,
  idu_vidu_ex1_vec_dp_sel,
  idu_vidu_ex1_vec_gateclk_sel,
  idu_vidu_ex1_vec_sel,
  ifu_idu_id_inst_vld,
  ifu_idu_warm_up,
  iu_idu_bju_full,
  iu_idu_bju_global_full,
  iu_idu_div_full,
  iu_idu_mult_full,
  iu_idu_mult_issue_stall,
  iu_yy_xx_cancel,
  lsu_idu_full,
  lsu_idu_global_full,
  pad_yy_icg_scan_en,
  rtu_idu_commit,
  rtu_idu_commit_for_bju,
  rtu_idu_flush_fe,
  rtu_idu_flush_stall,
  rtu_idu_pipeline_empty,
  rtu_yy_xx_dbgon,
  split_ctrl_id_stall,
  split_ctrl_inst_vld,
  split_dp_inst_sel,
  vidu_idu_fp_full,
  vidu_idu_vec_full,
  wbt_ctrl_dst0_info,
  wbt_ctrl_dst1_info,
  wbt_ctrl_src0_info,
  wbt_ctrl_src1_info,
  wbt_ctrl_src2_info
);

// &Ports; @28
input           cp0_idu_dis_fence_in_dbg;        
input           cp0_idu_icg_en;                  
input           cp0_idu_issue_stall;             
input           cp0_idu_vsetvl_dis_stall;        
input           cp0_yy_clk_en;                   
input           cpurst_b;                        
input           dp_ctrl_dis_inst_cancel;         
input           dp_ctrl_dis_inst_cp0_fence;      
input   [2 :0]  dp_ctrl_dis_inst_dst0_type;      
input           dp_ctrl_dis_inst_dst0_vld;       
input   [2 :0]  dp_ctrl_dis_inst_dst1_type;      
input           dp_ctrl_dis_inst_dst1_vld;       
input   [9 :0]  dp_ctrl_dis_inst_eu;             
input           dp_ctrl_dis_inst_expt_vld;       
input   [19:0]  dp_ctrl_dis_inst_func;           
input           dp_ctrl_dis_inst_src0_vld;       
input           dp_ctrl_dis_inst_src1_vld;       
input           dp_ctrl_dis_inst_src2_vld;       
input   [2 :0]  dp_ctrl_dis_inst_src_type;       
input           dp_ctrl_dis_inst_store;          
input           dp_ctrl_dis_inst_vec;            
input           dp_ctrl_inst_amo;                
input           dp_ctrl_inst_csr;                
input           dp_ctrl_inst_ecall;              
input           dp_ctrl_inst_sync;               
input           dp_ctrl_src0_fwd_vld;            
input           dp_ctrl_src1_fwd_vld;            
input           dp_ctrl_src2_fwd_vld;            
input           forever_cpuclk;                  
input           hpcp_idu_cnt_en;                 
input           ifu_idu_id_inst_vld;             
input           ifu_idu_warm_up;                 
input           iu_idu_bju_full;                 
input           iu_idu_bju_global_full;          
input           iu_idu_div_full;                 
input           iu_idu_mult_full;                
input           iu_idu_mult_issue_stall;         
input           iu_yy_xx_cancel;                 
input           lsu_idu_full;                    
input           lsu_idu_global_full;             
input           pad_yy_icg_scan_en;              
input           rtu_idu_commit;                  
input           rtu_idu_commit_for_bju;          
input           rtu_idu_flush_fe;                
input           rtu_idu_flush_stall;             
input           rtu_idu_pipeline_empty;          
input           rtu_yy_xx_dbgon;                 
input           split_ctrl_id_stall;             
input           split_ctrl_inst_vld;             
input           split_dp_inst_sel;               
input           vidu_idu_fp_full;                
input           vidu_idu_vec_full;               
input   [6 :0]  wbt_ctrl_dst0_info;              
input   [6 :0]  wbt_ctrl_dst1_info;              
input   [6 :0]  wbt_ctrl_src0_info;              
input   [6 :0]  wbt_ctrl_src1_info;              
input   [6 :0]  wbt_ctrl_src2_info;              
output          ctrl_dp_dis_int_inst_gateclk_vld; 
output          ctrl_dp_dis_vec_inst_gateclk_vld; 
output          ctrl_dp_ex1_stall;               
output  [9 :0]  ctrl_top_eu_sel;                 
output          ctrl_wbt_dis_inst_vld;           
output          ctrl_xx_dis_stall;               
output          idu_alu_ex1_gateclk_sel;         
output          idu_bju_ex1_gateclk_sel;         
output          idu_cp0_ex1_dp_sel;              
output          idu_cp0_ex1_gateclk_sel;         
output          idu_cp0_ex1_sel;                 
output          idu_div_ex1_gateclk_sel;         
output          idu_hpcp_backend_stall;          
output          idu_hpcp_frontend_stall;         
output  [6 :0]  idu_hpcp_inst_type;              
output          idu_ifu_id_stall;                
output          idu_iu_ex1_alu_dp_sel;           
output          idu_iu_ex1_alu_sel;              
output          idu_iu_ex1_bju_br_sel;           
output          idu_iu_ex1_bju_dp_sel;           
output          idu_iu_ex1_bju_sel;              
output          idu_iu_ex1_div_dp_sel;           
output          idu_iu_ex1_div_sel;              
output          idu_iu_ex1_inst_vld;             
output          idu_iu_ex1_mult_dp_sel;          
output          idu_iu_ex1_mult_sel;             
output          idu_iu_ex1_pipedown_vld;         
output          idu_lsu_ex1_dp_sel;              
output          idu_lsu_ex1_gateclk_sel;         
output          idu_lsu_ex1_sel;                 
output          idu_mult_ex1_gateclk_sel;        
output          idu_vidu_ex1_fp_dp_sel;          
output          idu_vidu_ex1_fp_gateclk_sel;     
output          idu_vidu_ex1_fp_sel;             
output          idu_vidu_ex1_vec_dp_sel;         
output          idu_vidu_ex1_vec_gateclk_sel;    
output          idu_vidu_ex1_vec_sel;            

// &Regs; @29
reg     [9 :0]  ctrl_dis_inst_eu;                
reg     [9 :0]  ex1_eu_sel;                      
reg             ex1_inst_vld;                    
reg             idu_hpcp_backend_stall;          
reg             idu_hpcp_frontend_stall;         
reg     [6 :0]  idu_hpcp_inst_type;              

// &Wires; @30
wire            cp0_idu_dis_fence_in_dbg;        
wire            cp0_idu_icg_en;                  
wire            cp0_idu_issue_stall;             
wire            cp0_idu_vsetvl_dis_stall;        
wire            cp0_yy_clk_en;                   
wire            cpurst_b;                        
wire            ctrl_dis_cp0_stall;              
wire            ctrl_dis_dep_stall;              
wire            ctrl_dis_dst0_waw;               
wire            ctrl_dis_dst0_waw_except;        
wire            ctrl_dis_dst1_waw;               
wire            ctrl_dis_dst1_waw_except;        
wire            ctrl_dis_inst_vld;               
wire            ctrl_dis_raw;                    
wire            ctrl_dis_src0_raw;               
wire            ctrl_dis_src0_raw_except;        
wire            ctrl_dis_src1_raw;               
wire            ctrl_dis_src1_raw_except;        
wire            ctrl_dis_src2_raw;               
wire            ctrl_dis_src2_raw_except;        
wire            ctrl_dis_stall;                  
wire            ctrl_dis_vec_stall;              
wire            ctrl_dis_waw;                    
wire            ctrl_dp_dis_int_inst_gateclk_vld; 
wire            ctrl_dp_dis_vec_inst_gateclk_vld; 
wire            ctrl_dp_ex1_stall;               
wire            ctrl_ex1_eu_full;                
wire            ctrl_ex1_internal_stall;         
wire            ctrl_ex1_issue_stall;            
wire            ctrl_ex1_stall;                  
wire    [9 :0]  ctrl_pipedown_eu_sel;            
wire            ctrl_pipedown_inst_vld;          
wire            ctrl_split_stall;                
wire    [9 :0]  ctrl_top_eu_sel;                 
wire            ctrl_wbt_dis_inst_vld;           
wire            ctrl_xx_dis_stall;               
wire            dp_ctrl_dis_inst_cancel;         
wire            dp_ctrl_dis_inst_cp0_fence;      
wire    [2 :0]  dp_ctrl_dis_inst_dst0_type;      
wire            dp_ctrl_dis_inst_dst0_vld;       
wire    [2 :0]  dp_ctrl_dis_inst_dst1_type;      
wire            dp_ctrl_dis_inst_dst1_vld;       
wire    [9 :0]  dp_ctrl_dis_inst_eu;             
wire            dp_ctrl_dis_inst_expt_vld;       
wire    [19:0]  dp_ctrl_dis_inst_func;           
wire            dp_ctrl_dis_inst_src0_vld;       
wire            dp_ctrl_dis_inst_src1_vld;       
wire            dp_ctrl_dis_inst_src2_vld;       
wire    [2 :0]  dp_ctrl_dis_inst_src_type;       
wire            dp_ctrl_dis_inst_store;          
wire            dp_ctrl_dis_inst_vec;            
wire            dp_ctrl_inst_amo;                
wire            dp_ctrl_inst_csr;                
wire            dp_ctrl_inst_ecall;              
wire            dp_ctrl_inst_sync;               
wire            dp_ctrl_src0_fwd_vld;            
wire            dp_ctrl_src1_fwd_vld;            
wire            dp_ctrl_src2_fwd_vld;            
wire            ex1_hpcp_clk;                    
wire            ex1_hpcp_clk_en;                 
wire            ex1_inst_clk;                    
wire            ex1_inst_clk_en;                 
wire            forever_cpuclk;                  
wire            hpcp_idu_cnt_en;                 
wire            idu_alu_ex1_gateclk_sel;         
wire            idu_backend_stall;               
wire            idu_bju_ex1_gateclk_sel;         
wire            idu_cp0_ex1_dp_sel;              
wire            idu_cp0_ex1_gateclk_sel;         
wire            idu_cp0_ex1_sel;                 
wire            idu_div_ex1_gateclk_sel;         
wire            idu_frontend_stall;              
wire            idu_ifu_id_stall;                
wire    [6 :0]  idu_inst_type;                   
wire            idu_iu_ex1_alu_dp_sel;           
wire            idu_iu_ex1_alu_sel;              
wire            idu_iu_ex1_bju_br_sel;           
wire            idu_iu_ex1_bju_dp_sel;           
wire            idu_iu_ex1_bju_sel;              
wire            idu_iu_ex1_div_dp_sel;           
wire            idu_iu_ex1_div_sel;              
wire            idu_iu_ex1_inst_vld;             
wire            idu_iu_ex1_mult_dp_sel;          
wire            idu_iu_ex1_mult_sel;             
wire            idu_iu_ex1_pipedown_vld;         
wire            idu_lsu_ex1_dp_sel;              
wire            idu_lsu_ex1_gateclk_sel;         
wire            idu_lsu_ex1_sel;                 
wire            idu_mult_ex1_gateclk_sel;        
wire            idu_vidu_ex1_fp_dp_sel;          
wire            idu_vidu_ex1_fp_gateclk_sel;     
wire            idu_vidu_ex1_fp_sel;             
wire            idu_vidu_ex1_vec_dp_sel;         
wire            idu_vidu_ex1_vec_gateclk_sel;    
wire            idu_vidu_ex1_vec_sel;            
wire            ifu_idu_id_inst_vld;             
wire            ifu_idu_warm_up;                 
wire            iu_idu_bju_full;                 
wire            iu_idu_bju_global_full;          
wire            iu_idu_div_full;                 
wire            iu_idu_mult_full;                
wire            iu_idu_mult_issue_stall;         
wire            iu_yy_xx_cancel;                 
wire            lsu_idu_full;                    
wire            lsu_idu_global_full;             
wire            pad_yy_icg_scan_en;              
wire            rtu_idu_commit;                  
wire            rtu_idu_commit_for_bju;          
wire            rtu_idu_flush_fe;                
wire            rtu_idu_flush_stall;             
wire            rtu_idu_pipeline_empty;          
wire            rtu_yy_xx_dbgon;                 
wire            split_ctrl_id_stall;             
wire            split_ctrl_inst_vld;             
wire            split_dp_inst_sel;               
wire            vidu_idu_fp_full;                
wire            vidu_idu_vec_full;               
wire    [6 :0]  wbt_ctrl_dst0_info;              
wire    [6 :0]  wbt_ctrl_dst1_info;              
wire    [6 :0]  wbt_ctrl_src0_info;              
wire    [6 :0]  wbt_ctrl_src1_info;              
wire    [6 :0]  wbt_ctrl_src2_info;              


//==========================================================
//                  Dispatch Inst Valid
//==========================================================
//----------------------------------------------------------
//                    IDU ID stalls
//----------------------------------------------------------
assign ctrl_dis_inst_vld      = ifu_idu_id_inst_vld
                                && (split_ctrl_inst_vld || !split_dp_inst_sel);
//output
assign ctrl_wbt_dis_inst_vld  = ctrl_dis_inst_vld;

//----------------------------------------------------------
//                   Pipedown inst vld
//----------------------------------------------------------
//pipedown inst if no dispatch stall
assign ctrl_pipedown_inst_vld = ctrl_dis_inst_vld && !ctrl_dis_stall;

//==========================================================
//                   ID Stall signals
//==========================================================
//----------------------------------------------------------
//                    IDU ID stalls
//----------------------------------------------------------
assign ctrl_split_stall       = ifu_idu_id_inst_vld && split_dp_inst_sel && split_ctrl_id_stall;
//idu stall include dispatch stall and split stall
assign idu_ifu_id_stall       = ctrl_dis_stall || ctrl_split_stall;

//----------------------------------------------------------
//                   Dispatch signals
//----------------------------------------------------------
//1.dispatch stage only has raw / waw stall
assign ctrl_dis_dep_stall     = ctrl_dis_inst_vld
                                && (ctrl_dis_raw || ctrl_dis_waw);
//2.cp0 (without vsetvl) should wait older inst retire and wb
//  when in debug mode, cp0 inst will not wait pipeline empty to enable debug
//  function when pipeline deadlock
//  cancel inst do not stall due to cancel signal timing
assign ctrl_dis_cp0_stall     = ctrl_dis_inst_vld
                                && dp_ctrl_dis_inst_cp0_fence
                                && !rtu_idu_pipeline_empty 
                                && !(rtu_yy_xx_dbgon && cp0_idu_dis_fence_in_dbg);
//3.vec instruction should wait older vsetvli/vsetvl wb
assign ctrl_dis_vec_stall     = ctrl_dis_inst_vld && dp_ctrl_dis_inst_vec
                                                  && cp0_idu_vsetvl_dis_stall;

//dispatch stall include dispatch internal stall and ex1 stage stall
assign ctrl_dis_stall         = rtu_idu_flush_stall
                                || ctrl_ex1_stall
                                || ctrl_dis_dep_stall
                                || ctrl_dis_cp0_stall
                                || ctrl_dis_vec_stall;
//output
assign ctrl_xx_dis_stall      = ctrl_dis_stall;

//==========================================================
//                       RAW Stall
//==========================================================
//----------------------------------------------------------
//                    RAW Stall signals
//----------------------------------------------------------
// &Force("bus","wbt_ctrl_dst0_info",`WB_INT_WIDTH-1,0); @92
// &Force("bus","wbt_ctrl_dst1_info",`WB_INT_WIDTH-1,0); @93
// &Force("bus","wbt_ctrl_src0_info",`WB_INT_WIDTH-1,0); @94
// &Force("bus","wbt_ctrl_src1_info",`WB_INT_WIDTH-1,0); @95
// &Force("bus","wbt_ctrl_src2_info",`WB_INT_WIDTH-1,0); @96
//when there is old producer has same dst reg with dispatch inst
//dispatch inst has waw stall (wb_vld includes writing back in wbt)
assign ctrl_dis_src0_raw = dp_ctrl_dis_inst_src0_vld
                           && !wbt_ctrl_src0_info[`WB_INT_VLD]
                           && !ctrl_dis_src0_raw_except;
assign ctrl_dis_src1_raw = dp_ctrl_dis_inst_src1_vld
                           && !wbt_ctrl_src1_info[`WB_INT_VLD]
                           && !ctrl_dis_src1_raw_except;
assign ctrl_dis_src2_raw = dp_ctrl_dis_inst_src2_vld
                           && !wbt_ctrl_src2_info[`WB_INT_VLD]
                           && !ctrl_dis_src2_raw_except;

//RAW stall signal except inst vld
assign ctrl_dis_raw      = ctrl_dis_src0_raw
                        || ctrl_dis_src1_raw
                        || ctrl_dis_src2_raw;

//----------------------------------------------------------
//                 RAW stall Exceptions
//----------------------------------------------------------
// &Force("bus","dp_ctrl_dis_inst_func",`FUNC_WIDTH-1,0); @117
//there are exceptions when normal raw stall
assign ctrl_dis_src0_raw_except =
  //1. if producer is alu/bju which could forward from ex1
     (wbt_ctrl_src0_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_ALU)
  || (wbt_ctrl_src0_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_BJU)
  //2. if producer is load and consumer is bju condbr
  || (wbt_ctrl_src0_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_LSU)
     && (dp_ctrl_dis_inst_src_type[2:0]                     == `WB_INT_TYPE_BJU)
     && (dp_ctrl_dis_inst_func[`FUNC_CONDBR_SEL]            == 1'b1)
     && ((wbt_ctrl_src0_info[`WB_INT_CNT:`WB_INT_CNT-1]     == 2'd0)
      || (wbt_ctrl_src0_info[`WB_INT_CNT:`WB_INT_CNT-1]     == 2'd1))
  //3. if result of producer can be forwarded
  || dp_ctrl_src0_fwd_vld
     && !(((wbt_ctrl_src0_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_LSU)
        || (wbt_ctrl_src0_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_MULT))
        && (wbt_ctrl_src0_info[`WB_INT_CNT:`WB_INT_CNT-1]   == 2'd2));

assign ctrl_dis_src1_raw_except =
  //1. if producer is alu/bju which could forward from ex1
     (wbt_ctrl_src1_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_ALU)
  || (wbt_ctrl_src1_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_BJU)
  //2. if producer is load and consumer is bju
  || (wbt_ctrl_src1_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_LSU)
     && (dp_ctrl_dis_inst_src_type[2:0]                     == `WB_INT_TYPE_BJU)
     && (dp_ctrl_dis_inst_func[`FUNC_CONDBR_SEL]            == 1'b1)
     && ((wbt_ctrl_src1_info[`WB_INT_CNT:`WB_INT_CNT-1]     == 2'd0)
      || (wbt_ctrl_src1_info[`WB_INT_CNT:`WB_INT_CNT-1]     == 2'd1))
  //3. if result of producer can be forwarded
  || dp_ctrl_src1_fwd_vld
     && !(((wbt_ctrl_src1_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_LSU)
        || (wbt_ctrl_src1_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_MULT))
        && (wbt_ctrl_src1_info[`WB_INT_CNT:`WB_INT_CNT-1]   == 2'd2));

assign ctrl_dis_src2_raw_except =
  //1. if producer is alu/bju which could forward from ex1
     (wbt_ctrl_src2_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_ALU)
  || (wbt_ctrl_src2_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_BJU)
  //2. if producer is load and consumer is bju
  || (wbt_ctrl_src2_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_LSU)
     && (dp_ctrl_dis_inst_src_type[2:0]                     == `WB_INT_TYPE_BJU)
     && (dp_ctrl_dis_inst_func[`FUNC_CONDBR_SEL]            == 1'b1)
     && ((wbt_ctrl_src2_info[`WB_INT_CNT:`WB_INT_CNT-1]     == 2'd0)
      || (wbt_ctrl_src2_info[`WB_INT_CNT:`WB_INT_CNT-1]     == 2'd1))
  //3. if result of producer can be forwarded
  || dp_ctrl_src2_fwd_vld
     && !(((wbt_ctrl_src2_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_LSU)
        || (wbt_ctrl_src2_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_MULT))
        && (wbt_ctrl_src2_info[`WB_INT_CNT:`WB_INT_CNT-1]   == 2'd2))
  //4. if producer is load and consumer is store source data (src2) and
  //   4.1 there is 1 load 4.2 there are 2 loads while first load is writing back
  || (wbt_ctrl_src2_info[`WB_INT_TYPE:`WB_INT_TYPE-2]       == `WB_INT_TYPE_LSU)
     && dp_ctrl_dis_inst_store
     && ((wbt_ctrl_src2_info[`WB_INT_CNT:`WB_INT_CNT-1]     == 2'd0)
      || (wbt_ctrl_src2_info[`WB_INT_CNT:`WB_INT_CNT-1]     == 2'd1)
      ||  wbt_ctrl_src2_info[`WB_INT_WB_CNT2]);

//==========================================================
//                       WAW Stall
//==========================================================
//----------------------------------------------------------
//                    WAW Stall signals
//----------------------------------------------------------
//when there is old producer has same dst reg with dispatch inst
//dispatch inst has waw stall (wb_vld includes writing back in wbt)
assign ctrl_dis_dst0_waw = dp_ctrl_dis_inst_dst0_vld
                           && !wbt_ctrl_dst0_info[`WB_INT_VLD]
                           && !ctrl_dis_dst0_waw_except;
assign ctrl_dis_dst1_waw = dp_ctrl_dis_inst_dst1_vld
                           && !wbt_ctrl_dst1_info[`WB_INT_VLD]
                           && !ctrl_dis_dst1_waw_except;

//WAW stall signal except inst vld
assign ctrl_dis_waw      = ctrl_dis_dst0_waw || ctrl_dis_dst1_waw;

//----------------------------------------------------------
//                 WAW stall Exceptions
//----------------------------------------------------------
//there are exceptions when normal waw stall
assign ctrl_dis_dst0_waw_except =
  //1. if new producer and old producer are both lsu/mult
  //   no waw stall when there is only 1 old lsu/mult producer or
  //   2 old lsu/mult producers while first producer is writing back
      (((wbt_ctrl_dst0_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_LSU)
     && (dp_ctrl_dis_inst_dst0_type[2:0]                 == `WB_INT_TYPE_LSU))
    || ((wbt_ctrl_dst0_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_MULT)
     && (dp_ctrl_dis_inst_dst0_type[2:0]                 == `WB_INT_TYPE_MULT)))
     && ((wbt_ctrl_dst0_info[`WB_INT_CNT:`WB_INT_CNT-1]  == 2'd0)
      || (wbt_ctrl_dst0_info[`WB_INT_CNT:`WB_INT_CNT-1]  == 2'd1)
      ||  wbt_ctrl_dst0_info[`WB_INT_WB_CNT2])
  //2. if new producer and old producer are alu or bju no waw stall
     || (wbt_ctrl_dst0_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_ALU)
     || (wbt_ctrl_dst0_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_BJU);

assign ctrl_dis_dst1_waw_except =
  //1. if new producer and old producer are both lsu/mult
  //   no waw stall when there is only 1 old lsu/mult producer or
  //   2 old lsu/mult producers while first producer is writing back
      (((wbt_ctrl_dst1_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_LSU)
     && (dp_ctrl_dis_inst_dst1_type[2:0]                 == `WB_INT_TYPE_LSU))
    || ((wbt_ctrl_dst1_info[`WB_INT_TYPE:`WB_INT_TYPE-2] == `WB_INT_TYPE_MULT)
     && (dp_ctrl_dis_inst_dst1_type[2:0]                 == `WB_INT_TYPE_MULT)))
     && ((wbt_ctrl_dst1_info[`WB_INT_CNT:`WB_INT_CNT-1]  == 2'd0)
      || (wbt_ctrl_dst1_info[`WB_INT_CNT:`WB_INT_CNT-1]  == 2'd1)
      ||  wbt_ctrl_dst1_info[`WB_INT_WB_CNT2])
  //3. if new producer and old producer are alu or bju no waw stall
    || (wbt_ctrl_dst1_info[`WB_INT_TYPE:`WB_INT_TYPE-2]  == `WB_INT_TYPE_ALU)
    || (wbt_ctrl_dst1_info[`WB_INT_TYPE:`WB_INT_TYPE-2]  == `WB_INT_TYPE_BJU);

//==========================================================
//                 EX1 Control Signals
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign ex1_inst_clk_en = ctrl_dis_inst_vld
                        || ex1_inst_vld;
// &Instance("gated_clk_cell", "x_ex1_inst_gated_clk"); @234
gated_clk_cell  x_ex1_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_inst_clk_en   ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @235
//          .external_en (1'b0), @236
//          .global_en   (cp0_yy_clk_en), @237
//          .module_en   (cp0_idu_icg_en), @238
//          .local_en    (ex1_inst_clk_en), @239
//          .clk_out     (ex1_inst_clk)); @240

//----------------------------------------------------------
//                 ID pipedown inst vld
//----------------------------------------------------------
// &CombBeg; @245
always @( dp_ctrl_dis_inst_eu[9:0]
       or dp_ctrl_dis_inst_expt_vld
       or dp_ctrl_dis_inst_cancel)
begin
  //issue exception instruction to cp0
  if(dp_ctrl_dis_inst_expt_vld || dp_ctrl_dis_inst_cancel)
    ctrl_dis_inst_eu[`EU_WIDTH-1:0] = `EU_CP0;
  //clear vector and fp inst sub eu sel (except vlsu/flsu) for int eu sel
  else if(|dp_ctrl_dis_inst_eu[`EU_VEC_SEL:`EU_FP_SEL])
    ctrl_dis_inst_eu[`EU_WIDTH-1:0] = {dp_ctrl_dis_inst_eu[`EU_VEC_SEL:`EU_FP_SEL],
                                       {`EU_FP_SEL-`EU_VLSU_SEL-1{1'b0}},
                                       dp_ctrl_dis_inst_eu[`EU_VLSU_SEL],
                                       {`EU_VLSU_SEL{1'b0}}};
  else
    ctrl_dis_inst_eu[`EU_WIDTH-1:0] =  dp_ctrl_dis_inst_eu[`EU_WIDTH-1:0];
// &CombEnd; @257
end
//dispatch eu sel control signals
assign ctrl_pipedown_eu_sel[`EU_WIDTH-1:0] =
         {`EU_WIDTH{ctrl_pipedown_inst_vld}} & ctrl_dis_inst_eu[`EU_WIDTH-1:0];

//for timing optimization: ignore expt fp/vec inst
assign ctrl_dp_dis_int_inst_gateclk_vld   = ctrl_dis_inst_vld;
assign ctrl_dp_dis_vec_inst_gateclk_vld   = ctrl_dis_inst_vld
                                            && (dp_ctrl_dis_inst_eu[`EU_FP_SEL]
                                             || dp_ctrl_dis_inst_eu[`EU_VEC_SEL]);

//----------------------------------------------------------
//                 EX1 Instruction Valid
//----------------------------------------------------------
always @(posedge ex1_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex1_inst_vld              <= 1'b0;
    ex1_eu_sel[`EU_WIDTH-1:0] <= {`EU_WIDTH{1'b0}};
  end
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel) begin
    ex1_inst_vld              <= 1'b0;
    ex1_eu_sel[`EU_WIDTH-1:0] <= {`EU_WIDTH{1'b0}};
  end
  else if(!ctrl_ex1_stall) begin
    ex1_inst_vld              <= ctrl_pipedown_inst_vld;
    ex1_eu_sel[`EU_WIDTH-1:0] <= ctrl_pipedown_eu_sel[`EU_WIDTH-1:0];
  end
  else begin
    ex1_inst_vld              <= ex1_inst_vld;
    ex1_eu_sel[`EU_WIDTH-1:0] <= ex1_eu_sel[`EU_WIDTH-1:0];
  end
end

assign ctrl_top_eu_sel[`EU_WIDTH-1:0] = ex1_eu_sel[`EU_WIDTH-1:0];
//output control signal for IU BJU PC control
assign idu_iu_ex1_inst_vld            = ex1_inst_vld;
assign idu_iu_ex1_pipedown_vld        = ex1_inst_vld && !ctrl_ex1_stall && rtu_idu_commit;

//----------------------------------------------------------
//               EX1 Execute Unit Selects
//----------------------------------------------------------
//select eu only when commit and eu not full
assign idu_iu_ex1_alu_sel    = ex1_eu_sel[`EU_ALU_SEL]  && !ctrl_ex1_internal_stall && rtu_idu_commit;
assign idu_iu_ex1_bju_sel    = ex1_eu_sel[`EU_BJU_SEL]  && !ctrl_ex1_internal_stall && rtu_idu_commit && !iu_idu_bju_full;
assign idu_iu_ex1_bju_br_sel = ex1_eu_sel[`EU_BJU_SEL]  && !ctrl_ex1_internal_stall && rtu_idu_commit_for_bju && !iu_idu_bju_full;
assign idu_iu_ex1_mult_sel   = ex1_eu_sel[`EU_MULT_SEL] && !ctrl_ex1_internal_stall && rtu_idu_commit && !iu_idu_mult_full;
assign idu_iu_ex1_div_sel    = ex1_eu_sel[`EU_DIV_SEL]  && !ctrl_ex1_internal_stall && rtu_idu_commit && !iu_idu_div_full;
assign idu_cp0_ex1_sel       = ex1_eu_sel[`EU_CP0_SEL]  && !ctrl_ex1_internal_stall && rtu_idu_commit;
//flsu and vlsu sel should be 0 when lsu or flsu/vlsu full
assign idu_lsu_ex1_sel       = ex1_eu_sel[`EU_LSU_SEL]  && !ctrl_ex1_internal_stall && rtu_idu_commit && !lsu_idu_full
                                                        && (!ex1_eu_sel[`EU_FP_SEL]  || !vidu_idu_fp_full)
                                                        && (!ex1_eu_sel[`EU_VEC_SEL] || !vidu_idu_vec_full);
assign idu_vidu_ex1_fp_sel   = ex1_eu_sel[`EU_FP_SEL]   && !ctrl_ex1_internal_stall && rtu_idu_commit && !vidu_idu_fp_full
                                                        && (!ex1_eu_sel[`EU_LSU_SEL] || !lsu_idu_full);
assign idu_vidu_ex1_vec_sel  = ex1_eu_sel[`EU_VEC_SEL]  && !ctrl_ex1_internal_stall && rtu_idu_commit && !vidu_idu_vec_full
                                                        && (!ex1_eu_sel[`EU_LSU_SEL] || !lsu_idu_full);

assign idu_iu_ex1_alu_dp_sel   = ex1_eu_sel[`EU_ALU_SEL]  && !ctrl_ex1_internal_stall;
assign idu_iu_ex1_bju_dp_sel   = ex1_eu_sel[`EU_BJU_SEL]  && !ctrl_ex1_internal_stall && !iu_idu_bju_full;
assign idu_iu_ex1_mult_dp_sel  = ex1_eu_sel[`EU_MULT_SEL] && !ctrl_ex1_internal_stall && !iu_idu_mult_full;
assign idu_iu_ex1_div_dp_sel   = ex1_eu_sel[`EU_DIV_SEL]  && !ctrl_ex1_internal_stall && !iu_idu_div_full;
assign idu_lsu_ex1_dp_sel      = ex1_eu_sel[`EU_LSU_SEL]  && !ctrl_ex1_internal_stall && !lsu_idu_full
                                                          && (!ex1_eu_sel[`EU_FP_SEL]  || !vidu_idu_fp_full)
                                                          && (!ex1_eu_sel[`EU_VEC_SEL] || !vidu_idu_vec_full);
assign idu_cp0_ex1_dp_sel      = ex1_eu_sel[`EU_CP0_SEL]  && !ctrl_ex1_internal_stall;
assign idu_vidu_ex1_fp_dp_sel  = ex1_eu_sel[`EU_FP_SEL]   && !ctrl_ex1_internal_stall && !vidu_idu_fp_full
                                                          && (!ex1_eu_sel[`EU_LSU_SEL] || !lsu_idu_full);
assign idu_vidu_ex1_vec_dp_sel = ex1_eu_sel[`EU_VEC_SEL]  && !ctrl_ex1_internal_stall && !vidu_idu_vec_full
                                                          && (!ex1_eu_sel[`EU_LSU_SEL] || !lsu_idu_full);

assign idu_alu_ex1_gateclk_sel      = ex1_eu_sel[`EU_ALU_SEL];
assign idu_bju_ex1_gateclk_sel      = ex1_eu_sel[`EU_BJU_SEL];
assign idu_mult_ex1_gateclk_sel     = ex1_eu_sel[`EU_MULT_SEL];
assign idu_div_ex1_gateclk_sel      = ex1_eu_sel[`EU_DIV_SEL];
assign idu_lsu_ex1_gateclk_sel      = ex1_eu_sel[`EU_LSU_SEL];
assign idu_cp0_ex1_gateclk_sel      = ex1_eu_sel[`EU_CP0_SEL];
assign idu_vidu_ex1_fp_gateclk_sel  = ex1_eu_sel[`EU_FP_SEL];
assign idu_vidu_ex1_vec_gateclk_sel = ex1_eu_sel[`EU_VEC_SEL];

//----------------------------------------------------------
//                  EX1 stall Signals
//----------------------------------------------------------
//1.if eu full, ex1 inst with same eu should
//  hold and cannot issue (no sel / data no change)
assign ctrl_ex1_eu_full =
     ex1_eu_sel[`EU_BJU_SEL]  && iu_idu_bju_full
  || ex1_eu_sel[`EU_MULT_SEL] && iu_idu_mult_full
  || ex1_eu_sel[`EU_DIV_SEL]  && iu_idu_div_full
  || ex1_eu_sel[`EU_LSU_SEL]  && lsu_idu_full
  || ex1_eu_sel[`EU_FP_SEL]   && vidu_idu_fp_full
  || ex1_eu_sel[`EU_VEC_SEL]  && vidu_idu_vec_full;
//2.if issue stall, ex1 inst should
//  hold and keep issue (sel / data no change)
assign ctrl_ex1_issue_stall    = ex1_inst_vld
                                 && (iu_idu_mult_issue_stall
                                  || cp0_idu_issue_stall);
//3.if internal stall, ex1 inst hould
//  hold and cannot issue (no sel / data no change)
assign ctrl_ex1_internal_stall = ex1_inst_vld
                                 && (iu_idu_bju_global_full
                                  || lsu_idu_global_full);
//4.if no commit, ex1 inst should
//  discard and cannot issue (no sel / inst no valid).
//  if no commit, rtu will flush, idu could discard ex1 inst
//  and not stall id dispatch

//ex1 stall include eu full and eu stall
assign ctrl_ex1_stall    = ctrl_ex1_eu_full || ctrl_ex1_issue_stall || ctrl_ex1_internal_stall;
//output
assign ctrl_dp_ex1_stall = ctrl_ex1_stall;

//==========================================================
//                    Out to HPCP
//==========================================================
assign idu_inst_type[0]   = idu_iu_ex1_alu_sel || idu_iu_ex1_mult_sel || idu_iu_ex1_div_sel;
assign idu_inst_type[1]   = idu_lsu_ex1_sel;
assign idu_inst_type[2]   = idu_vidu_ex1_vec_sel && !ex1_eu_sel[`EU_LSU_SEL];
assign idu_inst_type[3]   = idu_cp0_ex1_sel && dp_ctrl_inst_csr;
assign idu_inst_type[4]   = idu_cp0_ex1_sel && dp_ctrl_inst_sync && !cp0_idu_issue_stall || idu_lsu_ex1_sel && dp_ctrl_inst_amo;
assign idu_inst_type[5]   = idu_cp0_ex1_sel && dp_ctrl_inst_ecall;
assign idu_inst_type[6]   = idu_vidu_ex1_fp_sel && !ex1_eu_sel[`EU_LSU_SEL];
assign idu_backend_stall  = ctrl_dis_stall || ctrl_split_stall;
assign idu_frontend_stall = !(ctrl_dis_stall || ctrl_split_stall) && !ifu_idu_id_inst_vld;
// &Force("output","idu_iu_ex1_alu_sel"); @382
// &Force("output","idu_iu_ex1_mult_sel"); @383
// &Force("output","idu_iu_ex1_div_sel"); @384
// &Force("output","idu_lsu_ex1_sel"); @385
// &Force("output","idu_vidu_ex1_vec_sel"); @386
// &Force("output","idu_cp0_ex1_sel"); @387
// &Force("output","idu_vidu_ex1_fp_sel"); @388

assign ex1_hpcp_clk_en = hpcp_idu_cnt_en || ifu_idu_warm_up;
// &Instance("gated_clk_cell", "x_ex1_hpcp_gated_clk"); @391
gated_clk_cell  x_ex1_hpcp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_hpcp_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_hpcp_clk_en   ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @392
//          .external_en (1'b0), @393
//          .global_en   (cp0_yy_clk_en), @394
//          .module_en   (cp0_idu_icg_en), @395
//          .local_en    (ex1_hpcp_clk_en), @396
//          .clk_out     (ex1_hpcp_clk)); @397

always @(posedge ex1_hpcp_clk)
begin
  if(hpcp_idu_cnt_en || ifu_idu_warm_up) begin
    idu_hpcp_inst_type[6:0] <= idu_inst_type[6:0];
    idu_hpcp_backend_stall  <= idu_backend_stall;
    idu_hpcp_frontend_stall <= idu_frontend_stall;
  end
end

//==========================================================
//                      ASSERTION
//==========================================================
// &Force("nonport","flag"); @422
// &Force("nonport","clk"); @423
// &Force("nonport","rst"); @424
// &Force("output","ctrl_dis_inst_vld"); @434
// &Force("output","split_dp_inst_sel"); @435


// &ModuleEnd; @439
endmodule


