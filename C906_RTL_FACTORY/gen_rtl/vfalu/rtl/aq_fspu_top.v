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
module aq_fspu_top(
  cp0_vpu_icg_en,
  cp0_vpu_xx_bf16,
  cp0_yy_clk_en,
  forever_cpuclk,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  vfspu_vpu_ex2_result,
  vpu_group_1_xx_ex1_eu_sel,
  vpu_group_1_xx_ex1_func,
  vpu_group_1_xx_ex1_sel,
  vpu_group_1_xx_ex1_srcv0,
  vpu_group_1_xx_ex1_srcv0_type,
  vpu_group_1_xx_ex1_srcv1,
  vpu_group_1_xx_ex1_srcv1_type,
  vpu_group_1_xx_ex2_stall
);

// &Ports; @25
input           cp0_vpu_icg_en;               
input           cp0_vpu_xx_bf16;              
input           cp0_yy_clk_en;                
input           forever_cpuclk;               
input           ifu_vpu_warm_up;              
input           pad_yy_icg_scan_en;           
input   [9 :0]  vpu_group_1_xx_ex1_eu_sel;    
input   [19:0]  vpu_group_1_xx_ex1_func;      
input           vpu_group_1_xx_ex1_sel;       
input   [63:0]  vpu_group_1_xx_ex1_srcv0;     
input   [47:0]  vpu_group_1_xx_ex1_srcv0_type; 
input   [63:0]  vpu_group_1_xx_ex1_srcv1;     
input   [47:0]  vpu_group_1_xx_ex1_srcv1_type; 
input           vpu_group_1_xx_ex2_stall;     
output  [63:0]  vfspu_vpu_ex2_result;         

// &Regs; @26
reg     [63:0]  fspu_ex2_result;              

// &Wires; @27
wire            cp0_vpu_icg_en;               
wire            cp0_vpu_xx_bf16;              
wire            cp0_yy_clk_en;                
wire            ex1_bhalf;                    
wire    [63:0]  ex1_bhalf0_fsgnj_r;           
wire    [63:0]  ex1_bhalf0_fsgnjn_r;          
wire    [63:0]  ex1_bhalf0_fsgnjx_r;          
wire            ex1_bhalf0_src0_sign;         
wire            ex1_bhalf0_src1_sign;         
wire            ex1_dest_f;                   
wire            ex1_double;                   
wire    [63:0]  ex1_double_class_r;           
wire    [63:0]  ex1_double_fsgnj_r;           
wire    [63:0]  ex1_double_fsgnjn_r;          
wire    [63:0]  ex1_double_fsgnjx_r;          
wire            ex1_double_src0_sign;         
wire            ex1_double_src1_sign;         
wire            ex1_f16;                      
wire    [63:0]  ex1_f_rst;                    
wire    [63:0]  ex1_fmvdx_r;                  
wire    [63:0]  ex1_fmvhx_r;                  
wire    [63:0]  ex1_fmvwx_r;                  
wire    [63:0]  ex1_fmvxd_r;                  
wire    [63:0]  ex1_fmvxh_r;                  
wire    [63:0]  ex1_fmvxw_r;                  
wire            ex1_half;                     
wire    [63:0]  ex1_half0_class_r;            
wire    [63:0]  ex1_half0_fsgnj_r;            
wire    [63:0]  ex1_half0_fsgnjn_r;           
wire    [63:0]  ex1_half0_fsgnjx_r;           
wire            ex1_half0_src0_sign;          
wire            ex1_half0_src1_sign;          
wire    [63:0]  ex1_i_rst;                    
wire    [63:0]  ex1_int_src;                  
wire    [15:0]  ex1_op0_bhalf0;               
wire    [15:0]  ex1_op0_half0;                
wire    [31:0]  ex1_op0_single0;              
wire    [15:0]  ex1_op1_bhalf0;               
wire    [15:0]  ex1_op1_half0;                
wire    [31:0]  ex1_op1_single0;              
wire            ex1_op_class;                 
wire            ex1_op_fmvdx;                 
wire            ex1_op_fmvfx;                 
wire            ex1_op_fmvhx;                 
wire            ex1_op_fmvwx;                 
wire            ex1_op_fmvxd;                 
wire            ex1_op_fmvxf;                 
wire            ex1_op_fmvxh;                 
wire            ex1_op_fmvxw;                 
wire            ex1_op_fsgnj;                 
wire            ex1_op_fsgnjn;                
wire            ex1_op_fsgnjx;                
wire            ex1_pipe_clk;                 
wire            ex1_pipe_clk_en;              
wire            ex1_pipedown;                 
wire    [63:0]  ex1_result;                   
wire            ex1_scalar;                   
wire    [63:0]  ex1_scalar_class_r;           
wire    [63:0]  ex1_scalar_fsgnj_r;           
wire    [63:0]  ex1_scalar_fsgnjn_r;          
wire    [63:0]  ex1_scalar_fsgnjx_r;          
wire            ex1_single;                   
wire    [63:0]  ex1_single0_class_r;          
wire    [63:0]  ex1_single0_fsgnj_r;          
wire    [63:0]  ex1_single0_fsgnjn_r;         
wire    [63:0]  ex1_single0_fsgnjx_r;         
wire            ex1_single0_src0_sign;        
wire            ex1_single0_src1_sign;        
wire    [63:0]  ex1_src0;                     
wire    [63:0]  ex1_src1;                     
wire            forever_cpuclk;               
wire            fspu_ex1_sel;                 
wire    [19:0]  func;                         
wire            ifu_vpu_warm_up;              
wire            pad_yy_icg_scan_en;           
wire            src0_double_id;               
wire            src0_double_inf;              
wire            src0_double_norm;             
wire            src0_double_qnan;             
wire            src0_double_snan;             
wire            src0_double_zero;             
wire            src0_half0_cnan;              
wire            src0_half0_id;                
wire            src0_half0_inf;               
wire            src0_half0_norm;              
wire            src0_half0_qnan;              
wire            src0_half0_snan;              
wire            src0_half0_zero;              
wire            src0_single0_cnan;            
wire            src0_single0_id;              
wire            src0_single0_inf;             
wire            src0_single0_norm;            
wire            src0_single0_qnan;            
wire            src0_single0_snan;            
wire            src0_single0_zero;            
wire            src1_half0_cnan;              
wire            src1_single0_cnan;            
wire    [47:0]  srcv0_type;                   
wire    [47:0]  srcv1_type;                   
wire    [63:0]  vfspu_vpu_ex2_result;         
wire    [9 :0]  vpu_group_1_xx_ex1_eu_sel;    
wire    [19:0]  vpu_group_1_xx_ex1_func;      
wire            vpu_group_1_xx_ex1_sel;       
wire    [63:0]  vpu_group_1_xx_ex1_srcv0;     
wire    [47:0]  vpu_group_1_xx_ex1_srcv0_type; 
wire    [63:0]  vpu_group_1_xx_ex1_srcv1;     
wire    [47:0]  vpu_group_1_xx_ex1_srcv1_type; 
wire            vpu_group_1_xx_ex2_stall;     



// &Force("bus", "vpu_group_1_xx_ex1_func", 19, 0); @30


//------------------------------------------------------------------------------
//                           Interface with idu and fpu:
//------------------------------------------------------------------------------
// //&Force("bus","vpu_group_1_xx_ex1_srcv2",`VEC_WIDTH-1,0); @36

assign ex1_src0[63:0]    = {64{fspu_ex1_sel}} & (vpu_group_1_xx_ex1_srcv0[63:0]);
assign ex1_src1[63:0]    = {64{fspu_ex1_sel}} & vpu_group_1_xx_ex1_srcv1[63:0];
assign ex1_int_src[63:0] = {64{fspu_ex1_sel&&ex1_scalar}} & vpu_group_1_xx_ex1_srcv1[63:0];
//VFSPU
//  8       7      6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|             | sgn |                  |   x  |   n   |  none |
//+------+------+-----+--+--------+------+------+-------+-------+
//  8       7      6    5     4      3      2      1       0
//+------+------+-----+-----+----+------+------+-------+-------+
//|             |     | mv   fs  |   sf |  xf  |  vf   |    fx |
//+------+------+-----+-----+----+------+------+-------+-------+
//assign fspu_sel          = ctrl_falu_ex1_sel && vpu_group_1_xx_ex1_func[2];
assign fspu_ex1_sel      = ex1_pipedown;
//======================
// decode information
//======================
assign func[19:0]            = vpu_group_1_xx_ex1_func[19:0];
// &Force("bus","vpu_group_1_xx_ex1_split_count",2*`SPLIT_WIDTH-1,0); @59
assign ex1_scalar      = 1'b1;
assign ex1_double      = func[13:12] == 2'b11;
assign ex1_single      = func[13:12] == 2'b10;
assign ex1_f16         = func[13:12] == 2'b01;
assign ex1_half        = ex1_f16 && !cp0_vpu_xx_bf16;
assign ex1_bhalf       = ex1_f16 && cp0_vpu_xx_bf16;
assign ex1_op_fsgnjx   = func[6] && func[2];
assign ex1_op_fsgnjn   = func[6] && func[1];
assign ex1_op_fsgnj    = func[6] && func[0];
assign ex1_op_fmvfx    = func[5] && func[0];
assign ex1_op_fmvxf    = func[5] && func[2]; 
assign ex1_op_fmvdx    = ex1_op_fmvfx && ex1_double;
assign ex1_op_fmvwx    = ex1_op_fmvfx && ex1_single;
assign ex1_op_fmvhx    = ex1_op_fmvfx && ex1_f16;

assign ex1_op_fmvxd    = ex1_op_fmvxf && ex1_double;
assign ex1_op_fmvxw    = ex1_op_fmvxf && ex1_single;
assign ex1_op_fmvxh    = ex1_op_fmvxf && ex1_f16;


assign ex1_op_class    = func[7];

//VFSPU
//  8       7      6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|             | sgn |                  |   x  |   n   |  none |
//+------+------+-----+--+--------+------+------+-------+-------+
//  8       7      6    5     4      3      2      1       0
//+------+------+-----+-----+----+------+------+-------+-------+
//|             |     | mv   fs  |   sf |  xf  |  vf   |    fx |
//+------+------+-----+-----+----+------+------+-------+-------+

assign ex1_dest_f        = vpu_group_1_xx_ex1_func[5] && (vpu_group_1_xx_ex1_func[0] || vpu_group_1_xx_ex1_func[4]) ||
                           vpu_group_1_xx_ex1_func[6] && ex1_scalar;
assign srcv0_type[47:0]    = vpu_group_1_xx_ex1_srcv0_type[47:0];
assign srcv1_type[47:0]    = vpu_group_1_xx_ex1_srcv1_type[47:0];
assign src0_double_snan    = srcv0_type[47];
assign src0_double_qnan    = srcv0_type[46];
assign src0_double_inf     = srcv0_type[45];
assign src0_double_zero    = srcv0_type[44];
assign src0_double_id      = srcv0_type[43];
assign src0_double_norm    = srcv0_type[42];
assign src0_single0_cnan    = srcv0_type[41];
assign src0_single0_snan    = srcv0_type[40];
assign src0_single0_qnan    = srcv0_type[39];
assign src0_single0_inf    = srcv0_type[38];
assign src0_single0_zero    = srcv0_type[37];
assign src0_single0_id    = srcv0_type[36];
assign src0_single0_norm    = srcv0_type[35];
assign src0_half0_cnan    = srcv0_type[27];
assign src0_half0_snan    = srcv0_type[26];
assign src0_half0_qnan    = srcv0_type[25];
assign src0_half0_inf    = srcv0_type[24];
assign src0_half0_zero    = srcv0_type[23];
assign src0_half0_id    = srcv0_type[22];
assign src0_half0_norm    = srcv0_type[21];
assign src1_half0_cnan   = srcv1_type[27];
assign src1_single0_cnan = srcv1_type[41];



assign ex1_double_src0_sign      = ex1_src0[63];
assign ex1_single0_src0_sign     = ex1_op0_single0[31];
assign ex1_half0_src0_sign       = ex1_op0_half0[15];

assign ex1_bhalf0_src0_sign       = ex1_op0_bhalf0[15];

assign ex1_double_src1_sign      = ex1_src1[63];
assign ex1_single0_src1_sign     = ex1_op1_single0[31];
assign ex1_half0_src1_sign       = ex1_op1_half0[15];

assign ex1_bhalf0_src1_sign      = ex1_op1_bhalf0[15];
// single src normal judge
//assign src0_freg             = ex1_scalar || ex1_op_vf;
assign ex1_op0_single0[31:0] = src0_single0_cnan ? 32'h7fc00000 : ex1_src0[31:0];
assign ex1_op1_single0[31:0] = src1_single0_cnan ? 32'h7fc00000 : ex1_src1[31:0];
assign ex1_op0_half0[15:0]   = src0_half0_cnan ? 16'h7e00 : ex1_src0[15:0];
assign ex1_op1_half0[15:0]   = src1_half0_cnan ? 16'h7e00 : ex1_src1[15:0];
assign ex1_op0_bhalf0[15:0]  = src0_half0_cnan ? 16'h7fc0 : ex1_src0[15:0];
assign ex1_op1_bhalf0[15:0]  = src1_half0_cnan ? 16'h7fc0 : ex1_src1[15:0];
//------------------------------------------------------------------------------
//                           FCLASS Instruction:
//------------------------------------------------------------------------------
//class: r[9:0] = {qnan, snan, +inf, +nm, +dn, +0, -0, -dn, -nm, -inf}
assign ex1_double_class_r[63:0] = {54'b0,
                                    src0_double_qnan,
                                    src0_double_snan,
                                   !ex1_double_src0_sign && src0_double_inf,
                                   !ex1_double_src0_sign && src0_double_norm && !src0_double_id,
                                   !ex1_double_src0_sign && src0_double_id,
                                   !ex1_double_src0_sign && src0_double_zero,
                                    ex1_double_src0_sign && src0_double_zero,
                                    ex1_double_src0_sign && src0_double_id,
                                    ex1_double_src0_sign && src0_double_norm && !src0_double_id,
                                    ex1_double_src0_sign && src0_double_inf};

assign ex1_single0_class_r[63:0] = {54'b0,
                                    src0_single0_qnan,
                                    src0_single0_snan,
                                   !ex1_single0_src0_sign && src0_single0_inf,
                                   !ex1_single0_src0_sign && src0_single0_norm && !src0_single0_id,
                                   !ex1_single0_src0_sign && src0_single0_id && !src0_single0_cnan,
                                   !ex1_single0_src0_sign && src0_single0_zero,
                                    ex1_single0_src0_sign && src0_single0_zero,
                                    ex1_single0_src0_sign && src0_single0_id && !src0_single0_cnan,
                                    ex1_single0_src0_sign && src0_single0_norm && !src0_single0_id,
                                    ex1_single0_src0_sign && src0_single0_inf};
assign ex1_half0_class_r[63:0] = {54'b0,
                                    src0_half0_qnan,
                                    src0_half0_snan,
                                   !ex1_half0_src0_sign && src0_half0_inf,
                                   !ex1_half0_src0_sign && src0_half0_norm && !src0_half0_id,
                                   !ex1_half0_src0_sign && src0_half0_id && !src0_half0_cnan,
                                   !ex1_half0_src0_sign && src0_half0_zero,
                                    ex1_half0_src0_sign && src0_half0_zero,
                                    ex1_half0_src0_sign && src0_half0_id && !src0_half0_cnan,
                                    ex1_half0_src0_sign && src0_half0_norm && !src0_half0_id,
                                    ex1_half0_src0_sign && src0_half0_inf};

assign ex1_scalar_class_r[63:0] = {64{ex1_double}} & ex1_double_class_r[63:0]  | 
                                         {64{ex1_single}} & ex1_single0_class_r[63:0] |
                                         {64{ex1_f16}}   & ex1_half0_class_r[63:0];

//------------------------------------------------------------------------------
//                           FSGNJ Instruction:
//------------------------------------------------------------------------------
//fsgnjx : r_s = s0_s ^ s1_s
//fsgnjn : r_s = ~s1_s
//fsgnj  : r_s = s1_s

assign ex1_double_fsgnjx_r[63:0]  = {ex1_double_src0_sign ^ ex1_double_src1_sign, ex1_src0[62:0]};
assign ex1_single0_fsgnjx_r[63:0] = {32'hffffffff, ex1_single0_src0_sign ^ ex1_single0_src1_sign, ex1_op0_single0[30:0]};
assign ex1_half0_fsgnjx_r[63:0]   = {{48{1'b1}},ex1_half0_src0_sign ^ ex1_half0_src1_sign, ex1_op0_half0[14:0]};
assign ex1_bhalf0_fsgnjx_r[63:0]  = {{48{1'b1}},ex1_bhalf0_src0_sign ^ ex1_bhalf0_src1_sign, ex1_op0_bhalf0[14:0]};

assign ex1_double_fsgnjn_r[63:0]  = {~ex1_double_src1_sign, ex1_src0[62:0]};
assign ex1_single0_fsgnjn_r[63:0] = {32'hffffffff, ~ex1_single0_src1_sign, ex1_op0_single0[30:0]};
assign ex1_half0_fsgnjn_r[63:0]   = {{48{1'b1}},~ex1_half0_src1_sign, ex1_op0_half0[14:0]};
assign ex1_bhalf0_fsgnjn_r[63:0]  = {{48{1'b1}},~ex1_bhalf0_src1_sign, ex1_op0_bhalf0[14:0]};

assign ex1_double_fsgnj_r[63:0]  = {ex1_double_src1_sign, ex1_src0[62:0]};
assign ex1_single0_fsgnj_r[63:0] = {32'hffffffff, ex1_single0_src1_sign, ex1_op0_single0[30:0]};
assign ex1_half0_fsgnj_r[63:0]   = {{48{1'b1}},ex1_half0_src1_sign, ex1_op0_half0[14:0]};
assign ex1_bhalf0_fsgnj_r[63:0]  = {{48{1'b1}},ex1_bhalf0_src1_sign, ex1_op0_bhalf0[14:0]};
assign ex1_scalar_fsgnjx_r[63:0]         = {64{ex1_double}} & ex1_double_fsgnjx_r[63:0]    |
                                           {64{ex1_single}} & ex1_single0_fsgnjx_r[63:0]  |
                                           {64{ex1_half}}   & ex1_half0_fsgnjx_r[63:0]    |
                                           {64{ex1_bhalf}}  & ex1_bhalf0_fsgnjx_r[63:0];
assign ex1_scalar_fsgnjn_r[63:0]         = {64{ex1_double}} & ex1_double_fsgnjn_r[63:0]    |
                                           {64{ex1_single}} & ex1_single0_fsgnjn_r[63:0]  |
                                           {64{ex1_half}}   & ex1_half0_fsgnjn_r[63:0]    |
                                           {64{ex1_bhalf}}  & ex1_bhalf0_fsgnjn_r[63:0];
assign ex1_scalar_fsgnj_r[63:0]         = {64{ex1_double}} & ex1_double_fsgnj_r[63:0]    |
                                          {64{ex1_single}} & ex1_single0_fsgnj_r[63:0]  |
                                          {64{ex1_half}}   & ex1_half0_fsgnj_r[63:0]    |
                                          {64{ex1_bhalf}}  & ex1_bhalf0_fsgnj_r[63:0];



//------------------------------------------------------------------------------
//                           FMV Instruction:
//------------------------------------------------------------------------------
//fmv.x.w  : mov low 32bits float to int regsiter
//fmv.w.x  : mov from int register to low 32bit float regsiter
//fmv.x.hw : mov high 32bits float to int regsiter
//fmv.hw.x : mov from int register to high 32bit float regsiter

assign ex1_fmvwx_r[63:0]   = {{32{1'b1}}, ex1_int_src[31:0]};
assign ex1_fmvdx_r[63:0]   = {ex1_int_src[63:0]};
assign ex1_fmvhx_r[63:0]   = {{48{1'b1}}, ex1_int_src[15:0]};

assign ex1_fmvxw_r[63:0]   = {{32{ex1_src0[31]}},ex1_src0[31:0]};
assign ex1_fmvxd_r[63:0]   = ex1_src0[63:0];
assign ex1_fmvxh_r[63:0]   = {{48{ex1_src0[15]}},ex1_src0[15:0]};


//------------------------------------------------------------------------------
//                           Merge float and int result:
//------------------------------------------------------------------------------
assign ex1_f_rst[63:0] = {64{ex1_op_fsgnjx}}  & ex1_scalar_fsgnjx_r[63:0] |
                         {64{ex1_op_fsgnjn}}  & ex1_scalar_fsgnjn_r[63:0] |
                         {64{ex1_op_fsgnj}}   & ex1_scalar_fsgnj_r[63:0]  |
                         {64{ex1_op_fmvwx}}   & ex1_fmvwx_r[63:0]         |
                         {64{ex1_op_fmvdx}}   & ex1_fmvdx_r[63:0]         |
                         {64{ex1_op_fmvhx}}   & ex1_fmvhx_r[63:0];


assign ex1_i_rst[63:0] = {64{ex1_op_fmvxw}}   & ex1_fmvxw_r[63:0]  |
                         {64{ex1_op_fmvxd}}   & ex1_fmvxd_r[63:0]   |
                         {64{ex1_op_fmvxh}}   & ex1_fmvxh_r[63:0]   |
                         {64{ex1_op_class}}   & ex1_scalar_class_r[63:0];

assign ex1_result[63:0]= ex1_dest_f ?  ex1_f_rst[63:0] 
                                   : ex1_i_rst[63:0];


//------------------------------------------------------------------------------
//                            Float result rename for output:
//------------------------------------------------------------------------------
// &Force("bus","vpu_group_1_xx_ex1_eu_sel",9,0); @533
//=======================Pipe to EX2========================
//gate clk
// &Instance("gated_clk_cell","x_ex1_pipe_clk"); @536
gated_clk_cell  x_ex1_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_pipe_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_pipe_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @537
//           .clk_out        (ex1_pipe_clk),//Out Clock @538
//           .external_en    (1'b0), @539
//           .global_en      (cp0_yy_clk_en), @540
//           .local_en       (ex1_pipe_clk_en),//Local Condition @541
//           .module_en      (cp0_vpu_icg_en) @542
//         ); @543
assign ex1_pipe_clk_en = ex1_pipedown;
assign ex1_pipedown    = vpu_group_1_xx_ex1_sel && (vpu_group_1_xx_ex1_eu_sel[7:6] == 2'b10) && vpu_group_1_xx_ex1_eu_sel[1]&& !vpu_group_1_xx_ex2_stall|| ifu_vpu_warm_up;
always @(posedge ex1_pipe_clk )
begin
  if(ex1_pipedown )
  begin
    fspu_ex2_result[63:0]  <= ex1_result[63:0];
  end
end

assign vfspu_vpu_ex2_result[63:0]  = fspu_ex2_result[63:0];
//&Instance("gated_clk_cell","x_ex2_pipe_clk");
// //&Connect( .clk_in         (forever_cpuclk), @556
// //          .clk_out        (ex2_pipe_clk),//Out Clock @557
// //          .external_en    (1'b0), @558
// //          .global_en      (cp0_yy_clk_en), @559
// //          .local_en       (ex2_pipe_clk_en),//Local Condition @560
// //          .module_en      (cp0_vpu_icg_en) @561
// //        ); @562
//assign  ex2_pipedown    = vpu_group_1_xx_ex2_sel && (vpu_group_1_xx_ex2_eu_sel[7:6] == 2'b10) && vpu_group_1_xx_ex2_eu_sel[1]
//                          && !vpu_group_1_xx_ex3_stall|| ifu_vpu_warm_up;
//assign  ex2_pipe_clk_en = ex2_pipedown;
// //&Force("bus","vpu_group_1_xx_ex1_eu_sel",9,0); @566
// //&Force("bus","vpu_group_1_xx_ex2_eu_sel",9,0); @567
//assign ex2_result[63:0] = fspu_ex2_result[63:0];
//always @(posedge ex2_pipe_clk )
//begin
//  if(ex2_pipedown)
//  begin
//    fspu_ex3_result[63:0]  <= ex2_result[63:0];
//  end
//end
//
//assign vfspu_vpu_ex3_fflags[4  :0] = {5{1'b0}};              
//assign vfspu_vpu_ex3_fpr_result[63 :0] = fspu_ex3_result[63:0];          
//assign vfspu_vpu_ex3_gpr_result[63 :0] = fspu_ex3_result[63:0];          
//assign vfspu_vpu_ex3_vpr_result[63 :0] = fspu_ex3_result[63:0]; 



// &ModuleEnd; @584
endmodule


