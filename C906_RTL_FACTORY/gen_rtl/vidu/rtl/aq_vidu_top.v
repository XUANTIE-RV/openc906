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

// &Depend("cpu_cfig.h"); @23
// &Depend("aq_idu_cfig.h"); @24
// &ModuleBeg; @25
module aq_vidu_top(
  cp0_idu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  idu_vidu_ex1_fp_dp_sel,
  idu_vidu_ex1_fp_gateclk_sel,
  idu_vidu_ex1_fp_sel,
  idu_vidu_ex1_inst_data,
  idu_vidu_ex1_vec_dp_sel,
  idu_vidu_ex1_vec_gateclk_sel,
  idu_vidu_ex1_vec_sel,
  ifu_vidu_warm_up,
  pad_yy_icg_scan_en,
  rtu_vidu_flush_wbt,
  rtu_yy_xx_async_flush,
  vidu_cp0_vid_fof_vld,
  vidu_dtu_debug_info,
  vidu_idu_fp_full,
  vidu_idu_vec_full,
  vidu_rtu_no_op,
  vidu_vpu_vid_fp_inst_dp_vld,
  vidu_vpu_vid_fp_inst_dst_reg,
  vidu_vpu_vid_fp_inst_dst_vld,
  vidu_vpu_vid_fp_inst_dste_vld,
  vidu_vpu_vid_fp_inst_dstf_reg,
  vidu_vpu_vid_fp_inst_dstf_vld,
  vidu_vpu_vid_fp_inst_eu,
  vidu_vpu_vid_fp_inst_func,
  vidu_vpu_vid_fp_inst_gateclk_vld,
  vidu_vpu_vid_fp_inst_src1_data,
  vidu_vpu_vid_fp_inst_srcf0_data,
  vidu_vpu_vid_fp_inst_srcf1_data,
  vidu_vpu_vid_fp_inst_srcf2_data,
  vidu_vpu_vid_fp_inst_srcf2_rdy,
  vidu_vpu_vid_fp_inst_srcf2_vld,
  vidu_vpu_vid_fp_inst_vld,
  vpu_rtu_ex1_cmplt,
  vpu_rtu_ex1_cmplt_dp,
  vpu_rtu_ex1_fp_dirty,
  vpu_rtu_ex1_vec_dirty,
  vpu_vidu_fp_fwd_data,
  vpu_vidu_fp_fwd_reg,
  vpu_vidu_fp_fwd_vld,
  vpu_vidu_fp_wb_data,
  vpu_vidu_fp_wb_reg,
  vpu_vidu_fp_wb_vld,
  vpu_vidu_vex1_fp_stall,
  vpu_vidu_wbt_fp_wb0_reg,
  vpu_vidu_wbt_fp_wb0_vld,
  vpu_vidu_wbt_fp_wb1_reg,
  vpu_vidu_wbt_fp_wb1_vld
);

// &Ports; @26
input            cp0_idu_icg_en;                  
input            cp0_yy_clk_en;                   
input            cpurst_b;                        
input            forever_cpuclk;                  
input            idu_vidu_ex1_fp_dp_sel;          
input            idu_vidu_ex1_fp_gateclk_sel;     
input            idu_vidu_ex1_fp_sel;             
input   [179:0]  idu_vidu_ex1_inst_data;          
input            idu_vidu_ex1_vec_dp_sel;         
input            idu_vidu_ex1_vec_gateclk_sel;    
input            idu_vidu_ex1_vec_sel;            
input            ifu_vidu_warm_up;                
input            pad_yy_icg_scan_en;              
input            rtu_vidu_flush_wbt;              
input            rtu_yy_xx_async_flush;           
input   [63 :0]  vpu_vidu_fp_fwd_data;            
input   [4  :0]  vpu_vidu_fp_fwd_reg;             
input            vpu_vidu_fp_fwd_vld;             
input   [63 :0]  vpu_vidu_fp_wb_data;             
input   [4  :0]  vpu_vidu_fp_wb_reg;              
input            vpu_vidu_fp_wb_vld;              
input            vpu_vidu_vex1_fp_stall;          
input   [4  :0]  vpu_vidu_wbt_fp_wb0_reg;         
input            vpu_vidu_wbt_fp_wb0_vld;         
input   [4  :0]  vpu_vidu_wbt_fp_wb1_reg;         
input            vpu_vidu_wbt_fp_wb1_vld;         
output           vidu_cp0_vid_fof_vld;            
output  [7  :0]  vidu_dtu_debug_info;             
output           vidu_idu_fp_full;                
output           vidu_idu_vec_full;               
output           vidu_rtu_no_op;                  
output           vidu_vpu_vid_fp_inst_dp_vld;     
output  [5  :0]  vidu_vpu_vid_fp_inst_dst_reg;    
output           vidu_vpu_vid_fp_inst_dst_vld;    
output           vidu_vpu_vid_fp_inst_dste_vld;   
output  [4  :0]  vidu_vpu_vid_fp_inst_dstf_reg;   
output           vidu_vpu_vid_fp_inst_dstf_vld;   
output  [9  :0]  vidu_vpu_vid_fp_inst_eu;         
output  [19 :0]  vidu_vpu_vid_fp_inst_func;       
output           vidu_vpu_vid_fp_inst_gateclk_vld; 
output  [63 :0]  vidu_vpu_vid_fp_inst_src1_data;  
output  [63 :0]  vidu_vpu_vid_fp_inst_srcf0_data; 
output  [63 :0]  vidu_vpu_vid_fp_inst_srcf1_data; 
output  [63 :0]  vidu_vpu_vid_fp_inst_srcf2_data; 
output           vidu_vpu_vid_fp_inst_srcf2_rdy;  
output           vidu_vpu_vid_fp_inst_srcf2_vld;  
output           vidu_vpu_vid_fp_inst_vld;        
output           vpu_rtu_ex1_cmplt;               
output           vpu_rtu_ex1_cmplt_dp;            
output           vpu_rtu_ex1_fp_dirty;            
output           vpu_rtu_ex1_vec_dirty;           

// &Regs; @27

// &Wires; @28
wire             cp0_idu_icg_en;                  
wire             cp0_yy_clk_en;                   
wire             cpurst_b;                        
wire             ctrl_dis_fp_dep_stall_dp;        
wire             ctrl_dp_fgpr_reuse_inst_dp_vld;  
wire             ctrl_fgpr_reuse_inst_gateclk_vld; 
wire             ctrl_fgpr_reuse_inst_vld;        
wire             ctrl_split_fp_dis_stall;         
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
wire    [4  :0]  dp_wbt_fp_dstv_reg;              
wire             dp_wbt_fp_dstv_type;             
wire             dp_wbt_fp_dstv_vld;              
wire    [4  :0]  dp_wbt_fp_srcv0_reg;             
wire    [4  :0]  dp_wbt_fp_srcv1_reg;             
wire    [4  :0]  dp_wbt_fp_srcv2_reg;             
wire             forever_cpuclk;                  
wire    [63 :0]  gpr_fp_dp_src0_data;             
wire    [63 :0]  gpr_fp_dp_src1_data;             
wire    [63 :0]  gpr_fp_dp_src2_data;             
wire             idu_vidu_ex1_fp_dp_sel;          
wire             idu_vidu_ex1_fp_gateclk_sel;     
wire             idu_vidu_ex1_fp_sel;             
wire    [179:0]  idu_vidu_ex1_inst_data;          
wire             idu_vidu_ex1_vec_dp_sel;         
wire             idu_vidu_ex1_vec_sel;            
wire             ifu_vidu_warm_up;                
wire             pad_yy_icg_scan_en;              
wire             rtu_vidu_flush_wbt;              
wire             rtu_yy_xx_async_flush;           
wire             split_fp_ctrl_entry_vld;         
wire             split_fp_ctrl_inst_dp_vld;       
wire             split_fp_ctrl_inst_gateclk_vld;  
wire             split_fp_ctrl_inst_vld;          
wire    [179:0]  split_fp_dp_inst_data;           
wire             split_vec0_ctrl_entry_vld;       
wire             split_vec1_ctrl_entry_vld;       
wire             vidu_cp0_vid_fof_vld;            
wire    [7  :0]  vidu_dtu_debug_info;             
wire             vidu_idu_fp_full;                
wire             vidu_idu_vec_full;               
wire             vidu_rtu_no_op;                  
wire             vidu_vpu_vid_fp_inst_dp_vld;     
wire    [5  :0]  vidu_vpu_vid_fp_inst_dst_reg;    
wire             vidu_vpu_vid_fp_inst_dst_vld;    
wire             vidu_vpu_vid_fp_inst_dste_vld;   
wire    [4  :0]  vidu_vpu_vid_fp_inst_dstf_reg;   
wire             vidu_vpu_vid_fp_inst_dstf_vld;   
wire    [9  :0]  vidu_vpu_vid_fp_inst_eu;         
wire    [19 :0]  vidu_vpu_vid_fp_inst_func;       
wire             vidu_vpu_vid_fp_inst_gateclk_vld; 
wire    [63 :0]  vidu_vpu_vid_fp_inst_src1_data;  
wire    [63 :0]  vidu_vpu_vid_fp_inst_srcf0_data; 
wire    [63 :0]  vidu_vpu_vid_fp_inst_srcf1_data; 
wire    [63 :0]  vidu_vpu_vid_fp_inst_srcf2_data; 
wire             vidu_vpu_vid_fp_inst_srcf2_rdy;  
wire             vidu_vpu_vid_fp_inst_srcf2_vld;  
wire             vidu_vpu_vid_fp_inst_vld;        
wire             vpu_rtu_ex1_cmplt;               
wire             vpu_rtu_ex1_cmplt_dp;            
wire             vpu_rtu_ex1_fp_dirty;            
wire             vpu_rtu_ex1_vec_dirty;           
wire    [63 :0]  vpu_vidu_fp_fwd_data;            
wire    [4  :0]  vpu_vidu_fp_fwd_reg;             
wire             vpu_vidu_fp_fwd_vld;             
wire    [63 :0]  vpu_vidu_fp_wb_data;             
wire    [4  :0]  vpu_vidu_fp_wb_reg;              
wire             vpu_vidu_fp_wb_vld;              
wire             vpu_vidu_vex1_fp_stall;          
wire    [4  :0]  vpu_vidu_wbt_fp_wb0_reg;         
wire             vpu_vidu_wbt_fp_wb0_vld;         
wire    [4  :0]  vpu_vidu_wbt_fp_wb1_reg;         
wire             vpu_vidu_wbt_fp_wb1_vld;         
wire    [2  :0]  wbt_ctrl_fp_dstv_info;           
wire    [2  :0]  wbt_ctrl_fp_srcv0_info;          
wire    [2  :0]  wbt_ctrl_fp_srcv1_info;          
wire    [2  :0]  wbt_ctrl_fp_srcv2_info;          
wire    [2  :0]  wbt_ctrl_fp_srcvm_info;          
wire             wbt_top_fp_gpr_no_wb;            


//==========================================================
//                Scalar Floating-point
//==========================================================
//----------------------------------------------------------
//                   Module Instance
//----------------------------------------------------------
// &Instance("aq_vidu_vid_split_fp",   "x_aq_vidu_vid_split_fp"); @37
aq_vidu_vid_split_fp  x_aq_vidu_vid_split_fp (
  .cp0_idu_icg_en                 (cp0_idu_icg_en                ),
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .cpurst_b                       (cpurst_b                      ),
  .ctrl_split_fp_dis_stall        (ctrl_split_fp_dis_stall       ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .idu_vidu_ex1_fp_dp_sel         (idu_vidu_ex1_fp_dp_sel        ),
  .idu_vidu_ex1_fp_gateclk_sel    (idu_vidu_ex1_fp_gateclk_sel   ),
  .idu_vidu_ex1_fp_sel            (idu_vidu_ex1_fp_sel           ),
  .idu_vidu_ex1_inst_data         (idu_vidu_ex1_inst_data        ),
  .ifu_vidu_warm_up               (ifu_vidu_warm_up              ),
  .pad_yy_icg_scan_en             (pad_yy_icg_scan_en            ),
  .rtu_yy_xx_async_flush          (rtu_yy_xx_async_flush         ),
  .split_fp_ctrl_entry_vld        (split_fp_ctrl_entry_vld       ),
  .split_fp_ctrl_inst_dp_vld      (split_fp_ctrl_inst_dp_vld     ),
  .split_fp_ctrl_inst_gateclk_vld (split_fp_ctrl_inst_gateclk_vld),
  .split_fp_ctrl_inst_vld         (split_fp_ctrl_inst_vld        ),
  .split_fp_dp_inst_data          (split_fp_dp_inst_data         )
);


// &Instance("aq_vidu_vid_ctrl_fp",  "x_aq_vidu_vid_ctrl_fp"); @39
aq_vidu_vid_ctrl_fp  x_aq_vidu_vid_ctrl_fp (
  .ctrl_dis_fp_dep_stall_dp         (ctrl_dis_fp_dep_stall_dp        ),
  .ctrl_fgpr_reuse_inst_gateclk_vld (ctrl_fgpr_reuse_inst_gateclk_vld),
  .ctrl_fgpr_reuse_inst_vld         (ctrl_fgpr_reuse_inst_vld        ),
  .ctrl_split_fp_dis_stall          (ctrl_split_fp_dis_stall         ),
  .ctrl_wbt_fp_dis_inst_gateclk_vld (ctrl_wbt_fp_dis_inst_gateclk_vld),
  .ctrl_wbt_fp_dis_inst_vld         (ctrl_wbt_fp_dis_inst_vld        ),
  .dp_ctrl_dis_fp_inst_dstf_vld     (dp_ctrl_dis_fp_inst_dstf_vld    ),
  .dp_ctrl_dis_fp_inst_srcf0_reg    (dp_ctrl_dis_fp_inst_srcf0_reg   ),
  .dp_ctrl_dis_fp_inst_srcf0_vld    (dp_ctrl_dis_fp_inst_srcf0_vld   ),
  .dp_ctrl_dis_fp_inst_srcf1_reg    (dp_ctrl_dis_fp_inst_srcf1_reg   ),
  .dp_ctrl_dis_fp_inst_srcf1_vld    (dp_ctrl_dis_fp_inst_srcf1_vld   ),
  .dp_ctrl_dis_fp_inst_srcf2_reg    (dp_ctrl_dis_fp_inst_srcf2_reg   ),
  .dp_ctrl_dis_fp_inst_srcf2_vld    (dp_ctrl_dis_fp_inst_srcf2_vld   ),
  .dp_ctrl_dis_fp_inst_store        (dp_ctrl_dis_fp_inst_store       ),
  .dp_ctrl_dis_fp_inst_wb_type      (dp_ctrl_dis_fp_inst_wb_type     ),
  .idu_vidu_ex1_fp_dp_sel           (idu_vidu_ex1_fp_dp_sel          ),
  .idu_vidu_ex1_fp_sel              (idu_vidu_ex1_fp_sel             ),
  .idu_vidu_ex1_inst_data           (idu_vidu_ex1_inst_data          ),
  .idu_vidu_ex1_vec_dp_sel          (idu_vidu_ex1_vec_dp_sel         ),
  .idu_vidu_ex1_vec_sel             (idu_vidu_ex1_vec_sel            ),
  .split_fp_ctrl_entry_vld          (split_fp_ctrl_entry_vld         ),
  .split_fp_ctrl_inst_dp_vld        (split_fp_ctrl_inst_dp_vld       ),
  .split_fp_ctrl_inst_gateclk_vld   (split_fp_ctrl_inst_gateclk_vld  ),
  .split_fp_ctrl_inst_vld           (split_fp_ctrl_inst_vld          ),
  .split_vec0_ctrl_entry_vld        (split_vec0_ctrl_entry_vld       ),
  .split_vec1_ctrl_entry_vld        (split_vec1_ctrl_entry_vld       ),
  .vidu_idu_fp_full                 (vidu_idu_fp_full                ),
  .vidu_rtu_no_op                   (vidu_rtu_no_op                  ),
  .vidu_vpu_vid_fp_inst_dp_vld      (vidu_vpu_vid_fp_inst_dp_vld     ),
  .vidu_vpu_vid_fp_inst_gateclk_vld (vidu_vpu_vid_fp_inst_gateclk_vld),
  .vidu_vpu_vid_fp_inst_vld         (vidu_vpu_vid_fp_inst_vld        ),
  .vpu_rtu_ex1_cmplt                (vpu_rtu_ex1_cmplt               ),
  .vpu_rtu_ex1_cmplt_dp             (vpu_rtu_ex1_cmplt_dp            ),
  .vpu_vidu_fp_fwd_reg              (vpu_vidu_fp_fwd_reg             ),
  .vpu_vidu_fp_fwd_vld              (vpu_vidu_fp_fwd_vld             ),
  .vpu_vidu_vex1_fp_stall           (vpu_vidu_vex1_fp_stall          ),
  .wbt_ctrl_fp_dstv_info            (wbt_ctrl_fp_dstv_info           ),
  .wbt_ctrl_fp_srcv0_info           (wbt_ctrl_fp_srcv0_info          ),
  .wbt_ctrl_fp_srcv1_info           (wbt_ctrl_fp_srcv1_info          ),
  .wbt_ctrl_fp_srcv2_info           (wbt_ctrl_fp_srcv2_info          ),
  .wbt_ctrl_fp_srcvm_info           (wbt_ctrl_fp_srcvm_info          )
);


// &Instance("aq_vidu_vid_dp_fp",    "x_aq_vidu_vid_dp_fp"); @41
aq_vidu_vid_dp_fp  x_aq_vidu_vid_dp_fp (
  .ctrl_dp_fgpr_reuse_inst_dp_vld  (ctrl_dp_fgpr_reuse_inst_dp_vld ),
  .dp_ctrl_dis_fp_inst_dstf_vld    (dp_ctrl_dis_fp_inst_dstf_vld   ),
  .dp_ctrl_dis_fp_inst_srcf0_reg   (dp_ctrl_dis_fp_inst_srcf0_reg  ),
  .dp_ctrl_dis_fp_inst_srcf0_vld   (dp_ctrl_dis_fp_inst_srcf0_vld  ),
  .dp_ctrl_dis_fp_inst_srcf1_reg   (dp_ctrl_dis_fp_inst_srcf1_reg  ),
  .dp_ctrl_dis_fp_inst_srcf1_vld   (dp_ctrl_dis_fp_inst_srcf1_vld  ),
  .dp_ctrl_dis_fp_inst_srcf2_reg   (dp_ctrl_dis_fp_inst_srcf2_reg  ),
  .dp_ctrl_dis_fp_inst_srcf2_vld   (dp_ctrl_dis_fp_inst_srcf2_vld  ),
  .dp_ctrl_dis_fp_inst_store       (dp_ctrl_dis_fp_inst_store      ),
  .dp_ctrl_dis_fp_inst_wb_type     (dp_ctrl_dis_fp_inst_wb_type    ),
  .dp_gpr_fp_src0_reg              (dp_gpr_fp_src0_reg             ),
  .dp_gpr_fp_src1_reg              (dp_gpr_fp_src1_reg             ),
  .dp_gpr_fp_src2_reg              (dp_gpr_fp_src2_reg             ),
  .dp_vec_fgpr_reuse_dstf_reg      (dp_vec_fgpr_reuse_dstf_reg     ),
  .dp_vec_fgpr_reuse_dstf_vld      (dp_vec_fgpr_reuse_dstf_vld     ),
  .dp_vec_fgpr_reuse_srcf0_reg     (dp_vec_fgpr_reuse_srcf0_reg    ),
  .dp_vec_fgpr_reuse_srcf0_vld     (dp_vec_fgpr_reuse_srcf0_vld    ),
  .dp_vec_fgpr_reuse_srcf1_reg     (dp_vec_fgpr_reuse_srcf1_reg    ),
  .dp_vec_fgpr_reuse_srcf1_vld     (dp_vec_fgpr_reuse_srcf1_vld    ),
  .dp_vec_fgpr_reuse_srcf2_reg     (dp_vec_fgpr_reuse_srcf2_reg    ),
  .dp_vec_fgpr_reuse_srcf2_vld     (dp_vec_fgpr_reuse_srcf2_vld    ),
  .dp_wbt_fp_dstv_reg              (dp_wbt_fp_dstv_reg             ),
  .dp_wbt_fp_dstv_type             (dp_wbt_fp_dstv_type            ),
  .dp_wbt_fp_dstv_vld              (dp_wbt_fp_dstv_vld             ),
  .dp_wbt_fp_srcv0_reg             (dp_wbt_fp_srcv0_reg            ),
  .dp_wbt_fp_srcv1_reg             (dp_wbt_fp_srcv1_reg            ),
  .dp_wbt_fp_srcv2_reg             (dp_wbt_fp_srcv2_reg            ),
  .gpr_fp_dp_src0_data             (gpr_fp_dp_src0_data            ),
  .gpr_fp_dp_src1_data             (gpr_fp_dp_src1_data            ),
  .gpr_fp_dp_src2_data             (gpr_fp_dp_src2_data            ),
  .idu_vidu_ex1_inst_data          (idu_vidu_ex1_inst_data         ),
  .split_fp_dp_inst_data           (split_fp_dp_inst_data          ),
  .vidu_vpu_vid_fp_inst_dst_reg    (vidu_vpu_vid_fp_inst_dst_reg   ),
  .vidu_vpu_vid_fp_inst_dst_vld    (vidu_vpu_vid_fp_inst_dst_vld   ),
  .vidu_vpu_vid_fp_inst_dste_vld   (vidu_vpu_vid_fp_inst_dste_vld  ),
  .vidu_vpu_vid_fp_inst_dstf_reg   (vidu_vpu_vid_fp_inst_dstf_reg  ),
  .vidu_vpu_vid_fp_inst_dstf_vld   (vidu_vpu_vid_fp_inst_dstf_vld  ),
  .vidu_vpu_vid_fp_inst_eu         (vidu_vpu_vid_fp_inst_eu        ),
  .vidu_vpu_vid_fp_inst_func       (vidu_vpu_vid_fp_inst_func      ),
  .vidu_vpu_vid_fp_inst_src1_data  (vidu_vpu_vid_fp_inst_src1_data ),
  .vidu_vpu_vid_fp_inst_srcf0_data (vidu_vpu_vid_fp_inst_srcf0_data),
  .vidu_vpu_vid_fp_inst_srcf1_data (vidu_vpu_vid_fp_inst_srcf1_data),
  .vidu_vpu_vid_fp_inst_srcf2_data (vidu_vpu_vid_fp_inst_srcf2_data),
  .vidu_vpu_vid_fp_inst_srcf2_rdy  (vidu_vpu_vid_fp_inst_srcf2_rdy ),
  .vidu_vpu_vid_fp_inst_srcf2_vld  (vidu_vpu_vid_fp_inst_srcf2_vld ),
  .vpu_rtu_ex1_fp_dirty            (vpu_rtu_ex1_fp_dirty           ),
  .vpu_rtu_ex1_vec_dirty           (vpu_rtu_ex1_vec_dirty          ),
  .vpu_vidu_fp_fwd_data            (vpu_vidu_fp_fwd_data           ),
  .vpu_vidu_fp_fwd_reg             (vpu_vidu_fp_fwd_reg            ),
  .vpu_vidu_fp_fwd_vld             (vpu_vidu_fp_fwd_vld            ),
  .wbt_ctrl_fp_srcv2_info          (wbt_ctrl_fp_srcv2_info         )
);


// &Instance("aq_vidu_vid_gpr_fp",   "x_aq_vidu_vid_gpr_fp"); @43
aq_vidu_vid_gpr_fp  x_aq_vidu_vid_gpr_fp (
  .cp0_idu_icg_en      (cp0_idu_icg_en     ),
  .cp0_yy_clk_en       (cp0_yy_clk_en      ),
  .dp_gpr_fp_src0_reg  (dp_gpr_fp_src0_reg ),
  .dp_gpr_fp_src1_reg  (dp_gpr_fp_src1_reg ),
  .dp_gpr_fp_src2_reg  (dp_gpr_fp_src2_reg ),
  .forever_cpuclk      (forever_cpuclk     ),
  .gpr_fp_dp_src0_data (gpr_fp_dp_src0_data),
  .gpr_fp_dp_src1_data (gpr_fp_dp_src1_data),
  .gpr_fp_dp_src2_data (gpr_fp_dp_src2_data),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .vpu_vidu_fp_wb_data (vpu_vidu_fp_wb_data),
  .vpu_vidu_fp_wb_reg  (vpu_vidu_fp_wb_reg ),
  .vpu_vidu_fp_wb_vld  (vpu_vidu_fp_wb_vld )
);


// &ConnRule(s/bankx/fp/); @45
// &Instance("aq_vidu_vid_wbt",      "x_aq_vidu_vid_wbt_fp"); @46
aq_vidu_vid_wbt  x_aq_vidu_vid_wbt_fp (
  .cp0_idu_icg_en                      (cp0_idu_icg_en                     ),
  .cp0_yy_clk_en                       (cp0_yy_clk_en                      ),
  .cpurst_b                            (cpurst_b                           ),
  .ctrl_wbt_bankx_dis_inst_gateclk_vld (ctrl_wbt_fp_dis_inst_gateclk_vld   ),
  .ctrl_wbt_bankx_dis_inst_vld         (ctrl_wbt_fp_dis_inst_vld           ),
  .dp_wbt_bankx_dstv_reg               (dp_wbt_fp_dstv_reg                 ),
  .dp_wbt_bankx_dstv_type              (dp_wbt_fp_dstv_type                ),
  .dp_wbt_bankx_dstv_vld               (dp_wbt_fp_dstv_vld                 ),
  .dp_wbt_bankx_srcv0_reg              (dp_wbt_fp_srcv0_reg                ),
  .dp_wbt_bankx_srcv1_reg              (dp_wbt_fp_srcv1_reg                ),
  .dp_wbt_bankx_srcv2_reg              (dp_wbt_fp_srcv2_reg                ),
  .forever_cpuclk                      (forever_cpuclk                     ),
  .pad_yy_icg_scan_en                  (pad_yy_icg_scan_en                 ),
  .rtu_vidu_flush_wbt                  (rtu_vidu_flush_wbt                 ),
  .rtu_yy_xx_async_flush               (rtu_yy_xx_async_flush              ),
  .vpu_vidu_wbt_bankx_wb0_reg          (vpu_vidu_wbt_fp_wb0_reg            ),
  .vpu_vidu_wbt_bankx_wb0_vld          (vpu_vidu_wbt_fp_wb0_vld            ),
  .vpu_vidu_wbt_bankx_wb1_reg          (vpu_vidu_wbt_fp_wb1_reg            ),
  .vpu_vidu_wbt_bankx_wb1_vld          (vpu_vidu_wbt_fp_wb1_vld            ),
  .wbt_ctrl_bankx_dstv_info            (wbt_ctrl_fp_dstv_info              ),
  .wbt_ctrl_bankx_srcv0_info           (wbt_ctrl_fp_srcv0_info             ),
  .wbt_ctrl_bankx_srcv1_info           (wbt_ctrl_fp_srcv1_info             ),
  .wbt_ctrl_bankx_srcv2_info           (wbt_ctrl_fp_srcv2_info             ),
  .wbt_ctrl_bankx_srcvm_info           (wbt_ctrl_fp_srcvm_info             ),
  .wbt_top_bankx_gpr_no_wb             (wbt_top_fp_gpr_no_wb               )
);


//----------------------------------------------------------
//                     Debug Info
//----------------------------------------------------------
assign vidu_dtu_debug_info[0] = split_fp_ctrl_entry_vld;
assign vidu_dtu_debug_info[1] = wbt_top_fp_gpr_no_wb;

// &ConnRule(s/vecx/vec0/); @61
// &Instance("aq_vidu_vid_split_vec", "x_aq_vidu_vid_split_vec0"); @62
// &ConnRule(s/vecx/vec1/); @64
// &Instance("aq_vidu_vid_split_vec_dummy", "x_aq_vidu_vid_split_vec1_dummy"); @65
// &ConnRule(s/vecx/vec1/); @67
// &Instance("aq_vidu_vid_split_vec", "x_aq_vidu_vid_split_vec1"); @68
// &Instance("aq_vidu_vid_ctrl_vec",  "x_aq_vidu_vid_ctrl_vec"); @71
// &Instance("aq_vidu_vid_dp_vec",    "x_aq_vidu_vid_dp_vec"); @73
// &ConnRule(s/bankx/bank0/); @76
// &Instance("aq_vidu_vid_gpr_vec",   "x_aq_vidu_vid_gpr_bank0"); @77
// &ConnRule(s/bankx/bank0/); @78
// &Instance("aq_vidu_vid_wbt",       "x_aq_vidu_vid_wbt_bank0"); @79
// &ConnRule(s/bankx/bank1/); @82
// &Instance("aq_vidu_vid_gpr_vec",   "x_aq_vidu_vid_gpr_bank1"); @83
// &ConnRule(s/bankx/bank1/); @84
// &Instance("aq_vidu_vid_wbt",       "x_aq_vidu_vid_wbt_bank1"); @85
// &ConnRule(s/bankx/bank2/); @88
// &Instance("aq_vidu_vid_gpr_vec",   "x_aq_vidu_vid_gpr_bank2"); @89
// &ConnRule(s/bankx/bank2/); @90
// &Instance("aq_vidu_vid_wbt",       "x_aq_vidu_vid_wbt_bank2"); @91
// &ConnRule(s/bankx/bank3/); @94
// &Instance("aq_vidu_vid_gpr_vec",   "x_aq_vidu_vid_gpr_bank3"); @95
// &ConnRule(s/bankx/bank3/); @96
// &Instance("aq_vidu_vid_wbt",       "x_aq_vidu_vid_wbt_bank3"); @97
// &ConnRule(s/bankx/bank4/); @100
// &Instance("aq_vidu_vid_gpr_vec",   "x_aq_vidu_vid_gpr_bank4"); @101
// &ConnRule(s/bankx/bank4/); @102
// &Instance("aq_vidu_vid_wbt",       "x_aq_vidu_vid_wbt_bank4"); @103
// &ConnRule(s/bankx/bank5/); @106
// &Instance("aq_vidu_vid_gpr_vec",   "x_aq_vidu_vid_gpr_bank5"); @107
// &ConnRule(s/bankx/bank5/); @108
// &Instance("aq_vidu_vid_wbt",       "x_aq_vidu_vid_wbt_bank5"); @109
// &ConnRule(s/bankx/bank6/); @112
// &Instance("aq_vidu_vid_gpr_vec",   "x_aq_vidu_vid_gpr_bank6"); @113
// &ConnRule(s/bankx/bank6/); @114
// &Instance("aq_vidu_vid_wbt",       "x_aq_vidu_vid_wbt_bank6"); @115
// &ConnRule(s/bankx/bank7/); @118
// &Instance("aq_vidu_vid_gpr_vec",   "x_aq_vidu_vid_gpr_bank7"); @119
// &ConnRule(s/bankx/bank7/); @120
// &Instance("aq_vidu_vid_wbt",       "x_aq_vidu_vid_wbt_bank7"); @121
//==========================================================
//                     Vector Dummy
//==========================================================
assign vidu_idu_vec_full                = 1'b0;
assign vidu_cp0_vid_fof_vld             = 1'b0;
assign ctrl_fgpr_reuse_inst_vld         = 1'b0;
assign ctrl_dp_fgpr_reuse_inst_dp_vld   = 1'b0;
assign ctrl_fgpr_reuse_inst_gateclk_vld = 1'b0;
assign dp_vec_fgpr_reuse_dstf_reg[4:0]  = 5'b0;
assign dp_vec_fgpr_reuse_dstf_vld       = 1'b0;
assign dp_vec_fgpr_reuse_srcf0_reg[4:0] = 5'b0;
assign dp_vec_fgpr_reuse_srcf0_vld      = 1'b0;
assign dp_vec_fgpr_reuse_srcf1_reg[4:0] = 5'b0;
assign dp_vec_fgpr_reuse_srcf1_vld      = 1'b0;
assign dp_vec_fgpr_reuse_srcf2_reg[4:0] = 5'b0;
assign dp_vec_fgpr_reuse_srcf2_vld      = 1'b0;
assign split_vec0_ctrl_entry_vld        = 1'b0;
assign split_vec1_ctrl_entry_vld        = 1'b0;

assign vidu_dtu_debug_info[7:2]         = 6'b0;

// &Force("nonport","ctrl_dis_fp_dep_stall_dp"); @164

// &Force("input","idu_vidu_ex1_vec_sel"); @166
// &Force("input","idu_vidu_ex1_vec_dp_sel"); @167
// &Force("input","idu_vidu_ex1_vec_gateclk_sel"); @168

// &Force("input","idu_vidu_ex1_fp_sel"); @186
// &Force("input","idu_vidu_ex1_fp_dp_sel"); @187
// &Force("input","idu_vidu_ex1_fp_gateclk_sel"); @188
// &Force("input","idu_vidu_ex1_vec_sel"); @189
// &Force("input","idu_vidu_ex1_vec_dp_sel"); @190
// &Force("input","idu_vidu_ex1_vec_gateclk_sel"); @191
// &Force("input","rtu_vidu_flush_wbt"); @192
// &Force("input","ifu_vidu_warm_up"); @193
// &Force("input","idu_vidu_ex1_inst_data"); @195
// &Force("bus","idu_vidu_ex1_inst_data",`DIS_VEC_WIDTH-1,0); @196


//==========================================================
//                      ASSERTION
//==========================================================
// &Force("nonport","flag"); @213
// &Force("nonport","clk"); @214
// &Force("nonport","rst"); @215
//================================================
//        assertion
//================================================
// &Force("input","forever_cpuclk"); @231
// &Force("nonport","split_vec0_younger"); @235
// &Force("nonport","split_vec1_younger"); @236
// &Force("nonport","split_vec0_dp_vint"); @240
// &Force("nonport","split_vec1_dp_vint"); @241
// &ModuleEnd; @265
endmodule



