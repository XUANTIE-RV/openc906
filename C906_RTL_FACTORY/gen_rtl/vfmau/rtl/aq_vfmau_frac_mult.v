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
module aq_vfmau_frac_mult(
  ctrl_dp_ex1_inst_pipe_down,
  ex1_bf16,
  ex1_double,
  ex1_f16,
  ex1_id_reg,
  ex1_single,
  ex1_srcv0,
  ex1_srcv1,
  ex2_mult_data,
  fmau_ex2_data_clk,
  ifu_vpu_warm_up
);

// &Ports; @25
input            ctrl_dp_ex1_inst_pipe_down; 
input            ex1_bf16;                  
input            ex1_double;                
input            ex1_f16;                   
input   [1  :0]  ex1_id_reg;                
input            ex1_single;                
input   [63 :0]  ex1_srcv0;                 
input   [63 :0]  ex1_srcv1;                 
input            fmau_ex2_data_clk;         
input            ifu_vpu_warm_up;           
output  [105:0]  ex2_mult_data;             

// &Regs; @26
reg     [83 :0]  ex2_partial_result_0;      
reg     [83 :0]  ex2_partial_result_1;      
reg     [80 :0]  ex2_partial_result_2;      
reg     [80 :0]  ex2_partial_result_3;      

// &Wires; @27
wire             ctrl_dp_ex1_inst_pipe_down; 
wire             ex1_bf16;                  
wire             ex1_double;                
wire             ex1_f16;                   
wire    [52 :0]  ex1_frac_0;                
wire    [52 :0]  ex1_frac_1;                
wire             ex1_frac_mult_pipe_down;   
wire    [1  :0]  ex1_id_reg;                
wire    [83 :0]  ex1_partial_result_0;      
wire    [83 :0]  ex1_partial_result_1;      
wire    [80 :0]  ex1_partial_result_2;      
wire    [80 :0]  ex1_partial_result_3;      
wire             ex1_single;                
wire    [63 :0]  ex1_srcv0;                 
wire    [63 :0]  ex1_srcv1;                 
wire    [105:0]  ex2_c0_0;                  
wire    [105:0]  ex2_mult_data;             
wire    [105:0]  ex2_p0_0_0;                
wire    [105:0]  ex2_p0_0_1;                
wire    [105:0]  ex2_p0_0_2;                
wire    [105:0]  ex2_p0_0_3;                
wire    [105:0]  ex2_p0_0_cout;             
wire    [105:0]  ex2_p0_0_xor;              
wire    [105:0]  ex2_s0_0;                  
wire             fmau_ex2_data_clk;         
wire             ifu_vpu_warm_up;           
wire    [52 :0]  mult_0_0;                  
wire    [26 :0]  mult_0_1;                  
wire    [52 :0]  mult_1_0;                  
wire    [26 :0]  mult_1_1;                  
wire    [83 :0]  result_0_0;                
wire    [83 :0]  result_0_1;                
wire    [83 :0]  result_1_0;                
wire    [83 :0]  result_1_1;                


// &Depend("cpu_cfig.h"); @29

parameter FPU_WIDTH   = 64;
parameter BF16_FRAC   =  7;
parameter F16_FRAC    = 10;
parameter SINGLE_FRAC = 23;
parameter DOUBLE_FRAC = 52;
parameter SINGLE_EXPN =  8;
parameter DOUBLE_EXPN = 11;
parameter FUNC_WIDTH  = 10;

// &Force("bus","ex1_srcv0",63,0); @40
// &Force("bus","ex1_srcv1",63,0); @41
// &Force("bus","ex1_id_reg",7,0); @43
// &Force("bus","ex1_id_reg",1,0); @45
//==========================================================
//                     EX1 data path
//==========================================================
assign ex1_frac_0[DOUBLE_FRAC:0] = {(DOUBLE_FRAC+1){ex1_double}} & {!ex1_id_reg[0],ex1_srcv0[DOUBLE_FRAC-1:0]}
                                 | {(DOUBLE_FRAC+1){ex1_single}} & {!ex1_id_reg[0],ex1_srcv0[SINGLE_FRAC-1:0],{(DOUBLE_FRAC-SINGLE_FRAC){1'b0}}}
                                 | {(DOUBLE_FRAC+1){ex1_f16   }} & {!ex1_id_reg[0],ex1_srcv0[F16_FRAC-1:0],{(DOUBLE_FRAC-F16_FRAC){1'b0}}} 
                                 | {(DOUBLE_FRAC+1){ex1_bf16  }} & {!ex1_id_reg[0],ex1_srcv0[BF16_FRAC-1:0],{(DOUBLE_FRAC-BF16_FRAC){1'b0}}}; 

assign ex1_frac_1[DOUBLE_FRAC:0] = {(DOUBLE_FRAC+1){ex1_double}} & {!ex1_id_reg[1],ex1_srcv1[DOUBLE_FRAC-1:0]}
                                 | {(DOUBLE_FRAC+1){ex1_single}} & {!ex1_id_reg[1],ex1_srcv1[SINGLE_FRAC-1:0],{(DOUBLE_FRAC-SINGLE_FRAC){1'b0}} }
                                 | {(DOUBLE_FRAC+1){ex1_f16   }} & {!ex1_id_reg[1],ex1_srcv1[F16_FRAC-1:0],{(DOUBLE_FRAC-F16_FRAC){1'b0}}} 
                                 | {(DOUBLE_FRAC+1){ex1_bf16  }} & {!ex1_id_reg[1],ex1_srcv1[BF16_FRAC-1:0],{(DOUBLE_FRAC-BF16_FRAC){1'b0}}}; 

assign mult_0_0[52:0] = ex1_frac_0[52: 0];
assign mult_0_1[26:0] = ex1_frac_1[26: 0]; 

assign mult_1_0[52:0] = ex1_frac_0[52: 0];
assign mult_1_1[25:0] = ex1_frac_1[52:27];


assign mult_1_1[26] = 1'b0;

// &Instance("aq_vfmau_multiplier_53x27_partial","multiplier_53x27"); @102
aq_vfmau_multiplier_53x27_partial  multiplier_53x27 (
  .a          (mult_0_0  ),
  .b          (mult_0_1  ),
  .out0       (result_0_0),
  .out1       (result_0_1)
);

// &Connect( @103
//   .a(mult_0_0), @104
//   .b(mult_0_1), @105
//   .out0(result_0_0), @106
//   .out1(result_0_1) @107
// ); @108

// &Instance("aq_vfmau_multiplier_53x27_partial","multiplier_53x26"); @110
aq_vfmau_multiplier_53x27_partial  multiplier_53x26 (
  .a          (mult_1_0  ),
  .b          (mult_1_1  ),
  .out0       (result_1_0),
  .out1       (result_1_1)
);

// &Connect( @111
//   .a(mult_1_0), @112
//   .b(mult_1_1), @113
//   .out0(result_1_0), @114
//   .out1(result_1_1) @115
// ); @116

// &Force("bus","result_0_0",83,0); @118
// &Force("bus","result_0_1",83,0); @119
// &Force("bus","result_1_0",83,0); @120
// &Force("bus","result_1_1",83,0); @121

assign ex1_partial_result_0[83:0] = result_0_0[83:0];
assign ex1_partial_result_1[83:0] = result_0_1[83:0];
assign ex1_partial_result_2[80:0] = result_1_0[80:0];
assign ex1_partial_result_3[80:0] = result_1_1[80:0];


// &Force("nonport", "mult_0_0"); @130
// &Force("nonport", "mult_0_1"); @131
// &Force("nonport", "result_0_0"); @132
// &Force("nonport", "result_0_1"); @133
// &Force("nonport", "mult_1_0"); @143
// &Force("nonport", "mult_1_1"); @144
// &Force("nonport", "result_1_0"); @145
// &Force("nonport", "result_1_1"); @146

assign ex1_frac_mult_pipe_down = ctrl_dp_ex1_inst_pipe_down;

always@(posedge fmau_ex2_data_clk)
begin
  if(ex1_frac_mult_pipe_down || ifu_vpu_warm_up)
  begin
    ex2_partial_result_0[83:0] <= ex1_partial_result_0[83:0];
    ex2_partial_result_1[83:0] <= ex1_partial_result_1[83:0];
    ex2_partial_result_2[80:0] <= ex1_partial_result_2[80:0];
    ex2_partial_result_3[80:0] <= ex1_partial_result_3[80:0];
  end
end

assign ex2_p0_0_0[105:0] = { {23{ex2_partial_result_0[83]}},ex2_partial_result_0[82:0]};
assign ex2_p0_0_1[105:0] = { {23{ex2_partial_result_1[83]}},ex2_partial_result_1[82:0]};
assign ex2_p0_0_2[105:0] = {ex2_partial_result_2[78:0],{27{1'b0}} };
assign ex2_p0_0_3[105:0] = {ex2_partial_result_3[78:0],{27{1'b0}} };

assign ex2_p0_0_cout[105:0] = (ex2_p0_0_0[105:0]  &  ex2_p0_0_1[105:0]) |
                              (ex2_p0_0_1[105:0]  &  ex2_p0_0_2[105:0]) |
                              (ex2_p0_0_0[105:0]  &  ex2_p0_0_2[105:0]) ;

assign ex2_p0_0_xor[105:0]  = (ex2_p0_0_0[105:0]  ^  ex2_p0_0_1[105:0]) ^
                              (ex2_p0_0_2[105:0]  ^  ex2_p0_0_3[105:0]);

assign ex2_s0_0[105:0]      =  ex2_p0_0_xor[105:0]^ {ex2_p0_0_cout[104:0],1'b0};
assign ex2_c0_0[105:0]      =  ex2_p0_0_xor[105:0]& {ex2_p0_0_cout[104:0],1'b0}|
                             (~ex2_p0_0_xor[105:0]&  ex2_p0_0_3[105:0]);

assign ex2_mult_data[105:0] = ex2_s0_0[105:0] + {ex2_c0_0[104:0],1'b0};

// &ModuleEnd; @197
endmodule


