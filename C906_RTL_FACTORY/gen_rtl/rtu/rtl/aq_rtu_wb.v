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
module aq_rtu_wb(
  cp0_rtu_icg_en,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  ifu_rtu_warm_up,
  lsu_rtu_wb_data,
  lsu_rtu_wb_dest_reg,
  lsu_rtu_wb_vld,
  pad_yy_icg_scan_en,
  rbus_wb_rbus_wb_data,
  rbus_wb_rbus_wb_dp,
  rbus_wb_rbus_wb_preg,
  rbus_wb_rbus_wb_vld,
  rtu_cp0_fflags,
  rtu_cp0_fflags_updt,
  rtu_cp0_vxsat,
  rtu_cp0_vxsat_vld,
  rtu_idu_wb0_data,
  rtu_idu_wb0_reg,
  rtu_idu_wb0_vld,
  rtu_idu_wb1_data,
  rtu_idu_wb1_reg,
  rtu_idu_wb1_vld,
  rtu_vpu_gpr_wb_grnt,
  vpu_rtu_fflag,
  vpu_rtu_fflag_vld,
  vpu_rtu_gpr_wb_data,
  vpu_rtu_gpr_wb_index,
  vpu_rtu_gpr_wb_req,
  wb_retire_wb_no_op
);


// &Ports; @25
input           cp0_rtu_icg_en;      
input           cp0_yy_clk_en;       
input           cpurst_b;            
input           forever_cpuclk;      
input           ifu_rtu_warm_up;     
input   [63:0]  lsu_rtu_wb_data;     
input   [5 :0]  lsu_rtu_wb_dest_reg; 
input           lsu_rtu_wb_vld;      
input           pad_yy_icg_scan_en;  
input   [63:0]  rbus_wb_rbus_wb_data; 
input           rbus_wb_rbus_wb_dp;  
input   [5 :0]  rbus_wb_rbus_wb_preg; 
input           rbus_wb_rbus_wb_vld; 
input   [5 :0]  vpu_rtu_fflag;       
input           vpu_rtu_fflag_vld;   
input   [63:0]  vpu_rtu_gpr_wb_data; 
input   [5 :0]  vpu_rtu_gpr_wb_index; 
input           vpu_rtu_gpr_wb_req;  
output  [4 :0]  rtu_cp0_fflags;      
output          rtu_cp0_fflags_updt; 
output          rtu_cp0_vxsat;       
output          rtu_cp0_vxsat_vld;   
output  [63:0]  rtu_idu_wb0_data;    
output  [5 :0]  rtu_idu_wb0_reg;     
output          rtu_idu_wb0_vld;     
output  [63:0]  rtu_idu_wb1_data;    
output  [5 :0]  rtu_idu_wb1_reg;     
output          rtu_idu_wb1_vld;     
output          rtu_vpu_gpr_wb_grnt; 
output          wb_retire_wb_no_op;  

// &Regs; @26
reg             wb_rbus_wb_vld;      
reg     [63:0]  wb_wb_rbus_data;     
reg     [5 :0]  wb_wb_rbus_preg;     

// &Wires; @27
wire            cp0_rtu_icg_en;      
wire            cp0_yy_clk_en;       
wire            cpurst_b;            
wire            forever_cpuclk;      
wire            ifu_rtu_warm_up;     
wire    [63:0]  lsu_rtu_wb_data;     
wire    [5 :0]  lsu_rtu_wb_dest_reg; 
wire            lsu_rtu_wb_vld;      
wire            pad_yy_icg_scan_en;  
wire            rbus_wb_clk;         
wire            rbus_wb_clk_en;      
wire    [63:0]  rbus_wb_rbus_wb_data; 
wire            rbus_wb_rbus_wb_dp;  
wire    [5 :0]  rbus_wb_rbus_wb_preg; 
wire            rbus_wb_rbus_wb_vld; 
wire    [4 :0]  rtu_cp0_fflags;      
wire            rtu_cp0_fflags_updt; 
wire            rtu_cp0_vxsat;       
wire            rtu_cp0_vxsat_vld;   
wire    [63:0]  rtu_idu_wb0_data;    
wire    [5 :0]  rtu_idu_wb0_reg;     
wire            rtu_idu_wb0_vld;     
wire    [63:0]  rtu_idu_wb1_data;    
wire    [5 :0]  rtu_idu_wb1_reg;     
wire            rtu_idu_wb1_vld;     
wire            rtu_vpu_gpr_wb_grnt; 
wire    [5 :0]  vpu_rtu_fflag;       
wire            vpu_rtu_fflag_vld;   
wire    [63:0]  vpu_rtu_gpr_wb_data; 
wire    [5 :0]  vpu_rtu_gpr_wb_index; 
wire            vpu_rtu_gpr_wb_req;  
wire            wb_clk;              
wire            wb_clk_en;           
wire            wb_lsu_wb_vld;       
wire            wb_retire_wb_no_op;  
wire    [63:0]  wb_vpu_data;         
wire    [5 :0]  wb_vpu_preg;         
wire            wb_vpu_wb_grant;     
wire            wb_vpu_wb_vld;       
wire    [63:0]  wb_wb0_data;         
wire    [5 :0]  wb_wb0_preg;         
wire            wb_wb0_vld;          
wire    [63:0]  wb_wb1_data;         
wire    [5 :0]  wb_wb1_preg;         
wire            wb_wb1_vld;          
wire    [63:0]  wb_wb_lsu_data;      
wire    [5 :0]  wb_wb_lsu_reg;       


//==========================================================
//                        WriteBack
//==========================================================
// Have 2 wb ports:
//   1. Rbus
//   2. LSU
//----------------------------------------------------------
//                         Control
//----------------------------------------------------------
always @ (posedge wb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wb_rbus_wb_vld <= 1'b0;
  else
    wb_rbus_wb_vld <= rbus_wb_rbus_wb_vld;
end

assign wb_lsu_wb_vld = lsu_rtu_wb_vld;

//----------------------------------------------------------
//                      Rbus Datapath
//----------------------------------------------------------
always @ (posedge rbus_wb_clk)
begin
  if (rbus_wb_rbus_wb_dp || ifu_rtu_warm_up) begin
    wb_wb_rbus_preg[5:0]   <= rbus_wb_rbus_wb_preg[5:0];
    wb_wb_rbus_data[63:0]  <= rbus_wb_rbus_wb_data[63:0];
  end
end

//----------------------------------------------------------
//                       VPU Datapath
//----------------------------------------------------------
assign wb_vpu_wb_vld     = vpu_rtu_gpr_wb_req;
assign wb_vpu_preg[5:0]  = vpu_rtu_gpr_wb_index[5:0];
assign wb_vpu_data[63:0] = vpu_rtu_gpr_wb_data[63:0];

assign wb_vpu_wb_grant   = !wb_rbus_wb_vld;

//----------------------------------------------------------
//                       LSU Datapath
//----------------------------------------------------------
assign wb_wb_lsu_reg[5:0]   = lsu_rtu_wb_dest_reg[5:0];
assign wb_wb_lsu_data[63:0] = lsu_rtu_wb_data[63:0];

//----------------------------------------------------------
//                     WriteBack Port0
//----------------------------------------------------------
assign wb_wb0_vld        = wb_rbus_wb_vld || wb_vpu_wb_vld;
assign wb_wb0_preg[5:0]  = wb_rbus_wb_vld ? wb_wb_rbus_preg[5:0]
                                          : wb_vpu_preg[5:0];
assign wb_wb0_data[63:0] = wb_rbus_wb_vld ? wb_wb_rbus_data[63:0]
                                          : wb_vpu_data[63:0];

//----------------------------------------------------------
//                     WriteBack Port1
//----------------------------------------------------------
assign wb_wb1_vld        = wb_lsu_wb_vld;
assign wb_wb1_preg[5:0]  = wb_wb_lsu_reg[5:0];
assign wb_wb1_data[63:0] = wb_wb_lsu_data[63:0];

//==========================================================
//                           ICG
//==========================================================
assign wb_clk_en = wb_rbus_wb_vld
                || rbus_wb_rbus_wb_dp;
// &Instance("gated_clk_cell", "x_wb_clk"); @95
gated_clk_cell  x_wb_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (wb_clk            ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (wb_clk_en         ),
  .module_en          (cp0_rtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @96
//          .external_en (1'b0), @97
//          .global_en   (cp0_yy_clk_en), @98
//          .module_en   (cp0_rtu_icg_en), @99
//          .local_en    (wb_clk_en), @100
//          .clk_out     (wb_clk)); @101

assign rbus_wb_clk_en = rbus_wb_rbus_wb_dp
                     || ifu_rtu_warm_up;
// &Instance("gated_clk_cell", "x_rbus_wb_clk"); @105
gated_clk_cell  x_rbus_wb_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (rbus_wb_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (rbus_wb_clk_en    ),
  .module_en          (cp0_rtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @106
//          .external_en (1'b0), @107
//          .global_en   (cp0_yy_clk_en), @108
//          .module_en   (cp0_rtu_icg_en), @109
//          .local_en    (rbus_wb_clk_en), @110
//          .clk_out     (rbus_wb_clk)); @111
//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign wb_retire_wb_no_op = !wb_wb0_vld
                         && !wb_wb1_vld;

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign rtu_idu_wb1_vld        = wb_wb1_vld;
assign rtu_idu_wb1_reg[5:0]   = wb_wb1_preg[5:0];
assign rtu_idu_wb1_data[63:0] = wb_wb1_data[63:0];

assign rtu_idu_wb0_vld        = wb_wb0_vld;
assign rtu_idu_wb0_reg[5:0]   = wb_wb0_preg[5:0];
assign rtu_idu_wb0_data[63:0] = wb_wb0_data[63:0];

//----------------------------------------------------------
//                         For Pad
//----------------------------------------------------------

//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign rtu_cp0_fflags_updt = vpu_rtu_fflag_vld;
assign rtu_cp0_fflags[4:0] = vpu_rtu_fflag[4:0];

assign rtu_cp0_vxsat_vld   = vpu_rtu_fflag_vld;
assign rtu_cp0_vxsat       = vpu_rtu_fflag[5];

//----------------------------------------------------------
//                         For VPU
//----------------------------------------------------------
assign rtu_vpu_gpr_wb_grnt = wb_vpu_wb_grant;

// &ModuleEnd; @159
endmodule



