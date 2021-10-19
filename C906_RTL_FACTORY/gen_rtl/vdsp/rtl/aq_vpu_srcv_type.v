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
module aq_vpu_srcv_type(
  cp0_vpu_xx_bf16,
  ex1_srcvx,
  ex1_srcvx_high,
  ex1_srcvx_vec,
  inst_simd,
  srcvx_type
);

// &Ports; @25
input           cp0_vpu_xx_bf16;      
input   [63:0]  ex1_srcvx;            
input   [47:0]  ex1_srcvx_high;       
input           ex1_srcvx_vec;        
input           inst_simd;            
output  [47:0]  srcvx_type;           

// &Regs; @26

// &Wires; @27
wire            cp0_vpu_xx_bf16;      
wire    [63:0]  ex1_srcvx;            
wire    [47:0]  ex1_srcvx_high;       
wire            ex1_srcvx_vec;        
wire            inst_simd;            
wire    [63:0]  src;                  
wire            src_double_expn_max;  
wire            src_double_expn_zero; 
wire            src_double_frac_msb;  
wire            src_double_frac_zero; 
wire            src_double_id;        
wire            src_double_inf;       
wire            src_double_norm;      
wire            src_double_qnan;      
wire            src_double_snan;      
wire            src_double_zero;      
wire            src_half0_cnan;       
wire            src_half0_expn_max;   
wire            src_half0_expn_zero;  
wire            src_half0_frac_msb;   
wire            src_half0_frac_zero;  
wire            src_half0_id;         
wire            src_half0_inf;        
wire            src_half0_norm;       
wire            src_half0_qnan;       
wire            src_half0_snan;       
wire            src_half0_zero;       
wire            src_half1_cnan;       
wire            src_half1_expn_max;   
wire            src_half1_expn_zero;  
wire            src_half1_frac_msb;   
wire            src_half1_frac_zero;  
wire            src_half1_id;         
wire            src_half1_inf;        
wire            src_half1_norm;       
wire            src_half1_qnan;       
wire            src_half1_snan;       
wire            src_half1_zero;       
wire            src_half2_cnan;       
wire            src_half2_expn_max;   
wire            src_half2_expn_zero;  
wire            src_half2_frac_msb;   
wire            src_half2_frac_zero;  
wire            src_half2_id;         
wire            src_half2_inf;        
wire            src_half2_norm;       
wire            src_half2_qnan;       
wire            src_half2_snan;       
wire            src_half2_zero;       
wire            src_half3_cnan;       
wire            src_half3_expn_max;   
wire            src_half3_expn_zero;  
wire            src_half3_frac_msb;   
wire            src_half3_frac_zero;  
wire            src_half3_id;         
wire            src_half3_inf;        
wire            src_half3_norm;       
wire            src_half3_qnan;       
wire            src_half3_snan;       
wire            src_half3_zero;       
wire    [47:0]  src_high;             
wire            src_single0_cnan;     
wire            src_single0_expn_max; 
wire            src_single0_expn_zero; 
wire            src_single0_frac_msb; 
wire            src_single0_frac_zero; 
wire            src_single0_id;       
wire            src_single0_inf;      
wire            src_single0_norm;     
wire            src_single0_qnan;     
wire            src_single0_snan;     
wire            src_single0_zero;     
wire            src_single1_cnan;     
wire            src_single1_expn_max; 
wire            src_single1_expn_zero; 
wire            src_single1_frac_msb; 
wire            src_single1_frac_zero; 
wire            src_single1_id;       
wire            src_single1_inf;      
wire            src_single1_norm;     
wire            src_single1_qnan;     
wire            src_single1_snan;     
wire            src_single1_zero;     
wire            src_vec;              
wire    [47:0]  srcvx_type;           


assign src[63:0]       = ex1_srcvx[63:0];
assign src_high[47:0]  = ex1_srcvx_high[47:0]; 
assign src_vec         = ex1_srcvx_vec;

//double
assign src_double_expn_zero  = !(|src[62:52]);
assign src_double_expn_max   =  &src[62:52];
assign src_double_frac_zero  = !(|src[51:0]);
assign src_double_frac_msb   = src[51];

assign src_double_snan       = src_double_expn_max && !src_double_frac_msb &&!src_double_frac_zero;
assign src_double_qnan       = src_double_expn_max && src_double_frac_msb;
assign src_double_inf        = src_double_expn_max && src_double_frac_zero;
assign src_double_zero       = src_double_expn_zero && src_double_frac_zero;
assign src_double_id         = src_double_expn_zero && !src_double_frac_zero;
assign src_double_norm       = !src_double_zero && !src_double_expn_max;

//single0
//assign src_single0_cnan       = !(&src[63:32]) && (inst_vec_vf && src_sel || !inst_simd);
assign src_single0_cnan       = (inst_simd) ? !(&src_high[47:16] || src_vec): !(&src[63:32]);
//assign src_single0_cnan       = !(&src[63:32]);
assign src_single0_expn_zero  = !(|src[30:23]);
assign src_single0_expn_max   = &src[30:23];
assign src_single0_frac_zero  = !(|src[22:0]);
assign src_single0_frac_msb   = src[22];

assign src_single0_snan       = src_single0_expn_max && !src_single0_frac_msb && !src_single0_frac_zero && !src_single0_cnan;
assign src_single0_qnan       = src_single0_expn_max && src_single0_frac_msb || src_single0_cnan;
assign src_single0_inf        = src_single0_expn_max && src_single0_frac_zero && !src_single0_cnan;
assign src_single0_zero       = src_single0_expn_zero && src_single0_frac_zero && !src_single0_cnan;
assign src_single0_id         = src_single0_expn_zero && !src_single0_frac_zero;
assign src_single0_norm       = !src_single0_zero && !src_single0_expn_max && !src_single0_cnan;

//single1
//assign src_single1_cnan       = src_sel && inst_vec_vf && !(&src[63:32]);
assign src_single1_cnan       = !(&src_high[47:16] || src_vec);
//assign src_single1_cnan       = !(&src[63:32]);
assign src_single1_expn_zero  = !(|src[62:55]);
assign src_single1_expn_max   = &src[62:55];
assign src_single1_frac_zero  = !(|src[54:32]);
assign src_single1_frac_msb   = src[54];

assign src_single1_snan       = src_single1_expn_max && !src_single1_frac_msb && !src_single1_frac_zero && !src_single1_cnan;
assign src_single1_qnan       = src_single1_expn_max && src_single1_frac_msb || src_single1_cnan;
assign src_single1_inf        = src_single1_expn_max && src_single1_frac_zero && !src_single1_cnan;
assign src_single1_zero       = src_single1_expn_zero && src_single1_frac_zero && !src_single1_cnan;
assign src_single1_id         = src_single1_expn_zero && !src_single1_frac_zero;
assign src_single1_norm       = !src_single1_zero && !src_single1_expn_max && !src_single1_cnan;

//half0
//assign src_half0_cnan       = !(&src[63:16]) && (inst_vec_vf && src_sel || !inst_simd);
assign src_half0_cnan       = (inst_simd) ? !(&src_high[47:0] || src_vec): !(&src[63:16]);
//assign src_half0_cnan       = !(&src[63:16]);
assign src_half0_expn_zero  = (cp0_vpu_xx_bf16) ? !(|src[14:7]) : !(|src[14:10]);
assign src_half0_expn_max   = (cp0_vpu_xx_bf16) ? &src[14:7]    : &src[14:10];
assign src_half0_frac_zero  = (cp0_vpu_xx_bf16) ? !(|src[6:0])  :!(|src[9:0]);
assign src_half0_frac_msb   = (cp0_vpu_xx_bf16) ? src[6]        : src[9];

assign src_half0_snan       = src_half0_expn_max && !src_half0_frac_msb && !src_half0_frac_zero && !src_half0_cnan;
assign src_half0_qnan       = src_half0_expn_max && src_half0_frac_msb || src_half0_cnan;
assign src_half0_inf        = src_half0_expn_max && src_half0_frac_zero && !src_half0_cnan;
assign src_half0_zero       = src_half0_expn_zero && src_half0_frac_zero && !src_half0_cnan;
assign src_half0_id         = src_half0_expn_zero && !src_half0_frac_zero;
assign src_half0_norm       = !src_half0_zero && !src_half0_expn_max && !src_half0_cnan;

//half1
//assign src_half1_cnan       = src_sel && inst_vec_vf && !(&src[63:16]); 
assign src_half1_cnan       = !(&src_high[47:0] || src_vec); 
assign src_half1_expn_zero  = (cp0_vpu_xx_bf16) ? !(|src[30:23]) : !(|src[30:26]);
assign src_half1_expn_max   = (cp0_vpu_xx_bf16) ? &src[30:23]    : &src[30:26];
assign src_half1_frac_zero  = (cp0_vpu_xx_bf16) ? !(|src[22:16])  :!(|src[25:16]);
assign src_half1_frac_msb   = (cp0_vpu_xx_bf16) ? src[22]        : src[25];

assign src_half1_snan       = src_half1_expn_max && !src_half1_frac_msb && !src_half1_frac_zero && !src_half1_cnan;
assign src_half1_qnan       = src_half1_expn_max && src_half1_frac_msb || src_half1_cnan;
assign src_half1_inf        = src_half1_expn_max && src_half1_frac_zero && !src_half1_cnan;
assign src_half1_zero       = src_half1_expn_zero && src_half1_frac_zero && !src_half1_cnan;
assign src_half1_id         = src_half1_expn_zero && !src_half1_frac_zero;
assign src_half1_norm       = !src_half1_zero && !src_half1_expn_max && !src_half1_cnan;

//half2
//assign src_half2_cnan       = src_sel && inst_vec_vf && !(&src[63:16]); 
assign src_half2_cnan       = !(&src_high[47:0] || src_vec); 
assign src_half2_expn_zero  = (cp0_vpu_xx_bf16) ? !(|src[46:39]) : !(|src[46:42]);
assign src_half2_expn_max   = (cp0_vpu_xx_bf16) ? &src[46:39]    : &src[46:42];
assign src_half2_frac_zero  = (cp0_vpu_xx_bf16) ? !(|src[38:32]) :!(|src[41:32]);
assign src_half2_frac_msb   = (cp0_vpu_xx_bf16) ? src[38]        : src[41];

assign src_half2_snan       = src_half2_expn_max && !src_half2_frac_msb && !src_half2_frac_zero && !src_half2_cnan;
assign src_half2_qnan       = src_half2_expn_max && src_half2_frac_msb || src_half2_cnan;
assign src_half2_inf        = src_half2_expn_max && src_half2_frac_zero && !src_half2_cnan;
assign src_half2_zero       = src_half2_expn_zero && src_half2_frac_zero && !src_half2_cnan;
assign src_half2_id         = src_half2_expn_zero && !src_half2_frac_zero;
assign src_half2_norm       = !src_half2_zero && !src_half2_expn_max && !src_half2_cnan;

//half3
//assign src_half3_cnan       = src_sel && inst_vec_vf && !(&src[63:16]); 
assign src_half3_cnan       = !(&src_high[47:0] || src_vec); 
assign src_half3_expn_zero  = (cp0_vpu_xx_bf16) ? !(|src[62:55]) : !(|src[62:58]);
assign src_half3_expn_max   = (cp0_vpu_xx_bf16) ? &src[62:55]    : &src[62:58];
assign src_half3_frac_zero  = (cp0_vpu_xx_bf16) ? !(|src[54:48]) :!(|src[57:48]);
assign src_half3_frac_msb   = (cp0_vpu_xx_bf16) ? src[54]        : src[57];

assign src_half3_snan       = src_half3_expn_max && !src_half3_frac_msb && !src_half3_frac_zero && !src_half3_cnan;
assign src_half3_qnan       = src_half3_expn_max && src_half3_frac_msb || src_half3_cnan;
assign src_half3_inf        = src_half3_expn_max && src_half3_frac_zero && !src_half3_cnan;
assign src_half3_zero       = src_half3_expn_zero && src_half3_frac_zero && !src_half3_cnan;
assign src_half3_id         = src_half3_expn_zero && !src_half3_frac_zero;
assign src_half3_norm       = !src_half3_zero && !src_half3_expn_max && !src_half3_cnan;

assign srcvx_type[47:0] = {src_double_snan,
                           src_double_qnan,
                           src_double_inf,
                           src_double_zero,
                           src_double_id,
                           src_double_norm,
                           src_single0_cnan,
                           src_single0_snan,
                           src_single0_qnan,
                           src_single0_inf,
                           src_single0_zero,
                           src_single0_id,
                           src_single0_norm,
                           src_single1_cnan,
                           src_single1_snan,
                           src_single1_qnan,
                           src_single1_inf,
                           src_single1_zero,
                           src_single1_id,
                           src_single1_norm,
                           src_half0_cnan,
                           src_half0_snan,
                           src_half0_qnan,
                           src_half0_inf,
                           src_half0_zero,
                           src_half0_id,
                           src_half0_norm,
                           src_half1_cnan,
                           src_half1_snan,
                           src_half1_qnan,
                           src_half1_inf,
                           src_half1_zero,
                           src_half1_id,
                           src_half1_norm,
                           src_half2_cnan,
                           src_half2_snan,
                           src_half2_qnan,
                           src_half2_inf,
                           src_half2_zero,
                           src_half2_id,
                           src_half2_norm,
                           src_half3_cnan,
                           src_half3_snan,
                           src_half3_qnan,
                           src_half3_inf,
                           src_half3_zero,
                           src_half3_id,
                           src_half3_norm};

// &ModuleEnd; @188
endmodule



