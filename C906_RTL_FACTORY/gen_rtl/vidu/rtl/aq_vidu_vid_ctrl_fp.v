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

// &Depend("aq_idu_cfig.h"); @25
// &ModuleBeg; @26
module aq_vidu_vid_ctrl_fp(
  ctrl_dis_fp_dep_stall_dp,
  ctrl_fgpr_reuse_inst_gateclk_vld,
  ctrl_fgpr_reuse_inst_vld,
  ctrl_split_fp_dis_stall,
  ctrl_wbt_fp_dis_inst_gateclk_vld,
  ctrl_wbt_fp_dis_inst_vld,
  dp_ctrl_dis_fp_inst_dstf_vld,
  dp_ctrl_dis_fp_inst_srcf0_reg,
  dp_ctrl_dis_fp_inst_srcf0_vld,
  dp_ctrl_dis_fp_inst_srcf1_reg,
  dp_ctrl_dis_fp_inst_srcf1_vld,
  dp_ctrl_dis_fp_inst_srcf2_reg,
  dp_ctrl_dis_fp_inst_srcf2_vld,
  dp_ctrl_dis_fp_inst_store,
  dp_ctrl_dis_fp_inst_wb_type,
  idu_vidu_ex1_fp_dp_sel,
  idu_vidu_ex1_fp_sel,
  idu_vidu_ex1_inst_data,
  idu_vidu_ex1_vec_dp_sel,
  idu_vidu_ex1_vec_sel,
  split_fp_ctrl_entry_vld,
  split_fp_ctrl_inst_dp_vld,
  split_fp_ctrl_inst_gateclk_vld,
  split_fp_ctrl_inst_vld,
  split_vec0_ctrl_entry_vld,
  split_vec1_ctrl_entry_vld,
  vidu_idu_fp_full,
  vidu_rtu_no_op,
  vidu_vpu_vid_fp_inst_dp_vld,
  vidu_vpu_vid_fp_inst_gateclk_vld,
  vidu_vpu_vid_fp_inst_vld,
  vpu_rtu_ex1_cmplt,
  vpu_rtu_ex1_cmplt_dp,
  vpu_vidu_fp_fwd_reg,
  vpu_vidu_fp_fwd_vld,
  vpu_vidu_vex1_fp_stall,
  wbt_ctrl_fp_dstv_info,
  wbt_ctrl_fp_srcv0_info,
  wbt_ctrl_fp_srcv1_info,
  wbt_ctrl_fp_srcv2_info,
  wbt_ctrl_fp_srcvm_info
);

// &Ports; @27
input            ctrl_fgpr_reuse_inst_gateclk_vld; 
input            ctrl_fgpr_reuse_inst_vld;        
input            dp_ctrl_dis_fp_inst_dstf_vld;    
input   [4  :0]  dp_ctrl_dis_fp_inst_srcf0_reg;   
input            dp_ctrl_dis_fp_inst_srcf0_vld;   
input   [4  :0]  dp_ctrl_dis_fp_inst_srcf1_reg;   
input            dp_ctrl_dis_fp_inst_srcf1_vld;   
input   [4  :0]  dp_ctrl_dis_fp_inst_srcf2_reg;   
input            dp_ctrl_dis_fp_inst_srcf2_vld;   
input            dp_ctrl_dis_fp_inst_store;       
input            dp_ctrl_dis_fp_inst_wb_type;     
input            idu_vidu_ex1_fp_dp_sel;          
input            idu_vidu_ex1_fp_sel;             
input   [179:0]  idu_vidu_ex1_inst_data;          
input            idu_vidu_ex1_vec_dp_sel;         
input            idu_vidu_ex1_vec_sel;            
input            split_fp_ctrl_entry_vld;         
input            split_fp_ctrl_inst_dp_vld;       
input            split_fp_ctrl_inst_gateclk_vld;  
input            split_fp_ctrl_inst_vld;          
input            split_vec0_ctrl_entry_vld;       
input            split_vec1_ctrl_entry_vld;       
input   [4  :0]  vpu_vidu_fp_fwd_reg;             
input            vpu_vidu_fp_fwd_vld;             
input            vpu_vidu_vex1_fp_stall;          
input   [2  :0]  wbt_ctrl_fp_dstv_info;           
input   [2  :0]  wbt_ctrl_fp_srcv0_info;          
input   [2  :0]  wbt_ctrl_fp_srcv1_info;          
input   [2  :0]  wbt_ctrl_fp_srcv2_info;          
input   [2  :0]  wbt_ctrl_fp_srcvm_info;          
output           ctrl_dis_fp_dep_stall_dp;        
output           ctrl_split_fp_dis_stall;         
output           ctrl_wbt_fp_dis_inst_gateclk_vld; 
output           ctrl_wbt_fp_dis_inst_vld;        
output           vidu_idu_fp_full;                
output           vidu_rtu_no_op;                  
output           vidu_vpu_vid_fp_inst_dp_vld;     
output           vidu_vpu_vid_fp_inst_gateclk_vld; 
output           vidu_vpu_vid_fp_inst_vld;        
output           vpu_rtu_ex1_cmplt;               
output           vpu_rtu_ex1_cmplt_dp;            

// &Regs; @28

// &Wires; @29
wire             ctrl_dis_dstf_waw;               
wire             ctrl_dis_dstf_waw_except;        
wire             ctrl_dis_fp_dep_stall;           
wire             ctrl_dis_fp_dep_stall_dp;        
wire             ctrl_dis_fp_inst_dp_vld;         
wire             ctrl_dis_fp_inst_gateclk_vld;    
wire             ctrl_dis_fp_inst_vld;            
wire             ctrl_dis_fp_stall;               
wire             ctrl_dis_srcf0_raw;              
wire             ctrl_dis_srcf0_raw_except;       
wire             ctrl_dis_srcf1_raw;              
wire             ctrl_dis_srcf1_raw_except;       
wire             ctrl_dis_srcf2_raw;              
wire             ctrl_dis_srcf2_raw_except;       
wire             ctrl_dis_srcf_raw;               
wire             ctrl_fgpr_reuse_inst_gateclk_vld; 
wire             ctrl_fgpr_reuse_inst_vld;        
wire             ctrl_pipedown_inst_dp_vld;       
wire             ctrl_pipedown_inst_gateclk_vld;  
wire             ctrl_pipedown_inst_vld;          
wire             ctrl_split_fp_dis_stall;         
wire             ctrl_vidu_no_op;                 
wire    [2  :0]  ctrl_wbt_ctrl_fp_srcvm_info;     
wire             ctrl_wbt_fp_dis_inst_gateclk_vld; 
wire             ctrl_wbt_fp_dis_inst_vld;        
wire             dp_ctrl_dis_fp_inst_dstf_vld;    
wire    [4  :0]  dp_ctrl_dis_fp_inst_srcf0_reg;   
wire             dp_ctrl_dis_fp_inst_srcf0_vld;   
wire    [4  :0]  dp_ctrl_dis_fp_inst_srcf1_reg;   
wire             dp_ctrl_dis_fp_inst_srcf1_vld;   
wire    [4  :0]  dp_ctrl_dis_fp_inst_srcf2_reg;   
wire             dp_ctrl_dis_fp_inst_srcf2_vld;   
wire             dp_ctrl_dis_fp_inst_store;       
wire             dp_ctrl_dis_fp_inst_wb_type;     
wire             idu_vidu_ex1_fp_dp_sel;          
wire             idu_vidu_ex1_fp_sel;             
wire    [179:0]  idu_vidu_ex1_inst_data;          
wire             idu_vidu_ex1_vec_dp_sel;         
wire             idu_vidu_ex1_vec_sel;            
wire             split_fp_ctrl_entry_vld;         
wire             split_fp_ctrl_inst_dp_vld;       
wire             split_fp_ctrl_inst_gateclk_vld;  
wire             split_fp_ctrl_inst_vld;          
wire             split_vec0_ctrl_entry_vld;       
wire             split_vec1_ctrl_entry_vld;       
wire             vidu_idu_fp_full;                
wire             vidu_rtu_no_op;                  
wire             vidu_vpu_vid_fp_inst_dp_vld;     
wire             vidu_vpu_vid_fp_inst_gateclk_vld; 
wire             vidu_vpu_vid_fp_inst_vld;        
wire             vpu_rtu_ex1_cmplt;               
wire             vpu_rtu_ex1_cmplt_dp;            
wire    [4  :0]  vpu_vidu_fp_fwd_reg;             
wire             vpu_vidu_fp_fwd_vld;             
wire             vpu_vidu_vex1_fp_stall;          
wire    [2  :0]  wbt_ctrl_fp_dstv_info;           
wire    [2  :0]  wbt_ctrl_fp_srcv0_info;          
wire    [2  :0]  wbt_ctrl_fp_srcv1_info;          
wire    [2  :0]  wbt_ctrl_fp_srcv2_info;          
wire    [2  :0]  wbt_ctrl_fp_srcvm_info;          


//==========================================================
//                  FP / VEC inst cmplt
//==========================================================
// &Force("bus","idu_vidu_ex1_inst_data",`DIS_VEC_WIDTH-1,0); @34
assign vpu_rtu_ex1_cmplt = 
     idu_vidu_ex1_fp_sel
     && !idu_vidu_ex1_inst_data[`DIS_VEC_EU-`EU_WIDTH+1+`EU_FLSU_SEL]
  || idu_vidu_ex1_vec_sel
     && !idu_vidu_ex1_inst_data[`DIS_VEC_EU-`EU_WIDTH+1+`EU_VLSU_SEL];

assign vpu_rtu_ex1_cmplt_dp =
     idu_vidu_ex1_fp_dp_sel
     && !idu_vidu_ex1_inst_data[`DIS_VEC_EU-`EU_WIDTH+1+`EU_FLSU_SEL]
  || idu_vidu_ex1_vec_dp_sel
     && !idu_vidu_ex1_inst_data[`DIS_VEC_EU-`EU_WIDTH+1+`EU_VLSU_SEL];

//==========================================================
//                  Dispatch Inst Valid
//==========================================================
assign ctrl_dis_fp_inst_vld           = split_fp_ctrl_inst_vld;
assign ctrl_dis_fp_inst_dp_vld        = split_fp_ctrl_inst_dp_vld;
assign ctrl_dis_fp_inst_gateclk_vld   = split_fp_ctrl_inst_gateclk_vld;

assign ctrl_pipedown_inst_vld         = ctrl_dis_fp_inst_vld
                                        && !ctrl_dis_fp_stall;
assign ctrl_pipedown_inst_dp_vld      = ctrl_dis_fp_inst_dp_vld;
assign ctrl_pipedown_inst_gateclk_vld = ctrl_dis_fp_inst_gateclk_vld;

//==========================================================
//                   VID Stall signals
//==========================================================
//----------------------------------------------------------
//                    VIDU FP stalls
//----------------------------------------------------------
//if fp/vec0/vec1 split entry vld, stall ex1 fp inst
assign vidu_idu_fp_full           = split_fp_ctrl_entry_vld
                                    || split_vec0_ctrl_entry_vld
                                    || split_vec1_ctrl_entry_vld;

assign ctrl_vidu_no_op            = !(split_fp_ctrl_entry_vld
                                    || split_vec0_ctrl_entry_vld
                                    || split_vec1_ctrl_entry_vld);

assign vidu_rtu_no_op             = ctrl_vidu_no_op;

//----------------------------------------------------------
//                   Dispatch signals
//----------------------------------------------------------
//1.dispatch stage only has raw / waw stall
//  not include vec borrow fp data path
assign ctrl_dis_fp_dep_stall      = ctrl_dis_fp_inst_vld
                                    && (ctrl_dis_srcf_raw || ctrl_dis_dstf_waw);

//dispatch stall include dispatch internal stall and ex1 stage stall
assign ctrl_dis_fp_stall          = vpu_vidu_vex1_fp_stall
                                    || ctrl_dis_fp_dep_stall;
//output
assign ctrl_split_fp_dis_stall    = ctrl_dis_fp_stall;

//if vec borrow fp data path, vec can stall when fp raw / waw
assign ctrl_dis_fp_dep_stall_dp   = ctrl_dis_srcf_raw || ctrl_dis_dstf_waw;

//==========================================================
//           Control Signal for Write Back Table
//==========================================================
//dispatch fp inst and vec reuse need to access wbt
assign ctrl_wbt_fp_dis_inst_vld         = ctrl_pipedown_inst_vld
                                          || ctrl_fgpr_reuse_inst_vld;

assign ctrl_wbt_fp_dis_inst_gateclk_vld = ctrl_pipedown_inst_gateclk_vld
                                          || ctrl_fgpr_reuse_inst_gateclk_vld;

// &Force("nonport","ctrl_wbt_ctrl_fp_srcvm_info"); @103
assign ctrl_wbt_ctrl_fp_srcvm_info[`WB_VEC_WIDTH-1:0] = wbt_ctrl_fp_srcvm_info[`WB_VEC_WIDTH-1:0];

//==========================================================
//                       RAW Stall
//==========================================================
//----------------------------------------------------------
//                    RAW Stall signals
//----------------------------------------------------------
// &Force("bus","wbt_ctrl_fp_srcv0_info",`WB_VEC_WIDTH-1,0); @112
// &Force("bus","wbt_ctrl_fp_srcv1_info",`WB_VEC_WIDTH-1,0); @113
// &Force("bus","wbt_ctrl_fp_srcv2_info",`WB_VEC_WIDTH-1,0); @114
//when there is old producer has same dst reg with dispatch inst
//dispatch inst has waw stall (wb_vld includes writing back in wbt)
assign ctrl_dis_srcf0_raw = dp_ctrl_dis_fp_inst_srcf0_vld
                            && !wbt_ctrl_fp_srcv0_info[`WB_VEC_VLD]
                            && !ctrl_dis_srcf0_raw_except;
assign ctrl_dis_srcf1_raw = dp_ctrl_dis_fp_inst_srcf1_vld
                            && !wbt_ctrl_fp_srcv1_info[`WB_VEC_VLD]
                            && !ctrl_dis_srcf1_raw_except;
assign ctrl_dis_srcf2_raw = dp_ctrl_dis_fp_inst_srcf2_vld
                            && !wbt_ctrl_fp_srcv2_info[`WB_VEC_VLD]
                            && !ctrl_dis_srcf2_raw_except;

//RAW stall signal except inst vld
assign ctrl_dis_srcf_raw = ctrl_dis_srcf0_raw
                        || ctrl_dis_srcf1_raw
                        || ctrl_dis_srcf2_raw;

//----------------------------------------------------------
//                 RAW stall Exceptions
//----------------------------------------------------------
//there are exceptions when normal raw stall
assign ctrl_dis_srcf0_raw_except =
  //1. if producer is at forward port
     vpu_vidu_fp_fwd_vld
     && (dp_ctrl_dis_fp_inst_srcf0_reg[4:0]    == vpu_vidu_fp_fwd_reg[4:0])
     && !((wbt_ctrl_fp_srcv0_info[`WB_VEC_TYPE] == `WB_VEC_TYPE_VLSU)
       && (wbt_ctrl_fp_srcv0_info[`WB_VEC_CNT]  == 1'b1));

assign ctrl_dis_srcf1_raw_except =
  //1. if producer is at forward port
     vpu_vidu_fp_fwd_vld
     && (dp_ctrl_dis_fp_inst_srcf1_reg[4:0]    == vpu_vidu_fp_fwd_reg[4:0])
     && !((wbt_ctrl_fp_srcv1_info[`WB_VEC_TYPE] == `WB_VEC_TYPE_VLSU)
       && (wbt_ctrl_fp_srcv1_info[`WB_VEC_CNT]  == 1'b1));

assign ctrl_dis_srcf2_raw_except =
  //1. if producer is at forward port
     vpu_vidu_fp_fwd_vld
     && (dp_ctrl_dis_fp_inst_srcf2_reg[4:0]    == vpu_vidu_fp_fwd_reg[4:0])
     && !((wbt_ctrl_fp_srcv2_info[`WB_VEC_TYPE] == `WB_VEC_TYPE_VLSU)
       && (wbt_ctrl_fp_srcv2_info[`WB_VEC_CNT]  == 1'b1))
  //2. if consumer is store source data (srcv2)
  || dp_ctrl_dis_fp_inst_store
     && !((wbt_ctrl_fp_srcv2_info[`WB_VEC_TYPE] == `WB_VEC_TYPE_VLSU)
       && (wbt_ctrl_fp_srcv2_info[`WB_VEC_CNT]  == 1'b1));

//==========================================================
//                       WAW Stall
//==========================================================
//----------------------------------------------------------
//                    WAW Stall signals
//----------------------------------------------------------
// &Force("bus","wbt_ctrl_fp_dstv_info",`WB_VEC_WIDTH-1,0); @167
//when there is old producer has same dst reg with dispatch inst
//dispatch inst has waw stall (wb_vld includes writing back in wbt)
assign ctrl_dis_dstf_waw = dp_ctrl_dis_fp_inst_dstf_vld
                           && !wbt_ctrl_fp_dstv_info[`WB_VEC_VLD]
                           && !ctrl_dis_dstf_waw_except;

//----------------------------------------------------------
//                 WAW stall Exceptions
//----------------------------------------------------------
//there are exceptions when normal waw stall
assign ctrl_dis_dstf_waw_except =
  //1. if new producer and old producer are both lsu
  //   no waw stall when there is only 1 old lsu producer
        (wbt_ctrl_fp_dstv_info[`WB_VEC_TYPE] == `WB_VEC_TYPE_VLSU)
     && (dp_ctrl_dis_fp_inst_wb_type         == `WB_VEC_TYPE_VLSU)
     && !wbt_ctrl_fp_dstv_info[`WB_VEC_CNT];

//==========================================================
//                     Output to VFPU
//==========================================================
assign vidu_vpu_vid_fp_inst_vld         = ctrl_pipedown_inst_vld;
assign vidu_vpu_vid_fp_inst_dp_vld      = ctrl_pipedown_inst_dp_vld;
assign vidu_vpu_vid_fp_inst_gateclk_vld = ctrl_pipedown_inst_gateclk_vld;


// &ModuleEnd; @193
endmodule


