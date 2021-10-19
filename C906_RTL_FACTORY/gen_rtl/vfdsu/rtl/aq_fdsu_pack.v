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
module aq_fdsu_pack(
  bhalf0_denorm_shift_num,
  bhalf0_denorm_shift_num_in,
  bhalf0_denorm_shift_val,
  bhalf0_denorm_to_tiny_frac,
  bhalf0_ex4_qnan_f,
  double_denorm_shift_num,
  double_denorm_shift_num_in,
  double_denorm_shift_val,
  double_denorm_to_tiny_frac,
  double_ex4_qnan_f,
  double_pipe_ex4_denorm_to_tiny_frac,
  double_pipe_ex4_dz,
  double_pipe_ex4_expnt_rst,
  double_pipe_ex4_expt,
  double_pipe_ex4_nv,
  double_pipe_ex4_nx,
  double_pipe_ex4_of,
  double_pipe_ex4_of_rm_lfn,
  double_pipe_ex4_potnt_norm,
  double_pipe_ex4_potnt_of,
  double_pipe_ex4_potnt_uf,
  double_pipe_ex4_result,
  double_pipe_ex4_result_inf,
  double_pipe_ex4_result_lfn,
  double_pipe_ex4_result_nor,
  double_pipe_ex4_result_qnan,
  double_pipe_ex4_result_sign,
  double_pipe_ex4_result_zero,
  double_pipe_ex4_rslt_denorm,
  double_pipe_ex4_uf,
  double_pipe_fdsu_ex4_frac,
  fdsu_ex4_bhalf,
  fdsu_ex4_double,
  fdsu_ex4_half,
  fdsu_ex4_single,
  half0_denorm_shift_num,
  half0_denorm_shift_num_in,
  half0_denorm_shift_val,
  half0_denorm_to_tiny_frac,
  half0_ex4_qnan_f,
  single0_denorm_shift_num,
  single0_denorm_shift_num_in,
  single0_denorm_shift_val,
  single0_denorm_to_tiny_frac,
  single0_ex4_qnan_f
);

// &Ports; @24
input   [6 :0]  bhalf0_denorm_shift_num;            
input   [7 :0]  bhalf0_ex4_qnan_f;                  
input   [51:0]  double_denorm_shift_num;            
input   [52:0]  double_ex4_qnan_f;                  
input           double_pipe_ex4_denorm_to_tiny_frac; 
input           double_pipe_ex4_dz;                 
input   [12:0]  double_pipe_ex4_expnt_rst;          
input           double_pipe_ex4_nv;                 
input           double_pipe_ex4_nx;                 
input           double_pipe_ex4_of;                 
input           double_pipe_ex4_of_rm_lfn;          
input   [1 :0]  double_pipe_ex4_potnt_norm;         
input           double_pipe_ex4_potnt_of;           
input           double_pipe_ex4_potnt_uf;           
input           double_pipe_ex4_result_inf;         
input           double_pipe_ex4_result_lfn;         
input           double_pipe_ex4_result_nor;         
input           double_pipe_ex4_result_qnan;        
input           double_pipe_ex4_result_sign;        
input           double_pipe_ex4_result_zero;        
input           double_pipe_ex4_rslt_denorm;        
input           double_pipe_ex4_uf;                 
input   [54:0]  double_pipe_fdsu_ex4_frac;          
input           fdsu_ex4_bhalf;                     
input           fdsu_ex4_double;                    
input           fdsu_ex4_half;                      
input           fdsu_ex4_single;                    
input   [9 :0]  half0_denorm_shift_num;             
input   [10:0]  half0_ex4_qnan_f;                   
input   [22:0]  single0_denorm_shift_num;           
input   [23:0]  single0_ex4_qnan_f;                 
output  [6 :0]  bhalf0_denorm_shift_num_in;         
output  [8 :0]  bhalf0_denorm_shift_val;            
output          bhalf0_denorm_to_tiny_frac;         
output  [51:0]  double_denorm_shift_num_in;         
output  [11:0]  double_denorm_shift_val;            
output          double_denorm_to_tiny_frac;         
output  [4 :0]  double_pipe_ex4_expt;               
output  [63:0]  double_pipe_ex4_result;             
output  [9 :0]  half0_denorm_shift_num_in;          
output  [5 :0]  half0_denorm_shift_val;             
output          half0_denorm_to_tiny_frac;          
output  [22:0]  single0_denorm_shift_num_in;        
output  [8 :0]  single0_denorm_shift_val;           
output          single0_denorm_to_tiny_frac;        

// &Regs; @25
reg     [6 :0]  bhalf_denorm_frac;                  
reg     [51:0]  double_denorm_frac;                 
reg     [51:0]  ex4_frac_52;                        
reg     [63:0]  ex4_result;                         
reg     [12:0]  expnt_add_op1;                      
reg     [9 :0]  half_denorm_frac;                   
reg     [22:0]  single_denorm_frac;                 

// &Wires; @26
wire    [6 :0]  bhalf0_denorm_shift_num;            
wire    [6 :0]  bhalf0_denorm_shift_num_in;         
wire    [8 :0]  bhalf0_denorm_shift_val;            
wire            bhalf0_denorm_to_tiny_frac;         
wire    [7 :0]  bhalf0_ex4_qnan_f;                  
wire    [51:0]  double_denorm_shift_num;            
wire    [51:0]  double_denorm_shift_num_in;         
wire    [11:0]  double_denorm_shift_val;            
wire            double_denorm_to_tiny_frac;         
wire    [52:0]  double_ex4_qnan_f;                  
wire            double_pipe_ex4_denorm_to_tiny_frac; 
wire            double_pipe_ex4_dz;                 
wire    [12:0]  double_pipe_ex4_expnt_rst;          
wire    [4 :0]  double_pipe_ex4_expt;               
wire            double_pipe_ex4_nv;                 
wire            double_pipe_ex4_nx;                 
wire            double_pipe_ex4_of;                 
wire            double_pipe_ex4_of_rm_lfn;          
wire    [1 :0]  double_pipe_ex4_potnt_norm;         
wire            double_pipe_ex4_potnt_of;           
wire            double_pipe_ex4_potnt_uf;           
wire    [63:0]  double_pipe_ex4_result;             
wire            double_pipe_ex4_result_inf;         
wire            double_pipe_ex4_result_lfn;         
wire            double_pipe_ex4_result_nor;         
wire            double_pipe_ex4_result_qnan;        
wire            double_pipe_ex4_result_sign;        
wire            double_pipe_ex4_result_zero;        
wire            double_pipe_ex4_rslt_denorm;        
wire            double_pipe_ex4_uf;                 
wire    [54:0]  double_pipe_fdsu_ex4_frac;          
wire    [63:0]  ex4_bhalf_lfn;                      
wire    [63:0]  ex4_bhalf_rst_inf;                  
wire    [63:0]  ex4_bhalf_rst_norm;                 
wire            ex4_cor_nx;                         
wire            ex4_cor_uf;                         
wire            ex4_denorm_potnt_norm;              
wire    [63:0]  ex4_denorm_result;                  
wire    [63:0]  ex4_doub_lfn;                       
wire    [63:0]  ex4_doub_rst_inf;                   
wire    [63:0]  ex4_doub_rst_norm;                  
wire    [12:0]  ex4_expnt_rst;                      
wire    [4 :0]  ex4_expt;                           
wire            ex4_final_rst_norm;                 
wire    [54:0]  ex4_frac;                           
wire    [63:0]  ex4_half_lfn;                       
wire    [63:0]  ex4_half_rst_inf;                   
wire    [63:0]  ex4_half_rst_norm;                  
wire            ex4_of_plus;                        
wire            ex4_result_inf;                     
wire            ex4_result_lfn;                     
wire            ex4_result_zero;                    
wire            ex4_rslt_denorm;                    
wire            ex4_rslt_qnan;                      
wire    [63:0]  ex4_rst_inf;                        
wire    [63:0]  ex4_rst_lfn;                        
wire            ex4_rst_nor;                        
wire    [63:0]  ex4_rst_norm;                       
wire    [63:0]  ex4_rst_qnan;                       
wire    [63:0]  ex4_rst_zero;                       
wire    [63:0]  ex4_sing_lfn;                       
wire    [63:0]  ex4_sing_rst_inf;                   
wire    [63:0]  ex4_sing_rst_norm;                  
wire            ex4_uf_plus;                        
wire            fdsu_ex4_bhalf;                     
wire            fdsu_ex4_double;                    
wire            fdsu_ex4_dz;                        
wire    [12:0]  fdsu_ex4_expnt_rst;                 
wire            fdsu_ex4_half;                      
wire            fdsu_ex4_nv;                        
wire            fdsu_ex4_nx;                        
wire            fdsu_ex4_of;                        
wire            fdsu_ex4_of_rst_lfn;                
wire    [1 :0]  fdsu_ex4_potnt_norm;                
wire            fdsu_ex4_potnt_of;                  
wire            fdsu_ex4_potnt_uf;                  
wire            fdsu_ex4_result_inf;                
wire            fdsu_ex4_result_lfn;                
wire            fdsu_ex4_result_nor;                
wire            fdsu_ex4_result_sign;               
wire            fdsu_ex4_rslt_denorm;               
wire            fdsu_ex4_single;                    
wire            fdsu_ex4_uf;                        
wire    [9 :0]  half0_denorm_shift_num;             
wire    [9 :0]  half0_denorm_shift_num_in;          
wire    [5 :0]  half0_denorm_shift_val;             
wire            half0_denorm_to_tiny_frac;          
wire    [10:0]  half0_ex4_qnan_f;                   
wire    [22:0]  single0_denorm_shift_num;           
wire    [22:0]  single0_denorm_shift_num_in;        
wire    [8 :0]  single0_denorm_shift_val;           
wire            single0_denorm_to_tiny_frac;        
wire    [23:0]  single0_ex4_qnan_f;                 


assign fdsu_ex4_result_sign     = double_pipe_ex4_result_sign;
assign fdsu_ex4_of_rst_lfn      = double_pipe_ex4_of_rm_lfn;
//assign fdsu_ex4_double          = fdsu_yy_double;
//assign fdsu_ex4_single          
assign fdsu_ex4_result_inf      = double_pipe_ex4_result_inf;
assign fdsu_ex4_result_lfn      = double_pipe_ex4_result_lfn;
assign fdsu_ex4_of              = double_pipe_ex4_of;
assign fdsu_ex4_uf              = double_pipe_ex4_uf;
assign fdsu_ex4_nx              = double_pipe_ex4_nx;
assign fdsu_ex4_potnt_norm[1:0]      = double_pipe_ex4_potnt_norm[1:0];
assign fdsu_ex4_result_nor     = double_pipe_ex4_result_nor;
assign fdsu_ex4_potnt_of        = double_pipe_ex4_potnt_of;
assign fdsu_ex4_potnt_uf        = double_pipe_ex4_potnt_uf;
assign fdsu_ex4_nv              = double_pipe_ex4_nv;
assign fdsu_ex4_dz              = double_pipe_ex4_dz;
assign fdsu_ex4_expnt_rst[12:0] = double_pipe_ex4_expnt_rst[12:0];
assign fdsu_ex4_rslt_denorm     = double_pipe_ex4_rslt_denorm;
assign ex4_rslt_qnan            = double_pipe_ex4_result_qnan;
assign ex4_result_zero          = double_pipe_ex4_result_zero;

//============================EX4 STAGE=====================
assign ex4_frac[54:0] = double_pipe_fdsu_ex4_frac[54:0];
//exponent adder
// &CombBeg; @51
always @( ex4_frac[54:53])
begin
casez(ex4_frac[54:53])
  2'b00   : expnt_add_op1[12:0] = 13'h0fff;  //the expnt sub 1
  2'b01   : expnt_add_op1[12:0] = 13'h0;    //the expnt stay the origi
  2'b1?   : expnt_add_op1[12:0] = 13'h1;    // the exptn add 1
  default : expnt_add_op1[12:0] = 13'b0;  
endcase
// &CombEnd; @58
end
assign ex4_expnt_rst[12:0] = fdsu_ex4_expnt_rst[12:0] + 
                             expnt_add_op1[12:0];

//==========================Result Pack=====================
// result denormal pack 
// shift to the denormal number
assign double_denorm_shift_num_in[51:0]   = ex4_frac[54:3];
assign single0_denorm_shift_num_in[22:0]  = ex4_frac[54:32];
assign half0_denorm_shift_num_in[9:0]     = ex4_frac[54:45];
assign bhalf0_denorm_shift_num_in[6:0]    = ex4_frac[54:48];
assign double_denorm_shift_val[11:0]       = fdsu_ex4_expnt_rst[11:0];
assign single0_denorm_shift_val[8:0]      = fdsu_ex4_expnt_rst[8:0];
assign half0_denorm_shift_val[5:0]        = fdsu_ex4_expnt_rst[5:0];
assign bhalf0_denorm_shift_val[8:0]       = fdsu_ex4_expnt_rst[8:0];
assign double_denorm_to_tiny_frac  = double_pipe_ex4_denorm_to_tiny_frac;
assign single0_denorm_to_tiny_frac = double_pipe_ex4_denorm_to_tiny_frac;
assign half0_denorm_to_tiny_frac   = double_pipe_ex4_denorm_to_tiny_frac;
assign bhalf0_denorm_to_tiny_frac  = double_pipe_ex4_denorm_to_tiny_frac;


// &CombBeg; @79
always @( ex4_frac[53:1]
       or single0_denorm_shift_num[22:0]
       or half0_denorm_shift_num[9:0]
       or double_denorm_shift_num[51:0]
       or bhalf0_denorm_shift_num[6:0]
       or fdsu_ex4_expnt_rst[12:0])
begin
case(fdsu_ex4_expnt_rst[12:0])
  13'h1: begin double_denorm_frac[51:0] = ex4_frac[52:1];
               single_denorm_frac[22:0] = ex4_frac[52:30];
               half_denorm_frac[9:0]    = ex4_frac[52:43];
               bhalf_denorm_frac[6:0]   = ex4_frac[52:46];
         end
  13'h0: begin double_denorm_frac[51:0] = ex4_frac[53:2];
               single_denorm_frac[22:0] = ex4_frac[53:31];
               half_denorm_frac[9:0]    = ex4_frac[53:44];
               bhalf_denorm_frac[6:0]   = ex4_frac[53:47];
         end
  default:begin double_denorm_frac[51:0] = double_denorm_shift_num[51:0];
                single_denorm_frac[22:0] = single0_denorm_shift_num[22:0];
                half_denorm_frac[9:0]    = half0_denorm_shift_num[9:0];
                bhalf_denorm_frac[6:0]   = bhalf0_denorm_shift_num[6:0];
          end
endcase
// &CombEnd; @97
end
//&CombBeg;
//case(fdsu_ex4_expnt_rst[12:0])
//  13'h1:   ex4_denorm_frac[51:0] = {      ex4_frac[52:1]}; //-1022 1
//  13'h0:   ex4_denorm_frac[51:0] = {      ex4_frac[53:2]}; //-1023 0
//  13'h1fff:ex4_denorm_frac[51:0] = {      ex4_frac[54:3]}; //-1024 -1
//  13'h1ffe:ex4_denorm_frac[51:0] = {1'b0, ex4_frac[54:4]}; //-1025 -2
//  13'h1ffd:ex4_denorm_frac[51:0] = {2'b0, ex4_frac[54:5]}; //-1026 -3
//  13'h1ffc:ex4_denorm_frac[51:0] = {3'b0, ex4_frac[54:6]}; //-1027 -4
//  13'h1ffb:ex4_denorm_frac[51:0] = {4'b0, ex4_frac[54:7]}; //-1028 -5
//  13'h1ffa:ex4_denorm_frac[51:0] = {5'b0, ex4_frac[54:8]}; //-1029 -6
//  13'h1ff9:ex4_denorm_frac[51:0] = {6'b0, ex4_frac[54:9]}; //-1030 -7
//  13'h1ff8:ex4_denorm_frac[51:0] = {7'b0, ex4_frac[54:10]}; //-1031 -8
//  13'h1ff7:ex4_denorm_frac[51:0] = {8'b0, ex4_frac[54:11]}; //-1032 -9
//  13'h1ff6:ex4_denorm_frac[51:0] = {9'b0, ex4_frac[54:12]}; //-1033 -10
//  13'h1ff5:ex4_denorm_frac[51:0] = {10'b0,ex4_frac[54:13]}; //-1034 -11
//  13'h1ff4:ex4_denorm_frac[51:0] = {11'b0,ex4_frac[54:14]}; //-1035 -12
//  13'h1ff3:ex4_denorm_frac[51:0] = {12'b0,ex4_frac[54:15]}; //-1036 -13  
//  13'h1ff2:ex4_denorm_frac[51:0] = {13'b0,ex4_frac[54:16]}; // -1037
//  13'h1ff1:ex4_denorm_frac[51:0] = {14'b0,ex4_frac[54:17]}; //-1038
//  13'h1ff0:ex4_denorm_frac[51:0] = {15'b0,ex4_frac[54:18]}; //-1039
//  13'h1fef:ex4_denorm_frac[51:0] = {16'b0,ex4_frac[54:19]}; //-1040
//  13'h1fee:ex4_denorm_frac[51:0] = {17'b0,ex4_frac[54:20]}; //-1041
//  13'h1fed:ex4_denorm_frac[51:0] = {18'b0,ex4_frac[54:21]}; //-1042
//  13'h1fec:ex4_denorm_frac[51:0] = {19'b0,ex4_frac[54:22]}; //-1043
//  13'h1feb:ex4_denorm_frac[51:0] = {20'b0,ex4_frac[54:23]}; //-1044
//  13'h1fea:ex4_denorm_frac[51:0] = {21'b0,ex4_frac[54:24]}; //-1045
//  13'h1fe9:ex4_denorm_frac[51:0] = {22'b0,ex4_frac[54:25]}; //-1046
//  13'h1fe8:ex4_denorm_frac[51:0] = {23'b0,ex4_frac[54:26]}; //-1047
//  13'h1fe7:ex4_denorm_frac[51:0] = {24'b0,ex4_frac[54:27]}; //-1048
//  13'h1fe6:ex4_denorm_frac[51:0] = {25'b0,ex4_frac[54:28]}; //-1049
//  13'h1fe5:ex4_denorm_frac[51:0] = {26'b0,ex4_frac[54:29]}; //-1050
//  13'h1fe4:ex4_denorm_frac[51:0] = {27'b0,ex4_frac[54:30]}; //-1056
//  13'h1fe3:ex4_denorm_frac[51:0] = {28'b0,ex4_frac[54:31]}; //-1052
//  13'h1fe2:ex4_denorm_frac[51:0] = {29'b0,ex4_frac[54:32]}; //-1053
//  13'h1fe1:ex4_denorm_frac[51:0] = {30'b0,ex4_frac[54:33]}; //-1054
//  13'h1fe0:ex4_denorm_frac[51:0] = {31'b0,ex4_frac[54:34]}; //-1055
//  13'h1fdf:ex4_denorm_frac[51:0] = {32'b0,ex4_frac[54:35]}; //-1056
//  13'h1fde:ex4_denorm_frac[51:0] = {33'b0,ex4_frac[54:36]}; //-1057
//  13'h1fdd:ex4_denorm_frac[51:0] = {34'b0,ex4_frac[54:37]}; //-1058
//  13'h1fdc:ex4_denorm_frac[51:0] = {35'b0,ex4_frac[54:38]}; //-1059
//  13'h1fdb:ex4_denorm_frac[51:0] = {36'b0,ex4_frac[54:39]}; //-1060
//  13'h1fda:ex4_denorm_frac[51:0] = {37'b0,ex4_frac[54:40]}; //-1061
//  13'h1fd9:ex4_denorm_frac[51:0] = {38'b0,ex4_frac[54:41]}; //-1062
//  13'h1fd8:ex4_denorm_frac[51:0] = {39'b0,ex4_frac[54:42]}; //-1063
//  13'h1fd7:ex4_denorm_frac[51:0] = {40'b0,ex4_frac[54:43]}; //-1064
//  13'h1fd6:ex4_denorm_frac[51:0] = {41'b0,ex4_frac[54:44]}; //-1065
//  13'h1fd5:ex4_denorm_frac[51:0] = {42'b0,ex4_frac[54:45]};  //-1066
//  13'h1fd4:ex4_denorm_frac[51:0] = {43'b0,ex4_frac[54:46]};  //-1067
//  13'h1fd3:ex4_denorm_frac[51:0] = {44'b0,ex4_frac[54:47]};  //-1068
//  13'h1fd2:ex4_denorm_frac[51:0] = {45'b0,ex4_frac[54:48]};  //-1069
//  13'h1fd1:ex4_denorm_frac[51:0] = {46'b0,ex4_frac[54:49]};  //-1070
//  13'h1fd0:ex4_denorm_frac[51:0] = {47'b0,ex4_frac[54:50]};  //-1071
//  13'h1fcf:ex4_denorm_frac[51:0] = {48'b0,ex4_frac[54:51]};  //-1072
//  13'h1fce:ex4_denorm_frac[51:0] = {49'b0,ex4_frac[54:52]};  //-1073
//  13'h1fcd:ex4_denorm_frac[51:0] = {50'b0,ex4_frac[54:53]};  //-1074
//  default: ex4_denorm_frac[51:0] = fdsu_ex4_denorm_to_tiny_frac ? 52'b1 : 52'b0;
//endcase                                                                  
//&CombEnd;   
//&CombBeg;
//case(fdsu_ex4_expnt_rst[12:0])
//  13'h1:   ex4_single_denorm_frac[51:0] = {      ex4_frac[52:1]}; //-1022 1
//  13'h0:   ex4_single_denorm_frac[51:0] = {      ex4_frac[53:2]}; //-1023 0
//  13'h1fff:ex4_single_denorm_frac[51:0] = {      ex4_frac[54:3]}; //-1024 -1
//  13'h1ffe:ex4_single_denorm_frac[51:0] = {1'b0, ex4_frac[54:4]}; //-1025 -2
//  13'h1ffd:ex4_single_denorm_frac[51:0] = {2'b0, ex4_frac[54:5]}; //-1026 -3
//  13'h1ffc:ex4_single_denorm_frac[51:0] = {3'b0, ex4_frac[54:6]}; //-1027 -4
//  13'h1ffb:ex4_single_denorm_frac[51:0] = {4'b0, ex4_frac[54:7]}; //-1028 -5
//  13'h1ffa:ex4_single_denorm_frac[51:0] = {5'b0, ex4_frac[54:8]}; //-1029 -6
//  13'h1ff9:ex4_single_denorm_frac[51:0] = {6'b0, ex4_frac[54:9]}; //-1030 -7
//  13'h1ff8:ex4_single_denorm_frac[51:0] = {7'b0, ex4_frac[54:10]}; //-1031 -8
//  13'h1ff7:ex4_single_denorm_frac[51:0] = {8'b0, ex4_frac[54:11]}; //-1032 -9
//  13'h1ff6:ex4_single_denorm_frac[51:0] = {9'b0, ex4_frac[54:12]}; //-1033 -10
//  13'h1ff5:ex4_single_denorm_frac[51:0] = {10'b0,ex4_frac[54:13]}; //-1034 -11
//  13'h1ff4:ex4_single_denorm_frac[51:0] = {11'b0,ex4_frac[54:14]}; //-1035 -12
//  13'h1ff3:ex4_single_denorm_frac[51:0] = {12'b0,ex4_frac[54:15]}; //-1036 -13  
//  13'h1ff2:ex4_single_denorm_frac[51:0] = {13'b0,ex4_frac[54:16]}; // -1037
//  13'h1ff1:ex4_single_denorm_frac[51:0] = {14'b0,ex4_frac[54:17]}; //-1038
//  13'h1ff0:ex4_single_denorm_frac[51:0] = {15'b0,ex4_frac[54:18]}; //-1039
//  13'h1fef:ex4_single_denorm_frac[51:0] = {16'b0,ex4_frac[54:19]}; //-1040
//  13'h1fee:ex4_single_denorm_frac[51:0] = {17'b0,ex4_frac[54:20]}; //-1041
//  13'h1fed:ex4_single_denorm_frac[51:0] = {18'b0,ex4_frac[54:21]}; //-1042
//  13'h1fec:ex4_single_denorm_frac[51:0] = {19'b0,ex4_frac[54:22]}; //-1043
//  13'h1feb:ex4_single_denorm_frac[51:0] = {20'b0,ex4_frac[54:23]}; //-1044
//  13'h1fea:ex4_single_denorm_frac[51:0] = {21'b0,ex4_frac[54:24]}; //-1044
//  default :ex4_single_denorm_frac[51:0] = fdsu_ex4_denorm_to_tiny_frac ?{23'b1,29'b0} : 52'b0; //-1045
//endcase                                                                  
//&CombEnd;
//here when denormal number round to add1, it will become normal number
assign ex4_denorm_potnt_norm    = (fdsu_ex4_potnt_norm[1] && ex4_frac[53]) || 
                                  (fdsu_ex4_potnt_norm[0] && ex4_frac[54]) ;
assign ex4_rslt_denorm          = fdsu_ex4_rslt_denorm && !ex4_denorm_potnt_norm  && !ex4_rslt_qnan && !ex4_result_zero;
assign ex4_denorm_result[63:0]  = {64{fdsu_ex4_double}}  &
                                  {fdsu_ex4_result_sign,11'h0,double_denorm_frac[51:0]}  |
                                  {64{fdsu_ex4_single}} & {32'hffffffff,fdsu_ex4_result_sign,
                                                          8'h0,single_denorm_frac[22:0]} |
                                  {64{fdsu_ex4_half}} & {{48{1'b1}},fdsu_ex4_result_sign,
                                                          5'h0,half_denorm_frac[9:0]}  |
                                  {64{fdsu_ex4_bhalf}}& {{48{1'b1}},fdsu_ex4_result_sign,
                                                          8'h0,bhalf_denorm_frac[6:0]};
                                   
                                                              
//ex4 overflow/underflow plus                                 
assign ex4_rst_nor = fdsu_ex4_result_nor;                    
assign ex4_of_plus = fdsu_ex4_potnt_of  && 
                     (|ex4_frac[54:53])  && 
                     ex4_rst_nor;
assign ex4_uf_plus = fdsu_ex4_potnt_uf  && 
                     (~|ex4_frac[54:53]) && 
                     ex4_rst_nor;
//ex4 overflow round result
assign ex4_result_lfn = (ex4_of_plus &&  fdsu_ex4_of_rst_lfn) ||
                        fdsu_ex4_result_lfn;
assign ex4_result_inf = (ex4_of_plus && !fdsu_ex4_of_rst_lfn) ||
                        fdsu_ex4_result_inf;
//Special Result Form
// result largest finity number
assign ex4_doub_lfn[63:0]      = {fdsu_ex4_result_sign,11'h7fe,{52{1'b1}}};
assign ex4_sing_lfn[63:0]      = {32'hffffffff,fdsu_ex4_result_sign,8'hfe,{23{1'b1}}};
assign ex4_half_lfn[63:0]      = {{48{1'b1}},fdsu_ex4_result_sign,5'h1e,{10{1'b1}}};
assign ex4_bhalf_lfn[63:0]      ={{48{1'b1}},fdsu_ex4_result_sign,8'hfe,{7{1'b1}}};
assign ex4_rst_lfn[63:0]       = {64{fdsu_ex4_double}} & ex4_doub_lfn[63:0] |
                                 {64{fdsu_ex4_single}} & ex4_sing_lfn[63:0] |
                                 {64{fdsu_ex4_half}} & ex4_half_lfn[63:0] |
                                 {64{fdsu_ex4_bhalf}} & ex4_bhalf_lfn[63:0];
//result infinity
assign ex4_doub_rst_inf[63:0]  = {fdsu_ex4_result_sign,11'h7ff,52'b0};
assign ex4_sing_rst_inf[63:0]  = {32'hffffffff,fdsu_ex4_result_sign,8'hff,23'b0};
assign ex4_half_rst_inf[63:0]  = {{48{1'b1}},fdsu_ex4_result_sign,5'h1f,10'b0};
assign ex4_bhalf_rst_inf[63:0] = {{48{1'b1}},fdsu_ex4_result_sign,8'hff,7'b0};
assign ex4_rst_inf[63:0]       = {64{fdsu_ex4_double}} & ex4_doub_rst_inf[63:0] | 
                                 {64{fdsu_ex4_single}} & ex4_sing_rst_inf[63:0] |
                                 {64{fdsu_ex4_half}}   & ex4_half_rst_inf[63:0] |
                                 {64{fdsu_ex4_bhalf}}  & ex4_bhalf_rst_inf[63:0];
//result normal
// &CombBeg; @232
always @( ex4_frac[54:0])
begin
casez(ex4_frac[54:53])
  2'b00   : ex4_frac_52[51:0]  = ex4_frac[51:0];
  2'b01   : ex4_frac_52[51:0]  = ex4_frac[52:1];
  2'b1?   : ex4_frac_52[51:0]  = ex4_frac[53:2];
  default : ex4_frac_52[51:0]  = 52'b0;
endcase
// &CombEnd; @239
end
assign ex4_doub_rst_norm[63:0] = {fdsu_ex4_result_sign,
                                  ex4_expnt_rst[10:0],
                                  ex4_frac_52[51:0]};
assign ex4_sing_rst_norm[63:0] = {32'hffffffff,fdsu_ex4_result_sign,
                                  ex4_expnt_rst[7:0],
                                  ex4_frac_52[51:29]};
assign ex4_half_rst_norm[63:0] = {{48{1'b1}},fdsu_ex4_result_sign,
                                  ex4_expnt_rst[4:0],
                                  ex4_frac_52[51:42]};
assign ex4_bhalf_rst_norm[63:0] = {{48{1'b1}},fdsu_ex4_result_sign,
                                  ex4_expnt_rst[7:0],
                                  ex4_frac_52[51:45]};                                

assign ex4_rst_norm[63:0]      = {64{fdsu_ex4_double}} & ex4_doub_rst_norm[63:0] | 
                                 {64{fdsu_ex4_single}} & ex4_sing_rst_norm[63:0] | 
                                 {64{fdsu_ex4_half}}   & ex4_half_rst_norm[63:0] |
                                 {64{fdsu_ex4_bhalf}}  & ex4_bhalf_rst_norm[63:0];
assign ex4_cor_uf            = (fdsu_ex4_uf && !ex4_denorm_potnt_norm || ex4_uf_plus)
                               && fdsu_ex4_nx;
assign ex4_cor_nx            =  fdsu_ex4_nx 
                                || fdsu_ex4_of 
                                || ex4_of_plus;
                                        
assign ex4_expt[4:0]           = {
                                  fdsu_ex4_nv,
                                  fdsu_ex4_dz,
                                  fdsu_ex4_of | ex4_of_plus,
                                  ex4_cor_uf,
                                  ex4_cor_nx};

assign ex4_final_rst_norm      = !ex4_result_inf        &&
                                 !ex4_result_lfn        && 
                                 !ex4_rslt_denorm       && !ex4_rslt_qnan && !ex4_result_zero; 
// the qnan result
assign ex4_rst_qnan[63:0] = {64{fdsu_ex4_double}} & {double_ex4_qnan_f[52],{11{1'b1}},double_ex4_qnan_f[51:0]}   |
                            {64{fdsu_ex4_single}} & {{32{1'b1}},single0_ex4_qnan_f[23],{8{1'b1}},single0_ex4_qnan_f[22:0]} |
                            {64{fdsu_ex4_half}}   & {{48{1'b1}},half0_ex4_qnan_f[10],{5{1'b1}},half0_ex4_qnan_f[9:0]}       |
                            {64{fdsu_ex4_bhalf}}  & {{48{1'b1}},bhalf0_ex4_qnan_f[7],{8{1'b1}},bhalf0_ex4_qnan_f[6:0]};
assign ex4_rst_zero[63:0] = {64{fdsu_ex4_double}} & {fdsu_ex4_result_sign,{11{1'b0}},52'b0}           |
                            {64{fdsu_ex4_single}} & {{32{1'b1}},fdsu_ex4_result_sign,{8{1'b0}},23'b0} |
                            {64{fdsu_ex4_half}}   & {{48{1'b1}},fdsu_ex4_result_sign,{5{1'b0}},10'b0} |
                            {64{fdsu_ex4_bhalf}}  & {{48{1'b1}},fdsu_ex4_result_sign,{8{1'b0}},7'b0};                          
// &CombBeg; @282
always @( ex4_rst_norm[63:0]
       or ex4_rst_qnan[63:0]
       or ex4_result_lfn
       or ex4_result_zero
       or ex4_rst_lfn[63:0]
       or ex4_denorm_result[63:0]
       or ex4_result_inf
       or ex4_rslt_qnan
       or ex4_rst_inf[63:0]
       or ex4_rst_zero[63:0]
       or ex4_rslt_denorm
       or ex4_final_rst_norm)
begin
case({ex4_result_zero,
      ex4_rslt_qnan,
      ex4_rslt_denorm,
      ex4_result_inf,
      ex4_result_lfn,
      ex4_final_rst_norm})
  6'b100000 : ex4_result[63:0]  = ex4_rst_zero[63:0];
  6'b010000 : ex4_result[63:0]  = ex4_rst_qnan[63:0];
  6'b001000 : ex4_result[63:0]  = ex4_denorm_result[63:0];
  6'b000100 : ex4_result[63:0]  = ex4_rst_inf[63:0];
  6'b000010 : ex4_result[63:0]  = ex4_rst_lfn[63:0];
  6'b000001 : ex4_result[63:0]  = ex4_rst_norm[63:0];
  default   : ex4_result[63:0]  = 64'b0;
endcase
// &CombEnd; @297
end

////==========================================================
////                     Result Generate
////==========================================================
//assign fdsu_frbus_freg[4:0]   = fdsu_yy_wb_freg[4:0];
//assign fdsu_frbus_data[63:0]  = ex4_result[63:0];
//assign fdsu_frbus_single      = !fdsu_ex4_double;
//assign fdsu_frbus_fflags[4:0] = ex4_expt[4:0];
assign double_pipe_ex4_result[63:0]  = ex4_result[63:0];
assign double_pipe_ex4_expt[4:0] = ex4_expt[4:0];
// &ModuleEnd; @308
endmodule



