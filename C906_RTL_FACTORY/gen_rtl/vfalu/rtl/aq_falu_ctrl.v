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
module aq_falu_ctrl(
  cp0_vpu_icg_en,
  cp0_yy_clk_en,
  fadd_ex1_pipe_clk,
  fadd_ex1_pipedown,
  fadd_ex2_nocmp,
  fadd_ex2_nocmp_pipe_clk,
  fadd_ex2_nocmp_pipedown,
  fadd_ex2_pipe_clk,
  fadd_ex2_pipedown,
  fadd_ex3_pipedown,
  forever_cpuclk,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  vfalu_vpu_ex1_denormal_stall,
  vpu_group_1_xx_ex1_eu_sel,
  vpu_group_1_xx_ex1_sel,
  vpu_group_1_xx_ex2_eu_sel,
  vpu_group_1_xx_ex2_sel,
  vpu_group_1_xx_ex2_stall,
  vpu_group_1_xx_ex3_eu_sel,
  vpu_group_1_xx_ex3_sel,
  vpu_group_1_xx_ex3_stall,
  vpu_group_1_xx_ex4_stall
);

// &Ports; @23
input          cp0_vpu_icg_en;              
input          cp0_yy_clk_en;               
input          fadd_ex2_nocmp;              
input          forever_cpuclk;              
input          ifu_vpu_warm_up;             
input          pad_yy_icg_scan_en;          
input   [9:0]  vpu_group_1_xx_ex1_eu_sel;   
input          vpu_group_1_xx_ex1_sel;      
input   [9:0]  vpu_group_1_xx_ex2_eu_sel;   
input          vpu_group_1_xx_ex2_sel;      
input          vpu_group_1_xx_ex2_stall;    
input   [9:0]  vpu_group_1_xx_ex3_eu_sel;   
input          vpu_group_1_xx_ex3_sel;      
input          vpu_group_1_xx_ex3_stall;    
input          vpu_group_1_xx_ex4_stall;    
output         fadd_ex1_pipe_clk;           
output         fadd_ex1_pipedown;           
output         fadd_ex2_nocmp_pipe_clk;     
output         fadd_ex2_nocmp_pipedown;     
output         fadd_ex2_pipe_clk;           
output         fadd_ex2_pipedown;           
output         fadd_ex3_pipedown;           
output         vfalu_vpu_ex1_denormal_stall; 

// &Regs; @24

// &Wires; @25
wire           cp0_vpu_icg_en;              
wire           cp0_yy_clk_en;               
wire           fadd_ex1_pipe_clk;           
wire           fadd_ex1_pipedown;           
wire           fadd_ex1_vld;                
wire           fadd_ex2_nocmp;              
wire           fadd_ex2_nocmp_pipe_clk;     
wire           fadd_ex2_nocmp_pipedown;     
wire           fadd_ex2_pipe_clk;           
wire           fadd_ex2_pipedown;           
wire           fadd_ex2_stall;              
wire           fadd_ex2_vld;                
wire           fadd_ex3_pipedown;           
wire           fadd_ex3_stall;              
wire           fadd_ex3_vld;                
wire           fadd_ex4_stall;              
wire           forever_cpuclk;              
wire           ifu_vpu_warm_up;             
wire           pad_yy_icg_scan_en;          
wire           vfalu_vpu_ex1_denormal_stall; 
wire    [9:0]  vpu_group_1_xx_ex1_eu_sel;   
wire           vpu_group_1_xx_ex1_sel;      
wire    [9:0]  vpu_group_1_xx_ex2_eu_sel;   
wire           vpu_group_1_xx_ex2_sel;      
wire           vpu_group_1_xx_ex2_stall;    
wire    [9:0]  vpu_group_1_xx_ex3_eu_sel;   
wire           vpu_group_1_xx_ex3_sel;      
wire           vpu_group_1_xx_ex3_stall;    
wire           vpu_group_1_xx_ex4_stall;    


// &Force("bus", "idu_fpu_ex1_func", 9, 0); @27
// &Force("output", "fadd_ex1_pipedown"); @28
// &Force("output", "fadd_ex2_pipedown"); @29
// &Force("output", "fadd_ex3_pipedown"); @30
// &Force("output", "fadd_ex2_nocmp_pipedown"); @31

//==============================================================================
//                   Ctrl For FALU Pipedown:
//==============================================================================
//------------------------------------------------------------------------------
//                    fadd pipedown ctrl:
//------------------------------------------------------------------------------

// &Instance("gated_clk_cell", "x_fadd_ex1_pipe_clk"); @40
gated_clk_cell  x_fadd_ex1_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (fadd_ex1_pipe_clk ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (fadd_ex1_pipedown ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk      ), @41
//          .external_en (1'b0                ), @42
//          .global_en   (cp0_yy_clk_en       ), @43
//          .module_en   (cp0_vpu_icg_en      ), @44
//          .local_en    (fadd_ex1_pipedown   ), @45
//          .clk_out     (fadd_ex1_pipe_clk   )); @46


// &Instance("gated_clk_cell", "x_fadd_ex2_pipe_clk"); @49
gated_clk_cell  x_fadd_ex2_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (fadd_ex2_pipe_clk ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (fadd_ex2_pipedown ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk      ), @50
//          .external_en (1'b0                ), @51
//          .global_en   (cp0_yy_clk_en       ), @52
//          .module_en   (cp0_vpu_icg_en      ), @53
//          .local_en    (fadd_ex2_pipedown   ), @54
//          .clk_out     (fadd_ex2_pipe_clk   )); @55


// when fadd ex2 is not fle/flt/feq
assign fadd_ex2_nocmp_pipedown = fadd_ex2_pipedown && fadd_ex2_nocmp || ifu_vpu_warm_up;
// &Instance("gated_clk_cell", "x_fadd_ex1_nocmp_pipe_clk"); @60
gated_clk_cell  x_fadd_ex1_nocmp_pipe_clk (
  .clk_in                  (forever_cpuclk         ),
  .clk_out                 (fadd_ex2_nocmp_pipe_clk),
  .external_en             (1'b0                   ),
  .global_en               (cp0_yy_clk_en          ),
  .local_en                (fadd_ex2_nocmp_pipedown),
  .module_en               (cp0_vpu_icg_en         ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     )
);

// &Connect(.clk_in      (forever_cpuclk           ), @61
//          .external_en (1'b0                     ), @62
//          .global_en   (cp0_yy_clk_en            ), @63
//          .module_en   (cp0_vpu_icg_en           ), @64
//          .local_en    (fadd_ex2_nocmp_pipedown ), @65
//          .clk_out     (fadd_ex2_nocmp_pipe_clk )); @66



//------------------------------------------------------------------------------
//                           ctrl for inst_vld and sel signals:
//------------------------------------------------------------------------------
// &Force("bus","vpu_group_1_xx_ex1_eu_sel",9,0); @73
// &Force("bus","vpu_group_1_xx_ex2_eu_sel",9,0); @74
// &Force("bus","vpu_group_1_xx_ex3_eu_sel",9,0); @75
// &Force("output","fadd_ex1_vld"); @77
assign fadd_ex1_vld      = vpu_group_1_xx_ex1_sel && (vpu_group_1_xx_ex1_eu_sel[7:6] == 2'b01) && vpu_group_1_xx_ex1_eu_sel[0];
assign fadd_ex2_vld      = vpu_group_1_xx_ex2_sel && (vpu_group_1_xx_ex2_eu_sel[7:6] == 2'b01) && vpu_group_1_xx_ex2_eu_sel[0];
assign fadd_ex3_vld      = vpu_group_1_xx_ex3_sel && (vpu_group_1_xx_ex3_eu_sel[7:6] == 2'b01) && vpu_group_1_xx_ex3_eu_sel[0];
//assign fadd_ex4_vld      = vpu_group_1_xx_ex4_eu_sel[0];

assign fadd_ex2_stall    = vpu_group_1_xx_ex2_stall;
assign fadd_ex3_stall    = vpu_group_1_xx_ex3_stall;
assign fadd_ex4_stall    = vpu_group_1_xx_ex4_stall;
assign fadd_ex1_pipedown = fadd_ex1_vld  && !fadd_ex2_stall || ifu_vpu_warm_up;
assign fadd_ex2_pipedown = fadd_ex2_vld  && !fadd_ex3_stall || ifu_vpu_warm_up;
assign fadd_ex3_pipedown = fadd_ex3_vld  && !fadd_ex4_stall || ifu_vpu_warm_up;

//assign ifu_vpu_warm_up  = 
//assign fcnvt_ex1_sel     = ctrl_falu_ex1_sel && idu_fpu_ex1_func[1];


//assign falu_inst_vld_ex1_pipedown = !fadd_ex2_stall && (fadd_ex1_sel || falu_fadd_ex2_vld);
//assign falu_inst_vld_ex2_pipedown = !fadd_ex3_stall && (fadd_ex2_sel || falu_fadd_ex3_vld);

//assign falu_ctrl_ex1_pipedown_clk_en = fadd_ex1_pipedown || ifu_vpu_warm_up;
//assign falu_ctrl_ex2_pipedown_clk_en = fadd_ex2_pipedown || ifu_vpu_warm_up;
//
//&Instance("gated_clk_cell", "x_falu_ctrl_ex1_pipe_clk");
// //&Connect(.clk_in      (forever_cpuclk                 ), @102
// //         .external_en (1'b0                           ), @103
// //         .global_en   (cp0_yy_clk_en                  ), @104
// //         .module_en   (1'b0                           ), @105
// //         .local_en    (falu_ctrl_ex1_pipedown_clk_en  ), @106
// //         .clk_out     (falu_ctrl_ex1_pipe_clk         ) @107
// //         ); @108
//
//&Instance("gated_clk_cell", "x_falu_ctrl_ex2_pipe_clk");
// //&Connect(.clk_in      (forever_cpuclk                 ), @111
// //         .external_en (1'b0                           ), @112
// //         .global_en   (cp0_yy_clk_en                  ), @113
// //         .module_en   (1'b0                           ), @114
// //         .local_en    (falu_ctrl_ex2_pipedown_clk_en  ), @115
// //         .clk_out     (falu_ctrl_ex2_pipe_clk         ) @116
// //         ); @117
// &Force("output","fadd_ex2_stall"); @120
// &Force("output","ex1_src1_widden_stall"); @121
// &Instance("gated_clk_cell", "x_src1_widden_clk"); @124
// &Connect(.clk_in      (forever_cpuclk         ), @125
//          .external_en (1'b0                   ), @126
//          .global_en   (cp0_yy_clk_en          ), @127
//          .module_en   (cp0_vpu_icg_en         ), @128
//          .local_en    (src1_widden_clk_en   ), @129
//          .clk_out     (src1_widden_clk      )); @130
// &Force("output","src1_widden_clk"); @134
assign vfalu_vpu_ex1_denormal_stall = 1'b0;


// &ModuleEnd; @158
endmodule


