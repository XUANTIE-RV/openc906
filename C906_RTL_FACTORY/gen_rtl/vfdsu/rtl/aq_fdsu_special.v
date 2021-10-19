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
module aq_fdsu_special(
  bhalf0_ex1_qnan_f,
  cp0_vpu_xx_dqnan,
  double_ex1_qnan_f,
  double_pipe_ex1_dz,
  double_pipe_ex1_nv,
  double_pipe_ex1_op0_cnan,
  double_pipe_ex1_op0_inf,
  double_pipe_ex1_op0_norm,
  double_pipe_ex1_op0_qnan,
  double_pipe_ex1_op0_snan,
  double_pipe_ex1_op0_zero,
  double_pipe_ex1_op1_cnan,
  double_pipe_ex1_op1_inf,
  double_pipe_ex1_op1_norm,
  double_pipe_ex1_op1_qnan,
  double_pipe_ex1_op1_snan,
  double_pipe_ex1_op1_zero,
  double_pipe_ex1_result_inf,
  double_pipe_ex1_result_lfn,
  double_pipe_ex1_result_qnan,
  double_pipe_ex1_result_zero,
  double_pipe_ex1_srt_skip,
  ex1_div,
  ex1_op0_sign,
  ex1_oper0,
  ex1_oper1,
  ex1_sqrt,
  half0_ex1_qnan_f,
  single0_ex1_qnan_f
);

// &Ports; @24
input           cp0_vpu_xx_dqnan;           
input           double_pipe_ex1_op0_cnan;   
input           double_pipe_ex1_op0_inf;    
input           double_pipe_ex1_op0_qnan;   
input           double_pipe_ex1_op0_snan;   
input           double_pipe_ex1_op0_zero;   
input           double_pipe_ex1_op1_cnan;   
input           double_pipe_ex1_op1_inf;    
input           double_pipe_ex1_op1_qnan;   
input           double_pipe_ex1_op1_snan;   
input           double_pipe_ex1_op1_zero;   
input           ex1_div;                    
input           ex1_op0_sign;               
input   [63:0]  ex1_oper0;                  
input   [63:0]  ex1_oper1;                  
input           ex1_sqrt;                   
output  [7 :0]  bhalf0_ex1_qnan_f;          
output  [52:0]  double_ex1_qnan_f;          
output          double_pipe_ex1_dz;         
output          double_pipe_ex1_nv;         
output          double_pipe_ex1_op0_norm;   
output          double_pipe_ex1_op1_norm;   
output          double_pipe_ex1_result_inf; 
output          double_pipe_ex1_result_lfn; 
output          double_pipe_ex1_result_qnan; 
output          double_pipe_ex1_result_zero; 
output          double_pipe_ex1_srt_skip;   
output  [10:0]  half0_ex1_qnan_f;           
output  [23:0]  single0_ex1_qnan_f;         

// &Regs; @25
reg             ex1_result_cnan;            
reg             ex1_result_qnan_op0;        
reg             ex1_result_qnan_op1;        

// &Wires; @26
wire    [7 :0]  bhalf0_ex1_qnan_f;          
wire            cp0_vpu_xx_dqnan;           
wire    [52:0]  double_ex1_qnan_f;          
wire            double_pipe_ex1_dz;         
wire            double_pipe_ex1_nv;         
wire            double_pipe_ex1_op0_cnan;   
wire            double_pipe_ex1_op0_inf;    
wire            double_pipe_ex1_op0_norm;   
wire            double_pipe_ex1_op0_qnan;   
wire            double_pipe_ex1_op0_snan;   
wire            double_pipe_ex1_op0_zero;   
wire            double_pipe_ex1_op1_cnan;   
wire            double_pipe_ex1_op1_inf;    
wire            double_pipe_ex1_op1_norm;   
wire            double_pipe_ex1_op1_qnan;   
wire            double_pipe_ex1_op1_snan;   
wire            double_pipe_ex1_op1_zero;   
wire            double_pipe_ex1_result_inf; 
wire            double_pipe_ex1_result_lfn; 
wire            double_pipe_ex1_result_qnan; 
wire            double_pipe_ex1_result_zero; 
wire            double_pipe_ex1_srt_skip;   
wire            ex1_div;                    
wire            ex1_div_dz;                 
wire            ex1_div_nv;                 
wire            ex1_div_rst_inf;            
wire            ex1_div_rst_qnan;           
wire            ex1_div_rst_zero;           
wire            ex1_dz;                     
wire            ex1_nv;                     
wire            ex1_op0_cnan;               
wire            ex1_op0_inf;                
wire            ex1_op0_is_qnan;            
wire            ex1_op0_is_snan;            
wire            ex1_op0_norm;               
wire            ex1_op0_qnan;               
wire            ex1_op0_sign;               
wire            ex1_op0_snan;               
wire            ex1_op0_tt_zero;            
wire            ex1_op0_zero;               
wire            ex1_op1_cnan;               
wire            ex1_op1_inf;                
wire            ex1_op1_is_qnan;            
wire            ex1_op1_is_snan;            
wire            ex1_op1_norm;               
wire            ex1_op1_qnan;               
wire            ex1_op1_snan;               
wire            ex1_op1_tt_zero;            
wire            ex1_op1_zero;               
wire    [63:0]  ex1_oper0;                  
wire    [63:0]  ex1_oper1;                  
wire            ex1_result_inf;             
wire            ex1_result_lfn;             
wire            ex1_result_qnan;            
wire            ex1_result_zero;            
wire            ex1_rst_default_qnan;       
wire            ex1_sqrt;                   
wire            ex1_sqrt_nv;                
wire            ex1_sqrt_rst_inf;           
wire            ex1_sqrt_rst_qnan;          
wire            ex1_sqrt_rst_zero;          
wire    [10:0]  half0_ex1_qnan_f;           
wire    [23:0]  single0_ex1_qnan_f;         


//infinity number
// &Force("bus", "dp_xx_ex1_inf", 2, 0); @29
assign  ex1_op0_inf                = double_pipe_ex1_op0_inf;
assign  ex1_op1_inf                = double_pipe_ex1_op1_inf;

//zero
// &Force("bus", "dp_xx_ex1_zero", 2, 0); @34
assign ex1_op0_zero                = double_pipe_ex1_op0_zero;
assign ex1_op1_zero                = double_pipe_ex1_op1_zero;

//cNaN
// &Force("bus", "dp_xx_ex1_cnan", 2, 0); @39
assign ex1_op0_cnan                = double_pipe_ex1_op0_cnan;
assign ex1_op1_cnan                = double_pipe_ex1_op1_cnan;

//sNaN
// &Force("bus", "dp_xx_ex1_snan", 2, 0); @44
assign ex1_op0_snan                = double_pipe_ex1_op0_snan;
assign ex1_op1_snan                = double_pipe_ex1_op1_snan;

//qNaN
// &Force("bus", "dp_xx_ex1_qnan", 2, 0); @49
assign ex1_op0_qnan                = double_pipe_ex1_op0_qnan;
assign ex1_op1_qnan                = double_pipe_ex1_op1_qnan;


//======================EX1 expt detect=====================
//ex1_id_detect
//any opration is zero
// no input denormalize exception anymore
//
//ex1_nv_detect
//div_nv
//  1.any operation is sNaN
//  2.0/0(include DN flush to zero)
//  3.inf/inf
//sqrt_nv
//  1.any operation is sNaN
//  2.operation sign is 1 && operation is not zero/qNaN
assign ex1_nv      = ex1_div  && ex1_div_nv  ||
                     ex1_sqrt && ex1_sqrt_nv;
//ex1_div_nv
assign ex1_div_nv  = ex1_op0_snan ||
                     ex1_op1_snan ||
                    (ex1_op0_tt_zero && ex1_op1_tt_zero)||
                    (ex1_op0_inf && ex1_op1_inf);
assign ex1_op0_tt_zero = ex1_op0_zero;
assign ex1_op1_tt_zero = ex1_op1_zero;
//ex1_sqrt_nv
assign ex1_sqrt_nv = ex1_op0_snan ||
                     ex1_op0_sign &&
                    (ex1_op0_norm ||
                     ex1_op0_inf );

// This 'norm' also include denorm.
assign ex1_op0_norm = !ex1_op0_inf && !ex1_op0_zero && !ex1_op0_snan && !ex1_op0_qnan && !ex1_op0_cnan;
assign ex1_op1_norm = !ex1_op1_inf && !ex1_op1_zero && !ex1_op1_snan && !ex1_op1_qnan && !ex1_op1_cnan;

//ex1_of_detect
//div_of
//  1.only detect id overflow case
//assign ex1_of      = ex1_div && ex1_div_of;
//assign ex1_div_of  = ex1_op1_id_fm1 &&
//                     ex1_op0_norm &&
//                     ex1_div_id_of;
//
////ex1_uf_detect
////div_uf
////  1.only detect id underflow case
//assign ex1_uf      = ex1_div && ex1_div_uf;
//assign ex1_div_uf  = ex1_op0_id &&
//                     ex1_op1_norm &&
//                     ex1_div_id_uf;
//ex1_dz_detect
//div_dz
//  1.op0 is normal && op1 zero
assign ex1_dz      = ex1_div && ex1_div_dz;
assign ex1_div_dz  = ex1_op1_tt_zero && ex1_op0_norm;

//===================special cal result=====================
//ex1 result is zero
//div_zero
//  1.op0 is zero && op1 is normal
//  2.op0 is zero/normal && op1 is inf
//sqrt_zero
//  1.op0 is zero
assign ex1_result_zero   = ex1_div_rst_zero  && ex1_div  ||
                           ex1_sqrt_rst_zero && ex1_sqrt;
assign ex1_div_rst_zero  = (ex1_op0_tt_zero && ex1_op1_norm ) ||
                           // (!ex1_expnt0_max && !ex1_op0_cnan && ex1_op1_inf);
                           (!ex1_op0_inf && !ex1_op0_qnan && !ex1_op0_snan && !ex1_op0_cnan && ex1_op1_inf);
assign ex1_sqrt_rst_zero = ex1_op0_tt_zero;

//ex1 result is qNaN
//ex1_nv
//div_qnan
//  1.op0 is qnan || op1 is qnan
//sqrt_qnan
//  1.op0 is qnan
assign ex1_result_qnan   = ex1_div_rst_qnan  && ex1_div  ||
                           ex1_sqrt_rst_qnan && ex1_sqrt ||
                           ex1_nv;
assign ex1_div_rst_qnan  = ex1_op0_qnan ||
                           ex1_op1_qnan;
assign ex1_sqrt_rst_qnan = ex1_op0_qnan;

//ex1_rst_default_qnan
//0/0, inf/inf, sqrt negative should get default qNaN
assign ex1_rst_default_qnan = (ex1_div && ex1_op0_zero && ex1_op1_zero) ||
                              (ex1_div && ex1_op0_inf  && ex1_op1_inf)  ||
                              (ex1_sqrt&& ex1_op0_sign && (ex1_op0_norm || ex1_op0_inf));

//ex1 result is inf
//ex1_dz
//
//div_inf
//  1.op0 is inf && op1 is normal/zero
//sqrt_inf
//  1.op0 is inf
assign ex1_result_inf    = ex1_div_rst_inf  && ex1_div  ||
                           ex1_sqrt_rst_inf && ex1_sqrt ||
                           ex1_dz ;
// assign ex1_div_rst_inf   = ex1_op0_inf && !ex1_expnt1_max && !ex1_op1_cnan;
assign ex1_div_rst_inf   = ex1_op0_inf && !ex1_op1_inf && !ex1_op1_qnan && !ex1_op1_snan && !ex1_op1_cnan;
assign ex1_sqrt_rst_inf  = ex1_op0_inf && !ex1_op0_sign;

//ex1 result is lfn
//ex1_of && round result toward not inc 1
assign ex1_result_lfn = 1'b0;

//Default_qnan/Standard_qnan Select
assign ex1_op0_is_snan      = ex1_op0_snan;
assign ex1_op1_is_snan      = ex1_op1_snan && ex1_div;
assign ex1_op0_is_qnan      = ex1_op0_qnan;
assign ex1_op1_is_qnan      = ex1_op1_qnan && ex1_div;

// &CombBeg; @164
always @( ex1_op0_is_snan
       or ex1_op0_cnan
       or ex1_result_qnan
       or ex1_op0_is_qnan
       or ex1_rst_default_qnan
       or cp0_vpu_xx_dqnan
       or ex1_op1_cnan
       or ex1_op1_is_qnan
       or ex1_op1_is_snan)
begin
if(ex1_rst_default_qnan)
begin
  ex1_result_qnan_op0  = 1'b0;
  ex1_result_qnan_op1  = 1'b0;
  ex1_result_cnan      = ex1_result_qnan;
end
else if(ex1_op0_is_snan && cp0_vpu_xx_dqnan)
begin
  ex1_result_qnan_op0  = ex1_result_qnan;
  ex1_result_qnan_op1  = 1'b0;
  ex1_result_cnan      = 1'b0;
end
else if(ex1_op1_is_snan && cp0_vpu_xx_dqnan)
begin
  ex1_result_qnan_op0  = 1'b0;
  ex1_result_qnan_op1  = ex1_result_qnan;
  ex1_result_cnan      = 1'b0;
end
else if(ex1_op0_is_qnan && cp0_vpu_xx_dqnan)
begin
  ex1_result_qnan_op0  = ex1_result_qnan && !ex1_op0_cnan;
  ex1_result_qnan_op1  = 1'b0;
  ex1_result_cnan      = ex1_result_qnan &&  ex1_op0_cnan;
end
else if(ex1_op1_is_qnan && cp0_vpu_xx_dqnan)
begin
  ex1_result_qnan_op0  = 1'b0;
  ex1_result_qnan_op1  = ex1_result_qnan && !ex1_op1_cnan;
  ex1_result_cnan      = ex1_result_qnan &&  ex1_op1_cnan;
end
else
begin
  ex1_result_qnan_op0  = 1'b0;
  ex1_result_qnan_op1  = 1'b0;
  ex1_result_cnan      = ex1_result_qnan;
end
// &CombEnd; @201
end


//Special result should skip SRT logic
assign double_pipe_ex1_srt_skip = ex1_result_zero ||
                                  ex1_result_qnan ||
                      ex1_result_lfn  ||
                      ex1_result_inf;
// fflags:
// NV, DZ, OF, UF, NX
assign double_pipe_ex1_nv = ex1_nv;
assign double_pipe_ex1_dz = ex1_dz;
//assign double_pipe_ex1_special_sel[5:0] = ex1_special_sel[6:1]; 
assign double_pipe_ex1_result_lfn       = ex1_result_lfn;
assign double_pipe_ex1_result_inf       = ex1_result_inf;
assign double_pipe_ex1_result_zero      = ex1_result_zero;
//assign ex1_fflags[4:0] = {ex1_nv, ex1_dz, 3'b0};
// Special Sel[7:0]:
// qnan_src2, qnan_src1, qnan_src0, cnan, lfn, inf, zero, src2
//assign ex1_special_sel[7:0] = {1'b0, ex1_result_qnan_op1, ex1_result_qnan_op0,
//                               ex1_result_cnan, ex1_result_lfn, ex1_result_inf,
//                               ex1_result_zero, 1'b0};
//assign ex1_result_sign          = double_pipe_ex1_result_sign;
// &Force("bus","ex1_oper0",63,0); @224
// &Force("bus","ex1_oper1",63,0); @225
assign double_ex1_qnan_f[52:0]  = ex1_result_qnan_op1 ? {ex1_oper1[63],1'b1, ex1_oper1[50:0]} : 
                                  ex1_result_qnan_op0 ? {ex1_oper0[63],1'b1, ex1_oper0[50:0]} : {1'b0,1'b1, 51'b0};
assign single0_ex1_qnan_f[23:0] = ex1_result_qnan_op1 ? {ex1_oper1[31],1'b1, ex1_oper1[21:0]} : 
                                  ex1_result_qnan_op0 ? {ex1_oper0[31],1'b1, ex1_oper0[21:0]} : {1'b0,1'b1, 22'b0};
assign half0_ex1_qnan_f[10:0]    = ex1_result_qnan_op1 ? {ex1_oper1[15],1'b1, ex1_oper1[8:0]} : 
                                  ex1_result_qnan_op0 ? {ex1_oper0[15],1'b1, ex1_oper0[8:0]} : {1'b0,1'b1, 9'b0};
assign bhalf0_ex1_qnan_f[7:0]   = ex1_result_qnan_op1 ? {ex1_oper1[15],1'b1, ex1_oper1[5:0]} : 
                                  ex1_result_qnan_op0 ? {ex1_oper0[15],1'b1, ex1_oper0[5:0]} : {1'b0,1'b1, 6'b0};
assign double_pipe_ex1_result_qnan  = ex1_result_qnan_op1 || ex1_result_qnan_op0 
                                      || ex1_result_cnan;

// Special Sign[3:0]
// lfn, inf, zero, src2
//assign ex1_special_sign[3:0] = {ex1_result_sign, ex1_result_sign, ex1_result_sign, 1'b0};

//==========================================================
//                      Output Signal
//==========================================================
//assign fdsu_fpu_ex1_fflags[4:0]       = ex1_fflags[4:0];
//assign fdsu_fpu_ex1_special_sel[7:0]  = ex1_special_sel[7:0];
//assign fdsu_fpu_ex1_special_sign[3:0] = ex1_special_sign[3:0];
assign double_pipe_ex1_op0_norm = ex1_op0_norm;
assign double_pipe_ex1_op1_norm = ex1_op1_norm;
// //&Force("output", "ex1_op0_norm"); @249
// //&Force("output", "ex1_op1_norm"); @250

// &ModuleEnd; @252
endmodule



