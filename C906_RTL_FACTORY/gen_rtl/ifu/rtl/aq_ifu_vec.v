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

// &ModuleBeg; @23
module aq_ifu_vec(
  cp0_ifu_icg_en,
  cp0_ifu_rst_inv_done,
  cp0_yy_clk_en,
  cpurst_b,
  dtu_ifu_halt_on_reset,
  forever_cpuclk,
  ifu_cp0_rst_inv_req,
  ifu_cp0_warm_up,
  ifu_idu_warm_up,
  ifu_iu_reset_vld,
  ifu_iu_warm_up,
  ifu_lsu_warm_up,
  ifu_rtu_reset_halt_req,
  ifu_rtu_warm_up,
  ifu_vidu_warm_up,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  rtu_yy_xx_dbgon,
  vec_ctrl_reset_mask,
  vec_ibuf_warm_up,
  vec_pcgen_idle,
  vec_pcgen_rst_vld,
  vec_top_cur_st
);

// &Ports; @24
input          cp0_ifu_icg_en;        
input          cp0_ifu_rst_inv_done;  
input          cp0_yy_clk_en;         
input          cpurst_b;              
input          dtu_ifu_halt_on_reset; 
input          forever_cpuclk;        
input          pad_yy_icg_scan_en;    
input          rtu_yy_xx_dbgon;       
output         ifu_cp0_rst_inv_req;   
output         ifu_cp0_warm_up;       
output         ifu_idu_warm_up;       
output         ifu_iu_reset_vld;      
output         ifu_iu_warm_up;        
output         ifu_lsu_warm_up;       
output         ifu_rtu_reset_halt_req; 
output         ifu_rtu_warm_up;       
output         ifu_vidu_warm_up;      
output         ifu_vpu_warm_up;       
output         vec_ctrl_reset_mask;   
output         vec_ibuf_warm_up;      
output         vec_pcgen_idle;        
output         vec_pcgen_rst_vld;     
output  [1:0]  vec_top_cur_st;        

// &Regs; @25
reg     [1:0]  vec_cur_state;         
reg     [1:0]  vec_next_state;        
reg            vector_rst_inv_ff;     
reg            vector_rst_inv_ff2;    
reg            vector_warmup_ff;      
reg     [2:0]  warm_up_cnt;           

// &Wires; @26
wire           cp0_ifu_icg_en;        
wire           cp0_ifu_rst_inv_done;  
wire           cp0_yy_clk_en;         
wire           cpurst_b;              
wire           dtu_ifu_halt_on_reset; 
wire           forever_cpuclk;        
wire           ifu_cp0_rst_inv_req;   
wire           ifu_cp0_warm_up;       
wire           ifu_idu_warm_up;       
wire           ifu_iu_reset_vld;      
wire           ifu_iu_warm_up;        
wire           ifu_lsu_warm_up;       
wire           ifu_rtu_reset_halt_req; 
wire           ifu_rtu_warm_up;       
wire           ifu_vidu_warm_up;      
wire           ifu_vpu_warm_up;       
wire           pad_yy_icg_scan_en;    
wire           rtu_yy_xx_dbgon;       
wire           vec_ctrl_reset_mask;   
wire           vec_ibuf_warm_up;      
wire           vec_pcgen_idle;        
wire           vec_pcgen_rst_vld;     
wire           vec_rst_inv_req;       
wire           vec_sm_clk;            
wire           vec_sm_clk_en;         
wire           vec_sm_halt;           
wire           vec_sm_idle;           
wire           vec_sm_reset;          
wire           vec_sm_warm_up;        
wire    [1:0]  vec_top_cur_st;        
wire           vec_warmup_req;        
wire           warm_up_cnt_done;      


//==========================================================
// Branch History Table Module
// 1. Instance ICG Cell
// 2. Vector FSM
// 3. Reset Invalid Control
// 4. Generate Change Flow for non-vec and vec pc fetch
// 5. Generate vec table data fetch
// 6. Vector Error Handling
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign vec_sm_clk_en = !vec_sm_idle
                    || rtu_yy_xx_dbgon
                    || vector_rst_inv_ff
                    || vector_rst_inv_ff2
                    || vector_warmup_ff;

// &Instance("gated_clk_cell","x_ifu_vec_sm_clk"); @47
gated_clk_cell  x_ifu_vec_sm_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vec_sm_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (vec_sm_clk_en     ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in      (forever_cpuclk), @48
//           .clk_out     (vec_sm_clk), @49
//           .external_en (1'b0), @50
//           .global_en   (cp0_yy_clk_en), @51
//           .local_en    (vec_sm_clk_en), @52
//           .module_en   (cp0_ifu_icg_en) @53
//         ); @54

//------------------------------------------------
// 2. Vector FSM
// a. parameter define
// b. FSM implemetation
// c. FSM state signals
//------------------------------------------------

// a. parameter define
parameter RESET    = 2'b01;
parameter IDLE     = 2'b00;
parameter HALT     = 2'b10;
parameter WARM_UP  = 2'b11;

// b. FSM implemetation
// State Description:
// RESET    : Reset logic, for memory initial invalidation
// IDLE     : Wait for rtu expt signal & send physical address req
// WARM_UP  : Warump State

always @(posedge vec_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    vec_cur_state[1:0] <= RESET;
  else
    vec_cur_state[1:0] <= vec_next_state[1:0];
end

// &CombBeg; @83
always @( warm_up_cnt_done
       or cp0_ifu_rst_inv_done
       or dtu_ifu_halt_on_reset
       or vec_cur_state)
begin
case(vec_cur_state)
  RESET: 
    if(cp0_ifu_rst_inv_done)
      vec_next_state = WARM_UP;
    else
      vec_next_state = RESET;
  WARM_UP: 
    if(warm_up_cnt_done)
      if(dtu_ifu_halt_on_reset)
        vec_next_state = HALT;
      else
        vec_next_state = IDLE;
    else
      vec_next_state = WARM_UP;
  HALT: 
    vec_next_state = IDLE;
  IDLE: 
    vec_next_state = IDLE;
  default:
    vec_next_state = IDLE;
endcase
// &CombEnd; @105
end

// c. FSM state signals
assign vec_sm_reset    = vec_cur_state == RESET;
assign vec_sm_warm_up  = vec_cur_state == WARM_UP;
assign vec_sm_halt     = vec_cur_state == HALT;
assign vec_sm_idle     = vec_cur_state == IDLE;
          
//------------------------------------------------
// 3. Reset Invalid Control
//------------------------------------------------
// record reset state to generation a pulse req
always @(posedge vec_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    vector_rst_inv_ff  <= 1'b0;
    vector_rst_inv_ff2 <= 1'b0;
  end
  else
  begin
    vector_rst_inv_ff  <= vec_sm_reset;
    vector_rst_inv_ff2 <= vector_rst_inv_ff;
  end
end

assign vec_rst_inv_req = vec_sm_reset && !vector_rst_inv_ff;
//assign vec_rst_exit    = vector_rst_inv_ff && !vector_rst_inv_ff2;

always @(posedge vec_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    warm_up_cnt[2:0] <= 3'b0;
  else if(vec_sm_warm_up)
    warm_up_cnt[2:0] <= warm_up_cnt[2:0] + 3'b1;
  else
    warm_up_cnt[2:0] <= warm_up_cnt[2:0];
end

assign warm_up_cnt_done = warm_up_cnt[2:0] == 3'b111;

always @(posedge vec_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    vector_warmup_ff <= 1'b0;
  else
    vector_warmup_ff <= vec_sm_warm_up;
end

assign vec_warmup_req = vec_sm_warm_up && !vector_warmup_ff;

//==========================================================
// Rename for Output
//==========================================================

// Output to pcgen
assign vec_pcgen_rst_vld      = vec_rst_inv_req;
assign vec_pcgen_idle         = vec_sm_idle;

// Output to ctrl
assign vec_ctrl_reset_mask    = vec_sm_reset || vec_sm_warm_up;

// Output to ibuf
assign vec_ibuf_warm_up       = vec_warmup_req;

// Output to top
assign vec_top_cur_st[1:0]    = vec_cur_state[1:0];

// Output to IU
assign ifu_iu_reset_vld       = vec_sm_reset;

// Output to CP0
assign ifu_cp0_rst_inv_req    = vec_rst_inv_req;

// Output to HAD
assign ifu_rtu_reset_halt_req = vec_sm_halt;

// Output to xx for warm up
assign ifu_idu_warm_up        = vec_sm_warm_up;
assign ifu_vidu_warm_up       = vec_sm_warm_up;
assign ifu_iu_warm_up         = vec_sm_warm_up;
assign ifu_vpu_warm_up        = vec_sm_warm_up;
assign ifu_lsu_warm_up        = vec_sm_warm_up;
assign ifu_cp0_warm_up        = vec_sm_warm_up;
assign ifu_rtu_warm_up        = vec_sm_warm_up;

// &ModuleEnd; @191
endmodule


