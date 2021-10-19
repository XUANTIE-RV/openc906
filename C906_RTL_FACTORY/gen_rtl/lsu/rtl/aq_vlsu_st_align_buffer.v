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
module aq_vlsu_st_align_buffer(
  cp0_vpu_icg_en,
  cpurst_b,
  data_read,
  forever_cpuclk,
  fwd_data,
  fwd_data_ready,
  fwd_data_shift,
  fwd_next,
  last_merge,
  lsu_fwd_done,
  lsu_fwd_inst_size,
  lsu_fwd_rot,
  lsu_fwd_sew,
  lsu_fwd_vld,
  pad_yy_icg_scan_en,
  rtu_yy_xx_flush,
  sseg_active,
  sseg_nf3_part,
  vlsu_fwd_vld,
  vlsu_reg_data,
  vlsu_reg_fls,
  vlsu_reg_seq_last,
  vlsu_reg_wdata_ready,
  vlsu_warm_up
);

// &Ports; @21
input           cp0_vpu_icg_en;          
input           cpurst_b;                
input   [63:0]  data_read;               
input           forever_cpuclk;          
input           last_merge;              
input           lsu_fwd_done;            
input   [1 :0]  lsu_fwd_inst_size;       
input   [3 :0]  lsu_fwd_rot;             
input   [1 :0]  lsu_fwd_sew;             
input           pad_yy_icg_scan_en;      
input           rtu_yy_xx_flush;         
input           sseg_active;             
input           sseg_nf3_part;           
input           vlsu_fwd_vld;            
input   [63:0]  vlsu_reg_data;           
input           vlsu_reg_fls;            
input           vlsu_reg_seq_last;       
input           vlsu_reg_wdata_ready;    
input           vlsu_warm_up;            
output  [63:0]  fwd_data;                
output          fwd_data_ready;          
output  [3 :0]  fwd_data_shift;          
output          fwd_next;                
output          lsu_fwd_vld;             

// &Regs; @22
reg     [4 :0]  ab_rot;                  
reg             ab_seq_last;             
reg     [7 :0]  bytes_aft_rot;           
reg     [7 :0]  bytes_vld;               
reg     [63:0]  data;                    
reg     [63:0]  data_final;              
reg     [3 :0]  data_shift;              

// &Wires; @23
wire            ab_bytes_up;             
wire            ab_create_vld;           
wire            ab_create_vld_gate;      
wire    [4 :0]  ab_rot_create;           
wire            ab_vld;                  
wire            align_clk;               
wire            align_clk_en;            
wire            align_data_clk;          
wire            align_data_clk_en;       
wire    [7 :0]  bytes_create;            
wire    [7 :0]  bytes_merge_for_next;    
wire    [63:0]  bytes_merge_for_next_ext; 
wire    [7 :0]  bytes_next;              
wire    [63:0]  bytes_vld_ext;           
wire            cp0_vpu_icg_en;          
wire            cpurst_b;                
wire            cur_data_all_merged;     
wire    [3 :0]  cur_data_rem_cnt;        
wire    [3 :0]  cur_merge_cnt;           
wire            data_ack;                
wire    [63:0]  data_aft_ab;             
wire    [63:0]  data_aft_rot_for_next;   
wire    [63:0]  data_create;             
wire    [63:0]  data_merge;              
wire    [63:0]  data_merge_for_next;     
wire    [63:0]  data_ori;                
wire    [63:0]  data_read;               
wire            data_vld;                
wire            fls;                     
wire            forever_cpuclk;          
wire    [63:0]  fwd_data;                
wire            fwd_data_ready;          
wire    [3 :0]  fwd_data_shift;          
wire            fwd_done;                
wire            fwd_next;                
wire            fwd_vld;                 
wire            last_merge;              
wire            lsu_fwd_done;            
wire    [1 :0]  lsu_fwd_inst_size;       
wire    [3 :0]  lsu_fwd_rot;             
wire    [1 :0]  lsu_fwd_sew;             
wire            lsu_fwd_vld;             
wire    [1 :0]  mem_size;                
wire            nf3;                     
wire            nf3_all_merged;          
wire            nf3_first;               
wire            pad_yy_icg_scan_en;      
wire            part_fwd;                
wire    [4 :0]  rot;                     
wire    [4 :0]  rot_dis;                 
wire    [3 :0]  rot_ori;                 
wire    [7 :0]  rot_sel_for_next;        
wire            rtu_yy_xx_flush;         
wire            seq_last;                
wire    [1 :0]  sew;                     
wire            sseg_active;             
wire            sseg_nf3_part;           
wire            vlsu_fwd_vld;            
wire    [63:0]  vlsu_reg_data;           
wire            vlsu_reg_fls;            
wire            vlsu_reg_seq_last;       
wire            vlsu_reg_wdata_ready;    
wire            vlsu_warm_up;            


parameter BYTE = 2'b00;
parameter HALF = 2'b01;
parameter WORD = 2'b10;
parameter DWORD= 2'b11;

//================================================
//        input interface
//================================================
assign data_vld        = vlsu_fwd_vld;
assign data_ori[`LSU_DATAW-1:0] = sseg_active
                              ? data_read[`LSU_DATAW-1:0]
                              : vlsu_reg_data[`LSU_DATAW-1:0];
assign data_ack        = lsu_fwd_done;
assign rot_ori[3:0]    = lsu_fwd_rot[3:0];
assign mem_size[1:0]   = lsu_fwd_inst_size[1:0];
assign sew[1:0]        = lsu_fwd_sew[1:0];
assign seq_last        = sseg_active
                         ? last_merge
                         : vlsu_reg_seq_last;
assign fls             = sseg_active
                         ? 1'b0
                         : vlsu_reg_fls;   
//================================================
//        control
//================================================
assign fwd_done = fwd_vld && data_ack; 
//lsu rot offset
assign part_fwd = |rot_ori[2:0];
assign rot[4:0] = fwd_done
                  ? {1'b0,!part_fwd,rot_ori[2:0]}
                  : 5'b0;
//nf 3 read 48 bits one time
assign nf3 = sseg_active && sseg_nf3_part;

//nf3 first means first sseg read data and not ready for 64/128 bits
assign nf3_first = nf3 && !(&bytes_vld[7:6]);

assign ab_create_vld = data_vld
                       && !fls 
                       && (ab_vld
                           || nf3_first
                           || data_ack
                              && part_fwd);

assign ab_create_vld_gate = data_vld
                            && !fls 
                            && (ab_vld
                                || nf3_first
                                || part_fwd);

assign ab_bytes_up = ab_create_vld || fwd_done;
//================================================
//      ICG
//================================================
assign align_clk_en = data_vld || ab_vld || vlsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_align_buffer_gated_clk"); @92
gated_clk_cell  x_aq_lsu_align_buffer_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (align_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (align_clk_en      ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @93
//          .external_en (1'b0), @94
//          .global_en   (1'b1), @95
//          .module_en   (cp0_vpu_icg_en), @96
//          .local_en    (align_clk_en), @97
//          .clk_out     (align_clk)); @98

assign align_data_clk_en = ab_create_vld_gate || vlsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_align_buffer_data_gated_clk"); @102
gated_clk_cell  x_aq_lsu_align_buffer_data_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (align_data_clk    ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (align_data_clk_en ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @103
//          .external_en (1'b0), @104
//          .global_en   (1'b1), @105
//          .module_en   (cp0_vpu_icg_en), @106
//          .local_en    (align_data_clk_en), @107
//          .clk_out     (align_data_clk)); @108
//================================================
//      data rot
//================================================
always@(posedge align_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ab_rot[4:0] <= 5'b0;
  else if (rtu_yy_xx_flush)
    ab_rot[4:0] <= 5'b0;
  else if(ab_bytes_up)
    ab_rot[4:0] <= ab_rot_create[4:0];
end

//--------------rotate sel--------------------
//there one rotate for st align now
//only for next merge

//rotate data
assign bytes_vld_ext[63:0] = {{8{bytes_vld[7]}},{8{bytes_vld[6]}},
                              {8{bytes_vld[5]}},{8{bytes_vld[4]}},
                              {8{bytes_vld[3]}},{8{bytes_vld[2]}},
                              {8{bytes_vld[1]}},{8{bytes_vld[0]}}};

assign data_merge[`LSU_DATAW-1:0] = data_ori[`LSU_DATAW-1:0] & ~bytes_vld_ext[`LSU_DATAW-1:0]
                                    | data[`LSU_DATAW-1:0] & bytes_vld_ext[`LSU_DATAW-1:0];

//================================================
//        data for next merge
//================================================
// &Instance("aq_vlsu_rot_data", "x_vlsu_st_data_next_rot"); @149
aq_vlsu_rot_data  x_vlsu_st_data_next_rot (
  .data_in               (data_merge_for_next  ),
  .data_out              (data_aft_rot_for_next),
  .rot_sel               (rot_sel_for_next     )
);

// &Connect(.rot_sel   (rot_sel_for_next), @150
//          .data_in   (data_merge_for_next), @151
//          .data_out  (data_aft_rot_for_next )); @152

assign rot_sel_for_next[7:0] = nf3_all_merged
                               ? 8'h04
                               : 8'h01;


assign bytes_merge_for_next[7:0] = cur_data_all_merged
                                   ? nf3
                                     ? 8'hc0
                                     : 8'h00
                                   : bytes_vld[7:0];

assign bytes_merge_for_next_ext[63:0] = {{8{bytes_merge_for_next[7]}},{8{bytes_merge_for_next[6]}},
                                         {8{bytes_merge_for_next[5]}},{8{bytes_merge_for_next[4]}},
                                         {8{bytes_merge_for_next[3]}},{8{bytes_merge_for_next[2]}},
                                         {8{bytes_merge_for_next[1]}},{8{bytes_merge_for_next[0]}}};

assign data_merge_for_next[`LSU_DATAW-1:0] = data_ori[`LSU_DATAW-1:0] & ~bytes_merge_for_next_ext[`LSU_DATAW-1:0]
                                             | data_merge[`LSU_DATAW-1:0] & bytes_merge_for_next_ext[`LSU_DATAW-1:0];


//for next rot
// &CombBeg; @212
// &CombEnd; @233
assign rot_dis[4:0] = {1'b0,ab_rot[3:0]} + {1'b0,~rot[3:0]} + 5'h1; //ab_rot - rot

assign cur_data_all_merged = !rot_dis[4] || (rot_dis[3:0] == 4'b0)
                             || nf3 && (rot_dis[3:2] == 2'h0) && !(&rot_dis[1:0]); //<=2 

assign cur_merge_cnt[3:0] = data_vld
                            ? nf3
                              ? 4'h6
                              : 4'h8
                            : 4'h0; 

assign cur_data_rem_cnt[3:0] = cur_data_all_merged
                               ? cur_merge_cnt[3:0] + rot_dis[3:0]
                               : rot_dis[3:0];

// &CombBeg; @250
always @( cur_data_rem_cnt[3:0])
begin
case(cur_data_rem_cnt[3:0])
  4'h0:bytes_aft_rot[7:0] = 8'h00;
  4'h1:bytes_aft_rot[7:0] = 8'h80;
  4'h2:bytes_aft_rot[7:0] = 8'hc0;
  4'h3:bytes_aft_rot[7:0] = 8'he0;
  4'h4:bytes_aft_rot[7:0] = 8'hf0;
  4'h5:bytes_aft_rot[7:0] = 8'hf8;
  4'h6:bytes_aft_rot[7:0] = 8'hfc;
  4'h7:bytes_aft_rot[7:0] = 8'hfe;
  4'h8:bytes_aft_rot[7:0] = 8'hff;
  default: bytes_aft_rot[7:0] = {8{1'bx}};
endcase
// &CombEnd; @263
end

assign bytes_next[`LSU_BYTEW-1:0]  = bytes_aft_rot[`LSU_BYTEW-1:0];

assign nf3_all_merged = nf3 && cur_data_all_merged;

//================================================
//        data path
//================================================
assign ab_vld     = |bytes_vld[`LSU_BYTEW-1:0];
//assign bytes_full = &bytes_vld[`LSU_BYTEW-1:0];

always@(posedge align_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    bytes_vld[`LSU_BYTEW-1:0] <= {`LSU_BYTEW{1'b0}};
  else if (rtu_yy_xx_flush)
    bytes_vld[`LSU_BYTEW-1:0] <= {`LSU_BYTEW{1'b0}};
  else if (ab_bytes_up)
    bytes_vld[`LSU_BYTEW-1:0] <= bytes_create[`LSU_BYTEW-1:0];
end

always@(posedge align_data_clk)
begin
  if (ab_create_vld || vlsu_warm_up)
    data[`LSU_DATAW-1:0]  <= data_create[`LSU_DATAW-1:0];
end

always@(posedge align_clk)
begin
  if (ab_create_vld || vlsu_warm_up)
    ab_seq_last  <= seq_last;
end
//-----------------create---------------
assign bytes_create[`LSU_BYTEW-1:0] = bytes_next[`LSU_BYTEW-1:0];

assign data_create[`LSU_DATAW-1:0]  = data_aft_rot_for_next[`LSU_DATAW-1:0];

assign ab_rot_create[4:0] = {1'b0,cur_data_rem_cnt[3:0]};

//-----------------fwd data gen---------------
assign data_aft_ab[`LSU_DATAW-1:0] = data_merge[`LSU_DATAW-1:0];

// &CombBeg; @312
// &CombEnd; @340
// &CombBeg; @342
always @( mem_size[1:0]
       or sew[1:0]
       or data_aft_ab[63:0])
begin
case({mem_size[1:0],sew[1:0]})
  {BYTE,HALF}:data_final[63:0] = {2{data_aft_ab[55:48],
                                    data_aft_ab[39:32],
                                    data_aft_ab[23:16],
                                    data_aft_ab[7:0]}};
  {BYTE,WORD}:data_final[63:0] = {4{data_aft_ab[39:32],
                                    data_aft_ab[7:0]}};
  {HALF,WORD}:data_final[63:0] = {2{data_aft_ab[47:32],
                                    data_aft_ab[15:0]}};
  default: data_final[63:0] = data_aft_ab[63:0];
endcase
// &CombEnd; @354
end

assign fwd_vld = ab_vld
                 && ab_seq_last
                 || data_vld
                    && !nf3_first;

//-----------------fwd data shift---------------
// &CombBeg; @363
always @( mem_size[1:0]
       or ab_rot[4:0]
       or sew[1:0])
begin
case({mem_size[1:0],sew[1:0]})
  {BYTE,HALF}:data_shift[3:0] = ab_rot[4:1];
  {BYTE,WORD}:data_shift[3:0] = {1'b0,ab_rot[4:2]};
  {HALF,WORD}:data_shift[3:0] = ab_rot[4:1];
  default: data_shift[3:0] = ab_rot[3:0];
endcase
// &CombEnd;  @375
end

//================================================
//        output interface
//================================================
assign lsu_fwd_vld = fwd_vld;

assign fwd_data[`LSU_DATAW-1:0] = data_final[`LSU_DATAW-1:0];
assign fwd_data_ready           = ab_vld || !fls || vlsu_reg_wdata_ready;
assign fwd_data_shift[3:0]      = data_shift[3:0];

//for vlsu fwd done
assign fwd_next = ab_create_vld && cur_data_all_merged
                  || fwd_vld && !ab_vld && data_ack;

// &ModuleEnd; @390
endmodule


