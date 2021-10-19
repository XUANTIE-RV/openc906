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
module aq_cp0_lpmd(
  cp0_biu_lpmd_b,
  cp0_ifu_in_lpmd,
  cp0_ifu_lpmd_req,
  cp0_mmu_lpmd_req,
  cp0_rtu_in_lpmd,
  cp0_yy_clk_en,
  cpurst_b,
  dtu_cp0_wake_up,
  forever_cpuclk,
  ifu_yy_xx_no_op,
  iui_special_wfi,
  lpmd_clk,
  lpmd_clk_en,
  lpmd_top_cur_state,
  lsu_cp0_sync_ack,
  mmu_yy_xx_no_op,
  regs_lpmd_int_vld,
  rtu_yy_xx_dbgon,
  rtu_yy_xx_flush,
  special_lpmd_stall,
  special_lpmd_sync_req
);


// &Ports; @25
input          cpurst_b;             
input          dtu_cp0_wake_up;      
input          forever_cpuclk;       
input          ifu_yy_xx_no_op;      
input          iui_special_wfi;      
input          lpmd_clk;             
input          lsu_cp0_sync_ack;     
input          mmu_yy_xx_no_op;      
input          regs_lpmd_int_vld;    
input          rtu_yy_xx_dbgon;      
input          rtu_yy_xx_flush;      
output  [1:0]  cp0_biu_lpmd_b;       
output         cp0_ifu_in_lpmd;      
output         cp0_ifu_lpmd_req;     
output         cp0_mmu_lpmd_req;     
output         cp0_rtu_in_lpmd;      
output         cp0_yy_clk_en;        
output         lpmd_clk_en;          
output  [1:0]  lpmd_top_cur_state;   
output         special_lpmd_stall;   
output         special_lpmd_sync_req; 

// &Regs; @26
reg     [1:0]  cur_state;            
reg     [1:0]  lpmd_b;               
reg     [1:0]  next_state;           

// &Wires; @27
wire    [1:0]  cp0_biu_lpmd_b;       
wire           cp0_ifu_in_lpmd;      
wire           cp0_ifu_lpmd_req;     
wire           cp0_mmu_lpmd_req;     
wire           cp0_rtu_in_lpmd;      
wire           cp0_yy_clk_en;        
wire           cpu_in_lpmd;          
wire           cpurst_b;             
wire           dtu_cp0_wake_up;      
wire           forever_cpuclk;       
wire           ifu_yy_xx_no_op;      
wire           iui_special_wfi;      
wire           lpmd_ack;             
wire           lpmd_clk;             
wire           lpmd_clk_en;          
wire           lpmd_in_wait_state;   
wire           lpmd_stall;           
wire    [1:0]  lpmd_top_cur_state;   
wire           lsu_cp0_sync_ack;     
wire           mmu_yy_xx_no_op;      
wire           regs_lpmd_int_vld;    
wire           rtu_yy_xx_dbgon;      
wire           rtu_yy_xx_flush;      
wire           special_lpmd_stall;   
wire           special_lpmd_sync_req; 


//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//----------------------------------------------------------
//   Handling the low power operating modes
//----------------------------------------------------------
// Request the BIU to enter low power mode and do
// not accept any more transaction from IFU or LSU
                     
//-------------------FSM of lpmd req logic------------------
// State Description:
// IDLE : no lpmd instruction (wfi)
// WAIT : request biu and wait for biu ack
//        the lpmd request        
// LPMD : wait for wake up and then cmplt lpmd inst
//----------------------------------------------------------

parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter LPMD = 2'b10;

assign lpmd_clk_en = cur_state[1:0] == IDLE && iui_special_wfi
                  || cur_state[1:0] == WAIT
                  || cur_state[1:0] == LPMD && !cpu_in_lpmd;

always @(posedge lpmd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cur_state[1:0] <= IDLE;
  else if(rtu_yy_xx_flush)
    cur_state[1:0] <= IDLE;
  else
    cur_state[1:0] <= next_state[1:0];
end

// &CombBeg; @64
always @( cur_state[1:0]
       or lpmd_ack
       or iui_special_wfi
       or cpu_in_lpmd)
begin
  case(cur_state[1:0])
  IDLE       : if(iui_special_wfi)
                next_state[1:0] = WAIT;
              else
                next_state[1:0] = IDLE;
  WAIT      : if(lpmd_ack)
                next_state[1:0] = LPMD;
              else
                next_state[1:0] = WAIT;
  LPMD      : if(!cpu_in_lpmd)
                next_state[1:0] = IDLE;
              else
                next_state[1:0] = LPMD;
  default   :   next_state[1:0] = IDLE;
  endcase
// &CombEnd; @80
end

assign lpmd_in_wait_state = cur_state[0];


//----------------conctol signal by lpmd FSM----------------
//req if entering into WAIT state
assign special_lpmd_sync_req = lpmd_in_wait_state;
assign cp0_ifu_lpmd_req = lpmd_in_wait_state;
assign cp0_mmu_lpmd_req = lpmd_in_wait_state;

//----------------------------------------------------------
//               lpmd request ack 
//----------------------------------------------------------
assign lpmd_ack = lpmd_in_wait_state
                  && ifu_yy_xx_no_op
                  && lsu_cp0_sync_ack
                  && mmu_yy_xx_no_op;

assign lpmd_stall = cur_state == IDLE && iui_special_wfi
                 || cur_state == WAIT
                 || cur_state == LPMD && cpu_in_lpmd;

// assign lpmd_cmplt = (cur_state[1:0] == LPMD) && !cpu_in_lpmd;

//----------------------------------------------------------
// Send lpmd bits to BIU and HAD, when
// cp0 can enter low power mode (get biu_cp0_no_op)
//----------------------------------------------------------
// &Force("output","cp0_biu_lpmd_b"); @109

always @(posedge forever_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    lpmd_b[1:0] <= 2'b11;
  else if((dtu_cp0_wake_up || regs_lpmd_int_vld)
          && cpu_in_lpmd || rtu_yy_xx_dbgon)
    lpmd_b[1:0] <= 2'b11;
  else if(lpmd_ack && !cpu_in_lpmd)
  begin
    if(iui_special_wfi)
      lpmd_b[1:0] <= 2'b00;
    else
      lpmd_b[1:0] <= 2'b11;
  end
  else
    lpmd_b[1:0] <= lpmd_b[1:0];
end

assign cp0_biu_lpmd_b[1:0] = lpmd_b[1:0];

//cpu ack in debug mode
assign cpu_in_lpmd     = !(lpmd_b[1] & lpmd_b[0]);

assign cp0_ifu_in_lpmd = cpu_in_lpmd;
assign cp0_rtu_in_lpmd = cpu_in_lpmd;

//======================================================
//Generate clock enable signal to clock module
//Disable the clock when low power mode is entered
//======================================================
// &Force("output","cp0_yy_clk_en"); @141
assign cp0_yy_clk_en = lpmd_b[1] & lpmd_b[0];

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign special_lpmd_stall = lpmd_stall;

assign lpmd_top_cur_state[1:0] = cur_state[1:0];

// &ModuleEnd; @154
endmodule



