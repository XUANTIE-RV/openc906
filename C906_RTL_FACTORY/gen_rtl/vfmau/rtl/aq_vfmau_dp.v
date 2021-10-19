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
module aq_vfmau_dp(
  cp0_vpu_icg_en,
  cp0_vpu_xx_bf16,
  cp0_vpu_xx_dqnan,
  cp0_yy_clk_en,
  ctrl_dp_ex1_inst_pipe_down,
  ctrl_dp_ex1_inst_vld,
  ctrl_dp_ex2_inst_pipe_down,
  ctrl_dp_ex2_inst_vld,
  ctrl_dp_ex3_inst_pipe_down,
  ctrl_dp_ex3_inst_vld,
  ctrl_dp_ex4_inst_pipe_down,
  ctrl_dp_ex4_inst_vld,
  ex2_dst_double,
  ex2_mac,
  ex2_simd,
  ex2_special_sel,
  ex3_dst_double,
  ex3_mac,
  ex3_special_cmplt,
  ex4_dst_double,
  ex4_mac,
  forever_cpuclk,
  ifu_vpu_warm_up,
  pad_yy_icg_scan_en,
  vfmau_vpu_ex3_fflags,
  vfmau_vpu_ex3_fpr_result,
  vfmau_vpu_ex4_fflags,
  vfmau_vpu_ex4_fpr_result,
  vfmau_vpu_ex5_fflags,
  vfmau_vpu_ex5_fpr_result,
  vpu_group_0_xx_ex1_func,
  vpu_group_0_xx_ex1_id_reg,
  vpu_group_0_xx_ex1_rm,
  vpu_group_0_xx_ex1_srcv0,
  vpu_group_0_xx_ex1_srcv0_type,
  vpu_group_0_xx_ex1_srcv1,
  vpu_group_0_xx_ex1_srcv1_type,
  vpu_group_0_xx_ex1_srcv2,
  vpu_group_0_xx_ex1_srcv2_type
);

// &Ports; @25
input           cp0_vpu_icg_en;               
input           cp0_vpu_xx_bf16;              
input           cp0_vpu_xx_dqnan;             
input           cp0_yy_clk_en;                
input           ctrl_dp_ex1_inst_pipe_down;   
input           ctrl_dp_ex1_inst_vld;         
input           ctrl_dp_ex2_inst_pipe_down;   
input           ctrl_dp_ex2_inst_vld;         
input           ctrl_dp_ex3_inst_pipe_down;   
input           ctrl_dp_ex3_inst_vld;         
input           ctrl_dp_ex4_inst_pipe_down;   
input           ctrl_dp_ex4_inst_vld;         
input           forever_cpuclk;               
input           ifu_vpu_warm_up;              
input           pad_yy_icg_scan_en;           
input   [19:0]  vpu_group_0_xx_ex1_func;      
input   [1 :0]  vpu_group_0_xx_ex1_id_reg;    
input   [2 :0]  vpu_group_0_xx_ex1_rm;        
input   [63:0]  vpu_group_0_xx_ex1_srcv0;     
input   [47:0]  vpu_group_0_xx_ex1_srcv0_type; 
input   [63:0]  vpu_group_0_xx_ex1_srcv1;     
input   [47:0]  vpu_group_0_xx_ex1_srcv1_type; 
input   [63:0]  vpu_group_0_xx_ex1_srcv2;     
input   [47:0]  vpu_group_0_xx_ex1_srcv2_type; 
output          ex2_dst_double;               
output          ex2_mac;                      
output          ex2_simd;                     
output  [5 :0]  ex2_special_sel;              
output          ex3_dst_double;               
output          ex3_mac;                      
output          ex3_special_cmplt;            
output          ex4_dst_double;               
output          ex4_mac;                      
output  [4 :0]  vfmau_vpu_ex3_fflags;         
output  [63:0]  vfmau_vpu_ex3_fpr_result;     
output  [4 :0]  vfmau_vpu_ex4_fflags;         
output  [63:0]  vfmau_vpu_ex4_fpr_result;     
output  [4 :0]  vfmau_vpu_ex5_fflags;         
output  [63:0]  vfmau_vpu_ex5_fpr_result;     

// &Regs; @26
reg             ex2_bf16;                     
reg             ex2_double;                   
reg             ex2_f16;                      
reg             ex2_half;                     
reg             ex2_mac;                      
reg     [2 :0]  ex2_rm;                       
reg             ex2_single;                   
reg             ex3_bf16;                     
reg             ex3_double;                   
reg             ex3_f16;                      
reg             ex3_half;                     
reg             ex3_mac;                      
reg     [2 :0]  ex3_rm;                       
reg             ex3_single;                   
reg             ex4_bf16;                     
reg             ex4_double;                   
reg             ex4_f16;                      
reg             ex4_half;                     
reg             ex4_mac;                      
reg     [2 :0]  ex4_rm;                       
reg             ex4_single;                   

// &Wires; @27
wire            cp0_vpu_icg_en;               
wire            cp0_vpu_xx_bf16;              
wire            cp0_vpu_xx_dqnan;             
wire            cp0_yy_clk_en;                
wire            ctrl_dp_ex1_inst_pipe_down;   
wire            ctrl_dp_ex1_inst_vld;         
wire            ctrl_dp_ex2_inst_pipe_down;   
wire            ctrl_dp_ex2_inst_vld;         
wire            ctrl_dp_ex3_inst_pipe_down;   
wire            ctrl_dp_ex3_inst_vld;         
wire            ctrl_dp_ex4_inst_pipe_down;   
wire            ctrl_dp_ex4_inst_vld;         
wire            ex1_bf16;                     
wire            ex1_double;                   
wire            ex1_double_expnt_near_of;     
wire            ex1_double_expnt_near_uf;     
wire            ex1_dst_bf16;                 
wire            ex1_dst_double;               
wire            ex1_dst_f16;                  
wire            ex1_dst_half;                 
wire            ex1_dst_single;               
wire            ex1_f16;                      
wire    [19:0]  ex1_func;                     
wire            ex1_half;                     
wire    [1 :0]  ex1_id_reg;                   
wire            ex1_mac;                      
wire            ex1_mac_update;               
wire            ex1_neg;                      
wire    [2 :0]  ex1_rm;                       
wire            ex1_single;                   
wire    [63:0]  ex1_srcv0;                    
wire    [63:0]  ex1_srcv1;                    
wire    [63:0]  ex1_srcv2;                    
wire            ex1_sub;                      
wire            ex1_widen;                    
wire            ex2_dst_bf16;                 
wire            ex2_dst_double;               
wire            ex2_dst_f16;                  
wire            ex2_dst_half;                 
wire            ex2_dst_single;               
wire            ex2_simd;                     
wire    [5 :0]  ex2_special_sel;              
wire            ex2_widen;                    
wire            ex3_dst_bf16;                 
wire            ex3_dst_double;               
wire            ex3_dst_f16;                  
wire            ex3_dst_single;               
wire            ex3_simd;                     
wire            ex3_special_cmplt;            
wire            ex3_widen;                    
wire            ex4_dst_bf16;                 
wire            ex4_dst_double;               
wire            ex4_dst_f16;                  
wire            ex4_dst_half;                 
wire            ex4_dst_single;               
wire            ex4_widen;                    
wire            fmau_ex2_data_clk;            
wire            fmau_ex2_data_clk_en;         
wire            fmau_ex3_data_clk;            
wire            fmau_ex3_data_clk_en;         
wire            fmau_ex4_data_clk;            
wire            fmau_ex4_data_clk_en;         
wire            fmau_ex5_data_clk;            
wire            fmau_ex5_data_clk_en;         
wire            forever_cpuclk;               
wire            ifu_vpu_warm_up;              
wire            pad_yy_icg_scan_en;           
wire    [4 :0]  vfmau_vpu_ex3_fflags;         
wire    [63:0]  vfmau_vpu_ex3_fpr_result;     
wire    [4 :0]  vfmau_vpu_ex4_fflags;         
wire    [63:0]  vfmau_vpu_ex4_fpr_result;     
wire    [4 :0]  vfmau_vpu_ex5_fflags;         
wire    [63:0]  vfmau_vpu_ex5_fpr_result;     
wire    [19:0]  vpu_group_0_xx_ex1_func;      
wire    [1 :0]  vpu_group_0_xx_ex1_id_reg;    
wire    [2 :0]  vpu_group_0_xx_ex1_rm;        
wire    [63:0]  vpu_group_0_xx_ex1_srcv0;     
wire    [47:0]  vpu_group_0_xx_ex1_srcv0_type; 
wire    [63:0]  vpu_group_0_xx_ex1_srcv1;     
wire    [47:0]  vpu_group_0_xx_ex1_srcv1_type; 
wire    [63:0]  vpu_group_0_xx_ex1_srcv2;     
wire    [47:0]  vpu_group_0_xx_ex1_srcv2_type; 


// &Depend("cpu_cfig.h"); @29
// &Force("bus","vpu_group_0_xx_ex1_func_sel",FUNC_WIDTH-1,0); @30
// &Force("bus","vpu_group_0_xx_ex1_split_count",`SPLIT_WIDTH*2-1,0); @31
// &Force("input","vpu_group_0_xx_ex1_srcv0_type"); @32
// &Force("input","vpu_group_0_xx_ex1_srcv1_type"); @33
// &Force("input","vpu_group_0_xx_ex1_srcv2_type"); @34
// &Force("bus","vpu_group_0_xx_ex1_srcv0_type",47,0); @35
// &Force("bus","vpu_group_0_xx_ex1_srcv1_type",47,0); @36
// &Force("bus","vpu_group_0_xx_ex1_srcv2_type",47,0); @37
// &Force("bus","vpu_group_0_xx_ex1_srcv2",`VEC_WIDTH-1,0); @38

parameter DATA_WIDTH   = 64;

parameter DOUBLE_WIDTH = 64;
parameter DOUBLE_FRAC  = 52;
parameter DOUBLE_EXPN  = 11;

parameter SINGLE_WIDTH = 32;
parameter SINGLE_FRAC  = 23;
parameter SINGLE_EXPN  =  8;

parameter HALF_WIDTH   = 16;
parameter HALF_FRAC    = 10;
parameter HALF_EXPN    =  5;

parameter BF16_WIDTH  = 16;
parameter BF16_FRAC   =  7;
parameter BF16_EXPN   =  8;

parameter FUNC_WIDTH   = 20;

// &Instance("aq_vfmau_mult","x_aq_vfmau_mult"); @60
aq_vfmau_mult  x_aq_vfmau_mult (
  .cp0_vpu_xx_dqnan              (cp0_vpu_xx_dqnan             ),
  .ctrl_dp_ex1_inst_pipe_down    (ctrl_dp_ex1_inst_pipe_down   ),
  .ctrl_dp_ex2_inst_pipe_down    (ctrl_dp_ex2_inst_pipe_down   ),
  .ctrl_dp_ex3_inst_pipe_down    (ctrl_dp_ex3_inst_pipe_down   ),
  .ctrl_dp_ex4_inst_pipe_down    (ctrl_dp_ex4_inst_pipe_down   ),
  .ex1_bf16                      (ex1_bf16                     ),
  .ex1_double                    (ex1_double                   ),
  .ex1_double_expnt_near_of      (ex1_double_expnt_near_of     ),
  .ex1_double_expnt_near_uf      (ex1_double_expnt_near_uf     ),
  .ex1_dst_bf16                  (ex1_dst_bf16                 ),
  .ex1_dst_double                (ex1_dst_double               ),
  .ex1_dst_f16                   (ex1_dst_f16                  ),
  .ex1_dst_half                  (ex1_dst_half                 ),
  .ex1_dst_single                (ex1_dst_single               ),
  .ex1_f16                       (ex1_f16                      ),
  .ex1_half                      (ex1_half                     ),
  .ex1_id_reg                    (ex1_id_reg                   ),
  .ex1_mac                       (ex1_mac                      ),
  .ex1_neg                       (ex1_neg                      ),
  .ex1_rm                        (ex1_rm                       ),
  .ex1_single                    (ex1_single                   ),
  .ex1_srcv0                     (ex1_srcv0                    ),
  .ex1_srcv1                     (ex1_srcv1                    ),
  .ex1_srcv2                     (ex1_srcv2                    ),
  .ex1_sub                       (ex1_sub                      ),
  .ex1_widen                     (ex1_widen                    ),
  .ex2_bf16                      (ex2_bf16                     ),
  .ex2_double                    (ex2_double                   ),
  .ex2_dst_bf16                  (ex2_dst_bf16                 ),
  .ex2_dst_double                (ex2_dst_double               ),
  .ex2_dst_f16                   (ex2_dst_f16                  ),
  .ex2_dst_half                  (ex2_dst_half                 ),
  .ex2_dst_single                (ex2_dst_single               ),
  .ex2_mac                       (ex2_mac                      ),
  .ex2_single                    (ex2_single                   ),
  .ex2_special_sel               (ex2_special_sel              ),
  .ex3_bf16                      (ex3_bf16                     ),
  .ex3_dst_bf16                  (ex3_dst_bf16                 ),
  .ex3_dst_double                (ex3_dst_double               ),
  .ex3_dst_f16                   (ex3_dst_f16                  ),
  .ex3_dst_single                (ex3_dst_single               ),
  .ex3_f16                       (ex3_f16                      ),
  .ex3_rm                        (ex3_rm                       ),
  .ex3_simd                      (ex3_simd                     ),
  .ex3_single                    (ex3_single                   ),
  .ex3_special_cmplt             (ex3_special_cmplt            ),
  .ex4_bf16                      (ex4_bf16                     ),
  .ex4_dst_bf16                  (ex4_dst_bf16                 ),
  .ex4_dst_double                (ex4_dst_double               ),
  .ex4_dst_f16                   (ex4_dst_f16                  ),
  .ex4_dst_half                  (ex4_dst_half                 ),
  .ex4_dst_single                (ex4_dst_single               ),
  .ex4_f16                       (ex4_f16                      ),
  .ex4_rm                        (ex4_rm                       ),
  .ex4_single                    (ex4_single                   ),
  .fmau_ex2_data_clk             (fmau_ex2_data_clk            ),
  .fmau_ex3_data_clk             (fmau_ex3_data_clk            ),
  .fmau_ex4_data_clk             (fmau_ex4_data_clk            ),
  .fmau_ex5_data_clk             (fmau_ex5_data_clk            ),
  .ifu_vpu_warm_up               (ifu_vpu_warm_up              ),
  .vfmau_vpu_ex3_fflags          (vfmau_vpu_ex3_fflags         ),
  .vfmau_vpu_ex3_fpr_result      (vfmau_vpu_ex3_fpr_result     ),
  .vfmau_vpu_ex4_fflags          (vfmau_vpu_ex4_fflags         ),
  .vfmau_vpu_ex4_fpr_result      (vfmau_vpu_ex4_fpr_result     ),
  .vfmau_vpu_ex5_fflags          (vfmau_vpu_ex5_fflags         ),
  .vfmau_vpu_ex5_fpr_result      (vfmau_vpu_ex5_fpr_result     ),
  .vpu_group_0_xx_ex1_srcv0_type (vpu_group_0_xx_ex1_srcv0_type),
  .vpu_group_0_xx_ex1_srcv1_type (vpu_group_0_xx_ex1_srcv1_type),
  .vpu_group_0_xx_ex1_srcv2_type (vpu_group_0_xx_ex1_srcv2_type)
);


//==========================================================
//                     EX1 Interface
//==========================================================
assign ex1_func[FUNC_WIDTH-1:0] = vpu_group_0_xx_ex1_func[FUNC_WIDTH-1:0];

//function decode
assign ex1_double               = ex1_func[6];
assign ex1_single               = ex1_func[5];
assign ex1_half                 = ex1_func[4];
assign ex1_bf16                 = ex1_func[4] && cp0_vpu_xx_bf16;
assign ex1_f16                  = ex1_func[4] && !cp0_vpu_xx_bf16;
assign ex1_neg                  = ex1_func[2];
assign ex1_sub                  = ex1_func[1];
assign ex1_mac                  = ex1_func[0];
assign ex1_rm[2:0]              = vpu_group_0_xx_ex1_rm[2:0];
assign ex1_id_reg[1:0]          = vpu_group_0_xx_ex1_id_reg[1:0];
assign ex1_widen                = 1'b0;
assign ex1_dst_bf16   = ex1_bf16 && !ex1_widen;
assign ex1_dst_f16    = ex1_f16  && !ex1_widen;
assign ex1_dst_half   = ex1_half && !ex1_widen;
assign ex1_dst_single = (ex1_widen) ? ex1_half   : ex1_single;
assign ex1_dst_double = (ex1_widen) ? ex1_single : ex1_double;


//==========================================================
//                     EX1 Srcvx path
//==========================================================
assign ex1_srcv0[DATA_WIDTH-1:0] = vpu_group_0_xx_ex1_srcv0[DATA_WIDTH-1:0];
assign ex1_srcv1[DATA_WIDTH-1:0] = vpu_group_0_xx_ex1_srcv1[DATA_WIDTH-1:0];
assign ex1_srcv2[DATA_WIDTH-1:0] = (ex1_mac) ? vpu_group_0_xx_ex1_srcv2[DATA_WIDTH-1:0]
                                             : {DATA_WIDTH{1'b0}};

//==========================================================
//                     EX1 Fraction data path
//==========================================================
assign ex1_mac_update    = ex1_mac || |ex1_id_reg[1:0] || ex1_double_expnt_near_uf || ex1_double_expnt_near_of;
//==========================================================
//                    EX2 Stage
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign fmau_ex2_data_clk_en = ctrl_dp_ex1_inst_vld || ifu_vpu_warm_up;

//  &Instance("gated_clk_cell", "x_fmau_ex2_data_gated_clk"); @177
gated_clk_cell  x_fmau_ex2_data_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (fmau_ex2_data_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (fmau_ex2_data_clk_en),
  .module_en            (cp0_vpu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

//  &Connect(.clk_in      (forever_cpuclk      ), @178
//           .external_en (1'b0                ), @179
//           .global_en   (cp0_yy_clk_en       ), @180
//           .module_en   (cp0_vpu_icg_en      ), @181
//           .local_en    (fmau_ex2_data_clk_en), @182
//           .clk_out     (fmau_ex2_data_clk   )); @183

always @(posedge fmau_ex2_data_clk)
begin
 if(ctrl_dp_ex1_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex2_f16       <= ex1_f16;
    ex2_bf16      <= ex1_bf16;
    ex2_half      <= ex1_half;
    ex2_single    <= ex1_single;
    ex2_double    <= ex1_double;
    ex2_rm[2:0]   <= ex1_rm[2:0]; 
    ex2_mac       <= ex1_mac_update;
  end
end

assign ex2_widen      = 1'b0;
assign ex2_simd       = 1'b0;
assign ex2_dst_f16    = ex2_f16 && !ex2_widen;
assign ex2_dst_bf16   = ex2_bf16 && !ex2_widen;
assign ex2_dst_half   = ex2_half && !ex2_widen;
assign ex2_dst_single = (ex2_widen) ? ex2_half   : ex2_single;
assign ex2_dst_double = (ex2_widen) ? ex2_single : ex2_double;
// &Force("output","ex2_mac"); @214
// &Force("output","ex2_simd"); @215
// &Force("output","ex2_dst_double"); @216

// &Force("bus","vpu_group_0_xx_ex2_vm_byte_mask",`BYTE_NUM-1,0); @223
// &Force("bus","vpu_group_0_xx_ex2_vl_byte_mask",`BYTE_NUM-1,0); @224

//==========================================================
//                    EX3  Stage
//==========================================================
assign fmau_ex3_data_clk_en = ctrl_dp_ex2_inst_vld || ifu_vpu_warm_up;

// &Instance("gated_clk_cell", "x_fmau_ex3_data_gated_clk"); @258
gated_clk_cell  x_fmau_ex3_data_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (fmau_ex3_data_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (fmau_ex3_data_clk_en),
  .module_en            (cp0_vpu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

// &Connect(.clk_in      (forever_cpuclk      ), @259
//          .external_en (1'b0                ), @260
//          .global_en   (cp0_yy_clk_en       ), @261
//          .module_en   (cp0_vpu_icg_en      ), @262
//          .local_en    (fmau_ex3_data_clk_en), @263
//          .clk_out     (fmau_ex3_data_clk   )); @264
always @(posedge fmau_ex3_data_clk)
begin
 if(ctrl_dp_ex2_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex3_f16                   <= ex2_f16;
    ex3_bf16                  <= ex2_bf16;
    ex3_half                  <= ex2_half;
    ex3_single                <= ex2_single;
    ex3_double                <= ex2_double;
    ex3_mac                   <= ex2_mac;
    ex3_rm[2:0]               <= ex2_rm[2:0];
  end
end

assign ex3_widen      = 1'b0;
assign ex3_simd       = 1'b0;
assign ex3_dst_bf16   = ex3_bf16 && !ex3_widen;
assign ex3_dst_f16    = ex3_f16  && !ex3_widen;
assign ex3_dst_single = (ex3_widen) ? ex3_half   : ex3_single;
assign ex3_dst_double = (ex3_widen) ? ex3_single : ex3_double;
// &Force("output","ex3_mac"); @297
// &Force("output","ex3_dst_double"); @298

//==========================================================
//                    EX4  Stage
//==========================================================
assign fmau_ex4_data_clk_en = ctrl_dp_ex3_inst_vld || ifu_vpu_warm_up;

//  &Instance("gated_clk_cell", "x_fmau_ex4_data_gated_clk"); @305
gated_clk_cell  x_fmau_ex4_data_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (fmau_ex4_data_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (fmau_ex4_data_clk_en),
  .module_en            (cp0_vpu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

//  &Connect(.clk_in      (forever_cpuclk      ), @306
//           .external_en (1'b0                ), @307
//           .global_en   (cp0_yy_clk_en       ), @308
//           .module_en   (cp0_vpu_icg_en      ), @309
//           .local_en    (fmau_ex4_data_clk_en), @310
//           .clk_out     (fmau_ex4_data_clk   )); @311

always @(posedge fmau_ex4_data_clk)
begin
 if(ctrl_dp_ex3_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex4_f16                   <= ex3_f16;
    ex4_bf16                  <= ex3_bf16;
    ex4_half                  <= ex3_half;
    ex4_single                <= ex3_single;
    ex4_double                <= ex3_double;
    ex4_mac                   <= ex3_mac;
    ex4_rm[2:0]               <= ex3_rm[2:0];
  end
end

assign ex4_widen      = 1'b0;
assign ex4_dst_bf16   = ex4_bf16 && !ex4_widen;
assign ex4_dst_f16    = ex4_f16  && !ex4_widen;
assign ex4_dst_half   = ex4_half && !ex4_widen;
assign ex4_dst_single = (ex4_widen) ? ex4_half   : ex4_single;
assign ex4_dst_double = (ex4_widen) ? ex4_single : ex4_double;

// &Force("output","ex4_dst_double"); @345

assign fmau_ex5_data_clk_en = ctrl_dp_ex4_inst_vld || ifu_vpu_warm_up;

//  &Instance("gated_clk_cell", "x_fmau_ex5_data_gated_clk"); @349
gated_clk_cell  x_fmau_ex5_data_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (fmau_ex5_data_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (fmau_ex5_data_clk_en),
  .module_en            (cp0_vpu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

//  &Connect(.clk_in      (forever_cpuclk      ), @350
//           .external_en (1'b0                ), @351
//           .global_en   (cp0_yy_clk_en       ), @352
//           .module_en   (cp0_vpu_icg_en      ), @353
//           .local_en    (fmau_ex5_data_clk_en), @354
//           .clk_out     (fmau_ex5_data_clk   )); @355

//==========================================================
//                      ASSERTION
//==========================================================
// &Force("nonport","flag"); @369
// &Force("nonport","clk"); @370
// &Force("nonport","rst"); @371



// &ModuleEnd; @383
endmodule



