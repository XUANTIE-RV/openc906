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
module aq_sysio_kid(
  apb_clk_en,
  axim_clk_en,
  clint_core_ms_int,
  clint_core_mt_int,
  clint_core_ss_int,
  clint_core_st_int,
  core_pad_lpmd_b,
  core_sysio_lpmd_b,
  cpurst_b,
  forever_cpuclk,
  pad_yy_icg_scan_en,
  plic_core_me_int,
  plic_core_se_int,
  sysio_core_hartid,
  sysio_core_me_int,
  sysio_core_ms_int,
  sysio_core_mt_int,
  sysio_core_se_int,
  sysio_core_ss_int,
  sysio_core_st_int
);

// &Ports; @23
input          apb_clk_en;           
input          axim_clk_en;          
input          clint_core_ms_int;    
input          clint_core_mt_int;    
input          clint_core_ss_int;    
input          clint_core_st_int;    
input   [1:0]  core_sysio_lpmd_b;    
input          cpurst_b;             
input          forever_cpuclk;       
input          pad_yy_icg_scan_en;   
input          plic_core_me_int;     
input          plic_core_se_int;     
output  [1:0]  core_pad_lpmd_b;      
output  [2:0]  sysio_core_hartid;    
output         sysio_core_me_int;    
output         sysio_core_ms_int;    
output         sysio_core_mt_int;    
output         sysio_core_se_int;    
output         sysio_core_ss_int;    
output         sysio_core_st_int;    

// &Regs; @24
reg            clint_core_ms_int_cpu; 
reg            clint_core_mt_int_cpu; 
reg            clint_core_ss_int_cpu; 
reg            clint_core_st_int_cpu; 
reg     [1:0]  core_pad_lpmd_b;      
reg            plic_core_me_int_cpu; 
reg            plic_core_se_int_cpu; 

// &Wires; @25
wire           apb_clk_en;           
wire           axim_clk_en;          
wire           clint_core_ms_int;    
wire           clint_core_mt_int;    
wire           clint_core_ss_int;    
wire           clint_core_st_int;    
wire    [1:0]  core_sysio_lpmd_b;    
wire           cpurst_b;             
wire           forever_cpuclk;       
wire           kid_int_clk;          
wire           kid_int_clk_en;       
wire           pad_yy_icg_scan_en;   
wire           plic_core_me_int;     
wire           plic_core_se_int;     
wire           sysio_clk_en;         
wire    [2:0]  sysio_core_hartid;    
wire           sysio_core_me_int;    
wire           sysio_core_ms_int;    
wire           sysio_core_mt_int;    
wire           sysio_core_se_int;    
wire           sysio_core_ss_int;    
wire           sysio_core_st_int;    
wire           sysio_kid_clk;        


//input
assign sysio_clk_en = axim_clk_en;
// &Instance("gated_clk_cell", "x_sysio_kid_gated_clk"); @29
gated_clk_cell  x_sysio_kid_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (sysio_kid_clk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (sysio_clk_en      ),
  .module_en          (1'b0              ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @30
//          .external_en (1'b0          ), @31
//          .global_en   (1'b1          ), @32
//          .module_en   (1'b0          ). @33
//          .local_en    (sysio_clk_en  ), @34
//          .clk_out     (sysio_kid_clk ) @35
//         ); @36

//output
always @(posedge sysio_kid_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    core_pad_lpmd_b[1:0] <= 2'b11;
  end
  else if (axim_clk_en)
  begin
    core_pad_lpmd_b[1:0] <= core_sysio_lpmd_b[1:0];
  end
end

// &Force("output", "sysio_core_me_int"); @51
// &Force("output", "sysio_core_mt_int"); @52
// &Force("output", "sysio_core_ms_int"); @53
// &Force("output", "sysio_core_se_int"); @54
// &Force("output", "sysio_core_st_int"); @55
// &Force("output", "sysio_core_ss_int"); @56

assign kid_int_clk_en = apb_clk_en;
// &Instance("gated_clk_cell", "x_sysio_kid_int_gated_clk"); @59
gated_clk_cell  x_sysio_kid_int_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (kid_int_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (kid_int_clk_en    ),
  .module_en          (1'b0              ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @60
//          .external_en (1'b0          ), @61
//          .global_en   (1'b1          ), @62
//          .module_en   (1'b0          ). @63
//          .local_en    (kid_int_clk_en), @64
//          .clk_out     (kid_int_clk   ) @65
//         ); @66

always @(posedge kid_int_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    plic_core_me_int_cpu  <= 1'b0; 
    plic_core_se_int_cpu  <= 1'b0; 
    clint_core_ms_int_cpu <= 1'b0;
    clint_core_ss_int_cpu <= 1'b0;
    clint_core_mt_int_cpu <= 1'b0;
    clint_core_st_int_cpu <= 1'b0; 
  end
  else if (apb_clk_en)
  begin
    plic_core_me_int_cpu <= plic_core_me_int;
    plic_core_se_int_cpu <= plic_core_se_int;
    clint_core_ms_int_cpu <= clint_core_ms_int;
    clint_core_ss_int_cpu <= clint_core_ss_int;
    clint_core_mt_int_cpu <= clint_core_mt_int;
    clint_core_st_int_cpu <= clint_core_st_int;
  end
end

assign sysio_core_me_int =  plic_core_me_int_cpu;
assign sysio_core_se_int =  plic_core_se_int_cpu;
assign sysio_core_ms_int = clint_core_ms_int_cpu;
assign sysio_core_ss_int = clint_core_ss_int_cpu;
assign sysio_core_mt_int = clint_core_mt_int_cpu;
assign sysio_core_st_int = clint_core_st_int_cpu;

assign sysio_core_hartid[2:0] = 3'b0;

// &Force("output","core_pad_lpmd_b"); @100
// &ModuleEnd; @103
endmodule



