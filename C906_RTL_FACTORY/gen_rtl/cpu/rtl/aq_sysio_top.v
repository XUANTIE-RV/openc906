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

// &ModuleBeg; @24
module aq_sysio_top(
  apb_clk_en,
  axim_clk_en,
  clint_core0_ms_int,
  clint_core0_mt_int,
  clint_core0_ss_int,
  clint_core0_st_int,
  core0_pad_lpmd_b,
  core0_sysio_lpmd_b,
  cpurst_b,
  forever_cpuclk,
  l2c_plic_ecc_int_vld,
  pad_cpu_apb_base,
  pad_cpu_rvba,
  pad_cpu_sys_cnt,
  pad_yy_icg_scan_en,
  plic_core0_me_int,
  plic_core0_se_int,
  sysio_biu_apb_base,
  sysio_clint_mtime,
  sysio_core0_hartid,
  sysio_core0_me_int,
  sysio_core0_ms_int,
  sysio_core0_mt_int,
  sysio_core0_se_int,
  sysio_core0_ss_int,
  sysio_core0_st_int,
  sysio_cp0_apb_base,
  sysio_xx_rvba
);

// &Ports; @25
input           apb_clk_en;          
input           axim_clk_en;         
input           clint_core0_ms_int;  
input           clint_core0_mt_int;  
input           clint_core0_ss_int;  
input           clint_core0_st_int;  
input   [1 :0]  core0_sysio_lpmd_b;  
input           cpurst_b;            
input           forever_cpuclk;      
input   [39:0]  pad_cpu_apb_base;    
input   [39:0]  pad_cpu_rvba;        
input   [63:0]  pad_cpu_sys_cnt;     
input           pad_yy_icg_scan_en;  
input           plic_core0_me_int;   
input           plic_core0_se_int;   
output  [1 :0]  core0_pad_lpmd_b;    
output          l2c_plic_ecc_int_vld; 
output  [39:0]  sysio_biu_apb_base;  
output  [63:0]  sysio_clint_mtime;   
output  [2 :0]  sysio_core0_hartid;  
output          sysio_core0_me_int;  
output          sysio_core0_ms_int;  
output          sysio_core0_mt_int;  
output          sysio_core0_se_int;  
output          sysio_core0_ss_int;  
output          sysio_core0_st_int;  
output  [39:0]  sysio_cp0_apb_base;  
output  [39:0]  sysio_xx_rvba;       

// &Regs; @26
reg     [12:0]  apb_base;            
reg     [63:0]  ccvr;                
reg             rvba_rst;            
reg     [39:0]  sysio_xx_rvba;       

// &Wires; @27
wire            apb_base_clk;        
wire            apb_base_clk_en;     
wire            apb_clk_en;          
wire            axim_clk_en;         
wire            ccvr_clk;            
wire            ccvr_clk_en;         
wire            clint_core0_ms_int;  
wire            clint_core0_mt_int;  
wire            clint_core0_ss_int;  
wire            clint_core0_st_int;  
wire    [1 :0]  core0_pad_lpmd_b;    
wire    [1 :0]  core0_sysio_lpmd_b;  
wire            cpurst_b;            
wire            forever_cpuclk;      
wire            l2c_plic_ecc_int_vld; 
wire    [39:0]  pad_cpu_apb_base;    
wire    [39:0]  pad_cpu_rvba;        
wire    [63:0]  pad_cpu_sys_cnt;     
wire            pad_yy_icg_scan_en;  
wire            plic_core0_me_int;   
wire            plic_core0_se_int;   
wire            rvba_clk;            
wire    [39:0]  sysio_biu_apb_base;  
wire    [63:0]  sysio_clint_mtime;   
wire    [2 :0]  sysio_core0_hartid;  
wire            sysio_core0_me_int;  
wire            sysio_core0_ms_int;  
wire            sysio_core0_mt_int;  
wire            sysio_core0_se_int;  
wire            sysio_core0_ss_int;  
wire            sysio_core0_st_int;  
wire    [39:0]  sysio_cp0_apb_base;  


//================================================
//      system counter value to PTIM
//================================================
assign ccvr_clk_en = axim_clk_en;

// &Instance("gated_clk_cell", "x_ccvr_gated_clk"); @34
gated_clk_cell  x_ccvr_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ccvr_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ccvr_clk_en       ),
  .module_en          (1'b0              ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @35
//          .external_en (1'b0          ), @36
//          .global_en   (1'b1          ), @37
//          .module_en   (1'b0          ). @38
//          .local_en    (ccvr_clk_en   ), @39
//          .clk_out     (ccvr_clk      ) @40
//         ); @41

always@(posedge ccvr_clk)
begin
  if (axim_clk_en)
    ccvr[63:0] <= pad_cpu_sys_cnt[63:0];
  else
    ccvr[63:0] <= ccvr[63:0];
end

assign sysio_clint_mtime[63:0] = ccvr[63:0];

always@(posedge forever_cpuclk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rvba_rst <= 1'b1;
  else
    rvba_rst <= 1'b0;
end


// &Instance("gated_clk_cell", "x_aq_rvba_gated_clk"); @62
gated_clk_cell  x_aq_rvba_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (rvba_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (rvba_rst          ),
  .module_en          (1'b0              ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @63
//          .external_en (1'b0          ), @64
//          .global_en   (1'b1          ), @65
//          .module_en   (1'b0          ). @66
//          .local_en    (rvba_rst      ), @67
//          .clk_out     (rvba_clk      ) @68
//         ); @69

always @(posedge rvba_clk)
begin
  if(rvba_rst)
    sysio_xx_rvba[39:0] <= pad_cpu_rvba[39:0];
end

// &Force("bus","pad_cpu_apb_base",39,0); @77
assign apb_base_clk_en = axim_clk_en & |(apb_base[12:0] ^ pad_cpu_apb_base[39:27]);

// &Instance("gated_clk_cell", "x_aq_apb_base_gated_clk"); @80
gated_clk_cell  x_aq_apb_base_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (apb_base_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (apb_base_clk_en   ),
  .module_en          (1'b0              ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @81
//          .external_en (1'b0          ), @82
//          .global_en   (1'b1          ), @83
//          .module_en   (1'b0          ). @84
//          .local_en    (apb_base_clk_en), @85
//          .clk_out     (apb_base_clk   ) @86
//         ); @87

always @(posedge apb_base_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    apb_base[12:0] <= 13'b0;
  else if (axim_clk_en)
    apb_base[12:0] <= pad_cpu_apb_base[39:27];
end

assign sysio_biu_apb_base[39:0] = {apb_base[12:0], 27'b0};
assign sysio_cp0_apb_base[39:0] = {apb_base[12:0], 27'b0};

assign l2c_plic_ecc_int_vld = 1'b0;

// &ConnRule(s/core_/core0_/); @102
// &Instance("aq_sysio_kid", "x_aq_sysio_core0"); @103
aq_sysio_kid  x_aq_sysio_core0 (
  .apb_clk_en         (apb_clk_en        ),
  .axim_clk_en        (axim_clk_en       ),
  .clint_core_ms_int  (clint_core0_ms_int),
  .clint_core_mt_int  (clint_core0_mt_int),
  .clint_core_ss_int  (clint_core0_ss_int),
  .clint_core_st_int  (clint_core0_st_int),
  .core_pad_lpmd_b    (core0_pad_lpmd_b  ),
  .core_sysio_lpmd_b  (core0_sysio_lpmd_b),
  .cpurst_b           (cpurst_b          ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .plic_core_me_int   (plic_core0_me_int ),
  .plic_core_se_int   (plic_core0_se_int ),
  .sysio_core_hartid  (sysio_core0_hartid),
  .sysio_core_me_int  (sysio_core0_me_int),
  .sysio_core_ms_int  (sysio_core0_ms_int),
  .sysio_core_mt_int  (sysio_core0_mt_int),
  .sysio_core_se_int  (sysio_core0_se_int),
  .sysio_core_ss_int  (sysio_core0_ss_int),
  .sysio_core_st_int  (sysio_core0_st_int)
);


// &ConnRule(s/core_/core1_/); @106
// &Instance("aq_sysio_kid", "x_aq_sysio_core1"); @107

// &ConnRule(s/core_/core2_/); @111
// &Instance("aq_sysio_kid", "x_aq_sysio_core2"); @112

// &ConnRule(s/core_/core3_/); @116
// &Instance("aq_sysio_kid", "x_aq_sysio_core3"); @117

// &ModuleEnd; @120
endmodule



