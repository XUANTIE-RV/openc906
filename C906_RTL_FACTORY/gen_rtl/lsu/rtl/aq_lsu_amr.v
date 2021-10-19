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

// &Depend("cpu_cfig.h"); @17

// &ModuleBeg; @19
module aq_lsu_amr(
  amr_dc_wa_dis,
  cp0_lsu_amr,
  cp0_lsu_dcache_en,
  cp0_lsu_icg_en,
  cp0_lsu_sync_req,
  cpurst_b,
  dc_amr_cancel,
  dc_amr_st_addr,
  dc_amr_st_mask,
  dc_amr_st_miss,
  dc_amr_st_req,
  dc_amr_st_req_gate,
  dc_amr_st_size,
  forever_cpuclk,
  ifu_lsu_warm_up,
  pad_yy_icg_scan_en
);

// &Ports; @20
input   [1 :0]  cp0_lsu_amr;       
input           cp0_lsu_dcache_en; 
input           cp0_lsu_icg_en;    
input           cp0_lsu_sync_req;  
input           cpurst_b;          
input           dc_amr_cancel;     
input   [39:0]  dc_amr_st_addr;    
input           dc_amr_st_mask;    
input           dc_amr_st_miss;    
input           dc_amr_st_req;     
input           dc_amr_st_req_gate; 
input   [4 :0]  dc_amr_st_size;    
input           forever_cpuclk;    
input           ifu_lsu_warm_up;   
input           pad_yy_icg_scan_en; 
output          amr_dc_wa_dis;     

// &Regs; @21
reg     [39:0]  amr_addr;          
reg     [2 :0]  amr_cur_state;     
reg     [2 :0]  amr_next_state;    
reg     [5 :0]  amr_size;          
reg     [5 :0]  byte_cnt;          
reg     [5 :0]  byte_cnt_mask;     
reg     [1 :0]  confidence;        
reg     [5 :0]  line_cnt;          
reg     [5 :0]  line_cnt_mask;     
reg     [4 :0]  stride_reg;        

// &Wires; @22
wire            amr_clk;           
wire            amr_clk_en;        
wire            amr_create_en;     
wire            amr_cur_cals;      
wire            amr_cur_chk;       
wire            amr_cur_func;      
wire            amr_cur_idle;      
wire            amr_dc_wa_dis;     
wire            amr_dp_clk;        
wire            amr_dp_clk_en;     
wire            amr_en;            
wire            amr_exit;          
wire            amr_flush;         
wire            amr_st_clk;        
wire            amr_st_clk_en;     
wire            amr_start;         
wire            amr_start_chk;     
wire            byte_cnt_done;     
wire    [1 :0]  cp0_lsu_amr;       
wire            cp0_lsu_dcache_en; 
wire            cp0_lsu_icg_en;    
wire            cp0_lsu_sync_req;  
wire            cpurst_b;          
wire            dc_amr_cancel;     
wire    [39:0]  dc_amr_st_addr;    
wire            dc_amr_st_mask;    
wire            dc_amr_st_miss;    
wire            dc_amr_st_req;     
wire            dc_amr_st_req_gate; 
wire    [4 :0]  dc_amr_st_size;    
wire            dc_st_req;         
wire            dc_st_req_gate;    
wire            forever_cpuclk;    
wire            ifu_lsu_warm_up;   
wire            line_cnt_done;     
wire            pad_yy_icg_scan_en; 
wire    [5 :0]  stride_abs;        
wire    [39:0]  stride_cal;        
wire            stride_equal_size; 
wire            stride_hit;        
wire    [5 :0]  stride_neg;        
wire    [6 :0]  stride_raw;        


parameter PADDR = 40;
parameter BYTE  = 6'b000001;
parameter HALF  = 6'b000010;
parameter WORD  = 6'b000100;
parameter DWORD = 6'b001000;
parameter QWORD = 6'b010000;
parameter EWORD = 6'b100000;

//==============================================================================
//    AMR FSM
//==============================================================================
parameter AMR_IDLE      = 3'b000;
parameter AMR_MISS_WAIT = 3'b001;
parameter AMR_CALS      = 3'b101;
parameter AMR_CHCK      = 3'b110;
parameter AMR_FUNC      = 3'b111;

assign amr_flush = !amr_en | !cp0_lsu_dcache_en | cp0_lsu_sync_req | dc_amr_cancel;

always@(posedge amr_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    amr_cur_state[2:0] <= AMR_IDLE;
  else if (amr_flush)
    amr_cur_state[2:0] <= AMR_IDLE;
  else
    amr_cur_state[2:0] <= amr_next_state[2:0];
end

assign amr_en        = |cp0_lsu_amr[1:0];
assign amr_start     = dc_amr_st_req & amr_en & dc_amr_st_miss;
assign amr_start_chk = amr_start & !dc_amr_st_mask;
assign dc_st_req     = dc_amr_st_req & !dc_amr_st_mask;
assign dc_st_req_gate= dc_amr_st_req_gate;

// &CombBeg; @59
always @( stride_hit
       or amr_exit
       or stride_equal_size
       or line_cnt_done
       or amr_start_chk
       or amr_start
       or amr_cur_state
       or dc_st_req)
begin
  case(amr_cur_state)
    AMR_IDLE: begin
      if (amr_start_chk)
        amr_next_state = AMR_CALS;
      else if (amr_start)
        amr_next_state = AMR_MISS_WAIT;
      else
        amr_next_state = AMR_IDLE;
    end
    AMR_MISS_WAIT: begin
      if (dc_st_req)
        amr_next_state = AMR_CALS;
      else
        amr_next_state = AMR_MISS_WAIT;
    end
    AMR_CALS: begin
      if (dc_st_req & stride_equal_size)
        amr_next_state = AMR_CHCK;
      else if (dc_st_req)
        amr_next_state = AMR_IDLE;
      else
        amr_next_state = AMR_CALS;
    end
    AMR_CHCK: begin
      if (dc_st_req & stride_hit)
        amr_next_state = line_cnt_done ? AMR_FUNC : AMR_CHCK;
      else if (dc_st_req)
        amr_next_state = AMR_IDLE;
      else
        amr_next_state = AMR_CHCK;
    end
    AMR_FUNC: begin
      if (amr_exit)
        amr_next_state = AMR_IDLE;
      else
        amr_next_state = AMR_FUNC;
    end
    default: amr_next_state = AMR_IDLE;
  endcase
// &CombEnd; @99
end

assign amr_cur_idle = amr_cur_state == AMR_IDLE;
assign amr_cur_cals = amr_cur_state == AMR_CALS;
assign amr_cur_chk  = amr_cur_state == AMR_CHCK;
assign amr_cur_func = amr_cur_state == AMR_FUNC;

assign amr_create_en = !amr_cur_state[2] & dc_st_req & amr_en;

always@(posedge amr_st_clk)
begin
  if (amr_create_en | ifu_lsu_warm_up) begin
    amr_addr[PADDR-1:0] <= dc_amr_st_addr[PADDR-1:0];
  end
  else if (dc_st_req & !amr_cur_idle) begin
    amr_addr[PADDR-1:0] <= dc_amr_st_addr[PADDR-1:0];
  end
end

//for mask st inst,should accumulate size
always@(posedge amr_st_clk)
begin
  if (dc_st_req | ifu_lsu_warm_up) begin
    amr_size[5:0]       <= {1'b0,dc_amr_st_size[4:0]};
  end
  else if (dc_amr_st_req & dc_amr_st_mask) begin
    amr_size[5:0]       <= amr_size[5:0] + {1'b0,dc_amr_st_size[4:0]};
  end
end

assign stride_cal[PADDR-1:0] = dc_amr_st_addr[PADDR-1:0] - amr_addr[PADDR-1:0];
assign stride_raw[6:0]       = {stride_cal[PADDR-1], stride_cal[5:0]};
assign stride_neg[5:0]       = ~stride_raw[5:0] + 6'b1;
assign stride_abs[5:0]       = stride_raw[6] ? stride_neg[5:0] : stride_raw[5:0];
assign stride_equal_size     = stride_abs[5:0] == amr_size[5:0];

always@(posedge amr_dp_clk)
begin
  if (amr_cur_cals & dc_st_req | ifu_lsu_warm_up)
    stride_reg[4:0] <= stride_raw[4:0];
end

assign stride_hit = stride_reg[4:0] == stride_raw[4:0];

always@(posedge amr_dp_clk)
begin
  if (amr_cur_cals & dc_st_req | ifu_lsu_warm_up)
    byte_cnt[5:0] <= 6'b0;
  else if (amr_cur_chk & dc_st_req & stride_hit)
    byte_cnt[5:0] <= byte_cnt[5:0] + 6'b1;
end

// &CombBeg; @151
always @( amr_size[5:0])
begin
  byte_cnt_mask[5:0] = 6'b0;
  case(amr_size[5:0])
    BYTE:    byte_cnt_mask[5:0] = {6{1'b1}};
    HALF:    byte_cnt_mask[4:0] = {5{1'b1}};
    WORD:    byte_cnt_mask[3:0] = {4{1'b1}};
    DWORD:   byte_cnt_mask[2:0] = {3{1'b1}};
    QWORD:   byte_cnt_mask[1:0] = {2{1'b1}};
    EWORD:   byte_cnt_mask[0]   = 1'b1;
    default: byte_cnt_mask[5:0] = 6'b0;
  endcase
// &CombEnd; @162
end

assign byte_cnt_done = (byte_cnt[5:0] & byte_cnt_mask[5:0]) == ({6{1'b1}} & byte_cnt_mask[5:0]);

always@(posedge amr_dp_clk)
begin
  if (amr_cur_cals & dc_st_req | ifu_lsu_warm_up)
    line_cnt[5:0] <= 6'b0;
  else if (amr_cur_chk & dc_st_req & byte_cnt_done)
    line_cnt[5:0] <= line_cnt[5:0] + 6'b1;
end

// &CombBeg; @174
always @( cp0_lsu_amr[1:0])
begin
  line_cnt_mask[5:0] = 6'b0;
  case(cp0_lsu_amr[1:0])
    2'b01:   line_cnt_mask[1:0] = {2{1'b1}};
    2'b10:   line_cnt_mask[3:0] = {4{1'b1}};
    2'b11:   line_cnt_mask[5:0] = {6{1'b1}};
    default: line_cnt_mask[5:0] = 6'b0;
  endcase
// &CombEnd; @182
end

assign line_cnt_done = (line_cnt[5:0] & line_cnt_mask[5:0]) == ({6{1'b1}} & line_cnt_mask[5:0]);

always@(posedge amr_st_clk)
begin
  if (amr_cur_chk & dc_st_req & line_cnt_done | ifu_lsu_warm_up)
    confidence[1:0] <= 2'b11;
  else if (amr_cur_func & dc_st_req & !stride_hit)
    confidence[1:0] <= confidence[1:0] - 2'b1;
end

assign amr_exit = dc_st_req & (confidence[1:0] == 2'b00);

assign amr_dc_wa_dis = amr_cur_func;

//==============================================================================
//   ICG
//==============================================================================

assign amr_clk_en = dc_st_req_gate & amr_en | !amr_cur_idle | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_amr_gated_clk"); @203
gated_clk_cell  x_aq_lsu_amr_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (amr_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (amr_clk_en        ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @204
//          .external_en (1'b0), @205
//          .global_en   (1'b1), @206
//          .module_en   (cp0_lsu_icg_en), @207
//          .local_en    (amr_clk_en), @208
//          .clk_out     (amr_clk)); @209

assign amr_dp_clk_en = (amr_cur_cals | amr_cur_chk) & dc_st_req_gate & amr_en | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_amr_dp_gated_clk"); @212
gated_clk_cell  x_aq_lsu_amr_dp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (amr_dp_clk        ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (amr_dp_clk_en     ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @213
//          .external_en (1'b0), @214
//          .global_en   (1'b1), @215
//          .module_en   (cp0_lsu_icg_en), @216
//          .local_en    (amr_dp_clk_en), @217
//          .clk_out     (amr_dp_clk)); @218

assign amr_st_clk_en = dc_st_req_gate & amr_en | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_amr_st_gated_clk"); @221
gated_clk_cell  x_aq_lsu_amr_st_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (amr_st_clk        ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (amr_st_clk_en     ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @222
//          .external_en (1'b0), @223
//          .global_en   (1'b1), @224
//          .module_en   (cp0_lsu_icg_en), @225
//          .local_en    (amr_st_clk_en), @226
//          .clk_out     (amr_st_clk)); @227

// &ModuleEnd; @229
endmodule


