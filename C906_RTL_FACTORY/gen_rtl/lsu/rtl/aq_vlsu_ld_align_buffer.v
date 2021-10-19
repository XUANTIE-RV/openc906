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
module aq_vlsu_ld_align_buffer(
  ab_vld,
  abnormal_ff,
  cp0_vpu_icg_en,
  cpurst_b,
  data_read,
  forever_cpuclk,
  lsu_bytes_vld,
  lsu_data,
  lsu_data_vld,
  lsu_expt_vld,
  lsu_inst_fls,
  lsu_merge_vld,
  lsu_vl_update,
  lsu_wb_bytes_vld,
  lsu_wb_vld,
  merge_data,
  pad_yy_icg_scan_en,
  rtu_yy_xx_flush,
  sseg_active,
  sseg_expt_merge,
  sseg_expt_merge_gate,
  sseg_nf3_part,
  vlsu_warm_up
);

// &Ports; @21
input           abnormal_ff;           
input           cp0_vpu_icg_en;        
input           cpurst_b;              
input   [63:0]  data_read;             
input           forever_cpuclk;        
input   [7 :0]  lsu_bytes_vld;         
input   [63:0]  lsu_data;              
input           lsu_data_vld;          
input           lsu_expt_vld;          
input           lsu_inst_fls;          
input           lsu_vl_update;         
input           pad_yy_icg_scan_en;    
input           rtu_yy_xx_flush;       
input           sseg_active;           
input           sseg_expt_merge;       
input           sseg_expt_merge_gate;  
input           sseg_nf3_part;         
input           vlsu_warm_up;          
output          ab_vld;                
output          lsu_merge_vld;         
output  [7 :0]  lsu_wb_bytes_vld;      
output          lsu_wb_vld;            
output  [63:0]  merge_data;            

// &Regs; @22
reg     [7 :0]  ab_rot;                
reg     [7 :0]  ab_rot_create;         
reg     [7 :0]  bytes_aft_rot;         
reg     [7 :0]  bytes_vld;             
reg     [7 :0]  bytes_vld_for_abnormal; 
reg     [63:0]  data;                  
reg     [7 :0]  data_overflow;         
reg             overflow_ff;           
reg             wb_for_full;           

// &Wires; @23
wire            ab_bytes_up;           
wire            ab_create_vld;         
wire            ab_data_up;            
wire            ab_vld;                
wire            abnormal_ff;           
wire    [63:0]  abnormal_merge_data;   
wire            align_clk;             
wire            align_clk_en;          
wire            align_data_clk;        
wire            align_data_clk_en;     
wire            align_overflow_clk;    
wire            align_overflow_clk_en; 
wire    [7 :0]  byte_overflow_next;    
wire    [7 :0]  bytes_create;          
wire    [7 :0]  bytes_merge;           
wire    [7 :0]  bytes_next;            
wire    [7 :0]  bytes_ori;             
wire    [63:0]  bytes_vld_ext;         
wire            cp0_vpu_icg_en;        
wire            cpurst_b;              
wire    [63:0]  data_aft_rot;          
wire    [63:0]  data_create;           
wire    [63:0]  data_merge;            
wire    [63:0]  data_next;             
wire            data_normal_vld;       
wire    [63:0]  data_ori;              
wire    [63:0]  data_overflow_next;    
wire    [63:0]  data_read;             
wire            data_vld;              
wire            forever_cpuclk;        
wire            lsu_abnormal_vld;      
wire    [7 :0]  lsu_bytes_vld;         
wire    [63:0]  lsu_data;              
wire            lsu_data_vld;          
wire            lsu_expt_vld;          
wire            lsu_inst_fls;          
wire            lsu_merge_vld;         
wire            lsu_vl_update;         
wire    [7 :0]  lsu_wb_bytes_vld;      
wire            lsu_wb_ready;          
wire            lsu_wb_vld;            
wire    [63:0]  merge_data;            
wire            nf3;                   
wire            overflow_vld;          
wire            pad_yy_icg_scan_en;    
wire            rtu_yy_xx_flush;       
wire            sseg_abnormal_merge;   
wire            sseg_active;           
wire            sseg_expt_merge;       
wire            sseg_expt_merge_gate;  
wire            sseg_merge;            
wire    [63:0]  sseg_merge_data;       
wire            sseg_nf3_part;         
wire            vlsu_warm_up;          
wire            wb_ready;              


parameter BYTE = 2'b00;
parameter HALF = 2'b01;
parameter WORD = 2'b10;

//================================================
//        input interface
//================================================
assign data_vld                  = lsu_data_vld && !lsu_inst_fls;
assign data_ori[`LSU_DATAW-1:0]  = lsu_data[`LSU_DATAW-1:0]; 
assign bytes_ori[`LSU_BYTEW-1:0] = {`LSU_BYTEW{data_normal_vld}} & lsu_bytes_vld[`LSU_BYTEW-1:0];

assign lsu_abnormal_vld = lsu_vl_update || lsu_expt_vld;
assign data_normal_vld  = data_vld 
                          && !(sseg_active && lsu_abnormal_vld);

assign sseg_abnormal_merge   = sseg_expt_merge;
assign sseg_merge_data[`LSU_DATAW-1:0] = data_read[`LSU_DATAW-1:0]; 
//================================================
//        control
//================================================
assign ab_create_vld = data_normal_vld 
                       && (!wb_ready
                           || nf3
                           || ab_vld);

assign ab_data_up  = ab_create_vld || wb_ready && nf3; 

assign ab_bytes_up = data_normal_vld || wb_ready;
//================================================
//        ICG
//================================================
assign align_clk_en = data_vld || ab_vld || vlsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_align_buffer_gated_clk"); @58
gated_clk_cell  x_aq_lsu_align_buffer_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (align_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (align_clk_en      ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @59
//          .external_en (1'b0), @60
//          .global_en   (1'b1), @61
//          .module_en   (cp0_vpu_icg_en), @62
//          .local_en    (align_clk_en), @63
//          .clk_out     (align_clk)); @64

assign align_data_clk_en = ab_data_up || sseg_expt_merge_gate ||  vlsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_align_buffer_data_gated_clk"); @68
gated_clk_cell  x_aq_lsu_align_buffer_data_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (align_data_clk    ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (align_data_clk_en ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @69
//          .external_en (1'b0), @70
//          .global_en   (1'b1), @71
//          .module_en   (cp0_vpu_icg_en), @72
//          .local_en    (align_data_clk_en), @73
//          .clk_out     (align_data_clk)); @74

assign align_overflow_clk_en = overflow_vld || overflow_ff ||  vlsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_align_buffer_overflow_gated_clk"); @78
gated_clk_cell  x_aq_lsu_align_buffer_overflow_gated_clk (
  .clk_in                (forever_cpuclk       ),
  .clk_out               (align_overflow_clk   ),
  .external_en           (1'b0                 ),
  .global_en             (1'b1                 ),
  .local_en              (align_overflow_clk_en),
  .module_en             (cp0_vpu_icg_en       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   )
);

// &Connect(.clk_in      (forever_cpuclk), @79
//          .external_en (1'b0), @80
//          .global_en   (1'b1), @81
//          .module_en   (cp0_vpu_icg_en), @82
//          .local_en    (align_overflow_clk_en), @83
//          .clk_out     (align_overflow_clk));   @84
//================================================
//      data rot
//================================================
// &CombBeg; @101
// &CombEnd; @121
always@(posedge align_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ab_rot[7:0] <= 8'h01;
  else if (rtu_yy_xx_flush)
    ab_rot[7:0] <= 8'h01;
  else if (sseg_abnormal_merge)
    ab_rot[7:0] <= nf3 ? 8'h40 : 8'h01;
  else if(ab_bytes_up)
    ab_rot[7:0] <= ab_rot_create[7:0];
end

// &CombBeg; @135
always @( ab_rot[7:0]
       or bytes_ori[7:0])
begin
case(ab_rot[7:0])
  8'h01:bytes_aft_rot[7:0] = bytes_ori[7:0];
  8'h02:bytes_aft_rot[7:0] = {bytes_ori[6:0],bytes_ori[7]};
  8'h04:bytes_aft_rot[7:0] = {bytes_ori[5:0],bytes_ori[7:6]};
  8'h08:bytes_aft_rot[7:0] = {bytes_ori[4:0],bytes_ori[7:5]};
  8'h10:bytes_aft_rot[7:0] = {bytes_ori[3:0],bytes_ori[7:4]};
  8'h20:bytes_aft_rot[7:0] = {bytes_ori[2:0],bytes_ori[7:3]};
  8'h40:bytes_aft_rot[7:0] = {bytes_ori[1:0],bytes_ori[7:2]};
  8'h80:bytes_aft_rot[7:0] = {bytes_ori[0],bytes_ori[7:1]};
  default: bytes_aft_rot[7:0] = {8{1'bx}};
endcase
// &CombEnd; @147
end


//rotate data
// &Instance("aq_vlsu_rot_data", "x_vlsu_ld_data_rot"); @152
aq_vlsu_rot_data  x_vlsu_ld_data_rot (
  .data_in      (data_ori    ),
  .data_out     (data_aft_rot),
  .rot_sel      (ab_rot      )
);

// &Connect(.rot_sel   (ab_rot       ), @153
//          .data_in   (data_ori     ), @154
//          .data_out  (data_aft_rot )); @155


assign bytes_merge[`LSU_BYTEW-1:0] = bytes_aft_rot[`LSU_BYTEW-1:0] | bytes_vld[`LSU_BYTEW-1:0]; 
assign bytes_next[`LSU_BYTEW-1:0]  = wb_ready
                                ? bytes_aft_rot[`LSU_BYTEW-1:0] & bytes_vld[`LSU_BYTEW-1:0]
                                : bytes_merge[`LSU_BYTEW-1:0];


assign data_merge[`LSU_DATAW-1:0] = data_aft_rot[`LSU_DATAW-1:0] & ~bytes_vld_ext[`LSU_DATAW-1:0]
                               | data[`LSU_DATAW-1:0] & bytes_vld_ext[`LSU_DATAW-1:0];

assign data_next[`LSU_DATAW-1:0] = wb_ready
                              ? data_aft_rot[`LSU_DATAW-1:0]
                              : data_merge[`LSU_DATAW-1:0];

//-----------------for write back---------------
assign nf3 = sseg_active && sseg_nf3_part;

assign sseg_merge = sseg_active;

//for timing, use another logic to select wb_ready for lsu_wb_vld(not for sseg)
//assign bytes_vld_full = &bytes_vld[7:0];
// &CombBeg; @179
// &CombEnd;       @199
// &CombBeg; @205
always @( lsu_bytes_vld[7:0]
       or ab_rot[7:0])
begin
case(ab_rot[7:0])
  8'h01:wb_for_full = lsu_bytes_vld[7];
  8'h02:wb_for_full = lsu_bytes_vld[6];
  8'h04:wb_for_full = lsu_bytes_vld[5];
  8'h08:wb_for_full = lsu_bytes_vld[4];
  8'h10:wb_for_full = lsu_bytes_vld[3];
  8'h20:wb_for_full = lsu_bytes_vld[2];
  8'h40:wb_for_full = lsu_bytes_vld[1];
  8'h80:wb_for_full = lsu_bytes_vld[0];
  default: wb_for_full = 1'bx;
endcase
// &CombEnd;       @217
end

assign wb_ready = nf3
                  ? &bytes_merge[5:0]
                  : &bytes_merge[7:0];                       

assign lsu_wb_ready =  wb_for_full;

//================================================
//        data path
//================================================
always@(posedge align_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    bytes_vld[7:0] <= 8'b0;
  else if (rtu_yy_xx_flush)
    bytes_vld[7:0] <= 8'b0;
  else if (sseg_abnormal_merge)
    bytes_vld[7:0] <= nf3 ? 8'h3f : 8'hff;
  else if (ab_bytes_up)
    bytes_vld[7:0] <= bytes_create[7:0];
end

assign bytes_vld_ext[63:0] = {{8{bytes_vld[7]}},{8{bytes_vld[6]}},
                              {8{bytes_vld[5]}},{8{bytes_vld[4]}},
                              {8{bytes_vld[3]}},{8{bytes_vld[2]}},
                              {8{bytes_vld[1]}},{8{bytes_vld[0]}}};

always@(posedge align_data_clk)
begin
  if (ab_data_up || vlsu_warm_up)
    data[`LSU_DATAW-1:0]  <= data_create[`LSU_DATAW-1:0];
  else if(sseg_abnormal_merge)
    data[`LSU_DATAW-1:0]  <= abnormal_merge_data[`LSU_DATAW-1:0];
end

// &Force("output","ab_vld"); @277
assign ab_vld = |bytes_vld[`LSU_BYTEW-1:0];
//-----------------create---------------
// &CombBeg; @293
// &CombEnd; @312
assign bytes_create[7:0] = wb_ready && nf3
                           ? overflow_ff
                             ? byte_overflow_next[7:0]
                             : {bytes_next[5:0],bytes_merge[7:6]}
                           : bytes_next[7:0];

assign data_create[63:0] = wb_ready && nf3
                           ? overflow_ff
                             ? data_overflow_next[63:0]
                             : {data_next[47:0],data_merge[63:48]}
                           : data_next[63:0];

// &CombBeg; @326
always @( bytes_create[7:0])
begin
casez(bytes_create[7:0])
  8'b01??????:ab_rot_create[7:0] = 8'h80;
  8'b001?????:ab_rot_create[7:0] = 8'h40;
  8'b0001????:ab_rot_create[7:0] = 8'h20;
  8'b00001???:ab_rot_create[7:0] = 8'h10;
  8'b000001??:ab_rot_create[7:0] = 8'h08;
  8'b0000001?:ab_rot_create[7:0] = 8'h04;
  8'b00000001:ab_rot_create[7:0] = 8'h02;
  default: ab_rot_create[7:0] = 8'h01;
endcase
// &CombEnd; @337
end
//--------------abnormal data merge--------------
assign abnormal_merge_data[`LSU_DATAW-1:0] = sseg_merge_data[`LSU_DATAW-1:0] & ~bytes_vld_ext[`LSU_DATAW-1:0]
                                             | data[`LSU_DATAW-1:0] & bytes_vld_ext[`LSU_DATAW-1:0];

//for fof/expt,should save current bytes_vld
always@(posedge align_clk)
begin
  if(wb_ready)
    bytes_vld_for_abnormal[`LSU_BYTEW-1:0]  <= {`LSU_BYTEW{1'b0}};
  else if (data_vld && lsu_abnormal_vld)
    bytes_vld_for_abnormal[`LSU_BYTEW-1:0]  <= bytes_vld[`LSU_BYTEW-1:0];
end

//================================================
//        nf3 corner
//================================================
//when bytes_vld = 7f and new bytes_vld = ff, data is overflowed
always@(posedge align_overflow_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  overflow_ff <= 1'b0;
  else if(overflow_vld)
  overflow_ff <= 1'b1;
  else
  overflow_ff <= 1'b0;
end

// &CombBeg; @380
// &CombEnd;    @387
// &CombBeg; @389
// &CombEnd;    @396
assign overflow_vld = nf3
                      && (bytes_vld[7:0] == 8'h7f)
                      && &bytes_ori[7:0];

always@(posedge align_overflow_clk)
begin
  if (overflow_vld || vlsu_warm_up)
    data_overflow[7:0]  <= data_ori[63:56];
end

assign byte_overflow_next[7:0]  = {bytes_ori[4:0],3'b111}; 
assign data_overflow_next[63:0] = {data_ori[39:0],data_overflow[7:0],data[63:48]};
//================================================
//        output interface
//================================================
assign lsu_wb_vld = lsu_wb_ready && !sseg_merge;

assign lsu_wb_bytes_vld[`LSU_BYTEW-1:0] = abnormal_ff
                                          ? bytes_vld_for_abnormal[`LSU_BYTEW-1:0]
                                          : bytes_vld[`LSU_BYTEW-1:0];

//for sseg,write to vtb first
assign lsu_merge_vld = wb_ready && sseg_merge; 

assign merge_data[`LSU_DATAW-1:0] = data_merge[`LSU_DATAW-1:0];


// &ModuleEnd; @427
endmodule


