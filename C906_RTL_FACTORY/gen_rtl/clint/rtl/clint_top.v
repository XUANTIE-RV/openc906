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
module clint_top(
  apb_clk_en,
  ciu_clk,
  clint_core0_ms_int,
  clint_core0_mt_int,
  clint_core0_ss_int,
  clint_core0_st_int,
  clint_core0_time,
  cpurst_b,
  forever_apbclk,
  pad_yy_icg_scan_en,
  paddr,
  penable,
  perr_clint,
  pprot,
  prdata_clint,
  pready_clint,
  psel_clint,
  pwdata,
  pwrite,
  sysio_clint_mtime
);

// &Ports; @25
input           apb_clk_en;        
input           ciu_clk;           
input           cpurst_b;          
input           forever_apbclk;    
input           pad_yy_icg_scan_en; 
input   [31:0]  paddr;             
input           penable;           
input   [1 :0]  pprot;             
input           psel_clint;        
input   [31:0]  pwdata;            
input           pwrite;            
input   [63:0]  sysio_clint_mtime; 
output          clint_core0_ms_int; 
output          clint_core0_mt_int; 
output          clint_core0_ss_int; 
output          clint_core0_st_int; 
output  [63:0]  clint_core0_time;  
output          perr_clint;        
output  [31:0]  prdata_clint;      
output          pready_clint;      

// &Regs; @26

// &Wires; @27
wire            apb_clk_en;        
wire            ciu_clk;           
wire            clint_core0_ms_int; 
wire            clint_core0_mt_int; 
wire            clint_core0_ss_int; 
wire            clint_core0_st_int; 
wire    [63:0]  clint_core0_time;  
wire            cpurst_b;          
wire            forever_apbclk;    
wire            pad_yy_icg_scan_en; 
wire    [31:0]  paddr;             
wire            penable;           
wire            perr_clint;        
wire    [1 :0]  pprot;             
wire    [31:0]  prdata_clint;      
wire            pready_clint;      
wire            psel_clint;        
wire    [31:0]  pwdata;            
wire            pwrite;            
wire    [63:0]  sysio_clint_mtime; 


//==========================================================
// Instance clint func
//==========================================================
// &Instance("clint_func"); @32
clint_func  x_clint_func (
  .apb_clk_en         (apb_clk_en        ),
  .ciu_clk            (ciu_clk           ),
  .clint_core0_ms_int (clint_core0_ms_int),
  .clint_core0_mt_int (clint_core0_mt_int),
  .clint_core0_ss_int (clint_core0_ss_int),
  .clint_core0_st_int (clint_core0_st_int),
  .clint_core0_time   (clint_core0_time  ),
  .cpurst_b           (cpurst_b          ),
  .forever_apbclk     (forever_apbclk    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en),
  .paddr              (paddr             ),
  .penable            (penable           ),
  .perr_clint         (perr_clint        ),
  .pprot              (pprot             ),
  .prdata_clint       (prdata_clint      ),
  .pready_clint       (pready_clint      ),
  .psel_clint         (psel_clint        ),
  .pwdata             (pwdata            ),
  .pwrite             (pwrite            ),
  .sysio_clint_mtime  (sysio_clint_mtime )
);



// &ModuleEnd; @35
endmodule



