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
module aq_lsu_lm(
  cp0_lsu_icg_en,
  cpurst_b,
  forever_cpuclk,
  ifu_lsu_warm_up,
  lm_clr,
  lm_pass,
  lm_req_addr,
  lm_req_size,
  lm_set,
  lm_set_gate,
  pad_yy_icg_scan_en,
  rtu_lsu_expt_ack,
  rtu_lsu_expt_exit
);

// &Ports; @20
input           cp0_lsu_icg_en;    
input           cpurst_b;          
input           forever_cpuclk;    
input           ifu_lsu_warm_up;   
input           lm_clr;            
input   [39:0]  lm_req_addr;       
input   [1 :0]  lm_req_size;       
input           lm_set;            
input           lm_set_gate;       
input           pad_yy_icg_scan_en; 
input           rtu_lsu_expt_ack;  
input           rtu_lsu_expt_exit; 
output          lm_pass;           

// &Regs; @21
reg     [39:0]  lm_addr;           
reg             lm_cur_state;      
reg             lm_next_state;     
reg     [1 :0]  lm_size;           

// &Wires; @22
wire            cp0_lsu_icg_en;    
wire            cpurst_b;          
wire            expt_ack;          
wire            expt_exit;         
wire            forever_cpuclk;    
wire            ifu_lsu_warm_up;   
wire            lm_clk;            
wire            lm_clk_en;         
wire            lm_clr;            
wire            lm_pass;           
wire    [39:0]  lm_req_addr;       
wire    [1 :0]  lm_req_size;       
wire            lm_set;            
wire            lm_set_gate;       
wire            pad_yy_icg_scan_en; 
wire            rtu_lsu_expt_ack;  
wire            rtu_lsu_expt_exit; 
wire            warm_up;           


parameter PADDR = 40;
//================================================
//        input interface
//================================================
assign warm_up = ifu_lsu_warm_up;

//-----------from rtu-----------------
assign expt_exit = rtu_lsu_expt_exit;
assign expt_ack  = rtu_lsu_expt_ack;
//================================================
//        FSM
//================================================
parameter LM_OPEN = 1'b0;
parameter LM_EXCL = 1'b1;

assign lm_clk_en = lm_set_gate | (lm_cur_state == LM_EXCL) | ifu_lsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_lm_gated_clk"); @41
gated_clk_cell  x_aq_lsu_lm_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (lm_clk            ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (lm_clk_en         ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @42
//          .external_en (1'b0), @43
//          .global_en   (1'b1), @44
//          .module_en   (cp0_lsu_icg_en), @45
//          .local_en    (lm_clk_en), @46
//          .clk_out     (lm_clk)); @47

always@(posedge lm_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    lm_cur_state <= LM_OPEN;
  else
    lm_cur_state <= lm_next_state;
end
      
// &CombBeg; @57
always @( expt_ack
       or lm_clr
       or lm_cur_state
       or expt_exit
       or lm_set)
begin
  case (lm_cur_state)
    LM_OPEN:begin
      if (lm_set & !expt_ack & !expt_exit)
        lm_next_state = LM_EXCL;
      else
        lm_next_state = LM_OPEN;
    end
    LM_EXCL:begin
      if (expt_ack | expt_exit | lm_clr)
        lm_next_state = LM_OPEN;
      else
        lm_next_state = LM_EXCL;
    end
    default: lm_next_state = LM_OPEN;
  endcase
// &CombEnd; @73
end

always@(posedge lm_clk)
begin
  if (warm_up)
  begin
    lm_addr[PADDR-1:0] <= {PADDR{1'b0}};
    lm_size[1:0]       <= 2'b0; 
  end
  else if (lm_set)
  begin
    lm_addr[PADDR-1:0] <= lm_req_addr[PADDR-1:0];
    lm_size[1:0]       <= lm_req_size[1:0]; 
  end
end

assign lm_pass = lm_cur_state
                 & (lm_addr[PADDR-1:0] == lm_req_addr[PADDR-1:0])
                 & (lm_size[1:0] == lm_req_size[1:0]);


// &ModuleEnd; @94
endmodule


