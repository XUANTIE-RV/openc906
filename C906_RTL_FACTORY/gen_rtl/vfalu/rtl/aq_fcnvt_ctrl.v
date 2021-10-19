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
module aq_fcnvt_ctrl(
  cp0_vpu_icg_en,
  cp0_yy_clk_en,
  ex2_dest_l64,
  fcnvt_ex1_pipe_clk,
  fcnvt_ex1_pipedown,
  fcnvt_ex2_pipe_clk,
  fcnvt_ex2_pipe_double_clk,
  fcnvt_ex2_pipedown,
  forever_cpuclk,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  vpu_group_1_xx_ex1_eu_sel,
  vpu_group_1_xx_ex1_sel,
  vpu_group_1_xx_ex2_eu_sel,
  vpu_group_1_xx_ex2_sel,
  vpu_group_1_xx_ex2_stall,
  vpu_group_1_xx_ex3_stall
);

// &Ports; @23
input          cp0_vpu_icg_en;           
input          cp0_yy_clk_en;            
input          ex2_dest_l64;             
input          forever_cpuclk;           
input          ifu_vpu_warm_up;          
input          pad_yy_icg_scan_en;       
input   [9:0]  vpu_group_1_xx_ex1_eu_sel; 
input          vpu_group_1_xx_ex1_sel;   
input   [9:0]  vpu_group_1_xx_ex2_eu_sel; 
input          vpu_group_1_xx_ex2_sel;   
input          vpu_group_1_xx_ex2_stall; 
input          vpu_group_1_xx_ex3_stall; 
output         fcnvt_ex1_pipe_clk;       
output         fcnvt_ex1_pipedown;       
output         fcnvt_ex2_pipe_clk;       
output         fcnvt_ex2_pipe_double_clk; 
output         fcnvt_ex2_pipedown;       

// &Regs; @24

// &Wires; @25
wire           cp0_vpu_icg_en;           
wire           cp0_yy_clk_en;            
wire           ex2_dest_l64;             
wire           fcnvt_ex1_pipe_clk;       
wire           fcnvt_ex1_pipedown;       
wire           fcnvt_ex1_vld;            
wire           fcnvt_ex2_double_pipedown; 
wire           fcnvt_ex2_pipe_clk;       
wire           fcnvt_ex2_pipe_double_clk; 
wire           fcnvt_ex2_pipedown;       
wire           fcnvt_ex2_stall;          
wire           fcnvt_ex2_vld;            
wire           fcnvt_ex3_stall;          
wire           forever_cpuclk;           
wire           ifu_vpu_warm_up;          
wire           pad_yy_icg_scan_en;       
wire    [9:0]  vpu_group_1_xx_ex1_eu_sel; 
wire           vpu_group_1_xx_ex1_sel;   
wire    [9:0]  vpu_group_1_xx_ex2_eu_sel; 
wire           vpu_group_1_xx_ex2_sel;   
wire           vpu_group_1_xx_ex2_stall; 
wire           vpu_group_1_xx_ex3_stall; 


// //&Force("bus", "idu_fpu_ex1_func", 9, 0); @27
// &Force("output", "fcnvt_ex1_pipedown"); @28
// &Force("output", "fcnvt_ex2_pipedown"); @29
// //&Force("output", "fcnvt_ex3_pipedown"); @30
// //&Force("output", "fcnvt_ex2_nocmp_pipedown"); @31

//==============================================================================
//                   Ctrl For FALU Pipedown:
//==============================================================================
//------------------------------------------------------------------------------
//                    fadd pipedown ctrl:
//------------------------------------------------------------------------------



//------------------------------------------------------------------------------
//                           ctrl for inst_vld and sel signals:
//------------------------------------------------------------------------------
// &Force("bus","vpu_group_1_xx_ex1_eu_sel",9,0); @45
// &Force("bus","vpu_group_1_xx_ex2_eu_sel",9,0); @46
assign fcnvt_ex1_vld      = vpu_group_1_xx_ex1_sel && (vpu_group_1_xx_ex1_eu_sel[7:6]==2'b10) && vpu_group_1_xx_ex1_eu_sel[0];
assign fcnvt_ex2_vld      = vpu_group_1_xx_ex2_sel && (vpu_group_1_xx_ex2_eu_sel[7:6]==2'b10) && vpu_group_1_xx_ex2_eu_sel[0];
//assign fcnvt_ex3_vld      = vpu_group_1_xx_ex3_eu_sel[0];
//assign fcnvt_ex4_vld      = vpu_group_1_xx_ex4_eu_sel[0];

assign fcnvt_ex2_stall    = vpu_group_1_xx_ex2_stall;
assign fcnvt_ex3_stall    = vpu_group_1_xx_ex3_stall;
//assign fcnvt_ex4_stall    = vpu_group_1_xx_ex4_stall;
assign fcnvt_ex1_pipedown = fcnvt_ex1_vld  && !fcnvt_ex2_stall || ifu_vpu_warm_up;
assign fcnvt_ex2_pipedown = fcnvt_ex2_vld  && !fcnvt_ex3_stall || ifu_vpu_warm_up;
//assign fcnvt_ex3_pipedown = fcnvt_ex3_vld  && !fcnvt_ex4_stall || ifu_vpu_warm_up;



// &Instance("gated_clk_cell", "x_fcnvt_ex1_pipe_clk"); @61
gated_clk_cell  x_fcnvt_ex1_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (fcnvt_ex1_pipe_clk),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (fcnvt_ex1_pipedown),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk      ), @62
//          .external_en (1'b0                ), @63
//          .global_en   (cp0_yy_clk_en       ), @64
//          .module_en   (cp0_vpu_icg_en      ), @65
//          .local_en    (fcnvt_ex1_pipedown   ), @66
//          .clk_out     (fcnvt_ex1_pipe_clk   )); @67

// &Instance("gated_clk_cell", "x_fcnvt_ex2_pipe_clk"); @69
gated_clk_cell  x_fcnvt_ex2_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (fcnvt_ex2_pipe_clk),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (fcnvt_ex2_pipedown),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk      ), @70
//          .external_en (1'b0                ), @71
//          .global_en   (cp0_yy_clk_en       ), @72
//          .module_en   (cp0_vpu_icg_en      ), @73
//          .local_en    (fcnvt_ex2_pipedown   ), @74
//          .clk_out     (fcnvt_ex2_pipe_clk   )); @75

// &Instance("gated_clk_cell", "x_fcnvt_ex2_pipe_double_clk"); @77
gated_clk_cell  x_fcnvt_ex2_pipe_double_clk (
  .clk_in                    (forever_cpuclk           ),
  .clk_out                   (fcnvt_ex2_pipe_double_clk),
  .external_en               (1'b0                     ),
  .global_en                 (cp0_yy_clk_en            ),
  .local_en                  (fcnvt_ex2_double_pipedown),
  .module_en                 (cp0_vpu_icg_en           ),
  .pad_yy_icg_scan_en        (pad_yy_icg_scan_en       )
);

// &Connect(.clk_in      (forever_cpuclk      ), @78
//          .external_en (1'b0                ), @79
//          .global_en   (cp0_yy_clk_en       ), @80
//          .module_en   (cp0_vpu_icg_en      ), @81
//          .local_en    (fcnvt_ex2_double_pipedown   ), @82
//          .clk_out     (fcnvt_ex2_pipe_double_clk   )); @83
assign fcnvt_ex2_double_pipedown =  fcnvt_ex2_vld  && !fcnvt_ex3_stall && ex2_dest_l64 || ifu_vpu_warm_up;
//assign ifu_vpu_warm_up  = 
//assign fcnvt_ex1_sel     = ctrl_falu_ex1_sel && idu_fpu_ex1_func[1];


//assign falu_inst_vld_ex1_pipedown = !fcnvt_ex2_stall && (fcnvt_ex1_sel || falu_fcnvt_ex2_vld);
//assign falu_inst_vld_ex2_pipedown = !fcnvt_ex3_stall && (fcnvt_ex2_sel || falu_fcnvt_ex3_vld);

//assign falu_ctrl_ex1_pipedown_clk_en = fcnvt_ex1_pipedown || ifu_vpu_warm_up;
//assign falu_ctrl_ex2_pipedown_clk_en = fcnvt_ex2_pipedown || ifu_vpu_warm_up;
//
//&Instance("gated_clk_cell", "x_falu_ctrl_ex1_pipe_clk");
// //&Connect(.clk_in      (forever_cpuclk                 ), @96
// //         .external_en (1'b0                           ), @97
// //         .global_en   (cp0_yy_clk_en                  ), @98
// //         .module_en   (1'b0                           ), @99
// //         .local_en    (falu_ctrl_ex1_pipedown_clk_en  ), @100
// //         .clk_out     (falu_ctrl_ex1_pipe_clk         ) @101
// //         ); @102
//
//&Instance("gated_clk_cell", "x_falu_ctrl_ex2_pipe_clk");
// //&Connect(.clk_in      (forever_cpuclk                 ), @105
// //         .external_en (1'b0                           ), @106
// //         .global_en   (cp0_yy_clk_en                  ), @107
// //         .module_en   (1'b0                           ), @108
// //         .local_en    (falu_ctrl_ex2_pipedown_clk_en  ), @109
// //         .clk_out     (falu_ctrl_ex2_pipe_clk         ) @110
// //         ); @111

//assign vfalu_vpu_ex1_denormal_stall = (double_pipe_widden_denorm_stall || 
//                                       single_pipe_widden_denorm_stall) && fcnvt_ex1_vld;






// &ModuleEnd; @121
endmodule


