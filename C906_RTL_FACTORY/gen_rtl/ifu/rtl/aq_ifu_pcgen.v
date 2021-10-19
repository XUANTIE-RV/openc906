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
module aq_ifu_pcgen(
  btb_pcgen_tar_pc,
  btb_xx_chgflw_vld,
  cp0_ifu_icg_en,
  cp0_xx_mrvbr,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  icache_pcgen_addr,
  icache_pcgen_grant,
  icache_pcgen_grant_gate,
  icache_pcgen_inst_vld,
  icache_pcgen_inst_vld_gate,
  ifu_iu_chgflw_pc,
  ifu_iu_chgflw_vld,
  ipack_pcgen_reissue,
  iu_ifu_tar_pc,
  iu_ifu_tar_pc_vld,
  iu_ifu_tar_pc_vld_gate,
  pad_yy_icg_scan_en,
  pcgen_btb_ifpc,
  pcgen_ctrl_chgflw_vld,
  pcgen_ibuf_chgflw_vld,
  pcgen_icache_chgflw_vld,
  pcgen_icache_seq_tag,
  pcgen_icache_va,
  pcgen_pred_flush_vld,
  pcgen_pred_ifpc,
  pcgen_top_buf_chgflw,
  pred_pcgen_chgflw_pc,
  pred_pcgen_chgflw_vld,
  pred_pcgen_chgflw_vld_gate,
  pred_pcgen_curflw_pc,
  pred_pcgen_curflw_vld,
  pred_pcgen_curflw_vld_gate,
  rtu_ifu_chgflw_pc,
  rtu_ifu_chgflw_vld,
  vec_pcgen_idle,
  vec_pcgen_rst_vld
);

// &Ports; @24
input   [39:0]  btb_pcgen_tar_pc;           
input           btb_xx_chgflw_vld;          
input           cp0_ifu_icg_en;             
input   [39:0]  cp0_xx_mrvbr;               
input           cp0_yy_clk_en;              
input           cpurst_b;                   
input           forever_cpuclk;             
input   [39:0]  icache_pcgen_addr;          
input           icache_pcgen_grant;         
input           icache_pcgen_grant_gate;    
input           icache_pcgen_inst_vld;      
input           icache_pcgen_inst_vld_gate; 
input           ipack_pcgen_reissue;        
input   [63:0]  iu_ifu_tar_pc;              
input           iu_ifu_tar_pc_vld;          
input           iu_ifu_tar_pc_vld_gate;     
input           pad_yy_icg_scan_en;         
input   [39:0]  pred_pcgen_chgflw_pc;       
input           pred_pcgen_chgflw_vld;      
input           pred_pcgen_chgflw_vld_gate; 
input   [39:0]  pred_pcgen_curflw_pc;       
input           pred_pcgen_curflw_vld;      
input           pred_pcgen_curflw_vld_gate; 
input   [39:0]  rtu_ifu_chgflw_pc;          
input           rtu_ifu_chgflw_vld;         
input           vec_pcgen_idle;             
input           vec_pcgen_rst_vld;          
output  [39:0]  ifu_iu_chgflw_pc;           
output          ifu_iu_chgflw_vld;          
output  [39:0]  pcgen_btb_ifpc;             
output          pcgen_ctrl_chgflw_vld;      
output          pcgen_ibuf_chgflw_vld;      
output          pcgen_icache_chgflw_vld;    
output  [33:0]  pcgen_icache_seq_tag;       
output  [63:0]  pcgen_icache_va;            
output          pcgen_pred_flush_vld;       
output  [39:0]  pcgen_pred_ifpc;            
output          pcgen_top_buf_chgflw;       

// &Regs; @25
reg             pcgen_buf_chgflw;           
reg     [63:0]  pcgen_ifpc;                 
reg     [39:0]  pcgen_pipe_ifpc;            

// &Wires; @26
wire    [39:0]  btb_pcgen_tar_pc;           
wire            btb_xx_chgflw_vld;          
wire            cp0_ifu_icg_en;             
wire    [39:0]  cp0_xx_mrvbr;               
wire            cp0_yy_clk_en;              
wire            cpurst_b;                   
wire            forever_cpuclk;             
wire    [39:0]  icache_pcgen_addr;          
wire            icache_pcgen_grant;         
wire            icache_pcgen_grant_gate;    
wire            icache_pcgen_inst_vld;      
wire            icache_pcgen_inst_vld_gate; 
wire    [39:0]  ifu_iu_chgflw_pc;           
wire            ifu_iu_chgflw_vld;          
wire            ipack_pcgen_reissue;        
wire    [63:0]  iu_ifu_tar_pc;              
wire            iu_ifu_tar_pc_vld;          
wire            iu_ifu_tar_pc_vld_gate;     
wire            pad_yy_icg_scan_en;         
wire    [39:0]  pcgen_br_chgflw_pc;         
wire            pcgen_br_chgflw_vld;        
wire    [39:0]  pcgen_btb_ifpc;             
wire            pcgen_chgflw_btb;           
wire            pcgen_chgflw_cur;           
wire            pcgen_cpuclk;               
wire            pcgen_ctrl_chgflw_vld;      
wire    [39:0]  pcgen_delay_chgflw_pc;      
wire            pcgen_delay_chgflw_vld;     
wire            pcgen_delay_chgflw_vld_gate; 
wire    [63:0]  pcgen_fetch_pc;             
wire            pcgen_ibuf_chgflw_vld;      
wire            pcgen_icache_chgflw_vld;    
wire    [33:0]  pcgen_icache_seq_tag;       
wire    [63:0]  pcgen_icache_va;            
wire            pcgen_icg_en;               
wire    [63:0]  pcgen_ifpc_inc;             
wire            pcgen_pred_flush_vld;       
wire    [39:0]  pcgen_pred_ifpc;            
wire            pcgen_top_buf_chgflw;       
wire    [39:0]  pred_pcgen_chgflw_pc;       
wire            pred_pcgen_chgflw_vld;      
wire            pred_pcgen_chgflw_vld_gate; 
wire    [39:0]  pred_pcgen_curflw_pc;       
wire            pred_pcgen_curflw_vld;      
wire            pred_pcgen_curflw_vld_gate; 
wire    [39:0]  rtu_ifu_chgflw_pc;          
wire            rtu_ifu_chgflw_vld;         
wire            vec_pcgen_rst_vld;          


//==========================================================
// PC Generator Module
// 1. ICG Instance
// 2. Judge the priority of PC sources
// 3. IF PC Maintain
//==========================================================

//------------------------------------------------
// 1. ICG Instance
//------------------------------------------------
assign pcgen_icg_en = pcgen_delay_chgflw_vld_gate
                   || pcgen_buf_chgflw
                   || pred_pcgen_curflw_vld_gate
                   || btb_xx_chgflw_vld
                   || icache_pcgen_inst_vld_gate
                   || icache_pcgen_grant_gate
                   || vec_pcgen_rst_vld;
// &Instance("gated_clk_cell", "x_ifu_pcgen_icg_cell"); @45
gated_clk_cell  x_ifu_pcgen_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pcgen_cpuclk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (pcgen_icg_en      ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @46
//          .external_en (1'b0), @47
//          .global_en   (cp0_yy_clk_en), @48
//          .module_en   (cp0_ifu_icg_en), @49
//          .local_en    (pcgen_icg_en), @50
//          .clk_out     (pcgen_cpuclk) @51
//        ); @52

//assign pcgen_high_icg_en = iu_ifu_tar_pc_vld
//                        || pcgen_high_upd
//                        || vec_pcgen_rst_vld;
//&Instance("gated_clk_cell", "x_ifu_pcgen_high_icg_cell");
// //&Connect(.clk_in      (forever_cpuclk), @58
// //         .external_en (1'b0), @59
// //         .global_en   (cp0_yy_clk_en), @60
// //         .module_en   (1'b0), @61
// //         .local_en    (pcgen_high_icg_en), @62
// //         .clk_out     (pcgen_high_cpuclk) @63
// //       ); @64
//------------------------------------------------
// 2. Judge the priority of PC sources
// a. Delayed change flow: RTU > BJU > Pred
// b. Normal change flow: BTB > Inc
//------------------------------------------------
// a. Delayed change flow: RTU > BJU > Pred
// Following change flow are delayed for timing
assign pcgen_br_chgflw_vld      = (iu_ifu_tar_pc_vld || pred_pcgen_chgflw_vld)
                               && !rtu_ifu_chgflw_vld;
assign pcgen_br_chgflw_pc[39:0] = iu_ifu_tar_pc_vld ? iu_ifu_tar_pc[39:0]
                                                    : pred_pcgen_chgflw_pc[39:0];
assign pcgen_delay_chgflw_vld      = rtu_ifu_chgflw_vld
                                  || iu_ifu_tar_pc_vld
                                  || pred_pcgen_chgflw_vld;
assign pcgen_delay_chgflw_vld_gate = rtu_ifu_chgflw_vld
                                  || iu_ifu_tar_pc_vld_gate
                                  || pred_pcgen_chgflw_vld_gate;
assign pcgen_delay_chgflw_pc[39:0] = {40{rtu_ifu_chgflw_vld}}  & rtu_ifu_chgflw_pc[39:0]
                                   | {40{pcgen_br_chgflw_vld}} & pcgen_br_chgflw_pc[39:0];

always @ (posedge pcgen_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pcgen_buf_chgflw <= 1'b0;
  else if(pcgen_delay_chgflw_vld)
    pcgen_buf_chgflw <= 1'b1;
  else if(pcgen_buf_chgflw)
    pcgen_buf_chgflw <= 1'b0;
end

//------------------------------------------------
// 3. IF PC Maintain
// a. Normal IFPC for 40-bit Virtual PC
// b. High IFPC for 64-bit PC validation
//------------------------------------------------
// a. Normal IFPC for 40-bit Virtual PC
always @ (posedge pcgen_cpuclk)
begin
  if(vec_pcgen_rst_vld)
    pcgen_ifpc[39:0] <= cp0_xx_mrvbr[39:0];
  else if(pcgen_delay_chgflw_vld)
    pcgen_ifpc[39:0] <= pcgen_delay_chgflw_pc[39:0];
  else if(pcgen_chgflw_cur && !icache_pcgen_grant)
    pcgen_ifpc[39:0] <= pcgen_fetch_pc[39:0];
  else if(ipack_pcgen_reissue && icache_pcgen_inst_vld)
    pcgen_ifpc[39:0] <= icache_pcgen_addr[39:0];
  else if(pcgen_chgflw_btb && !icache_pcgen_grant)
    pcgen_ifpc[39:0] <= pcgen_fetch_pc[39:0];
  else if(icache_pcgen_grant)
    pcgen_ifpc[39:0] <= pcgen_ifpc_inc[39:0];
  else
    pcgen_ifpc[39:0] <= pcgen_ifpc[39:0];
end

// b. High IFPC for 64-bit PC validation
//assign pcgen_high_upd = pcgen_ifpc_inc[40] ^ pcgen_ifpc[40];
always @ (posedge pcgen_cpuclk)
begin
  if(vec_pcgen_rst_vld)
    pcgen_ifpc[63:40] <= 24'b0;
  else if(iu_ifu_tar_pc_vld && !rtu_ifu_chgflw_vld)
    pcgen_ifpc[63:40] <= iu_ifu_tar_pc[63:40];
  else if(pcgen_delay_chgflw_vld)
    pcgen_ifpc[63:40] <= {24{pcgen_delay_chgflw_pc[39]}};
  else if(pcgen_chgflw_cur && !icache_pcgen_grant)
    pcgen_ifpc[63:40] <= pcgen_fetch_pc[63:40];
  else if(ipack_pcgen_reissue && icache_pcgen_inst_vld)
    pcgen_ifpc[63:40] <= {24{icache_pcgen_addr[39]}};
  else if(pcgen_chgflw_btb && !icache_pcgen_grant)
    pcgen_ifpc[63:40] <= pcgen_fetch_pc[63:40];
  else if(icache_pcgen_grant)
    pcgen_ifpc[63:40] <= pcgen_ifpc_inc[63:40];
  else
    pcgen_ifpc[63:40] <= pcgen_ifpc[63:40];
end

assign pcgen_ifpc_inc[63:0] = {pcgen_fetch_pc[63:2], 2'b0} + 64'h4;

assign pcgen_chgflw_btb     = btb_xx_chgflw_vld && !pcgen_buf_chgflw;
assign pcgen_chgflw_cur     = pred_pcgen_curflw_vld && !pcgen_buf_chgflw;
assign pcgen_fetch_pc[63:0] = pcgen_chgflw_cur ? {{24{pred_pcgen_curflw_pc[39]}}, pred_pcgen_curflw_pc[39:0]}
                            : pcgen_chgflw_btb ? {{24{btb_pcgen_tar_pc[39]}}, btb_pcgen_tar_pc[39:0]}
                                               : pcgen_ifpc[63:0];

always @ (posedge pcgen_cpuclk)
begin
  if(vec_pcgen_rst_vld)
    pcgen_pipe_ifpc[39:0] <= cp0_xx_mrvbr[39:0];
  else if(icache_pcgen_grant)
    pcgen_pipe_ifpc[39:0] <= pcgen_fetch_pc[39:0];
  else
    pcgen_pipe_ifpc[39:0] <= pcgen_pipe_ifpc[39:0];
end

//==========================================================
// Rename for Output
//==========================================================

// Output to Ctrl
assign pcgen_ctrl_chgflw_vld = pcgen_delay_chgflw_vld || pred_pcgen_curflw_vld
                            || pcgen_buf_chgflw;

// Output to I-Buf
assign pcgen_ibuf_chgflw_vld = rtu_ifu_chgflw_vld
                            || iu_ifu_tar_pc_vld;

// Output to ICACHE
assign pcgen_icache_chgflw_vld = pcgen_delay_chgflw_vld || pred_pcgen_curflw_vld
                              || pcgen_buf_chgflw || btb_xx_chgflw_vld;
assign pcgen_icache_va[63:0]   = pcgen_fetch_pc[63:0];
assign pcgen_icache_seq_tag[33:0] = pcgen_ifpc[39:6];

// Output to BTB
assign pcgen_btb_ifpc[39:0]  = {pcgen_ifpc[39:16], pcgen_fetch_pc[15:0]};

// Output to Prediction
assign pcgen_pred_flush_vld  = rtu_ifu_chgflw_vld
                            || iu_ifu_tar_pc_vld;
assign pcgen_pred_ifpc[39:0] = pcgen_pipe_ifpc[39:0];

// Output to Top
assign pcgen_top_buf_chgflw  = pcgen_buf_chgflw;

// Output to IU
assign ifu_iu_chgflw_vld      = rtu_ifu_chgflw_vld;
assign ifu_iu_chgflw_pc[39:0] = pcgen_delay_chgflw_pc[39:0];

// &Force("input", "vec_pcgen_idle"); @192
// &Force("nonport", "rst_done"); @194

// &ModuleEnd; @224
endmodule


