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
module aq_idu_id_gpr_gated_reg(
  cp0_idu_icg_en,
  cp0_yy_clk_en,
  forever_cpuclk,
  pad_yy_icg_scan_en,
  read_data_y,
  rtu_idu_wb0_data,
  rtu_idu_wb1_data,
  wb0_vld_x,
  wb1_vld_x
);

// &Ports; @24
input           cp0_idu_icg_en;    
input           cp0_yy_clk_en;     
input           forever_cpuclk;    
input           pad_yy_icg_scan_en; 
input   [63:0]  rtu_idu_wb0_data;  
input   [63:0]  rtu_idu_wb1_data;  
input           wb0_vld_x;         
input           wb1_vld_x;         
output  [63:0]  read_data_y;       

// &Regs; @25
reg     [63:0]  reg_dout;          
reg     [63:0]  write_data;        

// &Wires; @26
wire            cp0_idu_icg_en;    
wire            cp0_yy_clk_en;     
wire            forever_cpuclk;    
wire            pad_yy_icg_scan_en; 
wire    [63:0]  read_data_y;       
wire            reg_clk;           
wire            reg_clk_en;        
wire    [63:0]  rtu_idu_wb0_data;  
wire    [63:0]  rtu_idu_wb1_data;  
wire            wb0_vld_x;         
wire            wb1_vld_x;         
wire            write_en;          



//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign reg_clk_en = write_en;
// &Instance("gated_clk_cell", "x_reg_gated_clk"); @33
gated_clk_cell  x_reg_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (reg_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (reg_clk_en        ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @34
//          .external_en (1'b0), @35
//          .global_en   (cp0_yy_clk_en), @36
//          .module_en   (cp0_idu_icg_en), @37
//          .local_en    (reg_clk_en), @38
//          .clk_out     (reg_clk)); @39

//==========================================================
//                     Write Port
//==========================================================
assign write_en = wb0_vld_x || wb1_vld_x;
// &CombBeg; @45
always @( rtu_idu_wb1_data[63:0]
       or rtu_idu_wb0_data[63:0]
       or wb1_vld_x
       or wb0_vld_x
       or reg_dout[63:0])
begin
  case ({wb1_vld_x,wb0_vld_x})
    2'b01  : write_data[63:0] = rtu_idu_wb0_data[63:0];
    2'b10  : write_data[63:0] = rtu_idu_wb1_data[63:0];
    default: write_data[63:0] = reg_dout[63:0];
  endcase
// &CombEnd; @51
end

//==========================================================
//                     Preg Register
//==========================================================
always @(posedge reg_clk)
begin
    reg_dout[63:0] <= write_data[63:0];
end

assign read_data_y[63:0] = write_data[63:0];

// &ModuleEnd; @63
endmodule


