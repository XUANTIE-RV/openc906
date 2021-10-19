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

// &Depend("cpu_cfig.h"); @18
// &Depend("aq_lsu_cfig.h"); @19

// &ModuleBeg; @21
module aq_vlsu_top(
  cp0_vpu_icg_en,
  cpurst_b,
  forever_cpuclk,
  ifu_vpu_warm_up,
  lsu_vlsu_bytes_vld,
  lsu_vlsu_data,
  lsu_vlsu_data_grant,
  lsu_vlsu_data_vld,
  lsu_vlsu_dc_create_vld,
  lsu_vlsu_dc_fld_req,
  lsu_vlsu_dc_fof,
  lsu_vlsu_dc_nf,
  lsu_vlsu_dc_sew,
  lsu_vlsu_dc_split_cnt,
  lsu_vlsu_dc_sseg_first,
  lsu_vlsu_dc_stall,
  lsu_vlsu_dest_reg,
  lsu_vlsu_expt_vld,
  lsu_vlsu_func,
  lsu_vlsu_sew,
  lsu_vlsu_split_last,
  lsu_vlsu_st_expt,
  lsu_vlsu_st_offset,
  lsu_vlsu_st_sew,
  lsu_vlsu_st_size,
  lsu_vlsu_vl_update,
  lsu_vlsu_vl_upval,
  pad_yy_icg_scan_en,
  rtu_yy_xx_async_flush,
  rtu_yy_xx_flush,
  vlsu_buf_stall,
  vlsu_dtu_data,
  vlsu_dtu_data_vld,
  vlsu_dtu_data_vld_gate,
  vlsu_lsu_data_shift,
  vlsu_lsu_data_vld,
  vlsu_lsu_fwd_data,
  vlsu_lsu_fwd_dest_reg,
  vlsu_lsu_fwd_vld,
  vlsu_lsu_src2_depd,
  vlsu_lsu_src2_reg,
  vlsu_lsu_wdata,
  vlsu_rbus_fpr_wb_data,
  vlsu_rbus_fpr_wb_index,
  vlsu_rbus_fpr_wb_req,
  vlsu_rtu_vl_updt_data,
  vlsu_rtu_vl_updt_vld,
  vlsu_vex1_split_stall,
  vlsu_xx_ex1_fp_stall,
  vlsu_xx_no_op,
  vpu_group_3_xx_ex1_func,
  vpu_group_3_xx_ex1_sel,
  vpu_group_3_xx_ex1_srcv1,
  vpu_group_3_xx_ex1_srcv2,
  vpu_group_3_xx_ex1_srcv2_ready,
  vpu_group_3_xx_ex1_vreg,
  vpu_vlsu_ex1_lsu_inst_vld,
  vpu_vlsu_fp_wb_data,
  vpu_vlsu_fp_wb_reg,
  vpu_vlsu_fp_wb_vld
);

// &Ports; @22
input           cp0_vpu_icg_en;                 
input           cpurst_b;                       
input           forever_cpuclk;                 
input           ifu_vpu_warm_up;                
input   [7 :0]  lsu_vlsu_bytes_vld;             
input   [63:0]  lsu_vlsu_data;                  
input           lsu_vlsu_data_grant;            
input           lsu_vlsu_data_vld;              
input           lsu_vlsu_dc_create_vld;         
input           lsu_vlsu_dc_fld_req;            
input           lsu_vlsu_dc_fof;                
input   [2 :0]  lsu_vlsu_dc_nf;                 
input   [1 :0]  lsu_vlsu_dc_sew;                
input   [9 :0]  lsu_vlsu_dc_split_cnt;          
input           lsu_vlsu_dc_sseg_first;         
input           lsu_vlsu_dc_stall;              
input   [4 :0]  lsu_vlsu_dest_reg;              
input           lsu_vlsu_expt_vld;              
input   [19:0]  lsu_vlsu_func;                  
input   [1 :0]  lsu_vlsu_sew;                   
input           lsu_vlsu_split_last;            
input           lsu_vlsu_st_expt;               
input   [3 :0]  lsu_vlsu_st_offset;             
input   [1 :0]  lsu_vlsu_st_sew;                
input   [1 :0]  lsu_vlsu_st_size;               
input           lsu_vlsu_vl_update;             
input   [6 :0]  lsu_vlsu_vl_upval;              
input           pad_yy_icg_scan_en;             
input           rtu_yy_xx_async_flush;          
input           rtu_yy_xx_flush;                
input   [19:0]  vpu_group_3_xx_ex1_func;        
input           vpu_group_3_xx_ex1_sel;         
input   [63:0]  vpu_group_3_xx_ex1_srcv1;       
input   [63:0]  vpu_group_3_xx_ex1_srcv2;       
input           vpu_group_3_xx_ex1_srcv2_ready; 
input   [6 :0]  vpu_group_3_xx_ex1_vreg;        
input           vpu_vlsu_ex1_lsu_inst_vld;      
input   [63:0]  vpu_vlsu_fp_wb_data;            
input   [4 :0]  vpu_vlsu_fp_wb_reg;             
input           vpu_vlsu_fp_wb_vld;             
output          vlsu_buf_stall;                 
output  [63:0]  vlsu_dtu_data;                  
output          vlsu_dtu_data_vld;              
output          vlsu_dtu_data_vld_gate;         
output  [3 :0]  vlsu_lsu_data_shift;            
output          vlsu_lsu_data_vld;              
output  [63:0]  vlsu_lsu_fwd_data;              
output  [4 :0]  vlsu_lsu_fwd_dest_reg;          
output          vlsu_lsu_fwd_vld;               
output          vlsu_lsu_src2_depd;             
output  [4 :0]  vlsu_lsu_src2_reg;              
output  [63:0]  vlsu_lsu_wdata;                 
output  [63:0]  vlsu_rbus_fpr_wb_data;          
output  [4 :0]  vlsu_rbus_fpr_wb_index;         
output          vlsu_rbus_fpr_wb_req;           
output  [7 :0]  vlsu_rtu_vl_updt_data;          
output          vlsu_rtu_vl_updt_vld;           
output          vlsu_vex1_split_stall;          
output          vlsu_xx_ex1_fp_stall;           
output          vlsu_xx_no_op;                  

// &Regs; @23

// &Wires; @24
wire            cp0_vpu_icg_en;                 
wire            cpurst_b;                       
wire            forever_cpuclk;                 
wire    [63:0]  if_vlsu_fls_data;               
wire    [4 :0]  if_vlsu_fls_reg;                
wire            if_vlsu_fls_wb_vld;             
wire            if_vlsu_fwd_done;               
wire    [63:0]  if_vlsu_merge_data;             
wire            if_vlsu_merge_vld;              
wire    [3 :0]  if_vlsu_sel0;                   
wire    [3 :0]  if_vlsu_sel1;                   
wire    [3 :0]  if_vlsu_sel2;                   
wire    [3 :0]  if_vlsu_sel3;                   
wire            if_vlsu_vl_update;              
wire    [6 :0]  if_vlsu_vl_upval;               
wire            if_vlsu_vls_wb_abnormal;        
wire    [7 :0]  if_vlsu_vls_wb_bytes_vld;       
wire    [63:0]  if_vlsu_vls_wb_data;            
wire            if_vlsu_vls_wb_vld;             
wire            ifu_vpu_warm_up;                
wire            index_stall;                    
wire    [7 :0]  lsu_vlsu_bytes_vld;             
wire    [63:0]  lsu_vlsu_data;                  
wire            lsu_vlsu_data_grant;            
wire            lsu_vlsu_data_vld;              
wire            lsu_vlsu_dc_create_vld;         
wire            lsu_vlsu_dc_fld_req;            
wire            lsu_vlsu_dc_fof;                
wire    [2 :0]  lsu_vlsu_dc_nf;                 
wire    [1 :0]  lsu_vlsu_dc_sew;                
wire    [9 :0]  lsu_vlsu_dc_split_cnt;          
wire            lsu_vlsu_dc_sseg_first;         
wire            lsu_vlsu_dc_stall;              
wire    [4 :0]  lsu_vlsu_dest_reg;              
wire            lsu_vlsu_expt_vld;              
wire    [19:0]  lsu_vlsu_func;                  
wire    [1 :0]  lsu_vlsu_sew;                   
wire            lsu_vlsu_split_last;            
wire            lsu_vlsu_st_expt;               
wire    [3 :0]  lsu_vlsu_st_offset;             
wire    [1 :0]  lsu_vlsu_st_sew;                
wire    [1 :0]  lsu_vlsu_st_size;               
wire            lsu_vlsu_vl_update;             
wire    [6 :0]  lsu_vlsu_vl_upval;              
wire            pad_yy_icg_scan_en;             
wire            rtu_yy_xx_async_flush;          
wire            rtu_yy_xx_flush;                
wire            sseg_abnormal_vld;              
wire            sseg_fwd_last;                  
wire            sseg_fwd_vld;                   
wire    [2 :0]  sseg_nf;                        
wire            sseg_split_pause;               
wire            sseg_vld;                       
wire            sseg_vtb_all_vld;               
wire            sseg_vtb_all_wb;                
wire            sseg_vtb_fwd_pre;               
wire            sseg_vtb_fwd_start;             
wire            sseg_vtb_next_ready;            
wire            sseg_wb_vld;                    
wire            vlsu_buf_stall;                 
wire    [63:0]  vlsu_dtu_data;                  
wire            vlsu_dtu_data_vld;              
wire            vlsu_dtu_data_vld_gate;         
wire            vlsu_fld_stall;                 
wire            vlsu_if_fof_vld;                
wire            vlsu_if_fwd_vld;                
wire    [2 :0]  vlsu_if_nf;                     
wire    [63:0]  vlsu_if_reg_data;               
wire            vlsu_if_reg_fls;                
wire            vlsu_if_reg_seq_last;           
wire    [4 :0]  vlsu_if_reg_src2_reg;           
wire            vlsu_if_reg_wdata_ready;        
wire    [1 :0]  vlsu_if_sew;                    
wire    [9 :0]  vlsu_if_split_cnt0;             
wire            vlsu_if_split_cnt0_vld;         
wire    [9 :0]  vlsu_if_split_cnt1;             
wire            vlsu_if_split_cnt1_vld;         
wire    [63:0]  vlsu_if_sseg_reg_data;          
wire    [1 :0]  vlsu_if_vtb_round_bit;          
wire            vlsu_index_stall;               
wire            vlsu_index_up_mask;             
wire    [3 :0]  vlsu_lsu_data_shift;            
wire            vlsu_lsu_data_vld;              
wire    [63:0]  vlsu_lsu_fwd_data;              
wire    [4 :0]  vlsu_lsu_fwd_dest_reg;          
wire            vlsu_lsu_fwd_vld;               
wire            vlsu_lsu_src2_depd;             
wire    [4 :0]  vlsu_lsu_src2_reg;              
wire    [63:0]  vlsu_lsu_wdata;                 
wire    [63:0]  vlsu_rbus_fpr_wb_data;          
wire    [4 :0]  vlsu_rbus_fpr_wb_index;         
wire            vlsu_rbus_fpr_wb_req;           
wire    [63:0]  vlsu_rbus_vpr_wb_data;          
wire    [6 :0]  vlsu_rbus_vpr_wb_index;         
wire            vlsu_rbus_vpr_wb_req;           
wire    [7 :0]  vlsu_rtu_vl_updt_data;          
wire            vlsu_rtu_vl_updt_vld;           
wire            vlsu_vex1_split_stall;          
wire            vlsu_vidu_split_cancel;         
wire            vlsu_vidu_split_pause;          
wire            vlsu_warm_up;                   
wire            vlsu_xx_ex1_fp_stall;           
wire            vlsu_xx_no_op;                  
wire    [19:0]  vpu_group_3_xx_ex1_func;        
wire    [4 :0]  vpu_group_3_xx_ex1_imm;         
wire    [1 :0]  vpu_group_3_xx_ex1_lmul;        
wire            vpu_group_3_xx_ex1_sel;         
wire    [1 :0]  vpu_group_3_xx_ex1_sew;         
wire    [7 :0]  vpu_group_3_xx_ex1_split_count; 
wire    [63:0]  vpu_group_3_xx_ex1_srcv1;       
wire    [63:0]  vpu_group_3_xx_ex1_srcv2;       
wire            vpu_group_3_xx_ex1_srcv2_ready; 
wire    [7 :0]  vpu_group_3_xx_ex1_vl;          
wire    [7 :0]  vpu_group_3_xx_ex1_vl_byte_mask; 
wire    [7 :0]  vpu_group_3_xx_ex1_vm_byte_mask; 
wire            vpu_group_3_xx_ex1_vm_high;     
wire    [6 :0]  vpu_group_3_xx_ex1_vreg;        
wire    [6 :0]  vpu_group_3_xx_ex1_vstart;      
wire            vpu_vlsu_ex1_lsu_inst_vld;      
wire    [63:0]  vpu_vlsu_fp_wb_data;            
wire    [4 :0]  vpu_vlsu_fp_wb_reg;             
wire            vpu_vlsu_fp_wb_vld;             


parameter BYTE = 2'b00;
parameter HALF = 2'b01;
parameter WORD = 2'b10;

//================================================
//        instance
//================================================
// &Instance("aq_vlsu_lsu_if", "x_aq_vlsu_lsu_if"); @33
aq_vlsu_lsu_if  x_aq_vlsu_lsu_if (
  .cp0_vpu_icg_en           (cp0_vpu_icg_en          ),
  .cpurst_b                 (cpurst_b                ),
  .forever_cpuclk           (forever_cpuclk          ),
  .if_vlsu_fls_data         (if_vlsu_fls_data        ),
  .if_vlsu_fls_reg          (if_vlsu_fls_reg         ),
  .if_vlsu_fls_wb_vld       (if_vlsu_fls_wb_vld      ),
  .if_vlsu_fwd_done         (if_vlsu_fwd_done        ),
  .if_vlsu_merge_data       (if_vlsu_merge_data      ),
  .if_vlsu_merge_vld        (if_vlsu_merge_vld       ),
  .if_vlsu_sel0             (if_vlsu_sel0            ),
  .if_vlsu_sel1             (if_vlsu_sel1            ),
  .if_vlsu_sel2             (if_vlsu_sel2            ),
  .if_vlsu_sel3             (if_vlsu_sel3            ),
  .if_vlsu_vl_update        (if_vlsu_vl_update       ),
  .if_vlsu_vl_upval         (if_vlsu_vl_upval        ),
  .if_vlsu_vls_wb_abnormal  (if_vlsu_vls_wb_abnormal ),
  .if_vlsu_vls_wb_bytes_vld (if_vlsu_vls_wb_bytes_vld),
  .if_vlsu_vls_wb_data      (if_vlsu_vls_wb_data     ),
  .if_vlsu_vls_wb_vld       (if_vlsu_vls_wb_vld      ),
  .lsu_vlsu_bytes_vld       (lsu_vlsu_bytes_vld      ),
  .lsu_vlsu_data            (lsu_vlsu_data           ),
  .lsu_vlsu_data_grant      (lsu_vlsu_data_grant     ),
  .lsu_vlsu_data_vld        (lsu_vlsu_data_vld       ),
  .lsu_vlsu_dc_create_vld   (lsu_vlsu_dc_create_vld  ),
  .lsu_vlsu_dc_fof          (lsu_vlsu_dc_fof         ),
  .lsu_vlsu_dc_nf           (lsu_vlsu_dc_nf          ),
  .lsu_vlsu_dc_sew          (lsu_vlsu_dc_sew         ),
  .lsu_vlsu_dc_split_cnt    (lsu_vlsu_dc_split_cnt   ),
  .lsu_vlsu_dc_sseg_first   (lsu_vlsu_dc_sseg_first  ),
  .lsu_vlsu_dc_stall        (lsu_vlsu_dc_stall       ),
  .lsu_vlsu_dest_reg        (lsu_vlsu_dest_reg       ),
  .lsu_vlsu_expt_vld        (lsu_vlsu_expt_vld       ),
  .lsu_vlsu_func            (lsu_vlsu_func           ),
  .lsu_vlsu_sew             (lsu_vlsu_sew            ),
  .lsu_vlsu_split_last      (lsu_vlsu_split_last     ),
  .lsu_vlsu_st_expt         (lsu_vlsu_st_expt        ),
  .lsu_vlsu_st_offset       (lsu_vlsu_st_offset      ),
  .lsu_vlsu_st_sew          (lsu_vlsu_st_sew         ),
  .lsu_vlsu_st_size         (lsu_vlsu_st_size        ),
  .lsu_vlsu_vl_update       (lsu_vlsu_vl_update      ),
  .lsu_vlsu_vl_upval        (lsu_vlsu_vl_upval       ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .rtu_yy_xx_flush          (rtu_yy_xx_flush         ),
  .sseg_abnormal_vld        (sseg_abnormal_vld       ),
  .sseg_fwd_last            (sseg_fwd_last           ),
  .sseg_fwd_vld             (sseg_fwd_vld            ),
  .sseg_nf                  (sseg_nf                 ),
  .sseg_split_pause         (sseg_split_pause        ),
  .sseg_vld                 (sseg_vld                ),
  .sseg_vtb_all_vld         (sseg_vtb_all_vld        ),
  .sseg_vtb_all_wb          (sseg_vtb_all_wb         ),
  .sseg_vtb_fwd_pre         (sseg_vtb_fwd_pre        ),
  .sseg_vtb_fwd_start       (sseg_vtb_fwd_start      ),
  .sseg_vtb_next_ready      (sseg_vtb_next_ready     ),
  .sseg_wb_vld              (sseg_wb_vld             ),
  .vlsu_buf_stall           (vlsu_buf_stall          ),
  .vlsu_dtu_data            (vlsu_dtu_data           ),
  .vlsu_dtu_data_vld        (vlsu_dtu_data_vld       ),
  .vlsu_dtu_data_vld_gate   (vlsu_dtu_data_vld_gate  ),
  .vlsu_fld_stall           (vlsu_fld_stall          ),
  .vlsu_if_fof_vld          (vlsu_if_fof_vld         ),
  .vlsu_if_fwd_vld          (vlsu_if_fwd_vld         ),
  .vlsu_if_nf               (vlsu_if_nf              ),
  .vlsu_if_reg_data         (vlsu_if_reg_data        ),
  .vlsu_if_reg_fls          (vlsu_if_reg_fls         ),
  .vlsu_if_reg_seq_last     (vlsu_if_reg_seq_last    ),
  .vlsu_if_reg_src2_reg     (vlsu_if_reg_src2_reg    ),
  .vlsu_if_reg_wdata_ready  (vlsu_if_reg_wdata_ready ),
  .vlsu_if_sew              (vlsu_if_sew             ),
  .vlsu_if_split_cnt0       (vlsu_if_split_cnt0      ),
  .vlsu_if_split_cnt0_vld   (vlsu_if_split_cnt0_vld  ),
  .vlsu_if_split_cnt1       (vlsu_if_split_cnt1      ),
  .vlsu_if_split_cnt1_vld   (vlsu_if_split_cnt1_vld  ),
  .vlsu_if_sseg_reg_data    (vlsu_if_sseg_reg_data   ),
  .vlsu_if_vtb_round_bit    (vlsu_if_vtb_round_bit   ),
  .vlsu_lsu_data_shift      (vlsu_lsu_data_shift     ),
  .vlsu_lsu_data_vld        (vlsu_lsu_data_vld       ),
  .vlsu_lsu_fwd_data        (vlsu_lsu_fwd_data       ),
  .vlsu_lsu_fwd_dest_reg    (vlsu_lsu_fwd_dest_reg   ),
  .vlsu_lsu_fwd_vld         (vlsu_lsu_fwd_vld        ),
  .vlsu_lsu_src2_depd       (vlsu_lsu_src2_depd      ),
  .vlsu_lsu_src2_reg        (vlsu_lsu_src2_reg       ),
  .vlsu_lsu_wdata           (vlsu_lsu_wdata          ),
  .vlsu_warm_up             (vlsu_warm_up            ),
  .vpu_vlsu_fp_wb_data      (vpu_vlsu_fp_wb_data     ),
  .vpu_vlsu_fp_wb_reg       (vpu_vlsu_fp_wb_reg      ),
  .vpu_vlsu_fp_wb_vld       (vpu_vlsu_fp_wb_vld      )
);

// &Instance("aq_vlsu_vtb", "x_aq_vlsu_vtb"); @34
aq_vlsu_vtb  x_aq_vlsu_vtb (
  .cp0_vpu_icg_en                  (cp0_vpu_icg_en                 ),
  .cpurst_b                        (cpurst_b                       ),
  .forever_cpuclk                  (forever_cpuclk                 ),
  .if_vlsu_fls_data                (if_vlsu_fls_data               ),
  .if_vlsu_fls_reg                 (if_vlsu_fls_reg                ),
  .if_vlsu_fls_wb_vld              (if_vlsu_fls_wb_vld             ),
  .if_vlsu_fwd_done                (if_vlsu_fwd_done               ),
  .if_vlsu_merge_data              (if_vlsu_merge_data             ),
  .if_vlsu_merge_vld               (if_vlsu_merge_vld              ),
  .if_vlsu_sel0                    (if_vlsu_sel0                   ),
  .if_vlsu_sel1                    (if_vlsu_sel1                   ),
  .if_vlsu_sel2                    (if_vlsu_sel2                   ),
  .if_vlsu_sel3                    (if_vlsu_sel3                   ),
  .if_vlsu_vl_update               (if_vlsu_vl_update              ),
  .if_vlsu_vl_upval                (if_vlsu_vl_upval               ),
  .if_vlsu_vls_wb_abnormal         (if_vlsu_vls_wb_abnormal        ),
  .if_vlsu_vls_wb_bytes_vld        (if_vlsu_vls_wb_bytes_vld       ),
  .if_vlsu_vls_wb_data             (if_vlsu_vls_wb_data            ),
  .if_vlsu_vls_wb_vld              (if_vlsu_vls_wb_vld             ),
  .index_stall                     (index_stall                    ),
  .lsu_vlsu_dc_fld_req             (lsu_vlsu_dc_fld_req            ),
  .lsu_vlsu_dc_stall               (lsu_vlsu_dc_stall              ),
  .pad_yy_icg_scan_en              (pad_yy_icg_scan_en             ),
  .rtu_yy_xx_async_flush           (rtu_yy_xx_async_flush          ),
  .rtu_yy_xx_flush                 (rtu_yy_xx_flush                ),
  .sseg_abnormal_vld               (sseg_abnormal_vld              ),
  .sseg_fwd_last                   (sseg_fwd_last                  ),
  .sseg_fwd_vld                    (sseg_fwd_vld                   ),
  .sseg_nf                         (sseg_nf                        ),
  .sseg_split_pause                (sseg_split_pause               ),
  .sseg_vld                        (sseg_vld                       ),
  .sseg_vtb_all_vld                (sseg_vtb_all_vld               ),
  .sseg_vtb_all_wb                 (sseg_vtb_all_wb                ),
  .sseg_vtb_fwd_pre                (sseg_vtb_fwd_pre               ),
  .sseg_vtb_fwd_start              (sseg_vtb_fwd_start             ),
  .sseg_vtb_next_ready             (sseg_vtb_next_ready            ),
  .sseg_wb_vld                     (sseg_wb_vld                    ),
  .vlsu_fld_stall                  (vlsu_fld_stall                 ),
  .vlsu_if_fof_vld                 (vlsu_if_fof_vld                ),
  .vlsu_if_fwd_vld                 (vlsu_if_fwd_vld                ),
  .vlsu_if_nf                      (vlsu_if_nf                     ),
  .vlsu_if_reg_data                (vlsu_if_reg_data               ),
  .vlsu_if_reg_fls                 (vlsu_if_reg_fls                ),
  .vlsu_if_reg_seq_last            (vlsu_if_reg_seq_last           ),
  .vlsu_if_reg_src2_reg            (vlsu_if_reg_src2_reg           ),
  .vlsu_if_reg_wdata_ready         (vlsu_if_reg_wdata_ready        ),
  .vlsu_if_sew                     (vlsu_if_sew                    ),
  .vlsu_if_split_cnt0              (vlsu_if_split_cnt0             ),
  .vlsu_if_split_cnt0_vld          (vlsu_if_split_cnt0_vld         ),
  .vlsu_if_split_cnt1              (vlsu_if_split_cnt1             ),
  .vlsu_if_split_cnt1_vld          (vlsu_if_split_cnt1_vld         ),
  .vlsu_if_sseg_reg_data           (vlsu_if_sseg_reg_data          ),
  .vlsu_if_vtb_round_bit           (vlsu_if_vtb_round_bit          ),
  .vlsu_index_stall                (vlsu_index_stall               ),
  .vlsu_index_up_mask              (vlsu_index_up_mask             ),
  .vlsu_rbus_fpr_wb_data           (vlsu_rbus_fpr_wb_data          ),
  .vlsu_rbus_fpr_wb_index          (vlsu_rbus_fpr_wb_index         ),
  .vlsu_rbus_fpr_wb_req            (vlsu_rbus_fpr_wb_req           ),
  .vlsu_rbus_vpr_wb_data           (vlsu_rbus_vpr_wb_data          ),
  .vlsu_rbus_vpr_wb_index          (vlsu_rbus_vpr_wb_index         ),
  .vlsu_rbus_vpr_wb_req            (vlsu_rbus_vpr_wb_req           ),
  .vlsu_rtu_vl_updt_data           (vlsu_rtu_vl_updt_data          ),
  .vlsu_rtu_vl_updt_vld            (vlsu_rtu_vl_updt_vld           ),
  .vlsu_vex1_split_stall           (vlsu_vex1_split_stall          ),
  .vlsu_vidu_split_cancel          (vlsu_vidu_split_cancel         ),
  .vlsu_vidu_split_pause           (vlsu_vidu_split_pause          ),
  .vlsu_warm_up                    (vlsu_warm_up                   ),
  .vlsu_xx_ex1_fp_stall            (vlsu_xx_ex1_fp_stall           ),
  .vlsu_xx_no_op                   (vlsu_xx_no_op                  ),
  .vpu_group_3_xx_ex1_func         (vpu_group_3_xx_ex1_func        ),
  .vpu_group_3_xx_ex1_imm          (vpu_group_3_xx_ex1_imm         ),
  .vpu_group_3_xx_ex1_lmul         (vpu_group_3_xx_ex1_lmul        ),
  .vpu_group_3_xx_ex1_sel          (vpu_group_3_xx_ex1_sel         ),
  .vpu_group_3_xx_ex1_sew          (vpu_group_3_xx_ex1_sew         ),
  .vpu_group_3_xx_ex1_split_count  (vpu_group_3_xx_ex1_split_count ),
  .vpu_group_3_xx_ex1_srcv1        (vpu_group_3_xx_ex1_srcv1       ),
  .vpu_group_3_xx_ex1_srcv2        (vpu_group_3_xx_ex1_srcv2       ),
  .vpu_group_3_xx_ex1_srcv2_ready  (vpu_group_3_xx_ex1_srcv2_ready ),
  .vpu_group_3_xx_ex1_vl           (vpu_group_3_xx_ex1_vl          ),
  .vpu_group_3_xx_ex1_vl_byte_mask (vpu_group_3_xx_ex1_vl_byte_mask),
  .vpu_group_3_xx_ex1_vm_byte_mask (vpu_group_3_xx_ex1_vm_byte_mask),
  .vpu_group_3_xx_ex1_vm_high      (vpu_group_3_xx_ex1_vm_high     ),
  .vpu_group_3_xx_ex1_vreg         (vpu_group_3_xx_ex1_vreg        ),
  .vpu_group_3_xx_ex1_vstart       (vpu_group_3_xx_ex1_vstart      ),
  .vpu_vlsu_ex1_lsu_inst_vld       (vpu_vlsu_ex1_lsu_inst_vld      ),
  .vpu_vlsu_fp_wb_data             (vpu_vlsu_fp_wb_data            ),
  .vpu_vlsu_fp_wb_reg              (vpu_vlsu_fp_wb_reg             ),
  .vpu_vlsu_fp_wb_vld              (vpu_vlsu_fp_wb_vld             )
);

// &Instance("aq_vlsu_index_gen", "x_aq_vlsu_index_gen"); @36
// &Force("nonport", "vlsu_rbus_vpr_wb_req"); @38
// &Force("nonport", "vlsu_rbus_vpr_wb_index"); @39
// &Force("nonport", "vlsu_rbus_vpr_wb_data"); @40
// &Force("nonport", "vlsu_vidu_split_cancel"); @41
// &Force("nonport", "vlsu_vidu_split_pause"); @42
// &Force("nonport", "vlsu_index_stall"); @43
// &Force("nonport", "vlsu_index_up_mask"); @44

assign vpu_group_3_xx_ex1_vl[7:0]           = 8'h0;
assign vpu_group_3_xx_ex1_vstart[6:0]       = 7'h0;
assign vpu_group_3_xx_ex1_vl_byte_mask[`LSU_BYTEW-1:0] = {`LSU_BYTEW{1'b0}};
assign vpu_group_3_xx_ex1_vm_byte_mask[`LSU_BYTEW-1:0] = {`LSU_BYTEW{1'b0}};
assign vpu_group_3_xx_ex1_vm_high           = 1'b0;
assign vpu_group_3_xx_ex1_imm[4:0]          = 5'b0;
assign vpu_group_3_xx_ex1_lmul[1:0]         = 2'b0;
assign vpu_group_3_xx_ex1_sew[1:0]          = 2'b0;
assign vpu_group_3_xx_ex1_split_count[7:0]  = 8'b0;

assign index_stall = 1'b0;

//================================================
//        input interface
//================================================
assign vlsu_warm_up = ifu_vpu_warm_up;

//================================================
//        output interface
//================================================


// &ModuleEnd; @69
endmodule


