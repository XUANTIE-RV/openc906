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
module aq_vidu_vid_dp_fp(
  ctrl_dp_fgpr_reuse_inst_dp_vld,
  dp_ctrl_dis_fp_inst_dstf_vld,
  dp_ctrl_dis_fp_inst_srcf0_reg,
  dp_ctrl_dis_fp_inst_srcf0_vld,
  dp_ctrl_dis_fp_inst_srcf1_reg,
  dp_ctrl_dis_fp_inst_srcf1_vld,
  dp_ctrl_dis_fp_inst_srcf2_reg,
  dp_ctrl_dis_fp_inst_srcf2_vld,
  dp_ctrl_dis_fp_inst_store,
  dp_ctrl_dis_fp_inst_wb_type,
  dp_gpr_fp_src0_reg,
  dp_gpr_fp_src1_reg,
  dp_gpr_fp_src2_reg,
  dp_vec_fgpr_reuse_dstf_reg,
  dp_vec_fgpr_reuse_dstf_vld,
  dp_vec_fgpr_reuse_srcf0_reg,
  dp_vec_fgpr_reuse_srcf0_vld,
  dp_vec_fgpr_reuse_srcf1_reg,
  dp_vec_fgpr_reuse_srcf1_vld,
  dp_vec_fgpr_reuse_srcf2_reg,
  dp_vec_fgpr_reuse_srcf2_vld,
  dp_wbt_fp_dstv_reg,
  dp_wbt_fp_dstv_type,
  dp_wbt_fp_dstv_vld,
  dp_wbt_fp_srcv0_reg,
  dp_wbt_fp_srcv1_reg,
  dp_wbt_fp_srcv2_reg,
  gpr_fp_dp_src0_data,
  gpr_fp_dp_src1_data,
  gpr_fp_dp_src2_data,
  idu_vidu_ex1_inst_data,
  split_fp_dp_inst_data,
  vidu_vpu_vid_fp_inst_dst_reg,
  vidu_vpu_vid_fp_inst_dst_vld,
  vidu_vpu_vid_fp_inst_dste_vld,
  vidu_vpu_vid_fp_inst_dstf_reg,
  vidu_vpu_vid_fp_inst_dstf_vld,
  vidu_vpu_vid_fp_inst_eu,
  vidu_vpu_vid_fp_inst_func,
  vidu_vpu_vid_fp_inst_src1_data,
  vidu_vpu_vid_fp_inst_srcf0_data,
  vidu_vpu_vid_fp_inst_srcf1_data,
  vidu_vpu_vid_fp_inst_srcf2_data,
  vidu_vpu_vid_fp_inst_srcf2_rdy,
  vidu_vpu_vid_fp_inst_srcf2_vld,
  vpu_rtu_ex1_fp_dirty,
  vpu_rtu_ex1_vec_dirty,
  vpu_vidu_fp_fwd_data,
  vpu_vidu_fp_fwd_reg,
  vpu_vidu_fp_fwd_vld,
  wbt_ctrl_fp_srcv2_info
);

// &Ports; @28
input            ctrl_dp_fgpr_reuse_inst_dp_vld; 
input   [4  :0]  dp_vec_fgpr_reuse_dstf_reg;     
input            dp_vec_fgpr_reuse_dstf_vld;     
input   [4  :0]  dp_vec_fgpr_reuse_srcf0_reg;    
input            dp_vec_fgpr_reuse_srcf0_vld;    
input   [4  :0]  dp_vec_fgpr_reuse_srcf1_reg;    
input            dp_vec_fgpr_reuse_srcf1_vld;    
input   [4  :0]  dp_vec_fgpr_reuse_srcf2_reg;    
input            dp_vec_fgpr_reuse_srcf2_vld;    
input   [63 :0]  gpr_fp_dp_src0_data;            
input   [63 :0]  gpr_fp_dp_src1_data;            
input   [63 :0]  gpr_fp_dp_src2_data;            
input   [179:0]  idu_vidu_ex1_inst_data;         
input   [179:0]  split_fp_dp_inst_data;          
input   [63 :0]  vpu_vidu_fp_fwd_data;           
input   [4  :0]  vpu_vidu_fp_fwd_reg;            
input            vpu_vidu_fp_fwd_vld;            
input   [2  :0]  wbt_ctrl_fp_srcv2_info;         
output           dp_ctrl_dis_fp_inst_dstf_vld;   
output  [4  :0]  dp_ctrl_dis_fp_inst_srcf0_reg;  
output           dp_ctrl_dis_fp_inst_srcf0_vld;  
output  [4  :0]  dp_ctrl_dis_fp_inst_srcf1_reg;  
output           dp_ctrl_dis_fp_inst_srcf1_vld;  
output  [4  :0]  dp_ctrl_dis_fp_inst_srcf2_reg;  
output           dp_ctrl_dis_fp_inst_srcf2_vld;  
output           dp_ctrl_dis_fp_inst_store;      
output           dp_ctrl_dis_fp_inst_wb_type;    
output  [4  :0]  dp_gpr_fp_src0_reg;             
output  [4  :0]  dp_gpr_fp_src1_reg;             
output  [4  :0]  dp_gpr_fp_src2_reg;             
output  [4  :0]  dp_wbt_fp_dstv_reg;             
output           dp_wbt_fp_dstv_type;            
output           dp_wbt_fp_dstv_vld;             
output  [4  :0]  dp_wbt_fp_srcv0_reg;            
output  [4  :0]  dp_wbt_fp_srcv1_reg;            
output  [4  :0]  dp_wbt_fp_srcv2_reg;            
output  [5  :0]  vidu_vpu_vid_fp_inst_dst_reg;   
output           vidu_vpu_vid_fp_inst_dst_vld;   
output           vidu_vpu_vid_fp_inst_dste_vld;  
output  [4  :0]  vidu_vpu_vid_fp_inst_dstf_reg;  
output           vidu_vpu_vid_fp_inst_dstf_vld;  
output  [9  :0]  vidu_vpu_vid_fp_inst_eu;        
output  [19 :0]  vidu_vpu_vid_fp_inst_func;      
output  [63 :0]  vidu_vpu_vid_fp_inst_src1_data; 
output  [63 :0]  vidu_vpu_vid_fp_inst_srcf0_data; 
output  [63 :0]  vidu_vpu_vid_fp_inst_srcf1_data; 
output  [63 :0]  vidu_vpu_vid_fp_inst_srcf2_data; 
output           vidu_vpu_vid_fp_inst_srcf2_rdy; 
output           vidu_vpu_vid_fp_inst_srcf2_vld; 
output           vpu_rtu_ex1_fp_dirty;           
output           vpu_rtu_ex1_vec_dirty;          

// &Regs; @29

// &Wires; @30
wire             ctrl_dp_fgpr_reuse_inst_dp_vld; 
wire             dp_ctrl_dis_fp_inst_dstf_vld;   
wire    [4  :0]  dp_ctrl_dis_fp_inst_srcf0_reg;  
wire             dp_ctrl_dis_fp_inst_srcf0_vld;  
wire    [4  :0]  dp_ctrl_dis_fp_inst_srcf1_reg;  
wire             dp_ctrl_dis_fp_inst_srcf1_vld;  
wire    [4  :0]  dp_ctrl_dis_fp_inst_srcf2_reg;  
wire             dp_ctrl_dis_fp_inst_srcf2_vld;  
wire             dp_ctrl_dis_fp_inst_store;      
wire             dp_ctrl_dis_fp_inst_wb_type;    
wire    [5  :0]  dp_dis_fp_inst_dst0_reg;        
wire             dp_dis_fp_inst_dst0_vld;        
wire             dp_dis_fp_inst_dste_vld;        
wire    [4  :0]  dp_dis_fp_inst_dstf_reg;        
wire             dp_dis_fp_inst_dstf_vld;        
wire    [9  :0]  dp_dis_fp_inst_eu;              
wire    [19 :0]  dp_dis_fp_inst_func;            
wire    [63 :0]  dp_dis_fp_inst_src1_data;       
wire    [63 :0]  dp_dis_fp_inst_srcf0_data;      
wire             dp_dis_fp_inst_srcf0_fwd_vld;   
wire    [63 :0]  dp_dis_fp_inst_srcf1_data;      
wire             dp_dis_fp_inst_srcf1_fwd_vld;   
wire    [63 :0]  dp_dis_fp_inst_srcf2_data;      
wire             dp_dis_fp_inst_srcf2_fwd_vld;   
wire             dp_dis_fp_inst_srcf2_rdy;       
wire             dp_dis_fp_inst_srcf2_vld;       
wire    [4  :0]  dp_fp_dstf_reg;                 
wire             dp_fp_dstf_vld;                 
wire    [179:0]  dp_fp_inst_data;                
wire    [4  :0]  dp_fp_srcf0_reg;                
wire             dp_fp_srcf0_vld;                
wire    [4  :0]  dp_fp_srcf1_reg;                
wire             dp_fp_srcf1_vld;                
wire    [4  :0]  dp_fp_srcf2_reg;                
wire             dp_fp_srcf2_vld;                
wire    [4  :0]  dp_gpr_fp_src0_reg;             
wire    [4  :0]  dp_gpr_fp_src1_reg;             
wire    [4  :0]  dp_gpr_fp_src2_reg;             
wire    [4  :0]  dp_vec_fgpr_reuse_dstf_reg;     
wire             dp_vec_fgpr_reuse_dstf_vld;     
wire    [4  :0]  dp_vec_fgpr_reuse_srcf0_reg;    
wire             dp_vec_fgpr_reuse_srcf0_vld;    
wire    [4  :0]  dp_vec_fgpr_reuse_srcf1_reg;    
wire             dp_vec_fgpr_reuse_srcf1_vld;    
wire    [4  :0]  dp_vec_fgpr_reuse_srcf2_reg;    
wire             dp_vec_fgpr_reuse_srcf2_vld;    
wire             dp_wb_inst_type;                
wire    [4  :0]  dp_wbt_fp_dstv_reg;             
wire             dp_wbt_fp_dstv_type;            
wire             dp_wbt_fp_dstv_vld;             
wire    [4  :0]  dp_wbt_fp_srcv0_reg;            
wire    [4  :0]  dp_wbt_fp_srcv1_reg;            
wire    [4  :0]  dp_wbt_fp_srcv2_reg;            
wire    [63 :0]  gpr_fp_dp_src0_data;            
wire    [63 :0]  gpr_fp_dp_src1_data;            
wire    [63 :0]  gpr_fp_dp_src2_data;            
wire    [179:0]  idu_vidu_ex1_inst_data;         
wire    [179:0]  split_fp_dp_inst_data;          
wire    [5  :0]  vidu_vpu_vid_fp_inst_dst_reg;   
wire             vidu_vpu_vid_fp_inst_dst_vld;   
wire             vidu_vpu_vid_fp_inst_dste_vld;  
wire    [4  :0]  vidu_vpu_vid_fp_inst_dstf_reg;  
wire             vidu_vpu_vid_fp_inst_dstf_vld;  
wire    [9  :0]  vidu_vpu_vid_fp_inst_eu;        
wire    [19 :0]  vidu_vpu_vid_fp_inst_func;      
wire    [63 :0]  vidu_vpu_vid_fp_inst_src1_data; 
wire    [63 :0]  vidu_vpu_vid_fp_inst_srcf0_data; 
wire    [63 :0]  vidu_vpu_vid_fp_inst_srcf1_data; 
wire    [63 :0]  vidu_vpu_vid_fp_inst_srcf2_data; 
wire             vidu_vpu_vid_fp_inst_srcf2_rdy; 
wire             vidu_vpu_vid_fp_inst_srcf2_vld; 
wire             vpu_rtu_ex1_fp_dirty;           
wire             vpu_rtu_ex1_vec_dirty;          
wire    [63 :0]  vpu_vidu_fp_fwd_data;           
wire    [4  :0]  vpu_vidu_fp_fwd_reg;            
wire             vpu_vidu_fp_fwd_vld;            
wire    [2  :0]  wbt_ctrl_fp_srcv2_info;         


//==========================================================
//                  FP / VEC inst cmplt
//==========================================================
// &Force("bus","idu_vidu_ex1_inst_data",`DIS_VEC_WIDTH-1,0); @35
assign vpu_rtu_ex1_fp_dirty                 = idu_vidu_ex1_inst_data[`DIS_VEC_DSTF_VLD]
                                           || idu_vidu_ex1_inst_data[`DIS_VEC_DSTE_VLD];
assign vpu_rtu_ex1_vec_dirty                = idu_vidu_ex1_inst_data[`DIS_VEC_DSTV_VLD] || idu_vidu_ex1_inst_data[`DIS_VEC_DSTV_LATE_VLD];

//==========================================================
//              Dispatch Instruction Data
//==========================================================
//----------------------------------------------------------
//             MUX between Decoder and Spliter
//----------------------------------------------------------
assign dp_fp_inst_data[`DIS_VEC_WIDTH-1:0]  = split_fp_dp_inst_data[`DIS_VEC_WIDTH-1:0];

//----------------------------------------------------------
//         Dispatch FP Instruction Information
//----------------------------------------------------------
assign dp_dis_fp_inst_func[`FUNC_WIDTH-1:0] = dp_fp_inst_data[`DIS_VEC_FUNC:`DIS_VEC_FUNC-`FUNC_WIDTH+1];
assign dp_dis_fp_inst_eu[`EU_WIDTH-1:0]     = dp_fp_inst_data[`DIS_VEC_EU:`DIS_VEC_EU-`EU_WIDTH+1];
assign dp_dis_fp_inst_dstf_reg[4:0]         = dp_fp_inst_data[`DIS_VEC_DSTV_REG-8:`DIS_VEC_DSTV_REG-12];
assign dp_dis_fp_inst_src1_data[63:0]       = dp_fp_inst_data[`DIS_VEC_SRC1_DATA:`DIS_VEC_SRC1_DATA-63];
assign dp_dis_fp_inst_dst0_reg[5:0]         = dp_fp_inst_data[`DIS_VEC_DST0_REG:`DIS_VEC_DST0_REG-5];
assign dp_dis_fp_inst_dst0_vld              = dp_fp_inst_data[`DIS_VEC_DST0_VLD];
assign dp_dis_fp_inst_dstf_vld              = dp_fp_inst_data[`DIS_VEC_DSTF_VLD];
assign dp_dis_fp_inst_dste_vld              = dp_fp_inst_data[`DIS_VEC_DSTE_VLD];

//==========================================================
//                 GPR Read Port Share
//==========================================================
//vector inst may read or forward fgpr
//----------------------------------------------------------
//                  Source Index Mux
//----------------------------------------------------------
assign dp_fp_srcf0_vld      = ctrl_dp_fgpr_reuse_inst_dp_vld
                              ? dp_vec_fgpr_reuse_srcf0_vld
                              : dp_fp_inst_data[`DIS_VEC_SRCF0_VLD];
assign dp_fp_srcf1_vld      = ctrl_dp_fgpr_reuse_inst_dp_vld
                              ? dp_vec_fgpr_reuse_srcf1_vld
                              : dp_fp_inst_data[`DIS_VEC_SRCF1_VLD];
assign dp_fp_srcf2_vld      = ctrl_dp_fgpr_reuse_inst_dp_vld
                              ? dp_vec_fgpr_reuse_srcf2_vld
                              : dp_fp_inst_data[`DIS_VEC_SRCF2_VLD];
assign dp_fp_dstf_vld       = ctrl_dp_fgpr_reuse_inst_dp_vld
                              ? dp_vec_fgpr_reuse_dstf_vld
                              : dp_fp_inst_data[`DIS_VEC_DSTF_VLD];

assign dp_fp_srcf0_reg[4:0] = ctrl_dp_fgpr_reuse_inst_dp_vld
                              ? dp_vec_fgpr_reuse_srcf0_reg[4:0]
                              : dp_fp_inst_data[`DIS_VEC_SRCV0_REG-8:`DIS_VEC_SRCV0_REG-12];
assign dp_fp_srcf1_reg[4:0] = ctrl_dp_fgpr_reuse_inst_dp_vld
                              ? dp_vec_fgpr_reuse_srcf1_reg[4:0]
                              : dp_fp_inst_data[`DIS_VEC_SRCV1_REG-8:`DIS_VEC_SRCV1_REG-12];
assign dp_fp_srcf2_reg[4:0] = ctrl_dp_fgpr_reuse_inst_dp_vld
                              ? dp_vec_fgpr_reuse_srcf2_reg[4:0]
                              : dp_fp_inst_data[`DIS_VEC_SRCV2_REG-8:`DIS_VEC_SRCV2_REG-12];
assign dp_fp_dstf_reg[4:0]  = ctrl_dp_fgpr_reuse_inst_dp_vld
                              ? dp_vec_fgpr_reuse_dstf_reg[4:0]
                              : dp_fp_inst_data[`DIS_VEC_DSTV_REG-8:`DIS_VEC_DSTV_REG-12];

//----------------------------------------------------------
//                Output Control Logic
//----------------------------------------------------------
assign dp_ctrl_dis_fp_inst_dstf_vld       = dp_fp_dstf_vld;
assign dp_ctrl_dis_fp_inst_srcf0_vld      = dp_fp_srcf0_vld;
assign dp_ctrl_dis_fp_inst_srcf1_vld      = dp_fp_srcf1_vld;
assign dp_ctrl_dis_fp_inst_srcf2_vld      = dp_fp_srcf2_vld;

assign dp_ctrl_dis_fp_inst_srcf0_reg[4:0] = dp_fp_srcf0_reg[4:0];
assign dp_ctrl_dis_fp_inst_srcf1_reg[4:0] = dp_fp_srcf1_reg[4:0];
assign dp_ctrl_dis_fp_inst_srcf2_reg[4:0] = dp_fp_srcf2_reg[4:0];

assign dp_ctrl_dis_fp_inst_store     = dp_fp_inst_data[`DIS_VEC_EU-`EU_WIDTH+1+`EU_VLSU_SEL]
                                       && dp_fp_inst_data[`DIS_VEC_FUNC-`FUNC_WIDTH+1+`FUNC_STORE_SEL];
assign dp_ctrl_dis_fp_inst_wb_type   = dp_wb_inst_type;

//==========================================================
//                     Access WBT
//==========================================================
assign dp_wbt_fp_srcv0_reg[4:0] = dp_fp_srcf0_reg[4:0];
assign dp_wbt_fp_srcv1_reg[4:0] = dp_fp_srcf1_reg[4:0];
assign dp_wbt_fp_srcv2_reg[4:0] = dp_fp_srcf2_reg[4:0];
assign dp_wbt_fp_dstv_reg[4:0]  = dp_fp_dstf_reg[4:0];
assign dp_wbt_fp_dstv_vld       = dp_fp_dstf_vld;

//if not special type, inst type is 0
//if fgpr reuse, inst type is 0
assign dp_wb_inst_type = ctrl_dp_fgpr_reuse_inst_dp_vld
                         ? 1'b0 : dp_fp_inst_data[`DIS_VEC_EU-`EU_WIDTH+1+`EU_VLSU_SEL];

assign dp_wbt_fp_dstv_type      = dp_wb_inst_type;

//==========================================================
//                     Access GPR
//==========================================================
//----------------------------------------------------------
//                Source and Dest Index
//----------------------------------------------------------
assign dp_gpr_fp_src0_reg[4:0] = dp_fp_srcf0_reg[4:0];
assign dp_gpr_fp_src1_reg[4:0] = dp_fp_srcf1_reg[4:0];
assign dp_gpr_fp_src2_reg[4:0] = dp_fp_srcf2_reg[4:0];

//==========================================================
//                     Forward
//==========================================================
assign dp_dis_fp_inst_srcf0_fwd_vld = vpu_vidu_fp_fwd_vld
                                      && (dp_fp_srcf0_reg[4:0] == vpu_vidu_fp_fwd_reg[4:0]);
assign dp_dis_fp_inst_srcf1_fwd_vld = vpu_vidu_fp_fwd_vld
                                      && (dp_fp_srcf1_reg[4:0] == vpu_vidu_fp_fwd_reg[4:0]);
assign dp_dis_fp_inst_srcf2_fwd_vld = vpu_vidu_fp_fwd_vld
                                      && (dp_fp_srcf2_reg[4:0] == vpu_vidu_fp_fwd_reg[4:0]);

//may forward data in exe unit, so indicate src vld
// &Force("bus","wbt_ctrl_fp_srcv2_info",`WB_VEC_WIDTH-1,0); @146
assign dp_dis_fp_inst_srcf2_rdy     = wbt_ctrl_fp_srcv2_info[`WB_VEC_VLD]
                                      || dp_dis_fp_inst_srcf2_fwd_vld
                                      || !dp_fp_inst_data[`DIS_VEC_SRCF2_VLD];

assign dp_dis_fp_inst_srcf2_vld     = dp_fp_srcf2_vld;
//==========================================================
//              Dispatch Instruction Operands
//==========================================================
//mux between GPR and forward bus
assign dp_dis_fp_inst_srcf0_data[63:0] = dp_dis_fp_inst_srcf0_fwd_vld
                                         ? vpu_vidu_fp_fwd_data[63:0]
                                         : gpr_fp_dp_src0_data[63:0];
assign dp_dis_fp_inst_srcf1_data[63:0] = dp_dis_fp_inst_srcf1_fwd_vld
                                         ? vpu_vidu_fp_fwd_data[63:0]
                                         : gpr_fp_dp_src1_data[63:0];
assign dp_dis_fp_inst_srcf2_data[63:0] = dp_dis_fp_inst_srcf2_fwd_vld
                                         ? vpu_vidu_fp_fwd_data[63:0]
                                         : gpr_fp_dp_src2_data[63:0];

//==========================================================
//                   Output to VFPU
//==========================================================
assign vidu_vpu_vid_fp_inst_func[`FUNC_WIDTH-1:0] = dp_dis_fp_inst_func[`FUNC_WIDTH-1:0];
assign vidu_vpu_vid_fp_inst_eu[`EU_WIDTH-1:0]     = dp_dis_fp_inst_eu[`EU_WIDTH-1:0];
assign vidu_vpu_vid_fp_inst_dst_vld               = dp_dis_fp_inst_dst0_vld;
assign vidu_vpu_vid_fp_inst_dstf_vld              = dp_dis_fp_inst_dstf_vld;
assign vidu_vpu_vid_fp_inst_dste_vld              = dp_dis_fp_inst_dste_vld;
assign vidu_vpu_vid_fp_inst_dst_reg[5:0]          = dp_dis_fp_inst_dst0_reg[5:0];
assign vidu_vpu_vid_fp_inst_dstf_reg[4:0]         = dp_dis_fp_inst_dstf_reg[4:0];
assign vidu_vpu_vid_fp_inst_src1_data[63:0]       = dp_dis_fp_inst_src1_data[63:0];
assign vidu_vpu_vid_fp_inst_srcf0_data[63:0]      = dp_dis_fp_inst_srcf0_data[63:0];
assign vidu_vpu_vid_fp_inst_srcf1_data[63:0]      = dp_dis_fp_inst_srcf1_data[63:0];
assign vidu_vpu_vid_fp_inst_srcf2_data[63:0]      = dp_dis_fp_inst_srcf2_data[63:0];
assign vidu_vpu_vid_fp_inst_srcf2_rdy             = dp_dis_fp_inst_srcf2_rdy;
assign vidu_vpu_vid_fp_inst_srcf2_vld             = dp_dis_fp_inst_srcf2_vld;

// &ModuleEnd; @183
endmodule


