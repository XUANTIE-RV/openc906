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
module aq_pmp_top(
  cp0_pmp_addr,
  cp0_pmp_icg_en,
  cp0_pmp_wdata,
  cp0_pmp_wreg,
  cpurst_b,
  forever_cpuclk,
  mmu_pmp_chk1,
  mmu_pmp_pa,
  mmu_pmp_priv_mode,
  pad_yy_icg_scan_en,
  pmp_cp0_data,
  pmp_mmu_flg,
  pmp_mmu_hit_num,
  pmp_mmu_napot_cross
);

// &Ports; @25
input   [11:0]  cp0_pmp_addr;       
input           cp0_pmp_icg_en;     
input   [63:0]  cp0_pmp_wdata;      
input           cp0_pmp_wreg;       
input           cpurst_b;           
input           forever_cpuclk;     
input           mmu_pmp_chk1;       
input   [27:0]  mmu_pmp_pa;         
input   [1 :0]  mmu_pmp_priv_mode;  
input           pad_yy_icg_scan_en; 
output  [63:0]  pmp_cp0_data;       
output  [3 :0]  pmp_mmu_flg;        
output  [15:0]  pmp_mmu_hit_num;    
output          pmp_mmu_napot_cross; 

// &Regs; @26

// &Wires; @27
wire    [11:0]  cp0_pmp_addr;       
wire            cp0_pmp_icg_en;     
wire    [63:0]  cp0_pmp_wdata;      
wire            cp0_pmp_wreg;       
wire            cpuclk;             
wire            cpurst_b;           
wire            forever_cpuclk;     
wire            mmu_pmp_chk1;       
wire    [27:0]  mmu_pmp_pa;         
wire    [1 :0]  mmu_pmp_priv_mode;  
wire            pad_yy_icg_scan_en; 
wire    [63:0]  pmp_cp0_data;       
wire    [17:0]  pmp_csr_sel;        
wire    [17:0]  pmp_csr_wen;        
wire    [3 :0]  pmp_mmu_flg;        
wire    [15:0]  pmp_mmu_hit_num;    
wire            pmp_mmu_napot_cross; 
wire    [28:0]  pmpaddr0_value;     
wire    [28:0]  pmpaddr1_value;     
wire    [28:0]  pmpaddr2_value;     
wire    [28:0]  pmpaddr3_value;     
wire    [28:0]  pmpaddr4_value;     
wire    [28:0]  pmpaddr5_value;     
wire    [28:0]  pmpaddr6_value;     
wire    [28:0]  pmpaddr7_value;     
wire    [63:0]  pmpcfg0_value;      
wire    [63:0]  pmpcfg2_value;      
wire            wr_pmp_regs;        



parameter PMPCFG0   = 12'h3A0;
parameter PMPCFG2   = 12'h3A2;
parameter PMPADDR0  = 12'h3B0;
parameter PMPADDR1  = 12'h3B1;
parameter PMPADDR2  = 12'h3B2;
parameter PMPADDR3  = 12'h3B3;
parameter PMPADDR4  = 12'h3B4;
parameter PMPADDR5  = 12'h3B5;
parameter PMPADDR6  = 12'h3B6;
parameter PMPADDR7  = 12'h3B7;
parameter PMPADDR8  = 12'h3B8;
parameter PMPADDR9  = 12'h3B9;
parameter PMPADDR10 = 12'h3BA;
parameter PMPADDR11 = 12'h3BB;
parameter PMPADDR12 = 12'h3BC;
parameter PMPADDR13 = 12'h3BD;
parameter PMPADDR14 = 12'h3BE;
parameter PMPADDR15 = 12'h3BF;

assign pmp_csr_sel[0]  = cp0_pmp_addr[11:0] == PMPCFG0; 
assign pmp_csr_sel[1]  = cp0_pmp_addr[11:0] == PMPCFG2; 
assign pmp_csr_sel[2]  = cp0_pmp_addr[11:0] == PMPADDR0; 
assign pmp_csr_sel[3]  = cp0_pmp_addr[11:0] == PMPADDR1; 
assign pmp_csr_sel[4]  = cp0_pmp_addr[11:0] == PMPADDR2; 
assign pmp_csr_sel[5]  = cp0_pmp_addr[11:0] == PMPADDR3; 
assign pmp_csr_sel[6]  = cp0_pmp_addr[11:0] == PMPADDR4; 
assign pmp_csr_sel[7]  = cp0_pmp_addr[11:0] == PMPADDR5; 
assign pmp_csr_sel[8]  = cp0_pmp_addr[11:0] == PMPADDR6; 
assign pmp_csr_sel[9]  = cp0_pmp_addr[11:0] == PMPADDR7; 
assign pmp_csr_sel[10] = cp0_pmp_addr[11:0] == PMPADDR8; 
assign pmp_csr_sel[11] = cp0_pmp_addr[11:0] == PMPADDR9; 
assign pmp_csr_sel[12] = cp0_pmp_addr[11:0] == PMPADDR10; 
assign pmp_csr_sel[13] = cp0_pmp_addr[11:0] == PMPADDR11; 
assign pmp_csr_sel[14] = cp0_pmp_addr[11:0] == PMPADDR12; 
assign pmp_csr_sel[15] = cp0_pmp_addr[11:0] == PMPADDR13; 
assign pmp_csr_sel[16] = cp0_pmp_addr[11:0] == PMPADDR14; 
assign pmp_csr_sel[17] = cp0_pmp_addr[11:0] == PMPADDR15; 

assign pmp_csr_wen[17:0] = pmp_csr_sel[17:0] & {18{cp0_pmp_wreg}};

assign wr_pmp_regs = |pmp_csr_wen[17:0];

// &Instance("gated_clk_cell", "x_pmp_gated_clk"); @72
gated_clk_cell  x_pmp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (cpuclk            ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (wr_pmp_regs       ),
  .module_en          (cp0_pmp_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( @73
//          .clk_in      (forever_cpuclk), @74
//          .global_en   (1'b1          ), @75
//          .module_en   (cp0_pmp_icg_en), @76
//          .local_en    (wr_pmp_regs   ), @77
//          .external_en (1'b0          ), @78
//          .clk_out     (cpuclk        ), @79
//         ); @80

// &Instance("aq_pmp_regs"); @82
aq_pmp_regs  x_aq_pmp_regs (
  .cp0_pmp_wdata  (cp0_pmp_wdata ),
  .cpuclk         (cpuclk        ),
  .cpurst_b       (cpurst_b      ),
  .pmp_cp0_data   (pmp_cp0_data  ),
  .pmp_csr_sel    (pmp_csr_sel   ),
  .pmp_csr_wen    (pmp_csr_wen   ),
  .pmpaddr0_value (pmpaddr0_value),
  .pmpaddr1_value (pmpaddr1_value),
  .pmpaddr2_value (pmpaddr2_value),
  .pmpaddr3_value (pmpaddr3_value),
  .pmpaddr4_value (pmpaddr4_value),
  .pmpaddr5_value (pmpaddr5_value),
  .pmpaddr6_value (pmpaddr6_value),
  .pmpaddr7_value (pmpaddr7_value),
  .pmpcfg0_value  (pmpcfg0_value ),
  .pmpcfg2_value  (pmpcfg2_value )
);

//assign cur_priv_mode[1:0] = cp0_yy_priv_mode[1:0];
//assign pmp_mprv_status = cp0_pmp_mprv;

// &Instance("aq_pmp_acc", "x_aq_pmp_acc"); @86
aq_pmp_acc  x_aq_pmp_acc (
  .mmu_pmp_chk1        (mmu_pmp_chk1       ),
  .mmu_pmp_pa          (mmu_pmp_pa         ),
  .mmu_pmp_priv_mode   (mmu_pmp_priv_mode  ),
  .pmp_mmu_flg         (pmp_mmu_flg        ),
  .pmp_mmu_hit_num     (pmp_mmu_hit_num    ),
  .pmp_mmu_napot_cross (pmp_mmu_napot_cross),
  .pmpaddr0_value      (pmpaddr0_value     ),
  .pmpaddr1_value      (pmpaddr1_value     ),
  .pmpaddr2_value      (pmpaddr2_value     ),
  .pmpaddr3_value      (pmpaddr3_value     ),
  .pmpaddr4_value      (pmpaddr4_value     ),
  .pmpaddr5_value      (pmpaddr5_value     ),
  .pmpaddr6_value      (pmpaddr6_value     ),
  .pmpaddr7_value      (pmpaddr7_value     ),
  .pmpcfg0_value       (pmpcfg0_value      ),
  .pmpcfg2_value       (pmpcfg2_value      )
);



// &ModuleEnd; @106
endmodule


