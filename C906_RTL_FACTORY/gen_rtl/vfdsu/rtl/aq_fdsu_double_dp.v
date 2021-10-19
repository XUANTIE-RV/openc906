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

// &ModuleBeg; @22
module aq_fdsu_double_dp(
  ex1_pipe_clk,
  ex1_pipedown,
  ex2_pipe_clk,
  ex2_pipedown,
  ex3_pipedown,
  expnt_rst_clk,
  fdsu_ex1_dz,
  fdsu_ex1_expnt_adder_op0,
  fdsu_ex1_id_expnt_f,
  fdsu_ex1_nv,
  fdsu_ex1_of_result_lfn,
  fdsu_ex1_op0_id_expnt_neg,
  fdsu_ex1_op0_norm,
  fdsu_ex1_op1_norm,
  fdsu_ex1_result_inf,
  fdsu_ex1_result_lfn,
  fdsu_ex1_result_qnan,
  fdsu_ex1_result_sign,
  fdsu_ex1_result_zero,
  fdsu_ex1_save_op0,
  fdsu_ex2_expnt_adder_op0,
  fdsu_ex2_of,
  fdsu_ex2_of_rm_lfn,
  fdsu_ex2_op0_norm,
  fdsu_ex2_op1_norm,
  fdsu_ex2_potnt_of,
  fdsu_ex2_potnt_uf,
  fdsu_ex2_result_inf,
  fdsu_ex2_result_lfn,
  fdsu_ex2_rslt_denorm,
  fdsu_ex2_srt_expnt_rst,
  fdsu_ex2_uf,
  fdsu_ex3_expnt_adjust_result,
  fdsu_ex3_expnt_rst,
  fdsu_ex3_potnt_uf,
  fdsu_ex3_result_inf,
  fdsu_ex3_result_lfn,
  fdsu_ex3_result_qnan,
  fdsu_ex3_result_sign,
  fdsu_ex3_result_zero,
  fdsu_ex3_rslt_denorm,
  fdsu_ex3_rslt_denorm_in,
  fdsu_ex4_dz,
  fdsu_ex4_expnt_rst,
  fdsu_ex4_nv,
  fdsu_ex4_of,
  fdsu_ex4_of_rm_lfn,
  fdsu_ex4_potnt_of,
  fdsu_ex4_potnt_uf,
  fdsu_ex4_result_inf,
  fdsu_ex4_result_lfn,
  fdsu_ex4_result_qnan,
  fdsu_ex4_result_sign,
  fdsu_ex4_result_zero,
  fdsu_ex4_rslt_denorm,
  fdsu_ex4_uf,
  fdsu_op0_ff1_cnt,
  fdsu_op0_id_expnt,
  fdsu_save_op0_neg_expnt
);

// &Ports; @23
input           ex1_pipe_clk;                
input           ex1_pipedown;                
input           ex2_pipe_clk;                
input           ex2_pipedown;                
input           ex3_pipedown;                
input           expnt_rst_clk;               
input           fdsu_ex1_dz;                 
input   [12:0]  fdsu_ex1_expnt_adder_op0;    
input           fdsu_ex1_nv;                 
input           fdsu_ex1_of_result_lfn;      
input   [12:0]  fdsu_ex1_op0_id_expnt_neg;   
input           fdsu_ex1_op0_norm;           
input           fdsu_ex1_op1_norm;           
input           fdsu_ex1_result_inf;         
input           fdsu_ex1_result_lfn;         
input           fdsu_ex1_result_qnan;        
input           fdsu_ex1_result_sign;        
input           fdsu_ex1_result_zero;        
input           fdsu_ex1_save_op0;           
input           fdsu_ex2_of;                 
input           fdsu_ex2_potnt_of;           
input           fdsu_ex2_potnt_uf;           
input           fdsu_ex2_result_inf;         
input           fdsu_ex2_result_lfn;         
input           fdsu_ex2_rslt_denorm;        
input   [12:0]  fdsu_ex2_srt_expnt_rst;      
input           fdsu_ex2_uf;                 
input   [12:0]  fdsu_ex3_expnt_adjust_result; 
input           fdsu_ex3_rslt_denorm;        
input   [12:0]  fdsu_op0_ff1_cnt;            
input           fdsu_save_op0_neg_expnt;     
output  [12:0]  fdsu_ex1_id_expnt_f;         
output  [12:0]  fdsu_ex2_expnt_adder_op0;    
output          fdsu_ex2_of_rm_lfn;          
output          fdsu_ex2_op0_norm;           
output          fdsu_ex2_op1_norm;           
output  [12:0]  fdsu_ex3_expnt_rst;          
output          fdsu_ex3_potnt_uf;           
output          fdsu_ex3_result_inf;         
output          fdsu_ex3_result_lfn;         
output          fdsu_ex3_result_qnan;        
output          fdsu_ex3_result_sign;        
output          fdsu_ex3_result_zero;        
output          fdsu_ex3_rslt_denorm_in;     
output          fdsu_ex4_dz;                 
output  [12:0]  fdsu_ex4_expnt_rst;          
output          fdsu_ex4_nv;                 
output          fdsu_ex4_of;                 
output          fdsu_ex4_of_rm_lfn;          
output          fdsu_ex4_potnt_of;           
output          fdsu_ex4_potnt_uf;           
output          fdsu_ex4_result_inf;         
output          fdsu_ex4_result_lfn;         
output          fdsu_ex4_result_qnan;        
output          fdsu_ex4_result_sign;        
output          fdsu_ex4_result_zero;        
output          fdsu_ex4_rslt_denorm;        
output          fdsu_ex4_uf;                 
output  [12:0]  fdsu_op0_id_expnt;           

// &Regs; @24
reg             fdsu_dz;                     
reg     [12:0]  fdsu_expnt_rst;              
reg             fdsu_nv;                     
reg             fdsu_of;                     
reg             fdsu_of_rm_lfn;              
reg             fdsu_op0_norm;               
reg             fdsu_op1_norm;               
reg             fdsu_potnt_of;               
reg             fdsu_potnt_uf;               
reg             fdsu_result_inf;             
reg             fdsu_result_lfn;             
reg             fdsu_result_qnan;            
reg             fdsu_result_sign;            
reg             fdsu_result_zero;            
reg             fdsu_uf;                     
reg             fdsu_yy_rslt_denorm;         

// &Wires; @25
wire            ex1_pipe_clk;                
wire            ex1_pipedown;                
wire            ex2_pipe_clk;                
wire            ex2_pipedown;                
wire            ex2_result_inf;              
wire            ex2_result_lfn;              
wire            ex3_pipedown;                
wire            expnt_rst_clk;               
wire            fdsu_ex1_dz;                 
wire    [12:0]  fdsu_ex1_expnt_adder_op0;    
wire    [12:0]  fdsu_ex1_id_expnt_f;         
wire            fdsu_ex1_nv;                 
wire            fdsu_ex1_of_result_lfn;      
wire    [12:0]  fdsu_ex1_op0_id_expnt_neg;   
wire            fdsu_ex1_op0_norm;           
wire            fdsu_ex1_op1_norm;           
wire            fdsu_ex1_result_inf;         
wire            fdsu_ex1_result_lfn;         
wire            fdsu_ex1_result_qnan;        
wire            fdsu_ex1_result_sign;        
wire            fdsu_ex1_result_zero;        
wire            fdsu_ex1_save_op0;           
wire    [12:0]  fdsu_ex2_expnt_adder_op0;    
wire            fdsu_ex2_of;                 
wire            fdsu_ex2_of_rm_lfn;          
wire            fdsu_ex2_op0_norm;           
wire            fdsu_ex2_op1_norm;           
wire            fdsu_ex2_potnt_of;           
wire            fdsu_ex2_potnt_uf;           
wire            fdsu_ex2_result_inf;         
wire            fdsu_ex2_result_lfn;         
wire            fdsu_ex2_rslt_denorm;        
wire    [12:0]  fdsu_ex2_srt_expnt_rst;      
wire            fdsu_ex2_uf;                 
wire    [12:0]  fdsu_ex3_expnt_adjust_result; 
wire    [12:0]  fdsu_ex3_expnt_rst;          
wire            fdsu_ex3_potnt_uf;           
wire            fdsu_ex3_result_inf;         
wire            fdsu_ex3_result_lfn;         
wire            fdsu_ex3_result_qnan;        
wire            fdsu_ex3_result_sign;        
wire            fdsu_ex3_result_zero;        
wire            fdsu_ex3_rslt_denorm;        
wire            fdsu_ex3_rslt_denorm_in;     
wire            fdsu_ex4_dz;                 
wire    [12:0]  fdsu_ex4_expnt_rst;          
wire            fdsu_ex4_nv;                 
wire            fdsu_ex4_of;                 
wire            fdsu_ex4_of_rm_lfn;          
wire            fdsu_ex4_potnt_of;           
wire            fdsu_ex4_potnt_uf;           
wire            fdsu_ex4_result_inf;         
wire            fdsu_ex4_result_lfn;         
wire            fdsu_ex4_result_qnan;        
wire            fdsu_ex4_result_sign;        
wire            fdsu_ex4_result_zero;        
wire            fdsu_ex4_rslt_denorm;        
wire            fdsu_ex4_uf;                 
wire    [12:0]  fdsu_op0_ff1_cnt;            
wire    [12:0]  fdsu_op0_id_expnt;           
wire            fdsu_save_op0_neg_expnt;     


// In 906 FDSU, if one op0/1 is not norm, it will not enter EX2.
//assign fdsu_op0_norm = 1'b1;
//assign fdsu_op1_norm = 1'b1;
// //&Force("input", "ex1_op0_norm"); @30
// //&Force("input", "ex1_op1_norm"); @31

// double_expnt_rst is used to save:
//  1. op0 denormal expnt;
//  2. op0 expnt;
//  3. result expnt.
always @ (posedge expnt_rst_clk)
begin
  if (fdsu_ex1_save_op0)
    fdsu_expnt_rst[12:0] <= fdsu_op0_ff1_cnt[12:0];
  else if(fdsu_save_op0_neg_expnt)
    fdsu_expnt_rst[12:0] <= fdsu_ex1_op0_id_expnt_neg[12:0];
  else if (ex1_pipedown)
    fdsu_expnt_rst[12:0] <= fdsu_ex1_expnt_adder_op0[12:0];
  else if (ex2_pipedown)
    fdsu_expnt_rst[12:0] <= fdsu_ex2_srt_expnt_rst[12:0];
  else if (ex3_pipedown)
    fdsu_expnt_rst[12:0] <= fdsu_ex3_expnt_adjust_result[12:0];
  else
    fdsu_expnt_rst[12:0] <= fdsu_expnt_rst[12:0];
end

//assign fdsu_ex1_op0_id_expnt_neg[12:0] = ~fdsu_expnt_rst[12:0] + 13'b1;
assign fdsu_op0_id_expnt[12:0]         = fdsu_expnt_rst[12:0];
assign fdsu_ex1_id_expnt_f[12:0]       = fdsu_expnt_rst[12:0];
assign fdsu_ex3_expnt_rst[12:0]        = fdsu_expnt_rst[12:0];
assign fdsu_ex4_expnt_rst[12:0]        = fdsu_expnt_rst[12:0];
assign fdsu_ex2_expnt_adder_op0[12:0]  = fdsu_expnt_rst[12:0];


always @ (posedge expnt_rst_clk)
begin
  if (ex2_pipedown)
    fdsu_yy_rslt_denorm <= fdsu_ex2_rslt_denorm;
  else if (ex3_pipedown)
    fdsu_yy_rslt_denorm <= fdsu_ex3_rslt_denorm;
  else
    fdsu_yy_rslt_denorm <= fdsu_yy_rslt_denorm;
end
assign fdsu_ex3_rslt_denorm_in = fdsu_yy_rslt_denorm;
assign fdsu_ex4_rslt_denorm = fdsu_yy_rslt_denorm;

always @ (posedge expnt_rst_clk)
begin
  if (ex1_pipedown)
  begin
    fdsu_result_inf  <= fdsu_ex1_result_inf;
    fdsu_result_lfn  <= fdsu_ex1_result_lfn;
  end
  else if(ex2_pipedown)
  begin
    fdsu_result_inf <= ex2_result_inf;
    fdsu_result_lfn <= ex2_result_lfn;
  end
end
// EX2 signal used in EX3 & EX4
always @ (posedge ex2_pipe_clk)
begin
  if (ex2_pipedown)
  begin
    fdsu_of         <= fdsu_ex2_of;
    fdsu_uf         <= fdsu_ex2_uf;
    fdsu_potnt_of   <= fdsu_ex2_potnt_of;
    fdsu_potnt_uf   <= fdsu_ex2_potnt_uf;
  end
  else
  begin
    fdsu_of         <= fdsu_of;
    fdsu_uf         <= fdsu_uf;
    fdsu_potnt_of   <= fdsu_potnt_of;
    fdsu_potnt_uf   <= fdsu_potnt_uf;
  end
end
assign ex2_result_inf = fdsu_result_inf || fdsu_ex2_result_inf;
assign ex2_result_lfn = fdsu_result_lfn || fdsu_ex2_result_lfn;
assign fdsu_ex3_result_qnan = fdsu_result_qnan;
assign fdsu_ex3_result_zero = fdsu_result_zero;

always @(posedge ex1_pipe_clk)
begin
  if(ex1_pipedown)
  begin
    fdsu_result_qnan <= fdsu_ex1_result_qnan;
    fdsu_result_zero <= fdsu_ex1_result_zero;
    fdsu_result_sign    <= fdsu_ex1_result_sign;
    fdsu_op0_norm       <= fdsu_ex1_op0_norm;
    fdsu_op1_norm       <= fdsu_ex1_op1_norm;
    fdsu_of_rm_lfn      <= fdsu_ex1_of_result_lfn;
    fdsu_nv              <= fdsu_ex1_nv;
    fdsu_dz              <= fdsu_ex1_dz;
  end
end
assign fdsu_ex3_result_sign = fdsu_result_sign;
assign fdsu_ex4_result_sign = fdsu_result_sign;



assign fdsu_ex4_nv              = fdsu_nv;
assign fdsu_ex4_dz              = fdsu_dz;
assign fdsu_ex4_result_qnan = fdsu_result_qnan;
assign fdsu_ex4_result_zero = fdsu_result_zero;
assign fdsu_ex2_op0_norm   = fdsu_op0_norm;
assign fdsu_ex2_op1_norm   = fdsu_op1_norm;
assign fdsu_ex2_of_rm_lfn  = fdsu_of_rm_lfn;
assign fdsu_ex4_of_rm_lfn  = fdsu_of_rm_lfn;
assign fdsu_ex3_result_inf = fdsu_result_inf;
assign fdsu_ex3_result_lfn = fdsu_result_lfn;
assign fdsu_ex4_result_inf = fdsu_result_inf;
assign fdsu_ex4_result_lfn = fdsu_result_lfn;
assign fdsu_ex4_of         = fdsu_of;
assign fdsu_ex4_uf         = fdsu_uf;
assign fdsu_ex4_potnt_of   = fdsu_potnt_of;
assign fdsu_ex4_potnt_uf   = fdsu_potnt_uf;
assign fdsu_ex3_potnt_uf   = fdsu_potnt_uf;




// &ModuleEnd; @149
endmodule


