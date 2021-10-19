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
module aq_mmu_jtlb_data_array(
  cp0_mmu_icg_en,
  forever_cpuclk,
  jtlb_data_cen,
  jtlb_data_din,
  jtlb_data_dout,
  jtlb_data_idx,
  jtlb_data_wen,
  pad_yy_icg_scan_en
);

// &Ports; @24
input           cp0_mmu_icg_en;    
input           forever_cpuclk;    
input           jtlb_data_cen;     
input   [87:0]  jtlb_data_din;     
input   [8 :0]  jtlb_data_idx;     
input   [1 :0]  jtlb_data_wen;     
input           pad_yy_icg_scan_en; 
output  [87:0]  jtlb_data_dout;    

// &Regs; @25

// &Wires; @26
wire            cp0_mmu_icg_en;    
wire            forever_cpuclk;    
wire    [87:0]  jtlb_data_bwen;    
wire    [87:0]  jtlb_data_bwen_b;  
wire            jtlb_data_cen;     
wire            jtlb_data_cen_b;   
wire            jtlb_data_clk;     
wire            jtlb_data_clk_en;  
wire    [87:0]  jtlb_data_din;     
wire    [87:0]  jtlb_data_dout;    
wire            jtlb_data_gwen;    
wire            jtlb_data_gwen_b;  
wire    [8 :0]  jtlb_data_idx;     
wire    [1 :0]  jtlb_data_wen;     
wire            pad_yy_icg_scan_en; 


// &Force("bus", "jtlb_data_idx", 8, 0); @28
//==========================================================
//                  Gate Cell
//==========================================================
assign jtlb_data_clk_en = jtlb_data_cen;
// &Instance("gated_clk_cell", "x_jtlb_data_gateclk"); @33
gated_clk_cell  x_jtlb_data_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (jtlb_data_clk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (jtlb_data_clk_en  ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk  ), @34
//           .external_en(1'b0            ), @35
//           .global_en  (1'b1            ), @36
//           .module_en  (cp0_mmu_icg_en  ), @37
//           .local_en   (jtlb_data_clk_en), @38
//           .clk_out    (jtlb_data_clk   ) @39
//          ); @40

// &Force("bus", "jtlb_data_din"); @42
assign jtlb_data_gwen       = |jtlb_data_wen[1:0];
assign jtlb_data_bwen[87:0] = {
                                 {44{jtlb_data_wen[1]}},
                                 {44{jtlb_data_wen[0]}}
                                };

assign jtlb_data_cen_b = !jtlb_data_cen;
assign jtlb_data_gwen_b = !jtlb_data_gwen;
assign jtlb_data_bwen_b[87:0] = ~jtlb_data_bwen[87:0];

// &Instance("aq_spsram_64x88","x_aq_spsram_64x88"); @54
aq_spsram_64x88  x_aq_spsram_64x88 (
  .A                  (jtlb_data_idx[5:0]),
  .CEN                (jtlb_data_cen_b   ),
  .CLK                (jtlb_data_clk     ),
  .D                  (jtlb_data_din     ),
  .GWEN               (jtlb_data_gwen_b  ),
  .Q                  (jtlb_data_dout    ),
  .WEN                (jtlb_data_bwen_b  )
);

// &Connect( @55
//          .CLK    (jtlb_data_clk     ), @56
//          .CEN    (jtlb_data_cen_b   ), @57
//          .GWEN   (jtlb_data_gwen_b  ), @58
//          .WEN    (jtlb_data_bwen_b  ), @59
//          .A      (jtlb_data_idx[5:0]), @60
//          .D      (jtlb_data_din     ), @61
//          .Q      (jtlb_data_dout    ) @62
//        ); @63

// &Instance("aq_spsram_128x88","x_aq_spsram_128x88"); @67
// &Connect( @68
//          .CLK    (jtlb_data_clk     ), @69
//          .CEN    (jtlb_data_cen_b   ), @70
//          .GWEN   (jtlb_data_gwen_b  ), @71
//          .WEN    (jtlb_data_bwen_b  ), @72
//          .A      (jtlb_data_idx[6:0]), @73
//          .D      (jtlb_data_din     ), @74
//          .Q      (jtlb_data_dout    ) @75
//        ); @76

// &Instance("aq_spsram_256x88","x_aq_spsram_256x88"); @80
// &Connect( @81
//          .CLK    (jtlb_data_clk     ), @82
//          .CEN    (jtlb_data_cen_b   ), @83
//          .GWEN   (jtlb_data_gwen_b  ), @84
//          .WEN    (jtlb_data_bwen_b  ), @85
//          .A      (jtlb_data_idx[7:0]), @86
//          .D      (jtlb_data_din     ), @87
//          .Q      (jtlb_data_dout    ) @88
//        ); @89

// &ModuleEnd; @92
endmodule


