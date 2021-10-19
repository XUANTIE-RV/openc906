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
module aq_dtu_pcfifo(
  cp0_dtu_addr,
  cp0_dtu_icg_en,
  cp0_dtu_pcfifo_frz,
  cp0_dtu_rreg,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  latest_pc,
  pad_yy_icg_scan_en,
  pcfifo_regs_data,
  rtu_dtu_halt_ack,
  rtu_dtu_retire_chgflw,
  rtu_dtu_retire_next_pc,
  rtu_dtu_retire_vld
);

// &Ports; @21
input   [11:0]  cp0_dtu_addr;          
input           cp0_dtu_icg_en;        
input           cp0_dtu_pcfifo_frz;    
input           cp0_dtu_rreg;          
input           cp0_yy_clk_en;         
input           cpurst_b;              
input           forever_cpuclk;        
input           pad_yy_icg_scan_en;    
input           rtu_dtu_halt_ack;      
input           rtu_dtu_retire_chgflw; 
input   [39:0]  rtu_dtu_retire_next_pc; 
input           rtu_dtu_retire_vld;    
output  [39:0]  latest_pc;             
output  [63:0]  pcfifo_regs_data;      

// &Regs; @22
reg     [3 :0]  rptr;                  
reg     [3 :0]  wptr;                  

// &Wires; @23
wire    [11:0]  cp0_dtu_addr;          
wire            cp0_dtu_icg_en;        
wire            cp0_dtu_pcfifo_frz;    
wire            cp0_dtu_rreg;          
wire            cp0_yy_clk_en;         
wire            cpurst_b;              
wire            ctrl_pcfifo_ren;       
wire            ctrl_pcfifo_wen;       
wire            forever_cpuclk;        
wire    [39:0]  latest_pc;             
wire    [3 :0]  latest_pc_ptr;         
wire            pad_yy_icg_scan_en;    
wire            pcfifo_clk;            
wire            pcfifo_clk_en;         
wire    [39:0]  pcfifo_din;            
wire    [39:0]  pcfifo_out;            
wire    [39:0]  pcfifo_reg_latest_pc;  
wire    [39:0]  pcfifo_reg_rptr_pc;    
wire    [63:0]  pcfifo_regs_data;      
wire            read_first_pc;         
wire            rtu_dtu_halt_ack;      
wire            rtu_dtu_retire_chgflw; 
wire    [39:0]  rtu_dtu_retire_next_pc; 
wire            rtu_dtu_retire_vld;    


parameter DATAW		= `TDT_DM_CORE_MAX_XLEN;


parameter DEPTH		= 16;
parameter PTR_WIDTH	= 4;

assign ctrl_pcfifo_wen = rtu_dtu_retire_vld && rtu_dtu_retire_chgflw && !cp0_dtu_pcfifo_frz;
assign ctrl_pcfifo_ren = cp0_dtu_rreg && cp0_dtu_addr[11:0] == 12'hfe2 && !cp0_dtu_pcfifo_frz;

//==========================================================
//                   PCFIFO write
//==========================================================
// when a branch or jump inst retires in normal mode,
// the target pc will be pushed into pcfifo

assign pcfifo_din[`PA_WIDTH-1:0] = rtu_dtu_retire_next_pc[`PA_WIDTH-1:0];

// //&Force("mem","pcfifo_reg",`PA_WIDTH-1,0,DEPTH-1,0); @48
// //&Force("output","pcfifo_reg");&Force("bus","pcfifo_reg",`PA_WIDTH-1,0); @49
//csky vperl_off
reg      [39:0]  pcfifo_reg  [DEPTH-1:0];

integer i;
always @(posedge pcfifo_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    begin
      for (i=0; i<DEPTH; i=i+1)
        pcfifo_reg[i] <= {`PA_WIDTH{1'b0}};
    end
  else if (ctrl_pcfifo_wen)
    pcfifo_reg[wptr[PTR_WIDTH-1:0]] <= pcfifo_din[`PA_WIDTH-1:0];
end
assign pcfifo_reg_rptr_pc[`PA_WIDTH-1:0]    = pcfifo_reg[rptr[PTR_WIDTH-1:0]];

assign pcfifo_reg_latest_pc[`PA_WIDTH-1:0] = pcfifo_reg[latest_pc_ptr[PTR_WIDTH-1:0]];
//csky vperl_on
// &Force("nonport","pcfifo_reg_rptr_pc"); @68
// &Force("nonport","pcfifo_reg_latest_pc"); @69

//==========================================================
//                   PCFIFO read
//==========================================================

assign pcfifo_out[`PA_WIDTH-1:0]   = read_first_pc ? {pcfifo_reg_rptr_pc[`PA_WIDTH-1:1],1'b1} : pcfifo_reg_rptr_pc[`PA_WIDTH-1:0];
assign pcfifo_regs_data[DATAW-1:0] = {{(DATAW-`PA_WIDTH){pcfifo_out[`PA_WIDTH-1]}},pcfifo_out[`PA_WIDTH-1:0]};

//==========================================================
//                 PCFIFO wptr maintenance
//==========================================================
//assign pcfifo_full = (wptr[PTR_WIDTH-2:0] == first_pc_ptr[PTR_WIDTH-2:0]) &&
//                      (wptr[PTR_WIDTH-1] ^ first_pc_ptr[PTR_WIDTH-1]);

// wptr increase conditon:
// write enable
always @(posedge pcfifo_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wptr[PTR_WIDTH-1:0] <= {PTR_WIDTH{1'b0}};
  else if (ctrl_pcfifo_wen)
    wptr[PTR_WIDTH-1:0] <= wptr[PTR_WIDTH-1:0] + 1'b1;
  else
    wptr[PTR_WIDTH-1:0] <= wptr[PTR_WIDTH-1:0];
end
//latest_pc ptr is behind wptr
assign latest_pc_ptr[PTR_WIDTH-1:0] =  wptr[PTR_WIDTH-1:0] - 1'b1;
// &Force("nonport","latest_pc_ptr"); @97
//==========================================================
//                 PCFIFO first_pc_ptr maintenance
//==========================================================
// first_pc_ptr increase conditon:
// wptr is overwriting a entry
//always @(posedge pcfifo_clk or negedge cpurst_b)
//begin
//  if (!cpurst_b)
//    first_pc_ptr[PTR_WIDTH-1:0] <= {PTR_WIDTH{1'b0}};
//  else if (ctrl_pcfifo_wen && pcfifo_full)
//    first_pc_ptr[PTR_WIDTH-1:0] <= first_pc_ptr[PTR_WIDTH-1:0] + 1'b1;
//  else
//    first_pc_ptr[PTR_WIDTH-1:0] <= first_pc_ptr[PTR_WIDTH-1:0];
//end

//==========================================================
//                 PCFIFO rptr maintenance
//==========================================================

// rptr increase condition:
// read enable
always @(posedge pcfifo_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rptr[PTR_WIDTH-1:0] <= {PTR_WIDTH{1'b0}};
  else if(rtu_dtu_halt_ack)
   rptr[PTR_WIDTH-1:0] <= wptr[PTR_WIDTH-1:0]; 
  else if (ctrl_pcfifo_ren)
    rptr[PTR_WIDTH-1:0] <= rptr[PTR_WIDTH-1:0] + 1'b1;
  else
    rptr[PTR_WIDTH-1:0] <= rptr[PTR_WIDTH-1:0];
end

assign read_first_pc = rptr[PTR_WIDTH-1:0] == wptr[PTR_WIDTH-1:0];

//==========================================================
//                 latest pc for dm
//==========================================================
assign latest_pc[`PA_WIDTH-1:0] = ctrl_pcfifo_wen ? pcfifo_din[`PA_WIDTH-1:0] : pcfifo_reg_latest_pc[`PA_WIDTH-1:0];

//==========================================================
//                     gate clk
//==========================================================
assign pcfifo_clk_en = ctrl_pcfifo_wen ||
                       ctrl_pcfifo_ren ||
                       rtu_dtu_halt_ack;
// &Force("nonport","pcfifo_clk_en"); @144


// &Instance("gated_clk_cell", "x_reg_gated_clk"); @147
gated_clk_cell  x_reg_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pcfifo_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (pcfifo_clk_en     ),
  .module_en          (cp0_dtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @148
//          .external_en (1'b0), @149
//          .global_en   (cp0_yy_clk_en), @150
//          .module_en   (cp0_dtu_icg_en), @151
//          .local_en    (pcfifo_clk_en), @152
//          //.local_en    (1'b1), @153
//          .clk_out     (pcfifo_clk)); @154
// &ModuleEnd; @155
endmodule


