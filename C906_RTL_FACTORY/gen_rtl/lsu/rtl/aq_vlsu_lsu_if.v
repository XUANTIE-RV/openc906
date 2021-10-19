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

// &ModuleBeg; @20
module aq_vlsu_lsu_if(
  cp0_vpu_icg_en,
  cpurst_b,
  forever_cpuclk,
  if_vlsu_fls_data,
  if_vlsu_fls_reg,
  if_vlsu_fls_wb_vld,
  if_vlsu_fwd_done,
  if_vlsu_merge_data,
  if_vlsu_merge_vld,
  if_vlsu_sel0,
  if_vlsu_sel1,
  if_vlsu_sel2,
  if_vlsu_sel3,
  if_vlsu_vl_update,
  if_vlsu_vl_upval,
  if_vlsu_vls_wb_abnormal,
  if_vlsu_vls_wb_bytes_vld,
  if_vlsu_vls_wb_data,
  if_vlsu_vls_wb_vld,
  lsu_vlsu_bytes_vld,
  lsu_vlsu_data,
  lsu_vlsu_data_grant,
  lsu_vlsu_data_vld,
  lsu_vlsu_dc_create_vld,
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
  rtu_yy_xx_flush,
  sseg_abnormal_vld,
  sseg_fwd_last,
  sseg_fwd_vld,
  sseg_nf,
  sseg_split_pause,
  sseg_vld,
  sseg_vtb_all_vld,
  sseg_vtb_all_wb,
  sseg_vtb_fwd_pre,
  sseg_vtb_fwd_start,
  sseg_vtb_next_ready,
  sseg_wb_vld,
  vlsu_buf_stall,
  vlsu_dtu_data,
  vlsu_dtu_data_vld,
  vlsu_dtu_data_vld_gate,
  vlsu_fld_stall,
  vlsu_if_fof_vld,
  vlsu_if_fwd_vld,
  vlsu_if_nf,
  vlsu_if_reg_data,
  vlsu_if_reg_fls,
  vlsu_if_reg_seq_last,
  vlsu_if_reg_src2_reg,
  vlsu_if_reg_wdata_ready,
  vlsu_if_sew,
  vlsu_if_split_cnt0,
  vlsu_if_split_cnt0_vld,
  vlsu_if_split_cnt1,
  vlsu_if_split_cnt1_vld,
  vlsu_if_sseg_reg_data,
  vlsu_if_vtb_round_bit,
  vlsu_lsu_data_shift,
  vlsu_lsu_data_vld,
  vlsu_lsu_fwd_data,
  vlsu_lsu_fwd_dest_reg,
  vlsu_lsu_fwd_vld,
  vlsu_lsu_src2_depd,
  vlsu_lsu_src2_reg,
  vlsu_lsu_wdata,
  vlsu_warm_up,
  vpu_vlsu_fp_wb_data,
  vpu_vlsu_fp_wb_reg,
  vpu_vlsu_fp_wb_vld
);

// &Ports; @21
input           cp0_vpu_icg_en;          
input           cpurst_b;                
input           forever_cpuclk;          
input   [7 :0]  lsu_vlsu_bytes_vld;      
input   [63:0]  lsu_vlsu_data;           
input           lsu_vlsu_data_grant;     
input           lsu_vlsu_data_vld;       
input           lsu_vlsu_dc_create_vld;  
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
input           rtu_yy_xx_flush;         
input           sseg_vtb_all_vld;        
input           sseg_vtb_all_wb;         
input           sseg_vtb_fwd_pre;        
input           sseg_vtb_fwd_start;      
input           sseg_vtb_next_ready;     
input           vlsu_fld_stall;          
input           vlsu_if_fof_vld;         
input           vlsu_if_fwd_vld;         
input   [2 :0]  vlsu_if_nf;              
input   [63:0]  vlsu_if_reg_data;        
input           vlsu_if_reg_fls;         
input           vlsu_if_reg_seq_last;    
input   [4 :0]  vlsu_if_reg_src2_reg;    
input           vlsu_if_reg_wdata_ready; 
input   [1 :0]  vlsu_if_sew;             
input   [9 :0]  vlsu_if_split_cnt0;      
input           vlsu_if_split_cnt0_vld;  
input   [9 :0]  vlsu_if_split_cnt1;      
input           vlsu_if_split_cnt1_vld;  
input   [63:0]  vlsu_if_sseg_reg_data;   
input   [1 :0]  vlsu_if_vtb_round_bit;   
input           vlsu_warm_up;            
input   [63:0]  vpu_vlsu_fp_wb_data;     
input   [4 :0]  vpu_vlsu_fp_wb_reg;      
input           vpu_vlsu_fp_wb_vld;      
output  [63:0]  if_vlsu_fls_data;        
output  [4 :0]  if_vlsu_fls_reg;         
output          if_vlsu_fls_wb_vld;      
output          if_vlsu_fwd_done;        
output  [63:0]  if_vlsu_merge_data;      
output          if_vlsu_merge_vld;       
output  [3 :0]  if_vlsu_sel0;            
output  [3 :0]  if_vlsu_sel1;            
output  [3 :0]  if_vlsu_sel2;            
output  [3 :0]  if_vlsu_sel3;            
output          if_vlsu_vl_update;       
output  [6 :0]  if_vlsu_vl_upval;        
output          if_vlsu_vls_wb_abnormal; 
output  [7 :0]  if_vlsu_vls_wb_bytes_vld; 
output  [63:0]  if_vlsu_vls_wb_data;     
output          if_vlsu_vls_wb_vld;      
output          sseg_abnormal_vld;       
output          sseg_fwd_last;           
output          sseg_fwd_vld;            
output  [2 :0]  sseg_nf;                 
output          sseg_split_pause;        
output          sseg_vld;                
output          sseg_wb_vld;             
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

// &Regs; @22
reg     [2 :0]  byte_reorder;            
reg     [2 :0]  byte_reorder_next;       
reg             expt_ff;                 
reg             fof_mask_ff;             
reg     [3 :0]  mux_reorder;             
reg     [3 :0]  mux_reorder_next;        
reg     [2 :0]  nf;                      
reg     [1 :0]  round_bit;               
reg     [3 :0]  sel0;                    
reg     [3 :0]  sel0_next;               
reg     [3 :0]  sel1;                    
reg     [3 :0]  sel1_next;               
reg     [3 :0]  sel2;                    
reg     [3 :0]  sel2_next;               
reg     [3 :0]  sel3;                    
reg     [3 :0]  sel3_next;               
reg     [1 :0]  sew;                     
reg     [1 :0]  sseg_cnt;                
reg     [3 :0]  sseg_cur_state;          
reg     [3 :0]  sseg_next_state;         

// &Wires; @23
wire            ab_vld;                  
wire            abnormal_clk;            
wire            abnormal_clk_en;         
wire            abnormal_data_mask;      
wire            abnormal_ff;             
wire            abnormal_vld;            
wire            cnt0_eq_dc;              
wire            cnt0_gt_dc;              
wire            cnt1_eq_dc;              
wire            cnt1_gt_dc;              
wire            cp0_vpu_icg_en;          
wire            cpurst_b;                
wire    [63:0]  data_read;               
wire    [63:0]  data_write;              
wire            forever_cpuclk;          
wire    [63:0]  fwd_data;                
wire            fwd_data_ready;          
wire    [3 :0]  fwd_data_shift;          
wire            fwd_next;                
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
wire            last_merge;              
wire    [7 :0]  lsu_bytes_vld;           
wire    [63:0]  lsu_data;                
wire            lsu_data_vld;            
wire            lsu_dc_create;           
wire            lsu_dc_fof;              
wire    [2 :0]  lsu_dc_nf;               
wire    [1 :0]  lsu_dc_sew;              
wire    [9 :0]  lsu_dc_split_cnt;        
wire            lsu_dc_sseg_first;       
wire            lsu_dc_stall;            
wire    [4 :0]  lsu_dest_reg;            
wire            lsu_expt_vld;            
wire            lsu_fwd_done;            
wire            lsu_fwd_expt;            
wire    [1 :0]  lsu_fwd_inst_size;       
wire    [3 :0]  lsu_fwd_rot;             
wire    [1 :0]  lsu_fwd_sew;             
wire            lsu_fwd_vld;             
wire            lsu_inst_fls;            
wire            lsu_inst_vfls;           
wire            lsu_merge_vld;           
wire    [1 :0]  lsu_sew;                 
wire            lsu_split_last;          
wire            lsu_vl_update;           
wire    [6 :0]  lsu_vl_upval;            
wire    [7 :0]  lsu_vlsu_bytes_vld;      
wire    [63:0]  lsu_vlsu_data;           
wire            lsu_vlsu_data_grant;     
wire            lsu_vlsu_data_vld;       
wire            lsu_vlsu_dc_create_vld;  
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
wire    [7 :0]  lsu_wb_bytes_vld;        
wire            lsu_wb_vld;              
wire    [63:0]  merge_data;              
wire    [2 :0]  nf_create;               
wire    [2 :0]  nf_next;                 
wire            pad_yy_icg_scan_en;      
wire            read_next;               
wire            rtu_yy_xx_flush;         
wire    [1 :0]  sew_create;              
wire            sew_le_blk;              
wire    [1 :0]  sew_next;                
wire    [2 :0]  sew_next_sel;            
wire            sew_qd_blk;              
wire            sew_tw_blk;              
wire    [8 :0]  split_cnt_dis0;          
wire    [8 :0]  split_cnt_dis1;          
wire            sseg_abnormal_idle;      
wire            sseg_abnormal_vld;       
wire            sseg_active;             
wire    [1 :0]  sseg_cnt_next;           
wire            sseg_expt_active;        
wire            sseg_expt_merge;         
wire            sseg_expt_merge_gate;    
wire            sseg_expt_wait;          
wire            sseg_fsm_clk;            
wire            sseg_fsm_start;          
wire            sseg_full;               
wire            sseg_fwd_active;         
wire            sseg_fwd_done;           
wire            sseg_fwd_last;           
wire            sseg_fwd_pre;            
wire            sseg_fwd_start;          
wire            sseg_fwd_vld;            
wire            sseg_merge_done;         
wire            sseg_merge_start;        
wire            sseg_next_inst;          
wire    [2 :0]  sseg_nf;                 
wire            sseg_nf3_part;           
wire            sseg_split_pause;        
wire            sseg_start_type;         
wire            sseg_vl_update;          
wire            sseg_vld;                
wire            sseg_vtb_all_vld;        
wire            sseg_vtb_all_wb;         
wire            sseg_vtb_fwd_pre;        
wire            sseg_vtb_fwd_start;      
wire            sseg_vtb_next_ready;     
wire            sseg_wb_active;          
wire            sseg_wb_vld;             
wire            trans_initial;           
wire            trans_up;                
wire            trans_up_clk_en;         
wire            vl_update;               
wire    [6 :0]  vl_upval;                
wire            vlsu_buf_stall;          
wire    [63:0]  vlsu_dtu_data;           
wire            vlsu_dtu_data_vld;       
wire            vlsu_dtu_data_vld_gate;  
wire            vlsu_fld_stall;          
wire            vlsu_fof_vld;            
wire            vlsu_fwd_vld;            
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
wire    [3 :0]  vlsu_lsu_data_shift;     
wire            vlsu_lsu_data_vld;       
wire    [63:0]  vlsu_lsu_fwd_data;       
wire    [4 :0]  vlsu_lsu_fwd_dest_reg;   
wire            vlsu_lsu_fwd_vld;        
wire            vlsu_lsu_src2_depd;      
wire    [4 :0]  vlsu_lsu_src2_reg;       
wire    [63:0]  vlsu_lsu_wdata;          
wire    [2 :0]  vlsu_nf;                 
wire    [63:0]  vlsu_reg_data;           
wire            vlsu_reg_fls;            
wire            vlsu_reg_seq_last;       
wire    [4 :0]  vlsu_reg_src2_reg;       
wire            vlsu_reg_wdata_ready;    
wire    [1 :0]  vlsu_sew;                
wire    [9 :0]  vlsu_split_cnt0;         
wire            vlsu_split_cnt0_vld;     
wire    [9 :0]  vlsu_split_cnt1;         
wire            vlsu_split_cnt1_vld;     
wire    [63:0]  vlsu_sseg_reg_data;      
wire            vlsu_vtb_ready;          
wire    [1 :0]  vlsu_vtb_round_bit;      
wire            vlsu_warm_up;            
wire    [63:0]  vpu_vlsu_fp_wb_data;     
wire    [4 :0]  vpu_vlsu_fp_wb_reg;      
wire            vpu_vlsu_fp_wb_vld;      


parameter BYTE = 2'b00;
parameter HALF = 2'b01;
parameter WORD = 2'b10;
parameter DWORD= 2'b11;

//================================================
//        Instance
//================================================
// &Instance("aq_vlsu_ld_align_buffer","x_aq_vlsu_ld_align_buffer"); @33
aq_vlsu_ld_align_buffer  x_aq_vlsu_ld_align_buffer (
  .ab_vld               (ab_vld              ),
  .abnormal_ff          (abnormal_ff         ),
  .cp0_vpu_icg_en       (cp0_vpu_icg_en      ),
  .cpurst_b             (cpurst_b            ),
  .data_read            (data_read           ),
  .forever_cpuclk       (forever_cpuclk      ),
  .lsu_bytes_vld        (lsu_bytes_vld       ),
  .lsu_data             (lsu_data            ),
  .lsu_data_vld         (lsu_data_vld        ),
  .lsu_expt_vld         (lsu_expt_vld        ),
  .lsu_inst_fls         (lsu_inst_fls        ),
  .lsu_merge_vld        (lsu_merge_vld       ),
  .lsu_vl_update        (lsu_vl_update       ),
  .lsu_wb_bytes_vld     (lsu_wb_bytes_vld    ),
  .lsu_wb_vld           (lsu_wb_vld          ),
  .merge_data           (merge_data          ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  ),
  .rtu_yy_xx_flush      (rtu_yy_xx_flush     ),
  .sseg_active          (sseg_active         ),
  .sseg_expt_merge      (sseg_expt_merge     ),
  .sseg_expt_merge_gate (sseg_expt_merge_gate),
  .sseg_nf3_part        (sseg_nf3_part       ),
  .vlsu_warm_up         (vlsu_warm_up        )
);

// &Instance("aq_vlsu_st_align_buffer","x_aq_vlsu_st_align_buffer"); @34
aq_vlsu_st_align_buffer  x_aq_vlsu_st_align_buffer (
  .cp0_vpu_icg_en       (cp0_vpu_icg_en      ),
  .cpurst_b             (cpurst_b            ),
  .data_read            (data_read           ),
  .forever_cpuclk       (forever_cpuclk      ),
  .fwd_data             (fwd_data            ),
  .fwd_data_ready       (fwd_data_ready      ),
  .fwd_data_shift       (fwd_data_shift      ),
  .fwd_next             (fwd_next            ),
  .last_merge           (last_merge          ),
  .lsu_fwd_done         (lsu_fwd_done        ),
  .lsu_fwd_inst_size    (lsu_fwd_inst_size   ),
  .lsu_fwd_rot          (lsu_fwd_rot         ),
  .lsu_fwd_sew          (lsu_fwd_sew         ),
  .lsu_fwd_vld          (lsu_fwd_vld         ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  ),
  .rtu_yy_xx_flush      (rtu_yy_xx_flush     ),
  .sseg_active          (sseg_active         ),
  .sseg_nf3_part        (sseg_nf3_part       ),
  .vlsu_fwd_vld         (vlsu_fwd_vld        ),
  .vlsu_reg_data        (vlsu_reg_data       ),
  .vlsu_reg_fls         (vlsu_reg_fls        ),
  .vlsu_reg_seq_last    (vlsu_reg_seq_last   ),
  .vlsu_reg_wdata_ready (vlsu_reg_wdata_ready),
  .vlsu_warm_up         (vlsu_warm_up        )
);


//================================================
//        input interface
//================================================
// &Force("bus","lsu_vlsu_func",19,0); @39
// &Force("nonport","lsu_sew"); @40
//----------------input from lsu------------------
//from dc create ahead
assign lsu_dc_create   = lsu_vlsu_dc_create_vld;
assign lsu_dc_sew[1:0] = lsu_vlsu_dc_sew[1:0]; 
assign lsu_dc_nf[2:0]  = lsu_vlsu_dc_nf[2:0];
assign lsu_dc_fof      = lsu_vlsu_dc_fof;
assign lsu_dc_stall    = lsu_vlsu_dc_stall;

assign lsu_dc_sseg_first     = lsu_vlsu_dc_sseg_first;
assign lsu_dc_split_cnt[9:0] = lsu_vlsu_dc_split_cnt[9:0];

//from da merge
assign lsu_data_vld        = lsu_vlsu_data_vld && !abnormal_data_mask; 
assign lsu_inst_fls        = lsu_vlsu_func[10]; 
assign lsu_inst_vfls       = |lsu_vlsu_func[11:10];
assign lsu_data[`LSU_DATAW-1:0] = {`LSU_DATAW{lsu_inst_vfls}} & lsu_vlsu_data[`LSU_DATAW-1:0];
assign lsu_bytes_vld[`LSU_BYTEW-1:0] = lsu_vlsu_bytes_vld[`LSU_BYTEW-1:0];
assign lsu_dest_reg[4:0]   = lsu_vlsu_dest_reg[4:0]; 
//assign lsu_nf[2:0]        = lsu_vlsu_func[18:16]; 
assign lsu_sew[1:0]        = lsu_vlsu_sew[1:0]; 

//expt fof signal
assign lsu_expt_vld      = lsu_vlsu_expt_vld;
assign lsu_vl_update     = lsu_vlsu_data_vld && !lsu_inst_fls && lsu_vlsu_vl_update && !fof_mask_ff;
assign lsu_vl_upval[6:0] = lsu_vlsu_vl_upval[6:0];

assign lsu_split_last    = lsu_vlsu_split_last;

//for st
assign lsu_fwd_done           = lsu_vlsu_data_grant;
assign lsu_fwd_rot[3:0]       = lsu_vlsu_st_offset[3:0];
assign lsu_fwd_inst_size[1:0] = lsu_vlsu_st_size[1:0];
assign lsu_fwd_sew[1:0]       = lsu_vlsu_st_sew[1:0];
assign lsu_fwd_expt           = lsu_vlsu_st_expt;
//----------------input from vec------------------
//from vtb
assign vlsu_fwd_vld             = vlsu_if_fwd_vld;
assign vlsu_sseg_reg_data[`LSU_DATAW-1:0] = vlsu_if_sseg_reg_data[`LSU_DATAW-1:0];
assign vlsu_reg_data[`LSU_DATAW-1:0]      = vlsu_if_reg_data[`LSU_DATAW-1:0];
assign vlsu_reg_seq_last        = vlsu_if_reg_seq_last;
assign vlsu_reg_fls             = vlsu_if_reg_fls;
assign vlsu_reg_wdata_ready     = vlsu_if_reg_wdata_ready;
assign vlsu_reg_src2_reg[4:0]   = vlsu_if_reg_src2_reg[4:0];

assign vlsu_split_cnt0_vld = vlsu_if_split_cnt0_vld; 
assign vlsu_split_cnt1_vld = vlsu_if_split_cnt1_vld; 
assign vlsu_split_cnt0[9:0]= vlsu_if_split_cnt0[9:0]; 
assign vlsu_split_cnt1[9:0]= vlsu_if_split_cnt1[9:0]; 
assign vlsu_fof_vld        = vlsu_if_fof_vld; 
assign vlsu_vtb_round_bit[1:0] = vlsu_if_vtb_round_bit[1:0];

//from vex1 create ahead
assign vlsu_sew[1:0] = vlsu_if_sew[1:0];
assign vlsu_nf[2:0]  = vlsu_if_nf[2:0];

//================================================
//        sseg ctrl FSM
//================================================
//vlsu use two different mechanism for ld merge
//one is direct write back with vtb merge bypass(other than sseg type)
//one is use FSM to control merge into vtb entry for sseg type
//following is sseg FSM(control both merge/fwd) and introduce briefly
//SSEG_IDLE    : IDLE STATE
//SSEG_EXPT_IDLE: sseg already has expt,but this sseg inst has not done yet
//SSEG_MERGE   : sseg type ld merge state
//SSEG_WB      : sseg type normal write back state(merge cmplt normally)
//SSEG_WAIT    : sseg type merge has encounterd expt,need to prepare ori dst val
//SSEG_EXPT    : sseg type expt write back state(after wait)
//
//SSEG_FWD_DATA_PRE: sseg type st fwd prepare(first vtb data valid)
//SSEG_FWD         : sseg type st fwd start

parameter SSEG_IDLE         = 4'b0000;
parameter SSEG_EXPT_IDLE    = 4'b1000;
parameter SSEG_MERGE        = 4'b1001;
parameter SSEG_WB           = 4'b1010;
parameter SSEG_FWD_DATA_PRE = 4'b1100;
parameter SSEG_FWD          = 4'b1101;
parameter SSEG_WAIT         = 4'b1110;
parameter SSEG_EXPT         = 4'b1111;

always@(posedge sseg_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    sseg_cur_state[3:0] <= SSEG_IDLE;
  else if(rtu_yy_xx_flush)
    sseg_cur_state[3:0] <= SSEG_IDLE;
  else
    sseg_cur_state[3:0] <= sseg_next_state[3:0];
end

// &CombBeg; @132
always @( abnormal_vld
       or sseg_vtb_all_vld
       or sseg_fwd_start
       or sseg_merge_done
       or sseg_vtb_all_wb
       or sseg_cur_state[3:0]
       or sseg_merge_start
       or sseg_next_inst
       or abnormal_ff
       or sseg_vtb_next_ready
       or sseg_fwd_done
       or sseg_fwd_pre
       or lsu_dc_stall)
begin
  case(sseg_cur_state[3:0])
    SSEG_IDLE: begin
      if (sseg_fwd_start)
        sseg_next_state[3:0] = SSEG_FWD;
      else if (sseg_fwd_pre)
        sseg_next_state[3:0] = SSEG_FWD_DATA_PRE;
      else if (sseg_merge_start && !lsu_dc_stall)
        sseg_next_state[3:0] = SSEG_MERGE;
      else 
        sseg_next_state[3:0] = SSEG_IDLE;
    end
    SSEG_MERGE: begin
      if (sseg_merge_done)
        sseg_next_state[3:0] = SSEG_WB;
      else if (abnormal_vld)
        sseg_next_state[3:0] = SSEG_WAIT;
      else 
        sseg_next_state[3:0] = SSEG_MERGE;
    end
    SSEG_WB: begin
      if (sseg_vtb_next_ready)
        sseg_next_state[3:0] = SSEG_IDLE;
      else 
        sseg_next_state[3:0] = SSEG_WB;
    end
    SSEG_FWD_DATA_PRE: begin
      if (sseg_fwd_start)
        sseg_next_state[3:0] = SSEG_FWD;
      else 
        sseg_next_state[3:0] = SSEG_FWD_DATA_PRE;
    end
    SSEG_FWD: begin
      if (sseg_fwd_done)
        sseg_next_state[3:0] = SSEG_IDLE;
      else 
        sseg_next_state[3:0] = SSEG_FWD;
    end
    SSEG_WAIT: begin
      if (sseg_vtb_all_vld)
        sseg_next_state[3:0] = SSEG_EXPT;
      else 
        sseg_next_state[3:0] = SSEG_WAIT;
    end
    SSEG_EXPT: begin
      if (sseg_vtb_all_wb && abnormal_ff)
        sseg_next_state[3:0] = SSEG_EXPT_IDLE;
      else if (sseg_vtb_all_wb)
        sseg_next_state[3:0] = SSEG_IDLE;
      else 
        sseg_next_state[3:0] = SSEG_EXPT;
    end
    SSEG_EXPT_IDLE: begin
      if (!abnormal_ff)
        sseg_next_state[3:0] = SSEG_IDLE;
      else if (sseg_merge_start && !sseg_next_inst && !lsu_dc_stall)
        sseg_next_state[3:0] = SSEG_WAIT;
      else 
        sseg_next_state[3:0] = SSEG_EXPT_IDLE;
    end
    default: sseg_next_state[3:0] = SSEG_IDLE;
  endcase
// &CombEnd; @194
end
//================================================
//        sseg FSM control
//================================================
//for dp 64, nf3 part means 48 bits per merge
//for dp 128.nf3 part means 96 bits per merge
assign sseg_nf3_part = (nf[2:0] == 3'h2) && !sew[1];

assign last_merge = sseg_nf3_part
                    ? (sseg_cnt[1:0] == 2'h3)
                    : (nf[1:0] == sseg_cnt[1:0]);

assign sseg_start_type = !lsu_dc_nf[2] && |lsu_dc_nf[1:0];

assign sseg_merge_start = lsu_dc_create
                          && lsu_dc_sseg_first
                          && sseg_start_type;

assign sseg_merge_done = lsu_merge_vld && last_merge; 

//fwd
assign sseg_fwd_pre    = sseg_vtb_fwd_pre;
assign sseg_fwd_start  = sseg_vtb_fwd_start;
assign sseg_fwd_done   = last_merge && fwd_next;
//================================================
//        sseg data transform
//================================================
//--------------register-------------------------
//for timing,select reorder ahead
assign trans_up_clk_en = sseg_fsm_start || sseg_active || vlsu_warm_up;

// &Instance("gated_clk_cell", "x_aq_vlsu_vtb_reorder_clk"); @229
gated_clk_cell  x_aq_vlsu_vtb_reorder_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (sseg_fsm_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (trans_up_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @230
//          .external_en (1'b0), @231
//          .global_en   (1'b1), @232
//          .module_en   (cp0_vpu_icg_en), @233
//          .local_en    (trans_up_clk_en), @234
//          .clk_out     (sseg_fsm_clk)); @235

assign sseg_fsm_start = (sseg_merge_start || sseg_fwd_pre || sseg_fwd_start)
                        && !sseg_active;

assign trans_initial = sseg_fsm_start;

assign trans_up = trans_initial
                  || lsu_merge_vld
                  || abnormal_vld
                  || sseg_expt_merge 
                  || fwd_next; 

always@(posedge sseg_fsm_clk)
begin
  if (trans_up || vlsu_warm_up) begin
    mux_reorder[3:0]  <= mux_reorder_next[3:0];
    byte_reorder[2:0] <= byte_reorder_next[2:0];
    sseg_cnt[1:0]     <= sseg_cnt_next[1:0];
    sel0[3:0]         <= sel0_next[3:0];
    sel1[3:0]         <= sel1_next[3:0];
    sel2[3:0]         <= sel2_next[3:0];
    sel3[3:0]         <= sel3_next[3:0];
  end
end

always@(posedge sseg_fsm_clk)
begin
  if (sseg_fsm_start || vlsu_warm_up) begin
    sew[1:0]  <= sew_create[1:0];
    nf[2:0]   <= nf_create[2:0];
    round_bit[1:0] <= lsu_dc_split_cnt[9:8];  //for fof
  end
end

//----------------prepare-------------------------
assign sseg_active     = sseg_cur_state[3];
assign sseg_abnormal_idle = (sseg_cur_state[3:0] == SSEG_EXPT_IDLE);
assign sseg_fwd_active = (sseg_cur_state[3:0] == SSEG_FWD);
assign sseg_wb_active  = (sseg_cur_state[3:0] == SSEG_WB);
assign sseg_expt_wait  = (sseg_cur_state[3:0] == SSEG_WAIT);
assign sseg_expt_merge = sseg_expt_wait
                         && ab_vld
                         && sseg_vtb_all_vld;
assign sseg_expt_merge_gate = sseg_expt_wait;
assign sseg_expt_active= (sseg_cur_state[3:0] == SSEG_EXPT);
//assign sseg_read_op    = sseg_fwd_active || sseg_expt_wait;
assign nf_create[2:0]  = sseg_fwd_pre
                         ? vlsu_nf[2:0]
                         : lsu_dc_nf[2:0];
assign sew_create[1:0] = sseg_fwd_pre
                         ? vlsu_sew[1:0]
                         : lsu_dc_sew[1:0];
//assign data_ori[`LSU_DATAW-1:0] = sseg_fwd_active || sseg_expt_merge
//                              ? vlsu_sseg_reg_data[`LSU_DATAW-1:0]
//                              : merge_data[`LSU_DATAW-1:0];

assign nf_next[2:0] = trans_initial
                      ? nf_create[2:0]
                      : nf[2:0];

assign sew_next[1:0] = trans_initial
                      ? sew_create[1:0]
                      : sew[1:0];

assign sseg_cnt_next[1:0] = trans_initial
                            ? 2'b0
                            : lsu_merge_vld || fwd_next
                              ? sseg_cnt[1:0] + 2'b1
                              : sseg_cnt[1:0];

assign read_next = !(sseg_merge_start && !sseg_active || lsu_merge_vld && !abnormal_vld || sseg_expt_merge);

assign sew_le_blk = !sew_next[1];               //less or equal
assign sew_tw_blk = (sew_next[1:0] == WORD);    //twice
assign sew_qd_blk = 1'b0;                       //quad

assign sew_next_sel[2:0] = {sew_qd_blk,sew_tw_blk,sew_le_blk};

// &CombBeg; @329
always @( sseg_cnt_next[1:0]
       or sew_next_sel[2:0]
       or nf_next[2:0]
       or read_next)
begin
  casez({nf_next[2:0],sew_next_sel[2:0],sseg_cnt_next[1:0],read_next})
  {3'h1,3'b001,2'h0,1'b1}:mux_reorder_next[3:0] = 4'h1;
  {3'h1,3'b001,2'h0,1'b0}:mux_reorder_next[3:0] = 4'h3;
  {3'h1,3'b001,2'h1,1'b1}:mux_reorder_next[3:0] = 4'h2;
  {3'h1,3'b001,2'h1,1'b0}:mux_reorder_next[3:0] = 4'h9;
  {3'h1,3'b010,2'h0,1'b?}:mux_reorder_next[3:0] = 4'h3;
  {3'h1,3'b010,2'h1,1'b1}:mux_reorder_next[3:0] = 4'h4;
  {3'h1,3'b010,2'h1,1'b0}:mux_reorder_next[3:0] = 4'h9;
  {3'h2,3'b001,2'h0,1'b1}:mux_reorder_next[3:0] = 4'h1;
  {3'h2,3'b001,2'h0,1'b0}:mux_reorder_next[3:0] = 4'h3;
  {3'h2,3'b001,2'h1,1'b1}:mux_reorder_next[3:0] = 4'h7;
  {3'h2,3'b001,2'h1,1'b0}:mux_reorder_next[3:0] = 4'h5;
  {3'h2,3'b001,2'h2,1'b1}:mux_reorder_next[3:0] = 4'h2;
  {3'h2,3'b001,2'h2,1'b0}:mux_reorder_next[3:0] = 4'h9;
  {3'h2,3'b001,2'h3,1'b1}:mux_reorder_next[3:0] = 4'h8;
  {3'h2,3'b001,2'h3,1'b0}:mux_reorder_next[3:0] = 4'h4;
  {3'h2,3'b010,2'h0,1'b?}:mux_reorder_next[3:0] = 4'h3;
  {3'h2,3'b010,2'h1,1'b?}:mux_reorder_next[3:0] = 4'h5;
  {3'h2,3'b010,2'h2,1'b?}:mux_reorder_next[3:0] = 4'h6;
  {3'h3,3'b001,2'h0,1'b1}:mux_reorder_next[3:0] = 4'h1;
  {3'h3,3'b001,2'h0,1'b0}:mux_reorder_next[3:0] = 4'h3;
  {3'h3,3'b001,2'h1,1'b1}:mux_reorder_next[3:0] = 4'h7;
  {3'h3,3'b001,2'h1,1'b0}:mux_reorder_next[3:0] = 4'h5;
  {3'h3,3'b001,2'h2,1'b1}:mux_reorder_next[3:0] = 4'h2;
  {3'h3,3'b001,2'h2,1'b0}:mux_reorder_next[3:0] = 4'h9;
  {3'h3,3'b001,2'h3,1'b1}:mux_reorder_next[3:0] = 4'h8;
  {3'h3,3'b001,2'h3,1'b0}:mux_reorder_next[3:0] = 4'h4;
  {3'h3,3'b010,2'h0,1'b?}:mux_reorder_next[3:0] = 4'h3;
  {3'h3,3'b010,2'h1,1'b?}:mux_reorder_next[3:0] = 4'h5;
  {3'h3,3'b010,2'h2,1'b1}:mux_reorder_next[3:0] = 4'h4;
  {3'h3,3'b010,2'h2,1'b0}:mux_reorder_next[3:0] = 4'h9;
  {3'h3,3'b010,2'h3,1'b1}:mux_reorder_next[3:0] = 4'h9;
  {3'h3,3'b010,2'h3,1'b0}:mux_reorder_next[3:0] = 4'h4;
  {3'h?,3'b100,2'h1,1'b?}:mux_reorder_next[3:0] = 4'ha;
  {3'h?,3'b100,2'h2,1'b?}:mux_reorder_next[3:0] = 4'h6;
  {3'h?,3'b100,2'h3,1'b?}:mux_reorder_next[3:0] = 4'hb;
  default:mux_reorder_next[3:0] = 4'h0;
  endcase
// &CombEnd; @368
end

 
// &CombBeg; @371
always @( sew_next[1:0]
       or nf_next[2:0])
begin
  casez({nf_next[2:0],sew_next[1:0]})
  {3'h1,BYTE}:byte_reorder_next[2:0] = 3'h1; 
  {3'h2,BYTE}:byte_reorder_next[2:0] = 3'h2; 
  {3'h3,BYTE}:byte_reorder_next[2:0] = 3'h3;
  {3'h?,HALF}:byte_reorder_next[2:0] = 3'h4; 
  default:byte_reorder_next[2:0] = 3'h0;
  endcase
// &CombEnd; @386
end

// &Instance("aq_vlsu_data_trans", "x_aq_vlsu_data_trans"); @388
aq_vlsu_data_trans  x_aq_vlsu_data_trans (
  .byte_reorder       (byte_reorder[2:0] ),
  .data_read          (data_read         ),
  .data_read_in       (vlsu_sseg_reg_data),
  .data_write         (data_write        ),
  .data_write_in      (merge_data        ),
  .mux_reorder        (mux_reorder[3:0]  )
);

// &Connect(.data_read_in (vlsu_sseg_reg_data), @389
//          .data_write_in(merge_data), @390
//          .byte_reorder (byte_reorder[2:0]), @391
//          .mux_reorder  (mux_reorder[3:0]), @392
//          .data_read    (data_read), @393
//          .data_write   (data_write)); @394
//----------------read/write port sel-------------------------
// &CombBeg; @396
always @( sseg_cnt_next[1:0]
       or sew_next_sel[2:0]
       or nf_next[2:0])
begin
  casez({nf_next[2:0],sew_next_sel[2:0],sseg_cnt_next[1:0]})
  {3'h1,3'b001,2'h0}:
  begin
  sel0_next[3:0] = 4'h1;
  sel1_next[3:0] = 4'h1;
  sel2_next[3:0] = 4'h2;
  sel3_next[3:0] = 4'h2;
  end
  {3'h1,3'b001,2'h1}:
  begin
  sel0_next[3:0] = 4'h2;
  sel1_next[3:0] = 4'h2;
  sel2_next[3:0] = 4'h1;
  sel3_next[3:0] = 4'h1;
  end
  {3'h2,3'b001,2'h0}:
  begin
  sel0_next[3:0] = 4'h1;
  sel1_next[3:0] = 4'h4;
  sel2_next[3:0] = 4'h0;
  sel3_next[3:0] = 4'h2;
  end
  {3'h2,3'b001,2'h1}:
  begin
  sel0_next[3:0] = 4'h4;
  sel1_next[3:0] = 4'h1;
  sel2_next[3:0] = 4'h2;
  sel3_next[3:0] = 4'h0;
  end
  {3'h2,3'b001,2'h2}:
  begin
  sel0_next[3:0] = 4'h0;
  sel1_next[3:0] = 4'h2;
  sel2_next[3:0] = 4'h1;
  sel3_next[3:0] = 4'h4;
  end 
  {3'h2,3'b001,2'h3}:
  begin
  sel0_next[3:0] = 4'h2;
  sel1_next[3:0] = 4'h0;
  sel2_next[3:0] = 4'h4;
  sel3_next[3:0] = 4'h1;
  end
  {3'h1,3'b010,2'h0}:
  begin
  sel0_next[3:0] = 4'h1;
  sel1_next[3:0] = 4'h1;
  sel2_next[3:0] = 4'h2;
  sel3_next[3:0] = 4'h2;
  end
  {3'h1,3'b010,2'h1}:
  begin
  sel0_next[3:0] = 4'h2;
  sel1_next[3:0] = 4'h2;
  sel2_next[3:0] = 4'h1;
  sel3_next[3:0] = 4'h1;
  end
  {3'h2,3'b010,2'h0}:
  begin
  sel0_next[3:0] = 4'h1;
  sel1_next[3:0] = 4'h1;
  sel2_next[3:0] = 4'h2;
  sel3_next[3:0] = 4'h2;
  end
  {3'h2,3'b010,2'h1}:
  begin
  sel0_next[3:0] = 4'h4;
  sel1_next[3:0] = 4'h4;
  sel2_next[3:0] = 4'h1;
  sel3_next[3:0] = 4'h1;
  end 
  {3'h2,3'b010,2'h2}:
  begin
  sel0_next[3:0] = 4'h2;
  sel1_next[3:0] = 4'h2;
  sel2_next[3:0] = 4'h4;
  sel3_next[3:0] = 4'h4;
  end 
  {3'h3,3'b001,2'h0}:
  begin
  sel0_next[3:0] = 4'h1;
  sel1_next[3:0] = 4'h4;
  sel2_next[3:0] = 4'h8;
  sel3_next[3:0] = 4'h2;
  end
  {3'h3,3'b001,2'h1}:
  begin
  sel0_next[3:0] = 4'h4;
  sel1_next[3:0] = 4'h1;
  sel2_next[3:0] = 4'h2;
  sel3_next[3:0] = 4'h8;
  end
  {3'h3,3'b001,2'h2}:
  begin
  sel0_next[3:0] = 4'h8;
  sel1_next[3:0] = 4'h2;
  sel2_next[3:0] = 4'h1;
  sel3_next[3:0] = 4'h4;
  end 
  {3'h3,3'b001,2'h3}:
  begin
  sel0_next[3:0] = 4'h2;
  sel1_next[3:0] = 4'h8;
  sel2_next[3:0] = 4'h4;
  sel3_next[3:0] = 4'h1;
  end
  {3'h3,3'b010,2'h0}:
  begin
  sel0_next[3:0] = 4'h1;
  sel1_next[3:0] = 4'h1;
  sel2_next[3:0] = 4'h2;
  sel3_next[3:0] = 4'h2;
  end 
  {3'h3,3'b010,2'h1}:
  begin
  sel0_next[3:0] = 4'h4;
  sel1_next[3:0] = 4'h4;
  sel2_next[3:0] = 4'h8;
  sel3_next[3:0] = 4'h8;
  end 
  {3'h3,3'b010,2'h2}:
  begin
  sel0_next[3:0] = 4'h2;
  sel1_next[3:0] = 4'h2;
  sel2_next[3:0] = 4'h1;
  sel3_next[3:0] = 4'h1;
  end
  {3'h3,3'b010,2'h3}:
  begin
  sel0_next[3:0] = 4'h8;
  sel1_next[3:0] = 4'h8;
  sel2_next[3:0] = 4'h4;
  sel3_next[3:0] = 4'h4;
  end
  default:
  begin
  sel0_next[3:0] = 4'h0;
  sel1_next[3:0] = 4'h0;
  sel2_next[3:0] = 4'h0;
  sel3_next[3:0] = 4'h0;
  end 
  endcase
// &CombEnd; @569
end
//================================================
//        fof data mask
//================================================
assign abnormal_clk_en = abnormal_vld 
                         || abnormal_ff
                         || sseg_vl_update
                         || lsu_fwd_done 
                            && lsu_fwd_expt;

// &Instance("gated_clk_cell", "x_aq_lsu_fof_gated_clk"); @579
gated_clk_cell  x_aq_lsu_fof_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (abnormal_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (abnormal_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @580
//          .external_en (1'b0), @581
//          .global_en   (1'b1), @582
//          .module_en   (cp0_vpu_icg_en), @583
//          .local_en    (abnormal_clk_en), @584
//          .clk_out     (abnormal_clk)); @585

always@(posedge abnormal_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    fof_mask_ff <= 1'b0;
  else if (lsu_vlsu_data_vld && !lsu_inst_fls && lsu_split_last)
    fof_mask_ff <= 1'b0;
  else if (lsu_vl_update)
    fof_mask_ff <= 1'b1;
end

//================================================
//        fof vl update
//================================================
//for wb bypass, vl can update imm
//for segment,vl update should wait until vtb valid
assign vl_update      = 1'b0;
assign vl_upval[6:0]  = 7'b0;
assign sseg_vl_update = 1'b0;
// &Force("nonport","lsu_vl_upval"); @633

//================================================
//        EXPT HANDLER
//================================================
//for expt,should hold mark until flush
//used to write back original value after expt

always@(posedge abnormal_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    expt_ff <= 1'b0;
  else if (rtu_yy_xx_flush)
    expt_ff <= 1'b0;
  else if (lsu_data_vld && !lsu_inst_fls && lsu_expt_vld)
    expt_ff <= 1'b1;
end

assign abnormal_vld = lsu_data_vld
                      && !lsu_inst_fls
                      && (lsu_vl_update || lsu_expt_vld);

assign abnormal_ff  = fof_mask_ff || expt_ff;

assign abnormal_data_mask = abnormal_ff && sseg_active;
//================================================
//        vlsu full generate
//================================================
assign sseg_next_inst = (round_bit[1:0] != lsu_dc_split_cnt[9:8]);

assign sseg_full = sseg_merge_start
                   && !(sseg_abnormal_idle && !sseg_next_inst)
                   && (sseg_active
                       || lsu_dc_fof
                          && !vlsu_fof_vld 
                       || vlsu_split_cnt0_vld 
                       || vlsu_split_cnt1_vld);

assign split_cnt_dis0[8:0] = {1'b0,vlsu_split_cnt0[7:0]} + {1'b0,~lsu_dc_split_cnt[7:0]};

assign cnt0_gt_dc = split_cnt_dis0[8]; 
assign cnt0_eq_dc = !split_cnt_dis0[8] && &split_cnt_dis0[7:0];

assign split_cnt_dis1[8:0] = {1'b0,vlsu_split_cnt1[7:0]} + {1'b0,~lsu_dc_split_cnt[7:0]};

assign cnt1_gt_dc = split_cnt_dis1[8]; 
assign cnt1_eq_dc = !split_cnt_dis1[8] && &split_cnt_dis1[7:0];  

//use split cnt to sync with lsu
//the highest bit of cnt is round bit, which distinguishing different inst
//lsu can pipe with all following condition
//1.lsu cnt <= vlsu cnt
//2.vlsu round bit == lsu_round bit
assign vlsu_vtb_ready = lsu_dc_create
                        && (vlsu_split_cnt0_vld
                               && (vlsu_split_cnt0[9:8] == lsu_dc_split_cnt[9:8])
                               && (cnt0_eq_dc || cnt0_gt_dc && !lsu_dc_nf[2])
                            || vlsu_split_cnt1_vld
                               && (vlsu_split_cnt1[9:8] == lsu_dc_split_cnt[9:8])
                               && (cnt1_eq_dc || cnt1_gt_dc && !lsu_dc_nf[2]));
//================================================
//        output interface
//================================================
// &Force("output","sseg_nf"); @697
//for vtb
assign if_vlsu_vls_wb_vld             = lsu_wb_vld;
assign if_vlsu_vls_wb_abnormal        = (abnormal_vld || abnormal_ff) && !sseg_active;
assign if_vlsu_vls_wb_data[`LSU_DATAW-1:0] = merge_data[`LSU_DATAW-1:0];
assign if_vlsu_vls_wb_bytes_vld[`LSU_BYTEW-1:0]  = lsu_wb_bytes_vld[`LSU_BYTEW-1:0];

assign if_vlsu_merge_vld              = lsu_merge_vld;
assign if_vlsu_merge_data[`LSU_DATAW-1:0]  = data_write[`LSU_DATAW-1:0];

assign if_vlsu_sel0[3:0] = sel0[3:0]; 
assign if_vlsu_sel1[3:0] = sel1[3:0]; 
assign if_vlsu_sel2[3:0] = sel2[3:0]; 
assign if_vlsu_sel3[3:0] = sel3[3:0]; 

assign if_vlsu_fls_wb_vld       = lsu_vlsu_data_vld && lsu_inst_fls && !lsu_expt_vld;
assign if_vlsu_fls_reg[4:0]     = lsu_dest_reg[4:0];
assign if_vlsu_fls_data[63:0]   = lsu_data[63:0];

assign if_vlsu_fwd_done         = fwd_next;

assign sseg_vld     = sseg_active;
assign sseg_fwd_vld = sseg_fwd_active; 
assign sseg_fwd_last= last_merge;
assign sseg_wb_vld  = sseg_wb_active && sseg_vtb_all_vld;

assign sseg_abnormal_vld= sseg_expt_active;
assign sseg_split_pause = sseg_expt_active || sseg_abnormal_idle && (vlsu_vtb_round_bit[1:0] != round_bit[1:0]); 

assign sseg_nf[2:0]  = nf[2:0]; 

//---------fof----------
assign if_vlsu_vl_update     = vl_update;
assign if_vlsu_vl_upval[6:0] = vl_upval[6:0];

//for lsu
assign vlsu_lsu_data_vld              = lsu_fwd_vld;
assign vlsu_lsu_data_shift[3:0]       = fwd_data_shift[3:0];
assign vlsu_lsu_wdata[`LSU_DATAW-1:0] = fwd_data[`LSU_DATAW-1:0];
assign vlsu_lsu_src2_depd             = !fwd_data_ready; 
assign vlsu_lsu_src2_reg[4:0]         = vlsu_reg_src2_reg[4:0]; 

assign vlsu_lsu_fwd_vld             = vpu_vlsu_fp_wb_vld;
assign vlsu_lsu_fwd_dest_reg[4:0]   = vpu_vlsu_fp_wb_reg[4:0];
assign vlsu_lsu_fwd_data[63:0]      = vpu_vlsu_fp_wb_data[63:0];


assign vlsu_buf_stall = sseg_full
                        || lsu_dc_create
                           && !sseg_start_type 
                           && !vlsu_vtb_ready
                        || vlsu_fld_stall;

//---------dtif-----------
assign vlsu_dtu_data_vld      = lsu_fwd_vld && fwd_data_ready && !lsu_fwd_done;
assign vlsu_dtu_data_vld_gate = lsu_fwd_vld; 
assign vlsu_dtu_data[63:0]    = fwd_data[63:0];
                        


// &ModuleEnd; @786
endmodule


