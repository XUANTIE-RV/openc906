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
module aq_fdsu_prepare(
  bhalf0_ex1_divisor,
  bhalf0_ex1_ff1_frac,
  bhalf0_ex1_id_frac,
  bhalf0_ex1_id_frac_f,
  bhalf0_ex1_op0_id_vld,
  bhalf0_ex1_op1_id_vld,
  bhalf0_ex1_op1_sel,
  bhalf0_ex1_remainder,
  double_ex1_divisor,
  double_ex1_ff1_frac,
  double_ex1_id_frac,
  double_ex1_id_frac_f,
  double_ex1_op0_id_vld,
  double_ex1_op1_id_vld,
  double_ex1_op1_sel,
  double_ex1_remainder,
  double_pipe_ex1_expnt_adder_op0,
  double_pipe_ex1_expnt_adder_op1,
  double_pipe_ex1_ff1_sel_op1,
  double_pipe_ex1_id_expnt_f,
  double_pipe_ex1_of_result_lfn,
  double_pipe_ex1_op0_id_expnt_neg,
  double_pipe_ex1_op1_id_expnt_neg,
  double_pipe_ex1_result_sign,
  double_pipe_oper0,
  double_pipe_oper1,
  dp_xx_ex1_rm,
  ex1_bhalf,
  ex1_bhalf0_op0_id,
  ex1_bhalf0_op1_id,
  ex1_div,
  ex1_double,
  ex1_double_op0_id,
  ex1_double_op1_id,
  ex1_f16,
  ex1_half,
  ex1_half0_op0_id,
  ex1_half0_op1_id,
  ex1_op0_sign,
  ex1_oper0,
  ex1_oper1,
  ex1_single,
  ex1_single0_op0_id,
  ex1_single0_op1_id,
  ex1_sqrt,
  fdsu_ex1_sel,
  half0_ex1_divisor,
  half0_ex1_ff1_frac,
  half0_ex1_id_frac,
  half0_ex1_id_frac_f,
  half0_ex1_op0_id_vld,
  half0_ex1_op1_id_vld,
  half0_ex1_op1_sel,
  half0_ex1_remainder,
  single0_ex1_divisor,
  single0_ex1_ff1_frac,
  single0_ex1_id_frac,
  single0_ex1_id_frac_f,
  single0_ex1_op0_id_vld,
  single0_ex1_op1_id_vld,
  single0_ex1_op1_sel,
  single0_ex1_remainder
);

// &Ports; @24
input   [6 :0]  bhalf0_ex1_id_frac;              
input   [6 :0]  bhalf0_ex1_id_frac_f;            
input           bhalf0_ex1_op1_sel;              
input   [51:0]  double_ex1_id_frac;              
input   [51:0]  double_ex1_id_frac_f;            
input           double_ex1_op1_sel;              
input           double_pipe_ex1_ff1_sel_op1;     
input   [12:0]  double_pipe_ex1_id_expnt_f;      
input   [12:0]  double_pipe_ex1_op0_id_expnt_neg; 
input   [12:0]  double_pipe_ex1_op1_id_expnt_neg; 
input   [63:0]  double_pipe_oper0;               
input   [63:0]  double_pipe_oper1;               
input   [2 :0]  dp_xx_ex1_rm;                    
input           ex1_bhalf;                       
input           ex1_bhalf0_op0_id;               
input           ex1_bhalf0_op1_id;               
input           ex1_div;                         
input           ex1_double;                      
input           ex1_double_op0_id;               
input           ex1_double_op1_id;               
input           ex1_f16;                         
input           ex1_half;                        
input           ex1_half0_op0_id;                
input           ex1_half0_op1_id;                
input           ex1_single;                      
input           ex1_single0_op0_id;              
input           ex1_single0_op1_id;              
input           ex1_sqrt;                        
input           fdsu_ex1_sel;                    
input   [9 :0]  half0_ex1_id_frac;               
input   [9 :0]  half0_ex1_id_frac_f;             
input           half0_ex1_op1_sel;               
input   [22:0]  single0_ex1_id_frac;             
input   [22:0]  single0_ex1_id_frac_f;           
input           single0_ex1_op1_sel;             
output  [7 :0]  bhalf0_ex1_divisor;              
output  [6 :0]  bhalf0_ex1_ff1_frac;             
output          bhalf0_ex1_op0_id_vld;           
output          bhalf0_ex1_op1_id_vld;           
output  [14:0]  bhalf0_ex1_remainder;            
output  [52:0]  double_ex1_divisor;              
output  [51:0]  double_ex1_ff1_frac;             
output          double_ex1_op0_id_vld;           
output          double_ex1_op1_id_vld;           
output  [59:0]  double_ex1_remainder;            
output  [12:0]  double_pipe_ex1_expnt_adder_op0; 
output  [12:0]  double_pipe_ex1_expnt_adder_op1; 
output          double_pipe_ex1_of_result_lfn;   
output          double_pipe_ex1_result_sign;     
output          ex1_op0_sign;                    
output  [63:0]  ex1_oper0;                       
output  [63:0]  ex1_oper1;                       
output  [10:0]  half0_ex1_divisor;               
output  [9 :0]  half0_ex1_ff1_frac;              
output          half0_ex1_op0_id_vld;            
output          half0_ex1_op1_id_vld;            
output  [18:0]  half0_ex1_remainder;             
output  [23:0]  single0_ex1_divisor;             
output  [22:0]  single0_ex1_ff1_frac;            
output          single0_ex1_op0_id_vld;          
output          single0_ex1_op1_id_vld;          
output  [30:0]  single0_ex1_remainder;           

// &Regs; @25
reg             double_pipe_ex1_of_result_lfn;   
reg     [12:0]  ex1_expnt_adder_op1;             

// &Wires; @26
wire    [7 :0]  bhalf0_ex1_div_nor_srt_op0;      
wire    [7 :0]  bhalf0_ex1_div_nor_srt_op1;      
wire    [12:0]  bhalf0_ex1_div_op0_expnt;        
wire    [12:0]  bhalf0_ex1_div_op1_expnt;        
wire    [7 :0]  bhalf0_ex1_divisor;              
wire    [6 :0]  bhalf0_ex1_ff1_frac;             
wire    [6 :0]  bhalf0_ex1_id_frac;              
wire    [6 :0]  bhalf0_ex1_id_frac_f;            
wire            bhalf0_ex1_op0_id_nor;           
wire            bhalf0_ex1_op0_id_vld;           
wire            bhalf0_ex1_op1_id_nor;           
wire            bhalf0_ex1_op1_id_vld;           
wire            bhalf0_ex1_op1_sel;              
wire    [12:0]  bhalf0_ex1_oper0_id_expnt;       
wire    [6 :0]  bhalf0_ex1_oper0_id_frac;        
wire    [12:0]  bhalf0_ex1_oper1_id_expnt;       
wire    [6 :0]  bhalf0_ex1_oper1_id_frac;        
wire    [14:0]  bhalf0_ex1_remainder;            
wire            bhalf0_ex1_sqrt_expnt_odd;       
wire    [7 :0]  bhalf0_ex1_sqrt_srt_op0;         
wire    [14:0]  bhalf0_sqrt_remainder;           
wire            div_sign;                        
wire    [52:0]  double_ex1_div_nor_srt_op0;      
wire    [52:0]  double_ex1_div_nor_srt_op1;      
wire    [12:0]  double_ex1_div_op0_expnt;        
wire    [12:0]  double_ex1_div_op1_expnt;        
wire    [52:0]  double_ex1_divisor;              
wire    [51:0]  double_ex1_ff1_frac;             
wire    [51:0]  double_ex1_id_frac;              
wire    [51:0]  double_ex1_id_frac_f;            
wire            double_ex1_op0_id_nor;           
wire            double_ex1_op0_id_vld;           
wire            double_ex1_op1_id_nor;           
wire            double_ex1_op1_id_vld;           
wire            double_ex1_op1_sel;              
wire    [12:0]  double_ex1_oper0_id_expnt;       
wire    [51:0]  double_ex1_oper0_id_frac;        
wire    [12:0]  double_ex1_oper1_id_expnt;       
wire    [51:0]  double_ex1_oper1_id_frac;        
wire    [59:0]  double_ex1_remainder;            
wire            double_ex1_sqrt_expnt_odd;       
wire    [52:0]  double_ex1_sqrt_srt_op0;         
wire    [12:0]  double_pipe_ex1_expnt_adder_op0; 
wire    [12:0]  double_pipe_ex1_expnt_adder_op1; 
wire            double_pipe_ex1_ff1_sel_op1;     
wire    [12:0]  double_pipe_ex1_id_expnt_f;      
wire    [12:0]  double_pipe_ex1_op0_id_expnt_neg; 
wire    [12:0]  double_pipe_ex1_op1_id_expnt_neg; 
wire            double_pipe_ex1_result_sign;     
wire    [63:0]  double_pipe_oper0;               
wire    [63:0]  double_pipe_oper1;               
wire    [59:0]  double_sqrt_remainder;           
wire    [2 :0]  dp_xx_ex1_rm;                    
wire            ex1_bhalf;                       
wire            ex1_bhalf0_op0_id;               
wire            ex1_bhalf0_op1_id;               
wire            ex1_div;                         
wire    [12:0]  ex1_div_op0_expnt;               
wire    [12:0]  ex1_div_op1_expnt;               
wire            ex1_double;                      
wire            ex1_double_op0_id;               
wire            ex1_double_op1_id;               
wire            ex1_f16;                         
wire            ex1_half;                        
wire            ex1_half0_op0_id;                
wire            ex1_half0_op1_id;                
wire            ex1_op0_sign;                    
wire            ex1_op1_sign;                    
wire    [63:0]  ex1_oper0;                       
wire    [63:0]  ex1_oper1;                       
wire            ex1_result_sign;                 
wire    [2 :0]  ex1_rm;                          
wire            ex1_single;                      
wire            ex1_single0_op0_id;              
wire            ex1_single0_op1_id;              
wire            ex1_sqrt;                        
wire    [12:0]  ex1_sqrt_op1_expnt;              
wire            fdsu_ex1_sel;                    
wire    [10:0]  half0_ex1_div_nor_srt_op0;       
wire    [10:0]  half0_ex1_div_nor_srt_op1;       
wire    [12:0]  half0_ex1_div_op0_expnt;         
wire    [12:0]  half0_ex1_div_op1_expnt;         
wire    [10:0]  half0_ex1_divisor;               
wire    [9 :0]  half0_ex1_ff1_frac;              
wire    [9 :0]  half0_ex1_id_frac;               
wire    [9 :0]  half0_ex1_id_frac_f;             
wire            half0_ex1_op0_id_nor;            
wire            half0_ex1_op0_id_vld;            
wire            half0_ex1_op1_id_nor;            
wire            half0_ex1_op1_id_vld;            
wire            half0_ex1_op1_sel;               
wire    [12:0]  half0_ex1_oper0_id_expnt;        
wire    [9 :0]  half0_ex1_oper0_id_frac;         
wire    [12:0]  half0_ex1_oper1_id_expnt;        
wire    [9 :0]  half0_ex1_oper1_id_frac;         
wire    [18:0]  half0_ex1_remainder;             
wire            half0_ex1_sqrt_expnt_odd;        
wire    [10:0]  half0_ex1_sqrt_srt_op0;          
wire    [18:0]  half0_sqrt_remainder;            
wire    [23:0]  single0_ex1_div_nor_srt_op0;     
wire    [23:0]  single0_ex1_div_nor_srt_op1;     
wire    [12:0]  single0_ex1_div_op0_expnt;       
wire    [12:0]  single0_ex1_div_op1_expnt;       
wire    [23:0]  single0_ex1_divisor;             
wire    [22:0]  single0_ex1_ff1_frac;            
wire    [22:0]  single0_ex1_id_frac;             
wire    [22:0]  single0_ex1_id_frac_f;           
wire            single0_ex1_op0_id_nor;          
wire            single0_ex1_op0_id_vld;          
wire            single0_ex1_op1_id_nor;          
wire            single0_ex1_op1_id_vld;          
wire            single0_ex1_op1_sel;             
wire    [12:0]  single0_ex1_oper0_id_expnt;      
wire    [22:0]  single0_ex1_oper0_id_frac;       
wire    [12:0]  single0_ex1_oper1_id_expnt;      
wire    [22:0]  single0_ex1_oper1_id_frac;       
wire    [30:0]  single0_ex1_remainder;           
wire            single0_ex1_sqrt_expnt_odd;      
wire    [23:0]  single0_ex1_sqrt_srt_op0;        
wire    [30:0]  single0_sqrt_remainder;          
wire            sqrt_sign;                       


parameter FLEN = 64;
// &Force("output","ex1_oper0"); @29
// &Force("output","ex1_oper1"); @30
assign ex1_oper0[63:0]             = double_pipe_oper0[FLEN-1:0] & {64{fdsu_ex1_sel}};
assign ex1_oper1[63:0]             = double_pipe_oper1[FLEN-1:0] & {64{fdsu_ex1_sel}};
//assign ex1_double                  = idu_fpu_ex1_fdsu_fmt[0];
//assign ex1_single                  = idu_fpu_ex1_fdsu_fmt[1];
//assign ex1_half                    = !ex1_double && !ex1_single && cp0_vpu_xx_bf16;
// &Force("bus", "idu_fpu_ex1_func", 9, 0); @36
assign double_ex1_op0_id_nor       = ex1_double_op0_id;
assign double_ex1_op1_id_nor       = ex1_double_op1_id;
assign single0_ex1_op0_id_nor      = ex1_single0_op0_id;
assign single0_ex1_op1_id_nor      = ex1_single0_op1_id;
assign half0_ex1_op0_id_nor        = ex1_half0_op0_id;
assign half0_ex1_op1_id_nor        = ex1_half0_op1_id;
assign bhalf0_ex1_op0_id_nor       = ex1_bhalf0_op0_id;
assign bhalf0_ex1_op1_id_nor       = ex1_bhalf0_op1_id;

//Sign bit prepare
assign ex1_op0_sign                = ex1_double && ex1_oper0[63]
                                  || ex1_single && ex1_oper0[31]
                                  || ex1_f16    && ex1_oper0[15];
assign ex1_op1_sign                = ex1_double && ex1_oper1[63]
                                  || ex1_single && ex1_oper1[31]
                                  || ex1_f16    && ex1_oper1[15];
assign div_sign                    = ex1_op0_sign ^ ex1_op1_sign;
assign sqrt_sign                   = ex1_op0_sign;
assign ex1_result_sign             = (ex1_div)
                                   ? div_sign
                                   : sqrt_sign;

//=====================find first one=======================
// this is for the denormal number
assign double_ex1_ff1_frac[51:0]  =  double_pipe_ex1_ff1_sel_op1 ? ex1_oper1[51:0]
                                                        : ex1_oper0[51:0];
assign single0_ex1_ff1_frac[22:0] = double_pipe_ex1_ff1_sel_op1 ? ex1_oper1[22:0]
                                                        : ex1_oper0[22:0];
assign half0_ex1_ff1_frac[9:0]    = double_pipe_ex1_ff1_sel_op1   ? ex1_oper1[9:0]
                                                        : ex1_oper0[9:0];
assign bhalf0_ex1_ff1_frac[6:0]   = double_pipe_ex1_ff1_sel_op1   ? ex1_oper1[6:0]
                                                        : ex1_oper0[6:0];
 
//&Instance("pa_fdsu_ff1", "x_frac_expnt");
// //&Connect(.frac_num(ex1_oper_frac[51:0])); @71
// //&Connect(.frac_bin_val(ex1_oper_id_expnt[12:0])); @72
// //&Connect(.fanc_shift_num(ex1_oper_id_frac[51:0])); @73
// //&Force("output", "ex1_oper_id_expnt"); &Force("bus", "ex1_oper_id_expnt", 12, 0); @74
// //&Force("output", "ex1_oper_id_frac"); &Force("bus", "ex1_oper_id_frac", 51, 0); @75

assign double_ex1_oper0_id_expnt[12:0]   = double_ex1_op1_sel ? double_pipe_ex1_id_expnt_f[12:0]
                                                              : double_pipe_ex1_op0_id_expnt_neg[12:0];
assign single0_ex1_oper0_id_expnt[12:0]  = single0_ex1_op1_sel ? double_pipe_ex1_id_expnt_f[12:0]
                                                               : double_pipe_ex1_op0_id_expnt_neg[12:0];
assign half0_ex1_oper0_id_expnt[12:0]    = half0_ex1_op1_sel ? double_pipe_ex1_id_expnt_f[12:0]
                                                             :  double_pipe_ex1_op0_id_expnt_neg[12:0];
assign bhalf0_ex1_oper0_id_expnt[12:0]   = bhalf0_ex1_op1_sel ? double_pipe_ex1_id_expnt_f[12:0]
                                                              : double_pipe_ex1_op0_id_expnt_neg[12:0]; 
//assign double_pipe_ex1_oper0_id_expnt[12:0]= {13{ex1_double}} & double_ex1_oper0_id_expnt[12:0]  |
//                                             {13{ex1_single}} & single0_ex1_oper0_id_expnt[12:0] |
//                                             {13{ex1_half}}   & half0_ex1_oper0_id_expnt[12:0]   |
//                                             {13{ex1_bhalf}}  & bhalf0_ex1_oper0_id_expnt[12:0];

assign double_ex1_oper0_id_frac[51:0]    = double_ex1_op1_sel ? double_ex1_id_frac_f[51:0]
                                                              : double_ex1_id_frac[51:0];
assign single0_ex1_oper0_id_frac[22:0]   = single0_ex1_op1_sel ? single0_ex1_id_frac_f[22:0]
                                                               : single0_ex1_id_frac[22:0];
assign half0_ex1_oper0_id_frac[9:0]      = half0_ex1_op1_sel ? half0_ex1_id_frac_f[9:0]
                                                             : half0_ex1_id_frac[9:0];         
assign bhalf0_ex1_oper0_id_frac[6:0]     = bhalf0_ex1_op1_sel ? bhalf0_ex1_id_frac_f[6:0]
                                                              : bhalf0_ex1_id_frac[6:0];


assign double_ex1_oper1_id_expnt[12:0]  = double_pipe_ex1_op1_id_expnt_neg[12:0];
assign double_ex1_oper1_id_frac[51:0]   = double_ex1_id_frac[51:0];
assign single0_ex1_oper1_id_expnt[12:0] = double_pipe_ex1_op1_id_expnt_neg[12:0];
assign single0_ex1_oper1_id_frac[22:0]  = single0_ex1_id_frac[22:0];
assign half0_ex1_oper1_id_expnt[12:0]   = double_pipe_ex1_op1_id_expnt_neg[12:0];
assign half0_ex1_oper1_id_frac[9:0]    = half0_ex1_id_frac[9:0];
assign bhalf0_ex1_oper1_id_expnt[12:0]  = double_pipe_ex1_op1_id_expnt_neg[12:0];
assign bhalf0_ex1_oper1_id_frac[6:0]   = bhalf0_ex1_id_frac[6:0];

//assign ex1_oper0_frac[51:0] = {52{ex1_double}} & ex1_oper0[51:0]
//                            | {52{ex1_single}} & {ex1_oper0[22:0],29'b0};
//assign ex1_oper1_frac[51:0] = {52{ex1_double}} & ex1_oper1[51:0]
//                            | {52{ex1_single}} & {ex1_oper1[22:0],29'b0};

//=====================exponent add=========================
//exponent number 0
assign double_ex1_div_op0_expnt[12:0]     = double_ex1_op0_id_nor ? double_ex1_oper0_id_expnt[12:0] 
                                                                  : {2'b0,ex1_oper0[62:52]};
assign single0_ex1_div_op0_expnt[12:0]    = single0_ex1_op0_id_nor ? single0_ex1_oper0_id_expnt[12:0]
                                                                   : {5'b0,ex1_oper0[30:23]};
assign half0_ex1_div_op0_expnt[12:0]      = half0_ex1_op0_id_nor ? half0_ex1_oper0_id_expnt[12:0]
                                                                 : {8'b0,ex1_oper0[14:10]};
assign bhalf0_ex1_div_op0_expnt[12:0]     = bhalf0_ex1_op0_id_nor ? bhalf0_ex1_oper0_id_expnt[12:0] 
                                                                  : {5'b0,ex1_oper0[14:7]};
// oper1                                                                   
assign double_ex1_div_op1_expnt[12:0]     = double_ex1_op1_id_nor ? double_ex1_oper1_id_expnt[12:0] 
                                                                  : {2'b0,ex1_oper1[62:52]};
assign single0_ex1_div_op1_expnt[12:0]    = single0_ex1_op1_id_nor ? single0_ex1_oper1_id_expnt[12:0]
                                                                   : {5'b0,ex1_oper1[30:23]};
assign half0_ex1_div_op1_expnt[12:0]      = half0_ex1_op1_id_nor ? half0_ex1_oper1_id_expnt[12:0]
                                                                 : {8'b0,ex1_oper1[14:10]};
assign bhalf0_ex1_div_op1_expnt[12:0]     = bhalf0_ex1_op1_id_nor ? bhalf0_ex1_oper1_id_expnt[12:0] 
                                                                  : {5'b0,ex1_oper1[14:7]};  

assign ex1_div_op0_expnt[12:0]     = {13{ex1_double}} & double_ex1_div_op0_expnt[12:0]
                                   | {13{ex1_single}} & single0_ex1_div_op0_expnt[12:0]
                                   | {13{ex1_half}}   & half0_ex1_div_op0_expnt[12:0]
                                   | {13{ex1_bhalf}}  & bhalf0_ex1_div_op0_expnt[12:0];
//exponent number 1
assign ex1_div_op1_expnt[12:0]  = {13{ex1_double}} & double_ex1_div_op1_expnt[12:0]
                                | {13{ex1_single}} & single0_ex1_div_op1_expnt[12:0]
                                | {13{ex1_half}}   & half0_ex1_div_op1_expnt[12:0]
                                | {13{ex1_bhalf}}  & bhalf0_ex1_div_op1_expnt[12:0];

assign ex1_sqrt_op1_expnt[12:0] = {13{ex1_double}} & {3'b0,{10{1'b1}}} //'d1023
                                | {13{ex1_single}} & {6'b0,{7{1'b1}}}  // d127
                                | {13{ex1_half}}   & {9'b0,{4{1'b1}}}  //'d15
                                | {13{ex1_bhalf}}  & {6'b0,{7{1'b1}}}; // d127
                              
assign double_pipe_ex1_expnt_adder_op0[12:0] = ex1_div_op0_expnt[12:0];
// &CombBeg; @150
always @( ex1_div
       or ex1_sqrt_op1_expnt[12:0]
       or ex1_sqrt
       or ex1_div_op1_expnt[12:0])
begin
case({ex1_div,ex1_sqrt})
  2'b10:   ex1_expnt_adder_op1[12:0] = ex1_div_op1_expnt[12:0];
  2'b01:   ex1_expnt_adder_op1[12:0] = ex1_sqrt_op1_expnt[12:0];
  default: ex1_expnt_adder_op1[12:0] = 13'b0;
endcase
// &CombEnd; @156
end

//ex1_sqrt_expnt_odd
//fraction will shift left by 1
// adder_op0/1 timing is bad.
// assign ex1_sqrt_expnt_odd          = ex1_expnt_adder_op0[0] ^ ex1_expnt_adder_op1[0];

// sqrt_odd is only used when is sqrt.
// ex1_expnt_adder_op1 is always 1'b1, so adder_op0[0] should be 0.
assign double_pipe_ex1_expnt_adder_op1[12:0] = ex1_expnt_adder_op1[12:0];
assign double_ex1_sqrt_expnt_odd             = !double_ex1_div_op0_expnt[0];
assign single0_ex1_sqrt_expnt_odd            = !single0_ex1_div_op0_expnt[0];
assign half0_ex1_sqrt_expnt_odd              = !half0_ex1_div_op0_expnt[0];
assign bhalf0_ex1_sqrt_expnt_odd             = !bhalf0_ex1_div_op0_expnt[0];

assign ex1_rm[2:0]       = dp_xx_ex1_rm[2:0];
//RNE : Always inc 1 because round to nearest of 1.111...11
//RTZ : Always not inc 1
//RUP : Always not inc 1 when posetive
//RDN : Always not inc 1 when negative
//RMM : Always inc 1 because round to max magnitude
// &CombBeg; @177
always @( ex1_rm[2:0]
       or ex1_result_sign)
begin
case(ex1_rm[2:0])
  3'b000  : double_pipe_ex1_of_result_lfn = 1'b0;
  3'b001  : double_pipe_ex1_of_result_lfn = 1'b1;
  3'b010  : double_pipe_ex1_of_result_lfn = !ex1_result_sign;
  3'b011  : double_pipe_ex1_of_result_lfn = ex1_result_sign;
  3'b100  : double_pipe_ex1_of_result_lfn = 1'b0;
  default:  double_pipe_ex1_of_result_lfn = 1'b0;
endcase
// &CombEnd; @186
end

//EX1 Remainder
//div  : 1/8  <= x < 1/4
//sqrt : 1/16 <= x < 1/4
//
assign double_ex1_remainder[59:0]  = {60{ex1_div }} & {5'b0,double_ex1_div_nor_srt_op0[52:0],2'b0} |
                                     {60{ex1_sqrt}} & double_sqrt_remainder[59:0];
assign single0_ex1_remainder[30:0] = {31{ex1_div }} & {5'b0,single0_ex1_div_nor_srt_op0[23:0],2'b0} |
                                     {31{ex1_sqrt}} & single0_sqrt_remainder[30:0];
assign half0_ex1_remainder[18:0]   = {19{ex1_div }} & {5'b0,half0_ex1_div_nor_srt_op0[10:0],3'b0} |
                                     {19{ex1_sqrt}} & half0_sqrt_remainder[18:0];
assign bhalf0_ex1_remainder[14:0]  = {15{ex1_div }} & {5'b0,bhalf0_ex1_div_nor_srt_op0[7:0],2'b0} |
                                     {15{ex1_sqrt}} & bhalf0_sqrt_remainder[14:0];
                                  

//EX1 Divisor
//1/2 <= y < 1
assign double_ex1_divisor[52:0]    = double_ex1_div_nor_srt_op1[52:0];
assign single0_ex1_divisor[23:0]   = single0_ex1_div_nor_srt_op1[23:0];
assign half0_ex1_divisor[10:0]     = half0_ex1_div_nor_srt_op1[10:0];
assign bhalf0_ex1_divisor[7:0]     = bhalf0_ex1_div_nor_srt_op1[7:0];

//ex1_div_nor_srt_op0
//assign ex1_div_noid_nor_srt_op0[52:0] = {1'b1,ex1_oper0[51:0]}
//                                      | {53{ex1_single}} & {1'b1,ex1_oper0[22:0],29'b0};
assign double_ex1_div_nor_srt_op0[52:0]  = double_ex1_op0_id_nor ? {double_ex1_oper0_id_frac[51:0],1'b0}
                                                                 : {1'b1,ex1_oper0[51:0]};
assign single0_ex1_div_nor_srt_op0[23:0] = single0_ex1_op0_id_nor ? {single0_ex1_oper0_id_frac[22:0],1'b0}
                                                                  : {1'b1,ex1_oper0[22:0]};
assign half0_ex1_div_nor_srt_op0[10:0]   = half0_ex1_op0_id_nor ? {half0_ex1_oper0_id_frac[9:0],1'b0}
                                                                : {1'b1,ex1_oper0[9:0]};
assign bhalf0_ex1_div_nor_srt_op0[7:0]   = bhalf0_ex1_op0_id_nor ? {bhalf0_ex1_oper0_id_frac[6:0],1'b0}
                                                                 : {1'b1,ex1_oper0[6:0]};
                                                                 
//ex1_div_nor_srt_op1
assign double_ex1_div_nor_srt_op1[52:0]  = double_ex1_op1_id_nor ? {double_ex1_oper1_id_frac[51:0],1'b0}
                                                               :  {1'b1,ex1_oper1[51:0]};
assign single0_ex1_div_nor_srt_op1[23:0] = single0_ex1_op1_id_nor ? {single0_ex1_oper1_id_frac[22:0],1'b0}
                                                               :  {1'b1,ex1_oper1[22:0]};
assign half0_ex1_div_nor_srt_op1[10:0]   = half0_ex1_op1_id_nor ? {half0_ex1_oper1_id_frac[9:0],1'b0}
                                                               :  {1'b1,ex1_oper1[9:0]};
assign bhalf0_ex1_div_nor_srt_op1[7:0]   = bhalf0_ex1_op1_id_nor ? {bhalf0_ex1_oper1_id_frac[6:0],1'b0}
                                                               :  {1'b1,ex1_oper1[6:0]};
//sqrt_remainder
assign double_sqrt_remainder[59:0]      = (double_ex1_sqrt_expnt_odd)
                                         ? {5'b0,double_ex1_sqrt_srt_op0[52:0],2'b0}
                                         : {6'b0,double_ex1_sqrt_srt_op0[52:0],1'b0};
assign single0_sqrt_remainder[30:0]     = (single0_ex1_sqrt_expnt_odd)
                                         ? {5'b0,single0_ex1_sqrt_srt_op0[23:0],2'b0}
                                         : {6'b0,single0_ex1_sqrt_srt_op0[23:0],1'b0};
assign half0_sqrt_remainder[18:0]       = (half0_ex1_sqrt_expnt_odd)
                                         ? {5'b0,half0_ex1_sqrt_srt_op0[10:0],3'b0}
                                         : {6'b0,half0_ex1_sqrt_srt_op0[10:0],2'b0};
assign bhalf0_sqrt_remainder[14:0]      = (bhalf0_ex1_sqrt_expnt_odd)
                                         ? {5'b0,bhalf0_ex1_sqrt_srt_op0[7:0],2'b0}
                                         : {6'b0,bhalf0_ex1_sqrt_srt_op0[7:0],1'b0};
//ex1_sqrt_srt_op0
assign double_ex1_sqrt_srt_op0[52:0]    = double_ex1_div_nor_srt_op0[52:0];
assign single0_ex1_sqrt_srt_op0[23:0]   = single0_ex1_div_nor_srt_op0[23:0];
assign half0_ex1_sqrt_srt_op0[10:0]     = half0_ex1_div_nor_srt_op0[10:0];
assign bhalf0_ex1_sqrt_srt_op0[7:0]     = bhalf0_ex1_div_nor_srt_op0[7:0];

//========================Pipe to EX2=======================
//exponent register cal result
// //&Force("output", "ex1_expnt_adder_op0"); &Force("bus", "ex1_expnt_adder_op0", 12, 0); @252
// //&Force("output", "ex1_expnt_adder_op1"); &Force("bus", "ex1_expnt_adder_op1", 12, 0); @253
// //&Force("output", "ex1_double"); @254
// //&Force("output", "ex1_expnt_adder_op0"); &Force("bus", "ex1_expnt_adder_op0", 12, 0); @256
// //&Force("output", "ex1_expnt_adder_op1"); &Force("bus", "ex1_expnt_adder_op1", 12, 0); @257
assign double_pipe_ex1_result_sign = ex1_result_sign;
// //&Force("output", "ex1_div"); @260
// //&Force("output", "ex1_sqrt"); @261
// //&Force("output", "ex1_rm"); &Force("bus", "ex1_rm", 2, 0); @262
// &Force("output", "ex1_op0_sign"); @263

assign double_ex1_op1_id_vld  = double_ex1_op1_id_nor && ex1_div;
assign single0_ex1_op1_id_vld = single0_ex1_op1_id_nor && ex1_div;
assign half0_ex1_op1_id_vld   = half0_ex1_op1_id_nor && ex1_div;
assign bhalf0_ex1_op1_id_vld  = bhalf0_ex1_op1_id_nor && ex1_div;

assign double_ex1_op0_id_vld  = double_ex1_op0_id_nor;
assign single0_ex1_op0_id_vld = single0_ex1_op0_id_nor;
assign half0_ex1_op0_id_vld   = half0_ex1_op0_id_nor; 
assign bhalf0_ex1_op0_id_vld  = bhalf0_ex1_op0_id_nor;
// &ModuleEnd; @274
endmodule



