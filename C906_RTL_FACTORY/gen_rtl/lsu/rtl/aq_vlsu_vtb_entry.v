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
module aq_vlsu_vtb_entry(
  cp0_vpu_icg_en,
  cpurst_b,
  forever_cpuclk,
  fwd_vld_x,
  if_vlsu_fls_data,
  if_vlsu_fls_reg,
  if_vlsu_fls_wb_vld,
  lsu_wen_data_entry_v,
  lsu_wen_entry_v,
  pad_yy_icg_scan_en,
  round_bit,
  rtu_yy_xx_flush,
  sseg_abnormal_vld,
  sseg_wb_vld,
  vlsu_create_data_v,
  vlsu_create_ele_cnt,
  vlsu_create_fls,
  vlsu_create_fof_vld,
  vlsu_create_mask,
  vlsu_create_mask_ext,
  vlsu_create_seq_last,
  vlsu_create_st_type_x,
  vlsu_create_vl_mask,
  vlsu_create_vld_x,
  vlsu_create_vreg,
  vlsu_create_wready,
  vlsu_sseg_create,
  vlsu_warm_up,
  vpu_vlsu_fp_wb_data,
  vpu_vlsu_fp_wb_reg,
  vpu_vlsu_fp_wb_vld,
  vtb_entry_all_wb_x,
  vtb_entry_data_v,
  vtb_entry_fls_x,
  vtb_entry_fof_vld_x,
  vtb_entry_seq_last_x,
  vtb_entry_split_cnt_v,
  vtb_entry_split_cnt_vld_x,
  vtb_entry_st_fwd_fp_bus_x,
  vtb_entry_st_fwd_vld_x,
  vtb_entry_st_vld_x,
  vtb_entry_vl_mask_v,
  vtb_entry_vld_x,
  vtb_entry_vload_vld_x,
  vtb_entry_vm_mask_v,
  vtb_entry_vreg_v,
  vtb_entry_wb_ready_x,
  vtb_entry_wb_vld_x,
  vtb_entry_wdata_ready_x,
  vtb_entry_wdata_vld_x,
  wb_vld_x
);

// &Ports; @21
input           cp0_vpu_icg_en;           
input           cpurst_b;                 
input           forever_cpuclk;           
input           fwd_vld_x;                
input   [63:0]  if_vlsu_fls_data;         
input   [4 :0]  if_vlsu_fls_reg;          
input           if_vlsu_fls_wb_vld;       
input   [63:0]  lsu_wen_data_entry_v;     
input   [3 :0]  lsu_wen_entry_v;          
input           pad_yy_icg_scan_en;       
input   [1 :0]  round_bit;                
input           rtu_yy_xx_flush;          
input           sseg_abnormal_vld;        
input           sseg_wb_vld;              
input   [63:0]  vlsu_create_data_v;       
input   [7 :0]  vlsu_create_ele_cnt;      
input           vlsu_create_fls;          
input           vlsu_create_fof_vld;      
input   [7 :0]  vlsu_create_mask;         
input   [63:0]  vlsu_create_mask_ext;     
input           vlsu_create_seq_last;     
input           vlsu_create_st_type_x;    
input   [7 :0]  vlsu_create_vl_mask;      
input           vlsu_create_vld_x;        
input   [6 :0]  vlsu_create_vreg;         
input           vlsu_create_wready;       
input           vlsu_sseg_create;         
input           vlsu_warm_up;             
input   [63:0]  vpu_vlsu_fp_wb_data;      
input   [4 :0]  vpu_vlsu_fp_wb_reg;       
input           vpu_vlsu_fp_wb_vld;       
input           wb_vld_x;                 
output          vtb_entry_all_wb_x;       
output  [63:0]  vtb_entry_data_v;         
output          vtb_entry_fls_x;          
output          vtb_entry_fof_vld_x;      
output          vtb_entry_seq_last_x;     
output  [9 :0]  vtb_entry_split_cnt_v;    
output          vtb_entry_split_cnt_vld_x; 
output          vtb_entry_st_fwd_fp_bus_x; 
output          vtb_entry_st_fwd_vld_x;   
output          vtb_entry_st_vld_x;       
output  [7 :0]  vtb_entry_vl_mask_v;      
output          vtb_entry_vld_x;          
output          vtb_entry_vload_vld_x;    
output  [7 :0]  vtb_entry_vm_mask_v;      
output  [6 :0]  vtb_entry_vreg_v;         
output          vtb_entry_wb_ready_x;     
output          vtb_entry_wb_vld_x;       
output          vtb_entry_wdata_ready_x;  
output          vtb_entry_wdata_vld_x;    

// &Regs; @22
reg     [7 :0]  entry_bytes_vld;          
reg     [63:0]  entry_data;               
reg             entry_fls;                
reg             entry_fof;                
reg     [7 :0]  entry_mask;               
reg             entry_ready;              
reg     [1 :0]  entry_round_bit;          
reg             entry_seq_last;           
reg     [7 :0]  entry_split_cnt;          
reg             entry_sseg_type;          
reg             entry_st;                 
reg     [7 :0]  entry_vl_mask;            
reg             entry_vld;                
reg     [6 :0]  entry_vreg;               

// &Wires; @23
wire            cp0_vpu_icg_en;           
wire            cpurst_b;                 
wire            entry_clk;                
wire            entry_clk_en;             
wire            entry_data0_clk;          
wire            entry_data0_clk_en;       
wire            entry_data1_clk;          
wire            entry_data1_clk_en;       
wire            entry_data2_clk;          
wire            entry_data2_clk_en;       
wire            entry_data3_clk;          
wire            entry_data3_clk_en;       
wire    [7 :0]  entry_mask_active;        
wire    [63:0]  entry_mask_ext;           
wire            forever_cpuclk;           
wire            fwd_vld;                  
wire            fwd_vld_x;                
wire    [63:0]  if_vlsu_fls_data;         
wire    [4 :0]  if_vlsu_fls_reg;          
wire            if_vlsu_fls_wb_vld;       
wire    [3 :0]  lsu_wen;                  
wire    [63:0]  lsu_wen_data;             
wire    [63:0]  lsu_wen_data_entry_v;     
wire    [3 :0]  lsu_wen_entry_v;          
wire            lsu_wen_vld;              
wire            pad_yy_icg_scan_en;       
wire    [1 :0]  round_bit;                
wire            rtu_yy_xx_flush;          
wire            sseg_abnormal_vld;        
wire            sseg_wb_vld;              
wire            st_fwd_fp_bus;            
wire            st_fwd_lsu;               
wire            st_fwd_vld;               
wire            st_fwd_vld_gate;          
wire    [63:0]  vlsu_create_data;         
wire            vlsu_create_data0_vld;    
wire            vlsu_create_data1_vld;    
wire            vlsu_create_data2_vld;    
wire            vlsu_create_data3_vld;    
wire    [63:0]  vlsu_create_data_v;       
wire    [7 :0]  vlsu_create_ele_cnt;      
wire            vlsu_create_fls;          
wire            vlsu_create_fof_vld;      
wire    [7 :0]  vlsu_create_mask;         
wire    [63:0]  vlsu_create_mask_ext;     
wire            vlsu_create_ready;        
wire            vlsu_create_seq_last;     
wire            vlsu_create_st;           
wire            vlsu_create_st_type_x;    
wire    [7 :0]  vlsu_create_vl_mask;      
wire            vlsu_create_vld;          
wire            vlsu_create_vld_x;        
wire    [6 :0]  vlsu_create_vreg;         
wire            vlsu_create_wready;       
wire    [63:0]  vlsu_entry_data;          
wire    [63:0]  vlsu_entry_data_aft_mask; 
wire    [7 :0]  vlsu_entry_merge_mask;    
wire    [63:0]  vlsu_entry_merge_mask_ext; 
wire    [63:0]  vlsu_fwd_data;            
wire            vlsu_sseg_create;         
wire            vlsu_warm_up;             
wire    [63:0]  vpu_vlsu_fp_wb_data;      
wire    [4 :0]  vpu_vlsu_fp_wb_reg;       
wire            vpu_vlsu_fp_wb_vld;       
wire            vtb_entry_all_wb_x;       
wire    [63:0]  vtb_entry_data_v;         
wire            vtb_entry_fls_x;          
wire            vtb_entry_fof_vld_x;      
wire            vtb_entry_seq_last_x;     
wire    [9 :0]  vtb_entry_split_cnt_v;    
wire            vtb_entry_split_cnt_vld_x; 
wire            vtb_entry_st_fwd_fp_bus_x; 
wire            vtb_entry_st_fwd_vld_x;   
wire            vtb_entry_st_vld_x;       
wire    [7 :0]  vtb_entry_vl_mask_v;      
wire            vtb_entry_vld_x;          
wire            vtb_entry_vload_vld_x;    
wire    [7 :0]  vtb_entry_vm_mask_v;      
wire    [6 :0]  vtb_entry_vreg_v;         
wire            vtb_entry_wb_ready_x;     
wire            vtb_entry_wb_vld_x;       
wire            vtb_entry_wdata_ready_x;  
wire            vtb_entry_wdata_vld_x;    
wire            wb_vld;                   
wire            wb_vld_x;                 


parameter BYTE = 2'b00;
parameter HALF = 2'b01;
parameter WORD = 2'b10;

//================================================
//        input interface
//================================================
// &Force("bus","vlsu_entry_data",`LSU_DATAW-1,0); @32
// &Force("bus","vlsu_create_mask_ext",`LSU_DATAW-1,0); @33
// &Force("bus","vlsu_fwd_data",63,0); @34

assign lsu_wen[3:0]            = lsu_wen_entry_v[3:0];
assign lsu_wen_data[`LSU_DATAW-1:0] = lsu_wen_data_entry_v[`LSU_DATAW-1:0];

assign vlsu_create_vld             = vlsu_create_vld_x;
assign vlsu_create_st              = vlsu_create_st_type_x;
assign vlsu_create_ready           = vlsu_create_wready && vlsu_create_st;
assign vlsu_create_data[`LSU_DATAW-1:0] = vlsu_create_data_v[`LSU_DATAW-1:0];

assign wb_vld  = wb_vld_x;
assign fwd_vld = fwd_vld_x;
//================================================
//        ICG
//================================================
//------------for low power----------------------
assign lsu_wen_vld = |lsu_wen[3:0];

assign vlsu_create_data0_vld = vlsu_create_vld;
assign vlsu_create_data1_vld = vlsu_create_vld;

assign vlsu_create_data2_vld = vlsu_create_vld;
assign vlsu_create_data3_vld = vlsu_create_vld;
//------------instance---------------------------
assign entry_clk_en = entry_vld || vlsu_create_vld || lsu_wen_vld || vlsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_vtb_entry_gated_clk"); @65
gated_clk_cell  x_aq_lsu_vtb_entry_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (entry_clk_en      ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @66
//          .external_en (1'b0), @67
//          .global_en   (1'b1), @68
//          .module_en   (cp0_vpu_icg_en), @69
//          .local_en    (entry_clk_en), @70
//          .clk_out     (entry_clk)); @71

assign entry_data0_clk_en = vlsu_create_data0_vld || st_fwd_vld_gate || lsu_wen[0] || vlsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_vtb_entry_data0_gated_clk"); @75
gated_clk_cell  x_aq_lsu_vtb_entry_data0_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_data0_clk   ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (entry_data0_clk_en),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @76
//          .external_en (1'b0), @77
//          .global_en   (1'b1), @78
//          .module_en   (cp0_vpu_icg_en), @79
//          .local_en    (entry_data0_clk_en), @80
//          .clk_out     (entry_data0_clk)); @81

assign entry_data1_clk_en = vlsu_create_data1_vld || st_fwd_vld_gate || lsu_wen[1] || vlsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_vtb_entry_data1_gated_clk"); @85
gated_clk_cell  x_aq_lsu_vtb_entry_data1_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_data1_clk   ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (entry_data1_clk_en),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @86
//          .external_en (1'b0), @87
//          .global_en   (1'b1), @88
//          .module_en   (cp0_vpu_icg_en), @89
//          .local_en    (entry_data1_clk_en), @90
//          .clk_out     (entry_data1_clk)); @91

assign entry_data2_clk_en = vlsu_create_data2_vld || st_fwd_vld_gate || lsu_wen[2] || vlsu_warm_up;

// &Instance("gated_clk_cell", "x_aq_lsu_vtb_entry_data2_gated_clk"); @99
gated_clk_cell  x_aq_lsu_vtb_entry_data2_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_data2_clk   ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (entry_data2_clk_en),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @100
//          .external_en (1'b0), @101
//          .global_en   (1'b1), @102
//          .module_en   (cp0_vpu_icg_en), @103
//          .local_en    (entry_data2_clk_en), @104
//          .clk_out     (entry_data2_clk)); @105

assign entry_data3_clk_en = vlsu_create_data3_vld || st_fwd_vld_gate || lsu_wen[3] || vlsu_warm_up;

// &Instance("gated_clk_cell", "x_aq_lsu_vtb_entry_data3_gated_clk"); @113
gated_clk_cell  x_aq_lsu_vtb_entry_data3_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_data3_clk   ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (entry_data3_clk_en),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @114
//          .external_en (1'b0), @115
//          .global_en   (1'b1), @116
//          .module_en   (cp0_vpu_icg_en), @117
//          .local_en    (entry_data3_clk_en), @118
//          .clk_out     (entry_data3_clk)); @119
//================================================
//        entry
//================================================
always@(posedge entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    entry_vld  <= 1'b0;
  else if (wb_vld || fwd_vld || rtu_yy_xx_flush)
    entry_vld  <= 1'b0;
  else if (vlsu_create_vld)
    entry_vld  <= 1'b1;
end

always@(posedge entry_data0_clk)
begin
  if (vlsu_create_data0_vld || vlsu_warm_up)
    entry_data[`VLSU_BLKW-1:0]  <= vlsu_entry_data[`VLSU_BLKW-1:0];
  else if (st_fwd_vld)
    entry_data[`VLSU_BLKW-1:0]  <= vlsu_fwd_data[`VLSU_BLKW-1:0];
  else if (lsu_wen[0])
    entry_data[`VLSU_BLKW-1:0]  <= lsu_wen_data[`VLSU_BLKW-1:0] & entry_mask_ext[`VLSU_BLKW-1:0]
                                   | entry_data[`VLSU_BLKW-1:0] & ~entry_mask_ext[`VLSU_BLKW-1:0];
end

always@(posedge entry_data1_clk)
begin
  if (vlsu_create_data1_vld || vlsu_warm_up)
    entry_data[2*`VLSU_BLKW-1:`VLSU_BLKW] <= vlsu_entry_data[2*`VLSU_BLKW-1:`VLSU_BLKW];
  else if (st_fwd_vld)
    entry_data[2*`VLSU_BLKW-1:`VLSU_BLKW] <= vlsu_fwd_data[2*`VLSU_BLKW-1:`VLSU_BLKW];
  else if (lsu_wen[1])
    entry_data[2*`VLSU_BLKW-1:`VLSU_BLKW] <= lsu_wen_data[2*`VLSU_BLKW-1:`VLSU_BLKW] & entry_mask_ext[2*`VLSU_BLKW-1:`VLSU_BLKW]
                                             | entry_data[2*`VLSU_BLKW-1:`VLSU_BLKW] & ~entry_mask_ext[2*`VLSU_BLKW-1:`VLSU_BLKW];
end

always@(posedge entry_data2_clk)
begin
  if (vlsu_create_data2_vld || vlsu_warm_up)
    entry_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] <= vlsu_entry_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW];
  else if (st_fwd_vld)
    entry_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] <= vlsu_fwd_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW];
  else if (lsu_wen[2])
    entry_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] <= lsu_wen_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] & entry_mask_ext[3*`VLSU_BLKW-1:2*`VLSU_BLKW]
                                               | entry_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] & ~entry_mask_ext[3*`VLSU_BLKW-1:2*`VLSU_BLKW];
end

always@(posedge entry_data3_clk)
begin
  if (vlsu_create_data3_vld || vlsu_warm_up)
    entry_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] <= vlsu_entry_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW];
  else if (st_fwd_vld)
    entry_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] <= vlsu_fwd_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW];
  else if (lsu_wen[3])
    entry_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] <= lsu_wen_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] & entry_mask_ext[4*`VLSU_BLKW-1:3*`VLSU_BLKW]
                                               | entry_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] & ~entry_mask_ext[4*`VLSU_BLKW-1:3*`VLSU_BLKW];
end
//-------------entry create data sel-----------------
assign entry_mask_active[`LSU_BYTEW-1:0]     = entry_vld && !entry_ready
                                          ? entry_mask[`LSU_BYTEW-1:0]
                                          : {`LSU_BYTEW{1'b1}};
assign vlsu_entry_merge_mask[`LSU_BYTEW-1:0] = entry_bytes_vld[`LSU_BYTEW-1:0] & vlsu_create_mask[`LSU_BYTEW-1:0];

assign entry_mask_ext[63:0]      = {{8{entry_mask_active[7]}},{8{entry_mask_active[6]}},
                                    {8{entry_mask_active[5]}},{8{entry_mask_active[4]}},
                                    {8{entry_mask_active[3]}},{8{entry_mask_active[2]}},
                                    {8{entry_mask_active[1]}},{8{entry_mask_active[0]}}};

assign vlsu_entry_merge_mask_ext[63:0] = {{8{vlsu_entry_merge_mask[7]}},{8{vlsu_entry_merge_mask[6]}},
                                          {8{vlsu_entry_merge_mask[5]}},{8{vlsu_entry_merge_mask[4]}},
                                          {8{vlsu_entry_merge_mask[3]}},{8{vlsu_entry_merge_mask[2]}},
                                          {8{vlsu_entry_merge_mask[1]}},{8{vlsu_entry_merge_mask[0]}}};

assign vlsu_entry_data_aft_mask[`LSU_DATAW-1:0] = vlsu_create_data[`LSU_DATAW-1:0] & ~vlsu_entry_merge_mask_ext[`LSU_DATAW-1:0]
                                             | entry_data[`LSU_DATAW-1:0] & vlsu_entry_merge_mask_ext[`LSU_DATAW-1:0];

assign vlsu_entry_data[`VLSU_BLKW-1:0] = lsu_wen[0]
                                   ? vlsu_create_data[`VLSU_BLKW-1:0] & ~vlsu_create_mask_ext[`VLSU_BLKW-1:0]
                                     | lsu_wen_data[`VLSU_BLKW-1:0] & vlsu_create_mask_ext[`VLSU_BLKW-1:0]
                                   : vlsu_entry_data_aft_mask[`VLSU_BLKW-1:0];

assign vlsu_entry_data[2*`VLSU_BLKW-1:`VLSU_BLKW] = lsu_wen[1]
                                        ? vlsu_create_data[2*`VLSU_BLKW-1:`VLSU_BLKW] & ~vlsu_create_mask_ext[2*`VLSU_BLKW-1:`VLSU_BLKW]
                                          | lsu_wen_data[2*`VLSU_BLKW-1:`VLSU_BLKW] & vlsu_create_mask_ext[2*`VLSU_BLKW-1:`VLSU_BLKW]
                                        : vlsu_entry_data_aft_mask[2*`VLSU_BLKW-1:`VLSU_BLKW];

assign vlsu_entry_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] = lsu_wen[2]
                                          ? vlsu_create_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] & ~vlsu_create_mask_ext[3*`VLSU_BLKW-1:2*`VLSU_BLKW]
                                            | lsu_wen_data[3*`VLSU_BLKW-1:2*`VLSU_BLKW] & vlsu_create_mask_ext[3*`VLSU_BLKW-1:2*`VLSU_BLKW]
                                          : vlsu_entry_data_aft_mask[3*`VLSU_BLKW-1:2*`VLSU_BLKW];

assign vlsu_entry_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] = lsu_wen[3]
                                          ? vlsu_create_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] & ~vlsu_create_mask_ext[4*`VLSU_BLKW-1:3*`VLSU_BLKW]
                                            | lsu_wen_data[4*`VLSU_BLKW-1:3*`VLSU_BLKW] & vlsu_create_mask_ext[4*`VLSU_BLKW-1:3*`VLSU_BLKW]
                                          : vlsu_entry_data_aft_mask[4*`VLSU_BLKW-1:3*`VLSU_BLKW];

//-------------entry merge info-----------------
always@(posedge entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    entry_mask[`LSU_BYTEW-1:0]    <= {`LSU_BYTEW{1'b1}};
    entry_vl_mask[`LSU_BYTEW-1:0] <= {`LSU_BYTEW{1'b1}};
  end
  else if (wb_vld)
  begin
    entry_mask[`LSU_BYTEW-1:0]    <= {`LSU_BYTEW{1'b1}};
    entry_vl_mask[`LSU_BYTEW-1:0] <= {`LSU_BYTEW{1'b1}};
  end
  else if (vlsu_create_vld)
  begin
    entry_mask[`LSU_BYTEW-1:0]    <= vlsu_create_mask[`LSU_BYTEW-1:0];
    entry_vl_mask[`LSU_BYTEW-1:0] <= vlsu_create_vl_mask[`LSU_BYTEW-1:0];
  end
end

always@(posedge entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    entry_bytes_vld[`LSU_BYTEW-1:0] <= {`LSU_BYTEW{1'b0}};
  else if (wb_vld)
    entry_bytes_vld[`LSU_BYTEW-1:0] <= {{`LSU_BYTEW/4{lsu_wen[3]}},{`LSU_BYTEW/4{lsu_wen[2]}},{`LSU_BYTEW/4{lsu_wen[1]}},{`LSU_BYTEW/4{lsu_wen[0]}}};
  else if (lsu_wen_vld)
    entry_bytes_vld[`LSU_BYTEW-1:0] <= {{`LSU_BYTEW/4{lsu_wen[3]}},{`LSU_BYTEW/4{lsu_wen[2]}},{`LSU_BYTEW/4{lsu_wen[1]}},{`LSU_BYTEW/4{lsu_wen[0]}}}
                                  | entry_bytes_vld[`LSU_BYTEW-1:0];
end
//-------------other info-----------------
always@(posedge entry_clk)
begin
  if (vlsu_create_vld || vlsu_warm_up)
    entry_vreg[6:0] <= vlsu_create_vreg[6:0];
end

always@(posedge entry_clk)
begin
  if (vlsu_create_vld || vlsu_warm_up)
    entry_st <= vlsu_create_st;
end

always@(posedge entry_clk)
begin
  if (vlsu_create_vld || vlsu_warm_up)
    entry_fls <= vlsu_create_fls;
end

always@(posedge entry_clk)
begin
  if (vlsu_create_vld || vlsu_warm_up)
    entry_sseg_type <= vlsu_sseg_create;
end

always@(posedge entry_clk)
begin
  if (vlsu_create_vld || vlsu_warm_up)
    entry_ready <= vlsu_create_ready;
  else if (st_fwd_vld || sseg_wb_vld || sseg_abnormal_vld)
    entry_ready <= 1'b1;
end

//ready logic
assign st_fwd_lsu = if_vlsu_fls_wb_vld
                    && (if_vlsu_fls_reg[4:0] == entry_vreg[6:2]);

assign st_fwd_fp_bus = vpu_vlsu_fp_wb_vld
                       && (vpu_vlsu_fp_wb_reg[4:0] == entry_vreg[6:2]);

assign st_fwd_vld_gate = entry_vld 
                         && entry_st
                         && entry_fls
                         && !entry_ready;

assign st_fwd_vld = entry_vld 
                    && entry_st
                    && entry_fls
                    && !entry_ready
                    && (st_fwd_lsu || st_fwd_fp_bus);

assign vlsu_fwd_data[63:0] = st_fwd_fp_bus
                             ? vpu_vlsu_fp_wb_data[63:0]
                             : if_vlsu_fls_data[63:0];

//-------------fof logic-----------------
always@(posedge entry_clk)
begin
  if (vlsu_create_vld || vlsu_warm_up)
    entry_fof <= vlsu_create_fof_vld;
end

//-------------split cnt-----------------
always@(posedge entry_clk)
begin
  if (vlsu_create_vld || vlsu_warm_up)
    entry_split_cnt[7:0] <= vlsu_create_ele_cnt[7:0];
end

always@(posedge entry_clk)
begin
  if (vlsu_create_vld || vlsu_warm_up)
    entry_round_bit[1:0] <= round_bit[1:0];
end
//-------------split last-----------------
always@(posedge entry_clk)
begin
  if (vlsu_create_vld || vlsu_warm_up)
    entry_seq_last <= vlsu_create_seq_last;
end
//================================================
//        output interface
//================================================
assign vtb_entry_vld_x = entry_vld;

assign vtb_entry_st_vld_x      = entry_vld && entry_st;
assign vtb_entry_st_fwd_vld_x  = st_fwd_vld;
assign vtb_entry_st_fwd_fp_bus_x = st_fwd_fp_bus;
assign vtb_entry_fls_x           = entry_fls;
assign vtb_entry_wdata_ready_x   = entry_ready || st_fwd_vld;
assign vtb_entry_wdata_vld_x     = entry_vld && entry_st && entry_ready;
assign vtb_entry_wb_ready_x      = entry_vld && !entry_st && entry_ready;
assign vtb_entry_wb_vld_x        = entry_vld && !entry_st && (entry_ready || sseg_wb_vld);
assign vtb_entry_all_wb_x        = !(entry_vld && !entry_st);
assign vtb_entry_vload_vld_x     = entry_vld && !entry_st && !entry_fls;
assign vtb_entry_split_cnt_vld_x = entry_vld && !entry_st && !entry_fls && !entry_sseg_type; 

assign vtb_entry_data_v[`LSU_DATAW-1:0]   = entry_data[`LSU_DATAW-1:0];
assign vtb_entry_vreg_v[6:0]          = entry_vreg[6:0];
assign vtb_entry_vl_mask_v[`LSU_BYTEW-1:0] = entry_vl_mask[`LSU_BYTEW-1:0];
assign vtb_entry_vm_mask_v[`LSU_BYTEW-1:0] = entry_mask[`LSU_BYTEW-1:0];

assign vtb_entry_fof_vld_x       = entry_vld && entry_fof;

assign vtb_entry_seq_last_x     = entry_seq_last;
assign vtb_entry_split_cnt_v[9:0] = {entry_round_bit[1:0],entry_split_cnt[7:0]};

// &ModuleEnd; @402
endmodule


