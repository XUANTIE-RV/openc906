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

// &Depend("cpu_cfig.h"); @27
// &Depend("aq_idu_cfig.h"); @28
// &ModuleBeg; @29
module aq_idu_id_decd(
  cp0_idu_cskyee,
  cp0_idu_frm,
  cp0_idu_fs,
  cp0_idu_ucme,
  cp0_idu_vill,
  cp0_idu_vl_zero,
  cp0_idu_vs,
  cp0_idu_vstart,
  cp0_yy_priv_mode,
  decd_dp_inst_data,
  dp_decd_inst,
  dp_decd_vlmul,
  dp_decd_vsew,
  rtu_yy_xx_dbgon
);

// &Ports; @30
input            cp0_idu_cskyee;                 
input   [2  :0]  cp0_idu_frm;                    
input   [1  :0]  cp0_idu_fs;                     
input            cp0_idu_ucme;                   
input            cp0_idu_vill;                   
input            cp0_idu_vl_zero;                
input   [1  :0]  cp0_idu_vs;                     
input   [6  :0]  cp0_idu_vstart;                 
input   [1  :0]  cp0_yy_priv_mode;               
input   [31 :0]  dp_decd_inst;                   
input   [1  :0]  dp_decd_vlmul;                  
input   [1  :0]  dp_decd_vsew;                   
input            rtu_yy_xx_dbgon;                
output  [264:0]  decd_dp_inst_data;              

// &Regs; @31
reg              decd_16_dst0_vld;               
reg              decd_16_dstf_vld;               
reg     [9  :0]  decd_16_eu;                     
reg     [19 :0]  decd_16_func;                   
reg              decd_16_illegal;                
reg              decd_16_src0_vld;               
reg              decd_16_src1_imm_vld;           
reg              decd_16_src1_vld;               
reg              decd_16_src2_imm_vld;           
reg              decd_16_src2_vld;               
reg              decd_16_srcf1_vld;              
reg              decd_16_srcf2_vld;              
reg              decd_32_dst0_vld;               
reg              decd_32_dste_vld;               
reg              decd_32_dstf_vld;               
reg              decd_32_dstv_vld;               
reg     [9  :0]  decd_32_eu;                     
reg     [19 :0]  decd_32_func;                   
reg              decd_32_illegal;                
reg              decd_32_src0_vld;               
reg              decd_32_src1_imm_vld;           
reg              decd_32_src1_vld;               
reg              decd_32_src2_imm_vld;           
reg              decd_32_src2_vld;               
reg              decd_32_srcf0_vld;              
reg              decd_32_srcf1_vld;              
reg              decd_32_srcf2_vld;              
reg              decd_32_srcv0_vld;              
reg              decd_32_srcv1_vld;              
reg              decd_32_srcv2_vld;              
reg     [9  :0]  decd_cache_eu;                  
reg     [19 :0]  decd_cache_func;                
reg              decd_cache_illegal;             
reg              decd_cache_src0_vld;            
reg              decd_code_illegal;              
reg     [264:0]  decd_dp_inst_data;              
reg              decd_fp0_dst0_vld;              
reg              decd_fp0_dste_vld;              
reg              decd_fp0_dstf_vld;              
reg     [9  :0]  decd_fp0_eu;                    
reg     [19 :0]  decd_fp0_func;                  
reg              decd_fp0_illegal;               
reg              decd_fp0_src0_vld;              
reg              decd_fp0_src1_vld;              
reg              decd_fp0_srcf0_vld;             
reg              decd_fp0_srcf1_vld;             
reg              decd_fp1_dst0_vld;              
reg              decd_fp1_dste_vld;              
reg              decd_fp1_dstf_vld;              
reg     [9  :0]  decd_fp1_eu;                    
reg     [19 :0]  decd_fp1_func;                  
reg              decd_fp1_illegal;               
reg              decd_fp1_src0_vld;              
reg              decd_fp1_srcf0_vld;             
reg              decd_fp1_srcf1_vld;             
reg              decd_fp1_srcf2_vld;             
reg              decd_fp_dst0_vld;               
reg              decd_fp_dste_vld;               
reg              decd_fp_dstf_vld;               
reg     [9  :0]  decd_fp_eu;                     
reg     [19 :0]  decd_fp_func;                   
reg              decd_fp_inst_illegal;           
reg              decd_fp_src0_vld;               
reg              decd_fp_src1_vld;               
reg              decd_fp_srcf0_vld;              
reg              decd_fp_srcf1_vld;              
reg              decd_fp_srcf2_vld;              
reg              decd_perf_dst0_vld;             
reg              decd_perf_dst1_vld;             
reg              decd_perf_dstf_vld;             
reg     [9  :0]  decd_perf_eu;                   
reg     [19 :0]  decd_perf_func;                 
reg              decd_perf_illegal;              
reg              decd_perf_src0_vld;             
reg              decd_perf_src1_imm_vld;         
reg              decd_perf_src1_vld;             
reg              decd_perf_src2_imm_vld;         
reg              decd_perf_src2_vld;             
reg              decd_perf_srcf1_vld;            
reg              decd_perf_srcf2_vld;            
reg              decd_v_dst0_vld;                
reg              decd_v_dste_vld;                
reg              decd_v_dstf_vld;                
reg              decd_v_dstv_late_vld;           
reg              decd_v_dstv_vld;                
reg     [9  :0]  decd_v_eu;                      
reg     [19 :0]  decd_v_func;                    
reg              decd_v_src0_vld;                
reg              decd_v_src1_vld;                
reg              decd_v_src2_vld;                
reg              decd_v_srcf0_vld;               
reg              decd_v_srcf1_vld;               
reg              decd_v_srcf2_vld;               
reg              decd_v_srcv0_vld;               
reg              decd_v_srcv1_vld;               
reg              decd_v_srcv2_vld;               
reg              decd_vec_dst0_vld;              
reg              decd_vec_dste_vld;              
reg              decd_vec_dstf_vld;              
reg              decd_vec_dstv_late_vld;         
reg              decd_vec_dstv_vld;              
reg     [9  :0]  decd_vec_eu;                    
reg     [19 :0]  decd_vec_func;                  
reg              decd_vec_illegal;               
reg              decd_vec_src0_vld;              
reg              decd_vec_src1_vld;              
reg              decd_vec_src2_vld;              
reg              decd_vec_srcf0_vld;             
reg              decd_vec_srcf1_vld;             
reg              decd_vec_srcf2_vld;             
reg              decd_vec_srcv0_vld;             
reg              decd_vec_srcv1_vld;             
reg              decd_vec_srcv2_vld;             
reg              x_decd_dst0_vld;                
reg              x_decd_dst1_vld;                
reg              x_decd_dste_vld;                
reg              x_decd_dstf_vld;                
reg              x_decd_dstv_late_vld;           
reg              x_decd_dstv_vld;                
reg     [9  :0]  x_decd_eu;                      
reg     [19 :0]  x_decd_func;                    
reg              x_decd_src0_vld;                
reg     [63 :0]  x_decd_src1_imm;                
reg              x_decd_src1_imm_vld;            
reg              x_decd_src1_vld;                
reg     [63 :0]  x_decd_src2_imm;                
reg              x_decd_src2_imm_vld;            
reg              x_decd_src2_vld;                
reg              x_decd_srcf0_vld;               
reg              x_decd_srcf1_vld;               
reg     [4  :0]  x_decd_srcf2_reg;               
reg              x_decd_srcf2_vld;               
reg     [4  :0]  x_decd_srcv0_reg;               
reg              x_decd_srcv0_vld;               
reg     [4  :0]  x_decd_srcv1_reg;               
reg              x_decd_srcv1_vld;               
reg     [4  :0]  x_decd_srcv2_reg;               
reg              x_decd_srcv2_vld;               

// &Wires; @32
wire             cp0_idu_cskyee;                 
wire    [2  :0]  cp0_idu_frm;                    
wire    [1  :0]  cp0_idu_fs;                     
wire             cp0_idu_ucme;                   
wire             cp0_idu_vill;                   
wire             cp0_idu_vl_zero;                
wire    [1  :0]  cp0_idu_vs;                     
wire    [6  :0]  cp0_idu_vstart;                 
wire    [1  :0]  cp0_yy_priv_mode;               
wire             decd_c_illegal;                 
wire    [9  :0]  decd_caddi4spn_src1_imm;        
wire    [9  :0]  decd_caddisp_src1_imm;          
wire             decd_debug_illegal;             
wire    [4  :0]  decd_dst0_reg;                  
wire    [4  :0]  decd_dst1_reg;                  
wire             decd_flsu_illegal;              
wire             decd_fp0_sel;                   
wire             decd_fp1_sel;                   
wire             decd_fp_illegal;                
wire             decd_fp_rounding_illegal;       
wire             decd_fp_sel;                    
wire             decd_fs_illegal;                
wire             decd_i_illegal;                 
wire             decd_inst_cls;                  
wire             decd_inst_cls_sp;               
wire             decd_inst_dst0_reg_16bit_3_high; 
wire             decd_inst_dst0_reg_16bit_3_low; 
wire             decd_inst_dst0_reg_16bit_5;     
wire             decd_inst_dst0_reg_16bit_x1;    
wire             decd_inst_dst0_reg_32bit;       
wire             decd_inst_dstf_reg_16bit;       
wire             decd_inst_dstf_reg_16bit_high;  
wire             decd_inst_dstf_reg_16bit_low;   
wire             decd_inst_dstf_reg_32bit;       
wire             decd_inst_dstf_reg_32bit_low;   
wire             decd_inst_fcvtfx;               
wire             decd_inst_fls;                  
wire             decd_inst_fmv;                  
wire             decd_inst_src0_reg_16bit_3;     
wire             decd_inst_src0_reg_16bit_5;     
wire             decd_inst_src0_reg_32bit;       
wire             decd_inst_src0_reg_cmv;         
wire             decd_inst_src0_reg_r2;          
wire             decd_inst_src1_reg_16bit_3;     
wire             decd_inst_src1_reg_16bit_5;     
wire             decd_inst_src1_reg_32bit;       
wire             decd_inst_src2_reg_16bit_3;     
wire             decd_inst_src2_reg_16bit_5;     
wire             decd_inst_src2_reg_32bit_11_7;  
wire             decd_inst_src2_reg_32bit_24_20; 
wire             decd_inst_srcf1_reg_16bit;      
wire             decd_inst_srcf1_reg_16bit_low;  
wire             decd_inst_srcf1_reg_32bit;      
wire             decd_inst_srcf1_reg_32bit_low;  
wire             decd_inst_vec;                  
wire             decd_inst_vls;                  
wire             decd_length;                    
wire    [1  :0]  decd_lsr_src3_imm;              
wire             decd_lsr_src3_imm_vld;          
wire             decd_lsu_illegal;               
wire    [8  :0]  decd_ovlp_ill;                  
wire             decd_ovlp_illegal;              
wire    [2  :0]  decd_ovlp_illegal_type;         
wire    [5  :0]  decd_sel;                       
wire    [3  :0]  decd_size_ill_case;             
wire             decd_size_illegal;              
wire    [4  :0]  decd_src0_reg;                  
wire             decd_src1_imm_c_branch_mask;    
wire    [13 :0]  decd_src1_imm_sel;              
wire    [4  :0]  decd_src1_reg;                  
wire             decd_src2_16bit_mask;           
wire    [6  :0]  decd_src2_imm_sel;              
wire    [63 :0]  decd_src2_inst16_c_j_imm;       
wire    [63 :0]  decd_src2_inst16_cbranch_imm;   
wire    [63 :0]  decd_src2_inst32_branch_imm;    
wire    [63 :0]  decd_src2_inst32_jal_imm;       
wire    [4  :0]  decd_src2_reg;                  
wire             decd_srcv0_srcv1_switch;        
wire             decd_srcv1_srcv2_switch;        
wire             decd_start_illegal;             
wire             decd_v_illegal;                 
wire             decd_vec_fp_ac_fcsr;            
wire             decd_vec_inst;                  
wire             decd_vec_inst_ac_fcsr;          
wire             decd_vec_inst_adc;              
wire             decd_vec_inst_comp;             
wire             decd_vec_inst_funary;           
wire             decd_vec_inst_mask;             
wire             decd_vec_inst_narr;             
wire             decd_vec_inst_scalar;           
wire             decd_vec_inst_slidedown;        
wire             decd_vec_inst_slideup;          
wire             decd_vec_inst_vcompress;        
wire             decd_vec_inst_vid;              
wire             decd_vec_inst_viota;            
wire             decd_vec_inst_vred;             
wire             decd_vec_inst_vred_n;           
wire             decd_vec_inst_vred_w;           
wire             decd_vec_inst_vrgather;         
wire             decd_vec_inst_wide;             
wire             decd_vec_inst_wide_w;           
wire    [3  :0]  decd_vec_ls_func;               
wire             decd_vec_lsu;                   
wire             decd_vec_nop;                   
wire             decd_vec_opcfg;                 
wire             decd_vec_opfv;                  
wire             decd_vec_opfvf;                 
wire             decd_vec_opfvv;                 
wire             decd_vec_opiv;                  
wire             decd_vec_opivi;                 
wire             decd_vec_opivv;                 
wire             decd_vec_opivx;                 
wire             decd_vec_opmv;                  
wire             decd_vec_opmvv;                 
wire             decd_vec_opmvx;                 
wire             decd_vec_opvx;                  
wire    [4  :0]  decd_vec_special_func;          
wire             decd_vec_vfunary0;              
wire             decd_vec_vfunary1;              
wire             decd_vec_vmunary0;              
wire             decd_vfunary0_vld;              
wire             decd_vfunary0_vld_narr;         
wire             decd_vfunary0_vld_norm;         
wire             decd_vfunary0_vld_wide;         
wire             decd_vill_illegal;              
wire             decd_vlsu_illegal;              
wire             decd_vmunary0_vld;              
wire             decd_vreg_dst_norm;             
wire    [4  :0]  decd_vreg_ill;                  
wire             decd_vreg_illegal;              
wire    [2  :0]  decd_vreg_illegal_type;         
wire             decd_vreg_src0_norm;            
wire             decd_vreg_src1_norm;            
wire             decd_vs_illegal;                
wire    [31 :0]  dp_decd_inst;                   
wire    [1  :0]  dp_decd_vlmul;                  
wire    [1  :0]  dp_decd_vsew;                   
wire             fcvt_f_x_narrow_il;             
wire             fcvt_f_x_widden;                
wire             fp_dynamic_rounding_illegal;    
wire             fp_fs_illegal;                  
wire             fp_static_rounding_illegal;     
wire             rtu_yy_xx_dbgon;                
wire             vec_mfvr_inst;                  
wire    [19 :0]  vfcvt_func;                     
wire    [5  :0]  x_decd_dst0_reg;                
wire    [5  :0]  x_decd_dst1_reg;                
wire    [4  :0]  x_decd_dstf_reg;                
wire    [4  :0]  x_decd_dstv_reg;                
wire             x_decd_illegal;                 
wire             x_decd_length;                  
wire    [31 :0]  x_decd_opcode;                  
wire    [5  :0]  x_decd_src0_reg;                
wire    [5  :0]  x_decd_src1_reg;                
wire    [5  :0]  x_decd_src2_reg;                
wire    [4  :0]  x_decd_srcf0_reg;               
wire    [4  :0]  x_decd_srcf1_reg;               
wire             x_decd_srcvm_vld;               
wire    [3  :0]  x_decd_vec_split_type;          
wire    [31 :0]  x_inst;                         
wire    [1  :0]  x_vlmul;                        
wire    [1  :0]  x_vsew;                         


//==========================================================
//                      Input Data
//==========================================================
assign x_inst[31:0] = dp_decd_inst[31:0];
assign x_vsew[1:0]  = dp_decd_vsew[1:0];
assign x_vlmul[1:0] = dp_decd_vlmul[1:0];

//==========================================================
//                      Output Data
//==========================================================
// &CombBeg; @44
always @( x_decd_eu[9:0]
       or x_decd_srcvm_vld
       or x_decd_dstf_vld
       or x_decd_srcf2_vld
       or x_decd_dst0_vld
       or x_decd_vec_split_type[3:0]
       or x_decd_src1_imm[63:0]
       or x_decd_dstv_reg[4:0]
       or x_decd_dst1_vld
       or x_decd_src1_imm_vld
       or x_decd_dst0_reg[5:0]
       or x_decd_srcv1_vld
       or x_decd_srcv1_reg[4:0]
       or x_decd_src2_vld
       or x_decd_src0_vld
       or x_decd_src2_imm_vld
       or x_decd_srcv0_reg[4:0]
       or x_decd_src2_imm[63:0]
       or x_decd_srcv2_reg[4:0]
       or x_decd_srcf1_vld
       or x_decd_illegal
       or x_decd_func[19:0]
       or x_decd_dstv_late_vld
       or x_decd_dste_vld
       or x_decd_srcf0_vld
       or x_decd_src1_reg[5:0]
       or x_decd_srcv0_vld
       or x_decd_src1_vld
       or x_decd_dstv_vld
       or x_decd_length
       or x_decd_src0_reg[5:0]
       or x_decd_srcv2_vld
       or x_decd_opcode[31:0]
       or x_decd_src2_reg[5:0]
       or x_decd_dst1_reg[5:0])
begin
  decd_dp_inst_data[`IDU_WIDTH-1:0]                            = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  decd_dp_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]         = x_decd_func[`FUNC_WIDTH-1:0];
  decd_dp_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]               = x_decd_eu[`EU_WIDTH-1:0];
  decd_dp_inst_data[`IDU_OPCODE:`IDU_OPCODE-31]                = x_decd_opcode[31:0];
  decd_dp_inst_data[`IDU_VEC_SPLIT_TYPE:`IDU_VEC_SPLIT_TYPE-3] = x_decd_vec_split_type[3:0];
  decd_dp_inst_data[`IDU_ILLEGAL]                              = x_decd_illegal;
  decd_dp_inst_data[`IDU_LENGTH]                               = x_decd_length;
  decd_dp_inst_data[`IDU_SRC2_IMM:`IDU_SRC2_IMM-63]            = x_decd_src2_imm[63:0];
  decd_dp_inst_data[`IDU_SRC1_IMM:`IDU_SRC1_IMM-63]            = x_decd_src1_imm[63:0];
  decd_dp_inst_data[`IDU_SRC2_IMM_VLD]                         = x_decd_src2_imm_vld;
  decd_dp_inst_data[`IDU_SRC1_IMM_VLD]                         = x_decd_src1_imm_vld;
  decd_dp_inst_data[`IDU_DSTV_REG:`IDU_DSTV_REG-4]             = x_decd_dstv_reg[4:0];
  decd_dp_inst_data[`IDU_SRCV2_REG:`IDU_SRCV2_REG-4]           = x_decd_srcv2_reg[4:0];
  decd_dp_inst_data[`IDU_SRCV1_REG:`IDU_SRCV1_REG-4]           = x_decd_srcv1_reg[4:0];
  decd_dp_inst_data[`IDU_SRCV0_REG:`IDU_SRCV0_REG-4]           = x_decd_srcv0_reg[4:0];
  decd_dp_inst_data[`IDU_DST1_REG:`IDU_DST1_REG-5]             = x_decd_dst1_reg[5:0];
  decd_dp_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5]             = x_decd_dst0_reg[5:0];
  decd_dp_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]             = x_decd_src2_reg[5:0];
  decd_dp_inst_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5]             = x_decd_src1_reg[5:0];
  decd_dp_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]             = x_decd_src0_reg[5:0];
  decd_dp_inst_data[`IDU_DSTV_LATE_VLD]                        = x_decd_dstv_late_vld;
  decd_dp_inst_data[`IDU_DSTV_VLD]                             = x_decd_dstv_vld;
  decd_dp_inst_data[`IDU_SRCVM_VLD]                            = x_decd_srcvm_vld;
  decd_dp_inst_data[`IDU_SRCV2_VLD]                            = x_decd_srcv2_vld;
  decd_dp_inst_data[`IDU_SRCV1_VLD]                            = x_decd_srcv1_vld;
  decd_dp_inst_data[`IDU_SRCV0_VLD]                            = x_decd_srcv0_vld;
  decd_dp_inst_data[`IDU_DSTE_VLD]                             = x_decd_dste_vld;
  decd_dp_inst_data[`IDU_DSTF_VLD]                             = x_decd_dstf_vld;
  decd_dp_inst_data[`IDU_SRCF2_VLD]                            = x_decd_srcf2_vld;
  decd_dp_inst_data[`IDU_SRCF1_VLD]                            = x_decd_srcf1_vld;
  decd_dp_inst_data[`IDU_SRCF0_VLD]                            = x_decd_srcf0_vld;
  decd_dp_inst_data[`IDU_DST1_VLD]                             = x_decd_dst1_vld;
  decd_dp_inst_data[`IDU_DST0_VLD]                             = x_decd_dst0_vld;
  decd_dp_inst_data[`IDU_SRC2_VLD]                             = x_decd_src2_vld;
  decd_dp_inst_data[`IDU_SRC1_VLD]                             = x_decd_src1_vld;
  decd_dp_inst_data[`IDU_SRC0_VLD]                             = x_decd_src0_vld;
 end
// &CombEnd; @83
end

//==========================================================
//               Decode Instruction Length
//==========================================================
assign decd_length         = (x_inst[1:0] == 2'b11);

assign x_decd_opcode[31:0] = decd_length ? x_inst[31:0] : {16'b0,x_inst[15:0]}; 
assign x_decd_length       = decd_length;

//==========================================================
//               Other Decoded Information
//==========================================================
//----------------------------------------------------------
//                   Vector Split Type
//----------------------------------------------------------
assign x_decd_vec_split_type[3:0] = `VEC_SPLIT_NON;

//==========================================================
//                       Immediate
//==========================================================
//----------------------------------------------------------
//                   Immediate Selection
//----------------------------------------------------------
//32 bit imm20
assign decd_src1_imm_sel[0]   = (x_inst[6:0] == 7'b0110111)
                             || (x_inst[6:0] == 7'b0010111);
//32 bit imm12
assign decd_src1_imm_sel[1]   = (x_inst[1:0] == 2'b11)
                                && !decd_src1_imm_sel[0]
                                && !decd_src1_imm_sel[5]
                                && !decd_src1_imm_sel[12]
                                && !decd_inst_vec;
//16 bit imm6
assign decd_src1_imm_sel[2]   = (x_inst[1:0] != 2'b11)
                                && !decd_src1_imm_sel[3]
                                && !decd_src1_imm_sel[4]
                                && !decd_src1_imm_sel[6]
                                && !decd_src1_imm_sel[7]
                                && !decd_src1_imm_sel[8]
                                && !decd_src1_imm_sel[9]
                                && !decd_src1_imm_sel[10]
                                && !decd_src1_imm_sel[11];
//16 bit caddisp
assign decd_src1_imm_sel[3]   = ({x_inst[15:13],x_inst[11:7],
                                  x_inst[1:0]} == 10'b011_00010_01);
//16 bit caddi4spn
assign decd_src1_imm_sel[4]   = ({x_inst[15:13],x_inst[1:0]}
                                 == 5'b000_00);
//32 bit store
assign decd_src1_imm_sel[5]   = (x_inst[6:0] == 7'b0100011)
                             || ({x_inst[14],x_inst[6:0]} == 8'b0_0100111);

//16 bit c.lwsp
assign decd_src1_imm_sel[6]   = {x_inst[15:13],x_inst[1:0]} == 5'b01010;

//16 bit c.lw/c.sw
assign decd_src1_imm_sel[7]   = {x_inst[14:13],x_inst[1:0]} == 4'b1000;

//16 bit c.swsp
assign decd_src1_imm_sel[8]   = {x_inst[15:13],x_inst[1:0]} == 5'b11010;

//16 bit c.fld/c.fsd/c.ld/c.sd
assign decd_src1_imm_sel[9]   = ({x_inst[13],x_inst[1:0]} == 3'b1_00);

//16 bit c.fldsp/c.ldsp
assign decd_src1_imm_sel[10]  = {x_inst[15],x_inst[13],x_inst[1:0]} == 4'b0_1_10;

//16 bit c.fsdsp/c.sdsp
assign decd_src1_imm_sel[11]  = {x_inst[15],x_inst[13],x_inst[1:0]} == 4'b1_1_10;

//lsi 
assign decd_src1_imm_sel[12]  = x_inst[6:0] == 7'b0001011 
                                && x_inst[14:13] == 2'b10 
                                && x_inst[27];
// vector opivi
assign decd_src1_imm_sel[13]  = decd_inst_vec && decd_vec_opivi;

//16 bit branch mask
assign decd_src1_imm_c_branch_mask = (x_inst[15:14] == 2'b11) ||
                                     (x_inst[15:12] == 4'b1000 && x_inst[6:2] != 5'b0 && x_inst[1:0] == 2'b10);

//----------------------------------------------------------
//                   Source 1 immediate
//----------------------------------------------------------
assign decd_caddisp_src1_imm[9:0]   = {x_inst[12],x_inst[4:3],
                                       x_inst[5], x_inst[2],
                                       x_inst[6], 4'b0};

assign decd_caddi4spn_src1_imm[9:0] = {x_inst[10:7],x_inst[12:11],
                                       x_inst[5], x_inst[6],2'b0};

// &CombBeg; @175
always @( x_inst[3:2]
       or decd_src1_imm_c_branch_mask
       or x_inst[31:2]
       or decd_caddisp_src1_imm[9:0]
       or decd_src1_imm_sel[13:0]
       or decd_caddi4spn_src1_imm[9:0])
begin
  case(decd_src1_imm_sel[13:0])
    14'h01  : x_decd_src1_imm[63:0] = {{32{x_inst[31]}}, x_inst[31:12], 12'b0};
    14'h02  : x_decd_src1_imm[63:0] = {{52{x_inst[31]}},x_inst[31:20]};
    14'h04  : x_decd_src1_imm[63:0] = {{58{x_inst[12]}},
                                           x_inst[12],x_inst[6:2]} & {64{!decd_src1_imm_c_branch_mask}};
    14'h08  : x_decd_src1_imm[63:0] = {{54{decd_caddisp_src1_imm[9]}},
                                           decd_caddisp_src1_imm[9:0]};
    14'h10  : x_decd_src1_imm[63:0] = {54'b0, decd_caddi4spn_src1_imm[9:0]};
    14'h20  : x_decd_src1_imm[63:0] = {{53{x_inst[31]}}, x_inst[30:25], x_inst[11:7]};
    14'h40  : x_decd_src1_imm[63:0] = {56'b0, x_inst[3:2],x_inst[12],x_inst[6:4],2'b0};
    14'h80  : x_decd_src1_imm[63:0] = {57'b0, x_inst[5],x_inst[12:10],x_inst[6],2'b0};
    14'h100 : x_decd_src1_imm[63:0] = {56'b0, x_inst[8:7], x_inst[12:9], 2'b0};
    14'h200 : x_decd_src1_imm[63:0] = {56'b0, x_inst[6:5], x_inst[12:10], 3'b0};
    14'h400 : x_decd_src1_imm[63:0] = {55'b0, x_inst[4:2], x_inst[12], x_inst[6:5],3'b0};
    14'h800 : x_decd_src1_imm[63:0] = {55'b0, x_inst[9:7], x_inst[12:10], 3'b0};
    14'h1000: x_decd_src1_imm[63:0] = {{59{x_inst[24]}}, x_inst[24:20]} << x_inst[26:25];
    14'h2000: x_decd_src1_imm[63:0] = {59'b0, x_inst[19:15]};
    default : x_decd_src1_imm[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @195
end

//----------------------------------------------------------
//                   Immediate Selection
//----------------------------------------------------------
//32 bit imm20
assign decd_src2_imm_sel[0]   = (x_inst[6:0] == 7'b0010111);

//32 bit imm12
assign decd_src2_imm_sel[1]   = (x_inst[1:0] == 2'b11)
                                && !decd_src2_imm_sel[0]
                                && !decd_src2_imm_sel[3]
                                && !decd_src2_imm_sel[4];
//16 bit imm6
assign decd_src2_imm_sel[2]   = (x_inst[1:0] != 2'b11)
                                && !(|decd_src2_imm_sel[6:5]);

// 32 bit branch
assign decd_src2_imm_sel[3]   = (x_inst[6:0] == 7'b1100011);

// 32 bit jal
assign decd_src2_imm_sel[4]   = (x_inst[6:0] == 7'b1101111);

//16 bit c.branch imm8
assign decd_src2_imm_sel[5]   = (x_inst[1:0] != 2'b11) && (x_inst[15:14] == 2'b11);

// 16 bit c.j
assign decd_src2_imm_sel[6]   = (x_inst[1:0] != 2'b11) && (x_inst[15:13] == 3'b101);

// 16 bit c.jr/jalr mask
assign decd_src2_16bit_mask   = (x_inst[1:0] != 2'b11) && (x_inst[15:14] == 2'b10);

//----------------------------------------------------------
//                   Source 2 immediate
//----------------------------------------------------------
assign decd_src2_inst32_branch_imm[63:0]  = {{51{x_inst[31]}}, x_inst[31],
                                             x_inst[7], x_inst[30:25], x_inst[11:8],1'b0};
assign decd_src2_inst32_jal_imm[63:0]     = {{44{x_inst[31]}}, x_inst[19:12], x_inst[20],
                                             x_inst[30:21], 1'b0};
assign decd_src2_inst16_cbranch_imm[63:0] = {{55{x_inst[12]}}, x_inst[12], x_inst[6:5], x_inst[2],
                                             x_inst[11:10], x_inst[4:3], 1'b0};
assign decd_src2_inst16_c_j_imm[63:0]     = {{52{x_inst[12]}}, x_inst[12], x_inst[8], x_inst[10:9],
                                             x_inst[6], x_inst[7], x_inst[2], x_inst[11],
                                             x_inst[5:3],1'b0};

// &CombBeg; @240
always @( decd_src2_inst16_cbranch_imm[63:0]
       or decd_src2_inst32_jal_imm[63:0]
       or decd_src2_imm_sel[6:0]
       or decd_src2_inst16_c_j_imm[63:0]
       or decd_src2_16bit_mask
       or decd_src2_inst32_branch_imm[63:0]
       or x_inst[31:12]
       or x_inst[6:2])
begin
  case(decd_src2_imm_sel[6:0])
    7'h01   : x_decd_src2_imm[63:0] = {{32{x_inst[31]}}, x_inst[31:12], 12'b0};
    7'h02   : x_decd_src2_imm[63:0] = {{52{x_inst[31]}},x_inst[31:20]};
    7'h04   : x_decd_src2_imm[63:0] = {{58{x_inst[12]}},
                                     x_inst[12],x_inst[6:2]} & {64{!decd_src2_16bit_mask}};
    7'h08   : x_decd_src2_imm[63:0] = decd_src2_inst32_branch_imm[63:0];
    7'h10   : x_decd_src2_imm[63:0] = decd_src2_inst32_jal_imm[63:0];
    7'h20   : x_decd_src2_imm[63:0] = decd_src2_inst16_cbranch_imm[63:0];
    7'h40   : x_decd_src2_imm[63:0] = decd_src2_inst16_c_j_imm[63:0];
    default: x_decd_src2_imm[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @252
end

//----------------------------------------------------------
//                   Source 3 immediate
//----------------------------------------------------------
//src3 immediate is only used by lsr inst
assign decd_lsr_src3_imm_vld  = (x_inst[6:0] == 7'b0001011) 
                             && x_inst[14] 
                             && !x_inst[27];
assign decd_lsr_src3_imm[1:0] = x_inst[26:25] & {2{decd_lsr_src3_imm_vld}};

//==========================================================
//              Decode Source Register Index
//==========================================================
//----------------------------------------------------------
//                  Source 0 Register Index
//----------------------------------------------------------
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic
assign decd_inst_src0_reg_32bit   = (x_inst[1:0] == 2'b11);
assign decd_inst_src0_reg_16bit_5 = (({x_inst[1:0],x_inst[15]} == 3'b01_0)
                                    || (x_inst[1:0] == 2'b10))
                                       && !decd_inst_src0_reg_r2
                                       && !decd_inst_src0_reg_cmv;
assign decd_inst_src0_reg_cmv     = ({x_inst[1:0],x_inst[15:12]} == 6'b10_1000)
                                    && (x_inst[6:2] != 5'd0); //c.mv
assign decd_inst_src0_reg_16bit_3 = (({x_inst[1:0],x_inst[15]} == 3'b01_1)
                                    || (x_inst[1:0] == 2'b00))
                                       && !decd_inst_src0_reg_r2;
assign decd_inst_src0_reg_r2      = ({x_inst[14:13],x_inst[1:0]} == 4'b00_00) //c.addi4spn
                                    || (x_inst[1:0] == 2'b10) //c. load and store
                                       && (x_inst[15:13] != 3'b000)
                                       && (x_inst[15:13] != 3'b100);
//index select
assign decd_src0_reg[4:0] =
           {5{decd_inst_src0_reg_32bit}}   & x_inst[19:15]
         | {5{decd_inst_src0_reg_16bit_5}} & x_inst[11:7]
         | {5{decd_inst_src0_reg_cmv}}     & x_inst[6:2]
         | {5{decd_inst_src0_reg_16bit_3}} & {2'd1, x_inst[9:7]}
         | {5{decd_inst_src0_reg_r2}}      & 5'd2;
//output
assign x_decd_src0_reg[5:0] = decd_inst_vec ? {1'b0,x_inst[24:20]} : {1'b0,decd_src0_reg[4:0]};

//----------------------------------------------------------
//                  Source 1 Register Index
//----------------------------------------------------------
assign decd_inst_src1_reg_32bit     = (x_inst[1:0] == 2'b11) && !decd_inst_fmv && !decd_inst_fcvtfx;
assign decd_inst_src1_reg_16bit_5   = (x_inst[1:0] == 2'b10);
assign decd_inst_src1_reg_16bit_3   = (x_inst[1:0] == 2'b00)
                                   || (x_inst[1:0] == 2'b01);
 assign decd_inst_fmv               = (x_inst[31:28] == 4'b1111)
                                   && (x_inst[6:0] == 7'b1010011);  
 assign decd_inst_fcvtfx            = (x_inst[31:28] == 4'b1101)
                                   && (x_inst[6:0] == 7'b1010011);  
//index select
assign decd_src1_reg[4:0] =
           {5{decd_inst_src1_reg_32bit}}   & x_inst[24:20]
         | {5{decd_inst_src1_reg_16bit_5}} & x_inst[6:2]
         | {5{decd_inst_src1_reg_16bit_3}} & {2'd1, x_inst[4:2]}
         | {5{decd_inst_fmv
              ||decd_inst_fcvtfx}}         & {x_inst[19:15]};

//output
assign x_decd_src1_reg[5:0] = decd_inst_vec ? {1'b0,x_inst[19:15]} : {1'b0,decd_src1_reg[4:0]};

//----------------------------------------------------------
//                  Source 2 Register Index
//----------------------------------------------------------
assign decd_inst_src2_reg_32bit_24_20  = (x_inst[6:0] == 7'b0100011) 
                                      || (x_inst[6:0]==7'b0100111) && (!x_inst[14] && |x_inst[13:12]);
assign decd_inst_src2_reg_32bit_11_7   = (x_inst[1:0] == 2'b11) && !decd_inst_src2_reg_32bit_24_20;
//assign decd_inst_src2_reg_16bit_5      = ({x_inst[1:0],x_inst[15]} == 3'b01_0) 
//                                       || (x_inst[1:0] == 2'b10);
//assign decd_inst_src2_reg_16bit_3_high = ({x_inst[1:0],x_inst[15]} == 3'b01_1);
//assign decd_inst_src2_reg_16bit_3_low  =  (x_inst[1:0] == 2'b00);
assign decd_inst_src2_reg_16bit_3      = ({x_inst[1:0],x_inst[15]} == 3'b00_1);
assign decd_inst_src2_reg_16bit_5      = ({x_inst[1:0],x_inst[15]} == 3'b10_1);

//index select
assign decd_src2_reg[4:0] =
           {5{decd_inst_src2_reg_32bit_24_20}}  & x_inst[24:20]
         | {5{decd_inst_src2_reg_32bit_11_7}}   & x_inst[11:7]
         | {5{decd_inst_src2_reg_16bit_3}}      & {2'd1,x_inst[4:2]}
         | {5{decd_inst_src2_reg_16bit_5}}      & x_inst[6:2];
//         | {5{decd_inst_src2_reg_16bit_5}}      & x_inst[11:7]
//         | {5{decd_inst_src2_reg_16bit_3_high}} & {2'd1, x_inst[9:7]}
//         | {5{decd_inst_src2_reg_16bit_3_low}}  & {2'd1, x_inst[4:2]}
//         | {5{decd_inst_vec}}                   & x_inst[11:7];
//output
assign x_decd_src2_reg[5:0] = {1'b0,decd_src2_reg[4:0]};

//==========================================================
//            Decode Destination Register Index
//==========================================================
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic

//----------------------------------------------------------
//          Decode destination 0 register index
//----------------------------------------------------------
assign decd_inst_dst0_reg_32bit        =  (x_inst[1:0] == 2'b11);
assign decd_inst_dst0_reg_16bit_5      = ({x_inst[1:0],x_inst[15]} == 3'b01_0)
                                       || (x_inst[1:0] == 2'b10)
                                          && ({x_inst[15:12],x_inst[6:2]} != 9'b1001_00000);
assign decd_inst_dst0_reg_16bit_3_high = ({x_inst[1:0],x_inst[15]} == 3'b01_1);
assign decd_inst_dst0_reg_16bit_3_low  =  (x_inst[1:0] == 2'b00);
assign decd_inst_dst0_reg_16bit_x1     =  ({x_inst[15:12],x_inst[6:0]} == 11'b1001_00000_10);

//index select
assign decd_dst0_reg[4:0] =
           {5{decd_inst_dst0_reg_32bit}}        & x_inst[11:7]
         | {5{decd_inst_dst0_reg_16bit_5}}      & x_inst[11:7]
         | {5{decd_inst_dst0_reg_16bit_3_high}} & {2'd1, x_inst[9:7]}
         | {5{decd_inst_dst0_reg_16bit_3_low}}  & {2'd1, x_inst[4:2]}
         | {5{decd_inst_dst0_reg_16bit_x1}}     & 5'd1;
//output
assign x_decd_dst0_reg[5:0] = {1'b0,decd_dst0_reg[4:0]};

//----------------------------------------------------------
//          Decode destination 1 register index
//----------------------------------------------------------
//index select
assign decd_dst1_reg[4:0] = x_inst[19:15];
//output
assign x_decd_dst1_reg[5:0] = {1'b0,decd_dst1_reg[4:0]};

//==========================================================
//            Decode Scalar FP Source Register Index
//==========================================================
//----------------------------------------------------------
//               Scalar FP Source 0 Register Index
//----------------------------------------------------------
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructio
//so add new instruction should carefully check these logic
assign x_decd_srcf0_reg[4:0] = (decd_inst_vls) 
                               ? x_inst[24:20]
                               : x_inst[19:15];

//----------------------------------------------------------
//               Scalar FP Source 1 Register Index
//----------------------------------------------------------
assign decd_inst_srcf1_reg_32bit     = (x_inst[1:0] == 2'b11)
                                       && (x_inst[6:0] != 7'b0001011)
                                       && !decd_inst_vec;
assign decd_inst_srcf1_reg_32bit_low = (x_inst[1:0] == 2'b11)
                                       && (x_inst[6:0] == 7'b0001011);
assign decd_inst_srcf1_reg_16bit     = (x_inst[1:0] == 2'b10);
assign decd_inst_srcf1_reg_16bit_low = (x_inst[1:0] == 2'b00);

assign x_decd_srcf1_reg[4:0] =
           {5{decd_inst_srcf1_reg_32bit}}     & x_inst[24:20]
         | {5{decd_inst_srcf1_reg_32bit_low}} & x_inst[11:7]
         | {5{decd_inst_srcf1_reg_16bit}}     & x_inst[6:2]
         | {5{decd_inst_srcf1_reg_16bit_low}} & {2'd1, x_inst[4:2]}
         | {5{decd_inst_vec}}                 & x_inst[19:15];

//----------------------------------------------------------
//               Scalar FP Source 2 Register Index
//----------------------------------------------------------
//perf_inst 
assign decd_inst_vls    = x_inst[6:0]==7'b0001011;

//// no other srcf2_vld inst except st
// c.fsd || c.fsdsp
assign decd_inst_cls_sp    = (x_inst[1:0]==2'b10);
assign decd_inst_cls       = (x_inst[1:0]==2'b00);
assign decd_inst_fls       = ((x_inst[6:0]==7'b0100111) || (x_inst[6:0]==7'b0000111)) &&
                             (!x_inst[14] && |x_inst[13:12]);
// &CombBeg; @430
always @( x_inst[24:20]
       or x_inst[4:2]
       or decd_inst_vls
       or decd_inst_cls_sp
       or x_inst[31:27]
       or decd_inst_cls
       or x_inst[11:2]
       or decd_inst_fls)
begin
case({decd_inst_vls,decd_inst_fls,decd_inst_cls_sp,decd_inst_cls})
  4'b1000: x_decd_srcf2_reg[4:0] = x_inst[11: 7];
  4'b0100: x_decd_srcf2_reg[4:0] = x_inst[24:20];
  4'b0010: x_decd_srcf2_reg[4:0] = x_inst[6:2];
  4'b0001: x_decd_srcf2_reg[4:0] = {2'b1,x_inst[4:2]};
  default: x_decd_srcf2_reg[4:0] = x_inst[31:27];
endcase

// &CombEnd; @439
end

//==========================================================
//            Decode Destination Register Index
//==========================================================
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic
assign decd_inst_dstf_reg_32bit      = (x_inst[6:0]==7'b0100111) && (!x_inst[14] && |x_inst[13:12]);
assign decd_inst_dstf_reg_32bit_low  = (x_inst[1:0] == 2'b11) && !decd_inst_dstf_reg_32bit;
assign decd_inst_dstf_reg_16bit_high = {x_inst[15],x_inst[1:0]} == 3'b010;
assign decd_inst_dstf_reg_16bit      = {x_inst[15],x_inst[13],x_inst[1:0]} == 4'b1110;
assign decd_inst_dstf_reg_16bit_low  = (x_inst[1:0] == 2'b00);

assign x_decd_dstf_reg[4:0] =
           {5{decd_inst_dstf_reg_32bit}}      & x_inst[24:20]
         | {5{decd_inst_dstf_reg_32bit_low}}  & x_inst[11:7]
         | {5{decd_inst_dstf_reg_16bit_high}} & x_inst[11:7]
         | {5{decd_inst_dstf_reg_16bit}}      & x_inst[6:2]
         | {5{decd_inst_dstf_reg_16bit_low}}  & {2'd1, x_inst[4:2]}
         | {5{decd_inst_vec}}                 & x_inst[11:7];

//==========================================================
//                 Illegal inst Decoder
//==========================================================
//32 bit decode instruction within inst[31:25],[14:12],[6:0]
//16 bit decode instruction within inst[15:10],[6:5],[1:0]
//decode illegal definition beyond main decoder scope here

//----------------------------------------------------------
//                Base Illegal Instruction
//----------------------------------------------------------
assign decd_i_illegal =
     ({x_inst[31:25],x_inst[14:12],x_inst[6:0]} == 17'b0000000_000_1110011)
     && ({x_inst[24:15],x_inst[11:7]} != 15'b0) //ecall
     && ({x_inst[24:15],x_inst[11:7]} != 15'h400) //ebreak
  || ({x_inst[31:25],x_inst[14:12],x_inst[6:0]} == 17'b0111101_000_1110011)
     && (({x_inst[24:15],x_inst[11:7]} != 15'h4800) || !rtu_yy_xx_dbgon) //dret
  || ({x_inst[31:25],x_inst[14:12],x_inst[6:0]} == 17'b0001000_000_1110011)
     && ({x_inst[24:15],x_inst[11:7]} != 15'h800) //sret
     && ({x_inst[24:15],x_inst[11:7]} != 15'h1400) //wfi
  || ({x_inst[31:25],x_inst[14:12],x_inst[6:0]} == 17'b0011000_000_1110011)
     && ({x_inst[24:15],x_inst[11:7]} != 15'h800) //mret
  || ({x_inst[31:25],x_inst[14:12],x_inst[6:0]} == 17'b0001001_000_1110011)
     && (x_inst[11:7] != 5'b0) //sfence.vma
  || ({x_inst[31:25],x_inst[14:12],x_inst[6:0]} == 17'b0010001_000_1110011)
//     && ((x_inst[11:7] != 5'b0) //hfence.vvma
//         || !cp0_yy_hyper)
//  || ({x_inst[31:25],x_inst[14:12],x_inst[6:0]} == 17'b0110001_000_1110011)
//     && ((x_inst[11:7] != 5'b0) //hfence.gvma
//         || !cp0_yy_hyper)
  || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b00010_010_0101111)
     && (x_inst[24:20] != 5'b0) //lr.w
  || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b00010_011_0101111)
     && (x_inst[24:20] != 5'b0) //lr.d
  || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b10000_001_0001011)
     && (x_inst[24:20] != 5'b0) //tstnbz,rev,ff0,ff1
  || ({x_inst[31:25],x_inst[14:12],x_inst[6:0]} == 17'b1001000_001_0001011)
     && (x_inst[24:20] != 5'b0); //revw

//----------------------------------------------------------
//                  C Illegal Instruction
//----------------------------------------------------------
assign decd_c_illegal =
     ({x_inst[15:13], x_inst[1:0]} == 5'b000_00)
     && (x_inst[12:5] == 8'b0) //c.addi4spn
  || ({x_inst[15:13], x_inst[1:0]} == 5'b001_01)
     && (x_inst[11:7] == 5'b0) //c.addiw
  || ({x_inst[15:13], x_inst[1:0]} == 5'b011_01)
     && ({x_inst[12],x_inst[6:2]} == 6'b0) //c.addi16sp / c.lui
  || ({x_inst[15:13], x_inst[1:0]} == 5'b010_10)
     && (x_inst[11:7] == 5'b0) //c.lwsp
  || ({x_inst[15:13], x_inst[1:0]} == 5'b011_10)
     && (x_inst[11:7] == 5'b0) //c.ldsp
  || ({x_inst[15:12], x_inst[1:0]} == 6'b1000_10)
     && (x_inst[6:2] == 5'b0) //c.jr
     && (x_inst[11:7] == 5'b0);

//----------------------------------------------------------
//            FP load/store Illegal Instruction
//----------------------------------------------------------
//FP load/store illegal:
//when FS=0,execute RV64F/D inst will trigger illegal
assign decd_flsu_illegal =
     (({x_inst[15:13], x_inst[1:0]} == 5'b001_00)     //c.fld
   || ({x_inst[15:13], x_inst[1:0]} == 5'b101_00) //c.fsd
   || ({x_inst[15:13], x_inst[1:0]} == 5'b001_10) //c.fldsp
   || ({x_inst[15:13], x_inst[1:0]} == 5'b101_10) //c.fsdsp
   || ((x_inst[6:0] == 7'b0000111) || (x_inst[6:0] == 7'b0100111)) //flh/flw/fld/fsh/fsw/fsd
      && ((x_inst[14:12]==3'b001)
          || (x_inst[14:12]==3'b010)
          || (x_inst[14:12]==3'b011))
   //if cskyee=0, decd_32_illegal will be 1 due to decd_sel[4] for flr/fsr
   || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b01000_110_0001011) //flrw
   || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b01100_110_0001011) //flrd
   || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b01010_110_0001011) //flurw
   || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b01110_110_0001011) //flurd
   || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b01000_111_0001011) //fsrw
   || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b01100_111_0001011) //fsrd
   || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b01010_111_0001011) //fsurw
   || ({x_inst[31:27],x_inst[14:12],x_inst[6:0]} == 15'b01110_111_0001011))//fsurd
   && (cp0_idu_fs[1:0] == 2'b00);

assign decd_lsu_illegal = decd_flsu_illegal || decd_vlsu_illegal;

// &CombBeg; @562
// &CombEnd; @573
// &CombBeg; @575
// &CombEnd; @588
// &CombBeg; @593
// &CombEnd; @600
// &CombBeg; @602
// &CombEnd; @609
assign decd_vlsu_illegal = 1'b0;
assign decd_vec_lsu      = 1'b0;

//----------------------------------------------------------
//                 FP Illegal Instruction
//----------------------------------------------------------
//FP extension illegal
//1. rounding mode == 3'b101 or rounding mode = 3'b110
//2. rounding mode == 3'b111 and fcsr[7:5] == 3'b101~3'b111
//3. FS==0,execute RV64F/D inst or read/write fcsr/fflags/frm/fxcr
//   read/write fcsr/... will decode in `EU_CP0
assign fp_static_rounding_illegal  = (x_inst[14:12] == 3'b101)
                                  || (x_inst[14:12] == 3'b110);
assign fp_dynamic_rounding_illegal = (x_inst[14:12] == 3'b111)
                                  && ((cp0_idu_frm[2:0] == 3'b101)
                                      ||(cp0_idu_frm[2:0] == 3'b110)
                                      ||(cp0_idu_frm[2:0] == 3'b111));
assign fp_fs_illegal   = (cp0_idu_fs[1:0] == 2'b00); //off
assign decd_fp_illegal =  decd_fp_inst_illegal
                       || fp_static_rounding_illegal
                       || fp_dynamic_rounding_illegal
                       || fp_fs_illegal;

//----------------------------------------------------------
//                Debug Illegal Instruction
//----------------------------------------------------------
//when in debug mode, inst with pc src or dest will be illegal
assign decd_debug_illegal = (x_decd_eu[`EU_WIDTH-1:0] == `EU_BJU);

//----------------------------------------------------------
//               Illegal Instruction Result
//----------------------------------------------------------
//output all illegal
assign x_decd_illegal = decd_32_illegal    && decd_sel[0]
                     || decd_16_illegal    && decd_sel[1]
                     || decd_i_illegal
                     || decd_c_illegal
                     || decd_lsu_illegal
                     || decd_fp_illegal    && decd_sel[2]
                     || decd_cache_illegal && decd_sel[3]
                     || decd_perf_illegal  && decd_sel[4]
                     || decd_vec_illegal   && decd_sel[5]
                     || decd_debug_illegal && rtu_yy_xx_dbgon;

//==========================================================
//          Full Decoder for valid and illegal inst
//==========================================================
//the destination and source valid signal and invalid
//instruction exception is hard to optimazied for timing,
//so here implement a full decoder for: type, dst0_vld, dst_c_vld
//src0_vld, src1_vld, srcc_vld, dstf_vld, dste_vld, srcf0_vld,
//srcf1_vld, srcf2_vld, inv_expt
//----------------------------------------------------------
//                  Decoder Result Selection
//----------------------------------------------------------

assign decd_fp_sel  = (x_inst[6:0] == 7'b1010011)
                   || ({x_inst[6:4],x_inst[1:0]} == 5'b10011);

//32 bits
assign decd_sel[0] = decd_length
                     && !decd_fp_sel
                     && !decd_sel[3]
                     && !decd_sel[4]
                     && !decd_sel[5];
//16 bits
assign decd_sel[1] = !decd_length;
//fp
assign decd_sel[2] = decd_fp_sel;
//cache
assign decd_sel[3] = ({x_inst[31:26],x_inst[14:0]}
                     == 21'b000000_000_00000_0001011)
                     && cp0_idu_cskyee;
//perf
assign decd_sel[4] = (x_inst[6:0] == 7'b0001011)
                     && (x_inst[14:12] != 3'b000)
                     && cp0_idu_cskyee;
//vector
assign decd_sel[5] = 1'b0;

// &CombBeg; @750
always @( decd_32_srcv2_vld
       or x_inst[14:12]
       or decd_32_srcv1_vld
       or decd_vec_srcf2_vld
       or decd_vec_dstf_vld
       or decd_perf_srcf1_vld
       or decd_vec_srcv2_vld
       or decd_cache_eu[9:0]
       or decd_vec_special_func[4:0]
       or decd_lsr_src3_imm[1:0]
       or decd_32_src0_vld
       or decd_32_func[19:0]
       or decd_perf_src2_vld
       or decd_vec_srcf0_vld
       or decd_vec_eu[9:0]
       or decd_32_dst0_vld
       or decd_perf_src1_imm_vld
       or decd_fp_dst0_vld
       or decd_perf_dst1_vld
       or decd_fp_srcf0_vld
       or decd_vec_dste_vld
       or decd_vec_src0_vld
       or decd_32_dste_vld
       or decd_vec_srcv1_vld
       or decd_16_eu[9:0]
       or decd_fp_srcf1_vld
       or decd_fp_dste_vld
       or decd_perf_eu[9:0]
       or decd_16_src1_imm_vld
       or decd_sel[5:0]
       or decd_32_srcv0_vld
       or decd_cache_src0_vld
       or decd_16_src1_vld
       or decd_32_src2_vld
       or decd_16_dst0_vld
       or decd_perf_src0_vld
       or decd_32_srcf0_vld
       or decd_16_src2_imm_vld
       or decd_32_src2_imm_vld
       or decd_16_src2_vld
       or decd_16_srcf2_vld
       or decd_cache_func[19:0]
       or decd_32_eu[9:0]
       or decd_vec_dst0_vld
       or decd_vec_src2_vld
       or decd_fp_src1_vld
       or decd_vec_func[19:0]
       or decd_vec_srcv0_vld
       or decd_vec_ls_func[3:0]
       or decd_vec_src1_vld
       or decd_perf_src1_vld
       or decd_fp_func[19:0]
       or decd_32_dstf_vld
       or decd_fp_srcf2_vld
       or decd_vec_dstv_vld
       or decd_vec_srcf1_vld
       or decd_32_dstv_vld
       or decd_perf_func[19:0]
       or decd_fp_dstf_vld
       or decd_32_src1_imm_vld
       or decd_perf_dstf_vld
       or decd_perf_src2_imm_vld
       or decd_16_srcf1_vld
       or decd_perf_srcf2_vld
       or decd_16_func[19:0]
       or decd_16_dstf_vld
       or decd_fp_src0_vld
       or decd_vec_dstv_late_vld
       or decd_32_src1_vld
       or decd_32_srcf2_vld
       or decd_32_srcf1_vld
       or decd_vec_opivi
       or decd_fp_eu[9:0]
       or decd_perf_dst0_vld
       or decd_16_src0_vld)
begin
  case(decd_sel[5:0])
    6'h1: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_32_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_32_func[`FUNC_WIDTH-1:0]
                                   | {decd_vec_ls_func[3:0],{`FUNC_WIDTH-4{1'b0}}};
      x_decd_dst0_vld              = decd_32_dst0_vld;
      x_decd_dst1_vld              = 1'b0;
      x_decd_dstf_vld              = decd_32_dstf_vld;
      x_decd_dstv_late_vld         = 1'b0;
      x_decd_dstv_vld              = decd_32_dstv_vld;
      x_decd_dste_vld              = decd_32_dste_vld;
      x_decd_src0_vld              = decd_32_src0_vld;
      x_decd_src1_vld              = decd_32_src1_vld;
      x_decd_src1_imm_vld          = decd_32_src1_imm_vld;
      x_decd_src2_vld              = decd_32_src2_vld;
      x_decd_src2_imm_vld          = decd_32_src2_imm_vld;
      x_decd_srcf0_vld             = decd_32_srcf0_vld;
      x_decd_srcf1_vld             = decd_32_srcf1_vld;
      x_decd_srcf2_vld             = decd_32_srcf2_vld;
      x_decd_srcv0_vld             = decd_32_srcv0_vld;
      x_decd_srcv1_vld             = decd_32_srcv1_vld;
      x_decd_srcv2_vld             = decd_32_srcv2_vld;
    end
    6'h2: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_16_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_16_func[`FUNC_WIDTH-1:0];
      x_decd_dst0_vld              = decd_16_dst0_vld;
      x_decd_dst1_vld              = 1'b0;
      x_decd_dstf_vld              = decd_16_dstf_vld;
      x_decd_dstv_late_vld         = 1'b0;
      x_decd_dstv_vld              = 1'b0;
      x_decd_dste_vld              = 1'b0;
      x_decd_src0_vld              = decd_16_src0_vld;
      x_decd_src1_vld              = decd_16_src1_vld;
      x_decd_src1_imm_vld          = decd_16_src1_imm_vld;
      x_decd_src2_vld              = decd_16_src2_vld;
      x_decd_src2_imm_vld          = decd_16_src2_imm_vld;
      x_decd_srcf0_vld             = 1'b0;
      x_decd_srcf1_vld             = decd_16_srcf1_vld;
      x_decd_srcf2_vld             = decd_16_srcf2_vld;
      x_decd_srcv0_vld             = 1'b0;
      x_decd_srcv1_vld             = 1'b0;
      x_decd_srcv2_vld             = 1'b0;
    end
    6'h4: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_fp_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_fp_func[`FUNC_WIDTH-1:0]
                                   | {1'b0,x_inst[14:12],{`FUNC_WIDTH-4{1'b0}}};
      x_decd_dst0_vld              = decd_fp_dst0_vld;
      x_decd_dst1_vld              = 1'b0;
      x_decd_dstf_vld              = decd_fp_dstf_vld;
      x_decd_dstv_late_vld         = 1'b0;
      x_decd_dstv_vld              = 1'b0;
      x_decd_dste_vld              = decd_fp_dste_vld;
      x_decd_src0_vld              = decd_fp_src0_vld;
      x_decd_src1_vld              = decd_fp_src1_vld;
      x_decd_src1_imm_vld          = 1'b0;
      x_decd_src2_vld              = 1'b0;
      x_decd_src2_imm_vld          = 1'b0;
      x_decd_srcf0_vld             = decd_fp_srcf0_vld;
      x_decd_srcf1_vld             = decd_fp_srcf1_vld;
      x_decd_srcf2_vld             = decd_fp_srcf2_vld;
      x_decd_srcv0_vld             = 1'b0;
      x_decd_srcv1_vld             = 1'b0;
      x_decd_srcv2_vld             = 1'b0;
    end
    6'h8: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_cache_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_cache_func[`FUNC_WIDTH-1:0];
      x_decd_dst0_vld              = 1'b0;
      x_decd_dst1_vld              = 1'b0;
      x_decd_dstf_vld              = 1'b0;
      x_decd_dstv_late_vld         = 1'b0;
      x_decd_dstv_vld              = 1'b0;
      x_decd_dste_vld              = 1'b0;
      x_decd_src0_vld              = decd_cache_src0_vld;
      x_decd_src1_vld              = 1'b0;
      x_decd_src1_imm_vld          = 1'b0;
      x_decd_src2_vld              = 1'b0;
      x_decd_src2_imm_vld          = 1'b0;
      x_decd_srcf0_vld             = 1'b0;
      x_decd_srcf1_vld             = 1'b0;
      x_decd_srcf2_vld             = 1'b0;
      x_decd_srcv0_vld             = 1'b0;
      x_decd_srcv1_vld             = 1'b0;
      x_decd_srcv2_vld             = 1'b0;
    end
    6'h10: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_perf_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_perf_func[`FUNC_WIDTH-1:0]
                                   | {{`FUNC_WIDTH-16{1'b0}},decd_lsr_src3_imm[1],10'b0,decd_lsr_src3_imm[0],{4{1'b0}}};
      x_decd_dst0_vld              = decd_perf_dst0_vld;
      x_decd_dst1_vld              = decd_perf_dst1_vld;
      x_decd_dstf_vld              = decd_perf_dstf_vld;
      x_decd_dstv_late_vld         = 1'b0;
      x_decd_dstv_vld              = 1'b0;
      x_decd_dste_vld              = 1'b0;
      x_decd_src0_vld              = decd_perf_src0_vld;
      x_decd_src1_vld              = decd_perf_src1_vld;
      x_decd_src1_imm_vld          = decd_perf_src1_imm_vld;
      x_decd_src2_vld              = decd_perf_src2_vld;
      x_decd_src2_imm_vld          = decd_perf_src2_imm_vld;
      x_decd_srcf0_vld             = 1'b0;
      x_decd_srcf1_vld             = decd_perf_srcf1_vld;
      x_decd_srcf2_vld             = decd_perf_srcf2_vld;
      x_decd_srcv0_vld             = 1'b0;
      x_decd_srcv1_vld             = 1'b0;
      x_decd_srcv2_vld             = 1'b0;
    end
    6'h20: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_vec_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_vec_func[`FUNC_WIDTH-1:0] 
                                   | {decd_vec_special_func[4:0],{`FUNC_WIDTH-5{1'b0}}};
      x_decd_dst0_vld              = decd_vec_dst0_vld;
      x_decd_dst1_vld              = 1'b0;
      x_decd_dstf_vld              = decd_vec_dstf_vld;
      x_decd_dstv_late_vld         = decd_vec_dstv_late_vld;
      x_decd_dstv_vld              = decd_vec_dstv_vld;
      x_decd_dste_vld              = decd_vec_dste_vld;
      x_decd_src0_vld              = decd_vec_src0_vld;
      x_decd_src1_vld              = decd_vec_src1_vld;
      x_decd_src1_imm_vld          = decd_vec_opivi;
      x_decd_src2_vld              = decd_vec_src2_vld;
      x_decd_src2_imm_vld          = 1'b0;
      x_decd_srcf0_vld             = decd_vec_srcf0_vld;
      x_decd_srcf1_vld             = decd_vec_srcf1_vld;
      x_decd_srcf2_vld             = decd_vec_srcf2_vld;
      x_decd_srcv0_vld             = decd_vec_srcv0_vld;
      x_decd_srcv1_vld             = decd_vec_srcv1_vld;
      x_decd_srcv2_vld             = decd_vec_srcv2_vld;
    end
    default: begin
      x_decd_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'bx}};
      x_decd_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'bx}};
      x_decd_dst0_vld              = 1'bx;
      x_decd_dst1_vld              = 1'bx;
      x_decd_dstf_vld              = 1'bx;
      x_decd_dstv_late_vld         = 1'bx;
      x_decd_dstv_vld              = 1'bx;
      x_decd_dste_vld              = 1'bx;
      x_decd_src0_vld              = 1'bx;
      x_decd_src1_vld              = 1'bx;
      x_decd_src1_imm_vld          = 1'bx;
      x_decd_src2_vld              = 1'bx;
      x_decd_src2_imm_vld          = 1'bx;
      x_decd_srcf0_vld             = 1'bx;
      x_decd_srcf1_vld             = 1'bx;
      x_decd_srcf2_vld             = 1'bx;
      x_decd_srcv0_vld             = 1'bx;
      x_decd_srcv1_vld             = 1'bx;
      x_decd_srcv2_vld             = 1'bx;
    end
  endcase
// &CombEnd; @904
end

//----------------------------------------------------------
//                   16 bits Full Decoder
//----------------------------------------------------------
// &CombBeg; @909
always @( x_inst[1:0]
       or x_inst[15:2])
begin
  //initialize decoded information value
  decd_16_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_16_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_16_dst0_vld              = 1'b0;
  decd_16_dstf_vld              = 1'b0;
  decd_16_src0_vld              = 1'b0;
  decd_16_src1_vld              = 1'b0;
  decd_16_src1_imm_vld          = 1'b0;
  decd_16_src2_vld              = 1'b0;
  decd_16_src2_imm_vld          = 1'b0;
  decd_16_srcf1_vld             = 1'b0;
  decd_16_srcf2_vld             = 1'b0;
  //illegal instruction
  decd_16_illegal               = 1'b0;

  casez({x_inst[15:10], x_inst[6:5], x_inst[1:0]})
    //16-bits instructions decode logic
    10'b000???_??00:begin //c.addi4spn
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_ADDI4SPN;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b001???_??00:begin //c.fld
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_FLD;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dstf_vld              = 1'b1;
      end
    10'b010???_??00:begin //c.lw
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_LW;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b011???_??00:begin //c.ld
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_LD;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b101???_??00:begin //c.fsd
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_FSD;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_srcf2_vld             = 1'b1;
      end
    10'b110???_??00:begin //c.sw
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_SW;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_src2_vld              = 1'b1;
      end
    10'b111???_??00:begin //c.sd
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_SD;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_src2_vld              = 1'b1;
      end
    10'b000???_??01:begin //c.addi / c.nop
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_ADDI;
      decd_16_src0_vld              = (x_inst[11:7] != 5'b0);
      decd_16_src1_imm_vld          = (x_inst[11:7] != 5'b0);
      decd_16_dst0_vld              = (x_inst[11:7] != 5'b0);
      end
    10'b001???_??01:begin //c.addiw
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_ADDIW;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b010???_??01:begin //c.li
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_LI;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b011???_??01:begin //c.addi16sp, c.lui
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = (x_inst[11:7] == 5'd2) ? `FUNC_C_ADDI16SP
                                                             : `FUNC_C_LUI;
      decd_16_src0_vld              = (x_inst[11:7] == 5'd2);
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b100?00_??01:begin //c.srli
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_SRLI;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b100?01_??01:begin //c.srai
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_SRAI;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b100?10_??01:begin //c.andi
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_ANDI;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b100011_0001:begin //c.sub
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_SUB;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_vld              = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b100011_0101:begin //c.xor
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_XOR;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_vld              = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b100011_1001:begin //c.or
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_OR;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_vld              = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b100011_1101:begin //c.and
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_AND;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_vld              = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b100111_0001:begin //c.subw
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_SUBW;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_vld              = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b100111_0101:begin //c.addw
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_ADDW;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_vld              = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b101???_??01:begin //c.j
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_J;
      decd_16_src2_imm_vld          = 1'b1;
      end
    10'b110???_??01:begin //c.beqz
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_BEQZ;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_src2_imm_vld          = 1'b1;
      decd_16_src0_vld              = 1'b1;
      end
    10'b111???_??01:begin //c.bnez
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_BNEZ;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_src2_imm_vld          = 1'b1;
      decd_16_src0_vld              = 1'b1;
      end
    10'b000???_??10:begin //c.slli
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_SLLI;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b001???_??10:begin //c.fldsp
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_FLDSP;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dstf_vld              = 1'b1;
      end
    10'b010???_??10:begin //c.lwsp
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_LWSP;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b011???_??10:begin //c.ldsp
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_LDSP;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_dst0_vld              = 1'b1;
      end
    10'b1000??_??10:begin //c.jr / c.mv
      decd_16_eu[`EU_WIDTH-1:0]     = (x_inst[6:2] == 5'b0) ? `EU_BJU : `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = (x_inst[6:2] == 5'b0) ? `FUNC_C_JR
                                                            : `FUNC_C_MV;
      decd_16_src1_imm_vld          = (x_inst[6:2] != 5'b0);
      decd_16_src2_imm_vld          = (x_inst[6:2] == 5'b0);
      decd_16_src0_vld              = 1'b1;
      decd_16_dst0_vld              = (x_inst[6:2] != 5'b0);
      end
    10'b1001??_??10:begin //c.jalr / c.add //c.ebreak
      decd_16_eu[`EU_WIDTH-1:0]     = (x_inst[6:2] == 5'b0)
                                      ? ((x_inst[11:7] == 5'b0) ? `EU_CP0 : `EU_BJU)
                                      : `EU_ALU;
      decd_16_func[`FUNC_WIDTH-1:0] = (x_inst[6:2] == 5'b0)
                                      ? ((x_inst[11:7] == 5'b0) ? `FUNC_EBREAK :  `FUNC_C_JALR)
                                      :  `FUNC_C_ADD;
      decd_16_src0_vld              = (x_inst[11:7] != 5'b0);
      decd_16_src2_imm_vld          = (x_inst[6:2] == 5'b0) && (x_inst[11:7] != 5'b0);
      decd_16_src1_vld              = (x_inst[11:7] != 5'b0)
                                      && (x_inst[6:2] != 5'b0);
      decd_16_dst0_vld              = (x_inst[11:2] != 10'b0000011100);
      end
    10'b101???_??10:begin //c.fsdsp
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_FSDSP;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_srcf2_vld             = 1'b1;
      end
    10'b110???_??10:begin //c.swsp
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_SWSP;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_src2_vld              = 1'b1;
      end
    10'b111???_??10:begin //c.sdsp
      decd_16_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_16_func[`FUNC_WIDTH-1:0] = `FUNC_C_SDSP;
      decd_16_src0_vld              = 1'b1;
      decd_16_src1_imm_vld          = 1'b1;
      decd_16_src2_vld              = 1'b1;
      end
    default:begin                //invalid instruction
      //deal in fence
      decd_16_illegal               = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @1171
end


//----------------------------------------------------------
//                   32 bits Full Decoder
//----------------------------------------------------------
// &CombBeg; @1177
always @( x_inst[14:12]
       or x_inst[31:25]
       or x_inst[6:2]
       or x_inst[20])
begin
  //initialize decoded information value
  decd_32_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_32_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_32_dst0_vld              = 1'b0;
  decd_32_dstf_vld              = 1'b0;
  decd_32_dste_vld              = 1'b0;
  decd_32_src0_vld              = 1'b0;
  decd_32_src1_vld              = 1'b0;
  decd_32_src1_imm_vld          = 1'b0;
  decd_32_src2_vld              = 1'b0;
  decd_32_src2_imm_vld          = 1'b0;
  decd_32_srcf0_vld             = 1'b0;
  decd_32_srcf1_vld             = 1'b0;
  decd_32_srcf2_vld             = 1'b0;
  decd_32_srcv0_vld             = 1'b0;
  decd_32_srcv1_vld             = 1'b0;
  decd_32_srcv2_vld             = 1'b0;
  decd_32_dstv_vld              = 1'b0;
  //illegal instruction
  decd_32_illegal               = 1'b0;

  casez({x_inst[31:25], x_inst[14:12], x_inst[6:2]})
    //16-bits instructions decode logic
    //32-bits instructions decode logic
    15'b?????_?????01101:begin //lui
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LUI;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b??????????00101:begin //auipc
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AUIPC;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b??????????11011:begin //jal (dst0_vlddeal in split)
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_JAL;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????00011001:begin //jalr (dst0_vlddeal in split)
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_JALR;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????00011000:begin //beq
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BEQ;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    15'b???????00111000:begin //bne
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BNE;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    15'b???????10011000:begin //blt
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BLT;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    15'b???????10111000:begin //bge
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BGE;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    15'b???????11011000:begin //bltu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BLTU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    15'b???????11111000:begin //bgeu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BGEU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    15'b???????00000000:begin //lb
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????00100000:begin //lh
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????01000000:begin //lw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????01100000:begin //ld
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????10000000:begin //lbu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LBU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????10100000:begin //lhu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LHU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????11000000:begin //lwu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????00100001:begin //flh
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    15'b???????01000001:begin //flw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    15'b???????01100001:begin //fld
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    15'b???????00001000:begin //sb
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    15'b???????00101000:begin //sh
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    15'b???????01001000:begin //sw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    15'b???????01101000:begin //sd
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    15'b???????00101001:begin //fsh
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSH; 
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    15'b???????01001001:begin //fsw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    15'b???????01101001:begin //fsd
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    15'b???????00000100:begin //addi
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDDI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????01000100:begin //slti
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLTI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????01100100:begin //sltiu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLTIU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????10000100:begin //xori
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_XORI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????11000100:begin //ori
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ORI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????11100100:begin //andi
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ANDI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000?00100100:begin //slli
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLLI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000?10100100:begin //srli
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRLI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b010000?10100100:begin //srai
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRAI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????00000110:begin //addiw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000000100110:begin //slliw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLLIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000010100110:begin //srliw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRLIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b010000010100110:begin //sraiw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRAIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000000001110:begin //addw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b010000000001110:begin //subw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SUBW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000000101110:begin //sllw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLLW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000010101110:begin //srlw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRLW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b010000010101110:begin //sraw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRAW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000000001100:begin //add
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b010000000001100:begin //sub
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SUB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000000101100:begin //sll
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLL;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000001001100:begin //slt
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLT;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000001101100:begin //sltu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLTU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000010001100:begin //xor
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_XOR;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000010101100:begin //srl
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRL;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b010000010101100:begin //sra
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRA;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000011001100:begin //or
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_OR;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000011101100:begin //and
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AND;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000100001100:begin //mul
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MUL;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000100101100:begin //mulh
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000101001100:begin //mulhsu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULHSU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000101101100:begin //mulhu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULHU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000110001100:begin //div
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DIV;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000110101100:begin //divu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DIVU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000111001100:begin //rem
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REM;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000111101100:begin //remu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REMU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000100001110:begin //mulw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000110001110:begin //divw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DIVW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000110101110:begin //divuw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DIVUW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000111001110:begin //remw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REMW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b000000111101110:begin //remuw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REMUW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b00010??01001011:begin //lr.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LR_W;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b00011??01001011:begin //sc.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SC_W;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b00000??01001011:begin //amoadd.w
      //deal in fence / split
      end
    15'b00001??01001011:begin //amoswap.w
      //deal in fence / split
      end
    15'b00100??01001011:begin //amoxor.w
      //deal in fence / split
      end
    15'b01100??01001011:begin //amoand.w
      //deal in fence / split
      end
    15'b01000??01001011:begin //amoor.w
      //deal in fence / split
      end
    15'b10000??01001011:begin //amomin.w
      //deal in fence / split
      end
    15'b10100??01001011:begin //amomax.w
      //deal in fence / split
      end
    15'b11000??01001011:begin //amominu.w
      //deal in fence / split
      end
    15'b11100??01001011:begin //amomaxu.w
      //deal in fence / split
      end
    15'b00010??01101011:begin //lr.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LR_D;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b00011??01101011:begin //sc.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SC_D;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b00000??01101011:begin //amoadd.d
      //deal in fence / split
      end
    15'b00001??01101011:begin //amoswap.d
      //deal in fence / split
      end
    15'b00100??01101011:begin //amoxor.d
      //deal in fence / split
      end
    15'b01100??01101011:begin //amoand.d
      //deal in fence / split
      end
    15'b01000??01101011:begin //amoor.d
      //deal in fence / split
      end
    15'b10000??01101011:begin //amomin.d
      //deal in fence / split
      end
    15'b10100??01101011:begin //amomax.d
      //deal in fence / split
      end
    15'b11000??01101011:begin //amominu.d
      //deal in fence / split
      end
    15'b11100??01101011:begin //amomaxu.d
      //deal in fence / split
      end
    15'b???????00000011:begin //fence
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FENCE;
      end
    15'b???????00100011:begin //fence.i
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FENCEI;
      end
    15'b000000000011100:begin //ecall ebreak
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = x_inst[20] ? `FUNC_EBREAK
                                                 : `FUNC_ECALL;
      end
    15'b011110100011100:begin //dret
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DRET;
      end
    15'b000100000011100:begin //sret wfi
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = x_inst[20] ? `FUNC_WFI
                                                 : `FUNC_SRET;
      end
    15'b000100100011100:begin //sfence.vma
      //deal in fence / split
      end
    15'b001100000011100:begin //mret
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MRET;
      end
    15'b???????00111100:begin //csrrw
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CSRRW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????01011100:begin //csrrs
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CSRRS;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????01111100:begin //csrrc
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CSRRC;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????10111100:begin //csrwi
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CSRRWI;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????11011100:begin //csrsi
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CSRRSI;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    15'b???????11111100:begin //csrci
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CSRRCI;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    default:begin                //invalid instruction
      //deal in fence
      decd_32_illegal               = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @2150
end

//----------------------------------------------------------
//       FP part0 Full Decoder(except fused multiply add)
//----------------------------------------------------------
// &CombBeg; @2155
always @( x_inst[14:12]
       or x_inst[31:20])
begin
  //initialize decoded information value
  decd_fp0_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_fp0_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_fp0_dst0_vld              = 1'b0;
  decd_fp0_dstf_vld              = 1'b0;
  decd_fp0_dste_vld              = 1'b0;
  decd_fp0_src0_vld              = 1'b0;
  decd_fp0_src1_vld              = 1'b0;
  decd_fp0_srcf0_vld             = 1'b0;
  decd_fp0_srcf1_vld             = 1'b0;
  //illegal instruction
  decd_fp0_illegal               = 1'b0;

  casez({x_inst[31:20], x_inst[14:12]})
    15'b0001010????????: begin  //fmul.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMULH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
     15'b0000010????????: begin  //fadd.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FADDH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0000110????????: begin  //fsub.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSUBH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0001110????????: begin  //fdiv.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FDSU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FDIVH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b010111000000???: begin  //fsqrt.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FDSU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSQRTH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b0;
      end
    15'b0010010?????000: begin  //fsgnj.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSGNJH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010010?????001: begin  //fsgnjn.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSGNJNH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010010?????010: begin  //fsgnjx.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSGNJXH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010110?????000: begin  //fmin.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMINH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010110?????001: begin  //fmax.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMAXH;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b110001000000???: begin  //fcvt.w.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_SI32_F16;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b110001000001???: begin  //fcvt.wu.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_UI32_F16;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b111001000000000: begin  //fmv.x.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMV_SI16_F16;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b1010010?????010: begin //feq.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FEQH;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b1010010?????001: begin //flt.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FLTH;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b1010010?????000: begin //fle.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FLEH;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b111001000000001: begin //fclass.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCLASSH;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b110101000000???: begin //fcvt.h.w
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F16_SI32;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110101000001???: begin //fcvt.h.wu
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F16_UI32;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b111101000000000: begin  //fmv.h.x
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMV_F16_SI16;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;
      end
    15'b110001000010???: begin //fcvt.l.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_SI64_F16;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110001000011???: begin //fcvt.lu.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_UI64_F16;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110101000010???: begin //fcvt.h.l
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F16_SI64;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110101000011???: begin //fcvt.h.lu
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F16_UI64;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b010000000010???: begin //fcvt.s.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F32_F16;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b010001000000???: begin //fcvt.h.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F16_F32;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b0;
      end
    15'b010000100010???: begin //fcvt.d.h
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F64_F16;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b0;
      end
    15'b010001000001???: begin //fcvt.h.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F16_F64;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b0;
      end

    15'b0000000????????: begin  //fadd.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FADDS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0000100????????: begin  //fsub.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSUBS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0001000????????: begin  //fmul.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMULS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0001100????????: begin  //fdiv.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FDSU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FDIVS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b010110000000???: begin  //fsqrt.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FDSU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSQRTS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b0;
      end
    15'b0010000?????000: begin  //fsgnj.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSGNJS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010000?????001: begin  //fsgnjn.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSGNJNS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010000?????010: begin //fsgnjx.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSGNJXS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010100?????000: begin //fmin.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMINS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010100?????001: begin //fmax.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMAXS;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b110000000000???: begin //fcvt.w.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_SI32_F32;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b110000000001???: begin //fcvt.wu.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_UI32_F32;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b111000000000000: begin //fmv.x.w
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMV_SI32_F32;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b1010000?????010: begin //feq.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FEQS;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b1010000?????001: begin //flt.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FLTS;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b1010000?????000: begin //fle.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FLES;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b111000000000001: begin //fclass.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCLASSS;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b110100000000???: begin //fcvt.s.w
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F32_SI32;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110100000001???: begin //fcvt.s.wu
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F32_UI32;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b111100000000000: begin  //fmv.w.x
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMV_F32_SI32;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;
      end
    15'b110000000010???: begin //fcvt.l.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_SI64_F32;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110000000011???: begin //fcvt.lu.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_UI64_F32;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110100000010???: begin //fcvt.s.l
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F32_SI64;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110100000011???: begin //fcvt.s.lu
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F32_UI64;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b0000001????????: begin  //fadd.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FADDD;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0000101????????: begin  //fsub.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSUBD;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0001001????????: begin  //fmul.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMULD;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0001101????????: begin  //fdiv.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FDSU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FDIVD;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b010110100000???: begin  //fsqrt.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FDSU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSQRTD;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b0;
      end
    15'b0010001?????000: begin  //fsgnj.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSGNJD;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010001?????001: begin  //fsgnjn.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSGNJND;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010001?????010: begin //fsgnjx.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FSGNJXD;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010101?????000: begin //fmin.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMIND;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b0010101?????001: begin //fmax.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMAXD;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b010000000001???: begin //fcvt.s.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F32_F64;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b0;
      end
    15'b010000100000???: begin //fcvt.d.s
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F64_F32;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b0;
      end
    15'b1010001?????010: begin //feq.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FEQD;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b1010001?????001: begin //flt.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FLTD;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b1010001?????000: begin //fle.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FALU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FLED;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_dste_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      decd_fp0_srcf1_vld             = 1'b1;
      end
    15'b111000100000001: begin //fclass.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCLASSD;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b110000100000???: begin //fcvt.w.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_SI32_F64;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110000100001???: begin //fcvt.wu.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_UI32_F64;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110100100000???: begin //fcvt.d.w
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F64_SI32;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110100100001???: begin //fcvt.d.wu
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F64_UI32;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110000100010???: begin //fcvt.l.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_SI64_F64;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110000100011???: begin //fcvt.lu.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_UI64_F64;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b111000100000000: begin //fmv.x.d
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMV_SI64_F64;
      decd_fp0_dst0_vld              = 1'b1;
      decd_fp0_srcf0_vld             = 1'b1;
      end
    15'b110100100010???: begin //fcvt.d.l
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F64_SI64;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b110100100011???: begin //fcvt.d.lu
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FCVT;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCVT_F64_UI64;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;      
      decd_fp0_dste_vld              = 1'b1;      
      end
    15'b111100100000000: begin  //fmv.d.x
      decd_fp0_eu[`EU_WIDTH-1:0]     = `EU_FSPU;
      decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FMV_F64_SI64;
      decd_fp0_dstf_vld              = 1'b1;
      decd_fp0_src1_vld              = 1'b1;
      end
    default:             begin  //invalid instruction
      //deal in fence
      decd_fp0_illegal               = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @2749
end

//----------------------------------------------------------
//       FP part1 Full Decoder(fused multiply add)
//----------------------------------------------------------
// &CombBeg; @2754
always @( x_inst[4:2]
       or x_inst[26:25])
begin
  //initialize decoded information value
  decd_fp1_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_fp1_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_fp1_dst0_vld              = 1'b0;
  decd_fp1_dstf_vld              = 1'b0;
  decd_fp1_dste_vld              = 1'b0;
  decd_fp1_src0_vld              = 1'b0;
  decd_fp1_srcf0_vld             = 1'b0;
  decd_fp1_srcf1_vld             = 1'b0;
  decd_fp1_srcf2_vld             = 1'b0;
  //illegal instruction
  decd_fp1_illegal               = 1'b0;

  casez({x_inst[26:25], x_inst[4:2]})
    5'b10000: begin //fmadd.h
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FMADDH;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b10001: begin //fmsub.h
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FMSUBH;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b10010: begin //fnmsub.h
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FNMSUBH;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b10011: begin //fnmadd.h
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FNMADDH;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b00000: begin //fmadd.s
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FMADDS;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b00001: begin //fmsub.s
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FMSUBS;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b00010: begin //fnmsub.s
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FNMSUBS;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b00011: begin //fnmadd.s
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FNMADDS;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b01000: begin //fmadd.d
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FMADDD;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b01001: begin //fmsub.d
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FMSUBD;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b01010: begin //fnmsub.d
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FNMSUBD;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    5'b01011: begin //fnmadd.d
      decd_fp1_eu[`EU_WIDTH-1:0]     = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0] = `FUNC_FNMADDD;
      decd_fp1_dstf_vld              = 1'b1;
      decd_fp1_dste_vld              = 1'b1;
      decd_fp1_srcf0_vld             = 1'b1;
      decd_fp1_srcf1_vld             = 1'b1;
      decd_fp1_srcf2_vld             = 1'b1;
      end
    default:             begin  //invalid instruction
      //deal in fence
      decd_fp1_illegal               = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @2883
end

assign decd_fp0_sel = x_inst[6:0] == 7'b1010011;
assign decd_fp1_sel = {x_inst[6:4],x_inst[1:0]} == 5'b10011;

// &CombBeg; @2888
always @( decd_fp1_eu[9:0]
       or decd_fp0_dst0_vld
       or decd_fp1_sel
       or decd_fp0_src1_vld
       or decd_fp0_srcf1_vld
       or decd_fp0_src0_vld
       or decd_fp0_func[19:0]
       or decd_fp0_illegal
       or decd_fp0_sel
       or decd_fp1_func[19:0]
       or decd_fp1_dste_vld
       or decd_fp1_illegal
       or decd_fp1_srcf2_vld
       or decd_fp0_dstf_vld
       or decd_fp1_dstf_vld
       or decd_fp0_srcf0_vld
       or decd_fp1_srcf1_vld
       or decd_fp0_eu[9:0]
       or decd_fp1_src0_vld
       or decd_fp1_dst0_vld
       or decd_fp0_dste_vld
       or decd_fp1_srcf0_vld)
begin
  case({decd_fp1_sel,decd_fp0_sel})
    2'h1: begin
      decd_fp_eu[`EU_WIDTH-1:0]     = decd_fp0_eu[`EU_WIDTH-1:0];
      decd_fp_func[`FUNC_WIDTH-1:0] = decd_fp0_func[`FUNC_WIDTH-1:0];
      decd_fp_dst0_vld              = decd_fp0_dst0_vld;
      decd_fp_dstf_vld              = decd_fp0_dstf_vld;
      decd_fp_dste_vld              = decd_fp0_dste_vld;
      decd_fp_src0_vld              = decd_fp0_src0_vld;
      decd_fp_src1_vld              = decd_fp0_src1_vld;
      decd_fp_srcf0_vld             = decd_fp0_srcf0_vld;
      decd_fp_srcf1_vld             = decd_fp0_srcf1_vld;
      decd_fp_srcf2_vld             = 1'b0;
      decd_fp_inst_illegal          = decd_fp0_illegal;
    end
    2'h2: begin
      decd_fp_eu[`EU_WIDTH-1:0]     = decd_fp1_eu[`EU_WIDTH-1:0];
      decd_fp_func[`FUNC_WIDTH-1:0] = decd_fp1_func[`FUNC_WIDTH-1:0];
      decd_fp_dst0_vld              = decd_fp1_dst0_vld;
      decd_fp_dstf_vld              = decd_fp1_dstf_vld;
      decd_fp_dste_vld              = decd_fp1_dste_vld;
      decd_fp_src0_vld              = decd_fp1_src0_vld;
      decd_fp_src1_vld              = 1'b0;
      decd_fp_srcf0_vld             = decd_fp1_srcf0_vld;
      decd_fp_srcf1_vld             = decd_fp1_srcf1_vld;
      decd_fp_srcf2_vld             = decd_fp1_srcf2_vld;
      decd_fp_inst_illegal          = decd_fp1_illegal;
    end
    default: begin
      decd_fp_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'bx}};
      decd_fp_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'bx}};
      decd_fp_dst0_vld              = 1'bx;
      decd_fp_dstf_vld              = 1'bx;
      decd_fp_dste_vld              = 1'bx;
      decd_fp_src0_vld              = 1'bx;
      decd_fp_src1_vld              = 1'bx;
      decd_fp_srcf0_vld             = 1'bx;
      decd_fp_srcf1_vld             = 1'bx;
      decd_fp_srcf2_vld             = 1'bx;
      decd_fp_inst_illegal          = 1'bx;
    end
  endcase
// &CombEnd; @2930
end

//----------------------------------------------------------
//              Cache Extension Full Decoder
//----------------------------------------------------------
// &CombBeg; @2935
always @( cp0_idu_ucme
       or cp0_yy_priv_mode[1:0]
       or rtu_yy_xx_dbgon
       or x_inst[25:15])
begin
  //initialize decoded information value
  decd_cache_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_cache_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_cache_src0_vld              = 1'b0;
  //illegal instruction
  decd_cache_illegal               = 1'b0;

  casez({x_inst[25],x_inst[24:20],x_inst[19:15]})
    //32-bits instructions decode logic
    11'b0_00010_00000:begin //dcache.iall
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_IALL;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b0_00001_00000:begin //dcache.call
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CALL;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b0_00011_00000:begin //dcache.ciall
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CIALL;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b1_00010_?????:begin //dcache.isw
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_ISW;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b1_00001_?????:begin //dcache.csw
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CSW;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b1_00011_?????:begin //dcache.cisw
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CISW;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b1_00110_?????:begin //dcache.iva
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_IVA;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b1_00101_?????:begin //dcache.cva
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CVA;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && (!cp0_idu_ucme && !rtu_yy_xx_dbgon);
      end
    11'b1_00100_?????:begin //dcache.cval1
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CVAL1;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && (!cp0_idu_ucme && !rtu_yy_xx_dbgon);
      end
    11'b1_00111_?????:begin //dcache.civa
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CIVA;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && (!cp0_idu_ucme && !rtu_yy_xx_dbgon);
      end
    11'b1_01010_?????:begin //dcache.ipa
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_IPA;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b1_01001_?????:begin //dcache.cpa
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CPA;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b1_01000_?????:begin //dcache.cpal1
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CPAL1;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b1_01011_?????:begin //dcache.cipa
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_DCACHE_CIPA;
      decd_cache_src0_vld              = 1'b1;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b0_10000_00000:begin //icache.iall
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_FENCEI;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b0_10001_00000:begin //icache.ialls
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_FENCEI;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b1_10000_?????:begin //icache.iva
      //deal in fence / split
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && (!cp0_idu_ucme && !rtu_yy_xx_dbgon);
      end
    11'b1_11000_?????:begin //icache.ipa
      //deal in fence / split
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b0_10110_00000:begin //l2cache.iall
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_CACHE;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b0_10101_00000:begin //l2cache.call
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_CACHE;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b0_10111_00000:begin //l2cache.ciall
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_CACHE;
      decd_cache_illegal               = cp0_yy_priv_mode[1:0] == 2'b0
                                      && !rtu_yy_xx_dbgon;
      end
    11'b0_11000_00000:begin //sync
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_SYNC;
      end
    11'b0_11001_00000:begin //sync.s
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_SYNC;
      end
    11'b0_11010_00000:begin //sync.i
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_SYNCI;
      end
    11'b0_11011_00000:begin //sync.is
      decd_cache_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_cache_func[`FUNC_WIDTH-1:0] = `FUNC_SYNCI;
      end
    default: begin                //invalid instruction
      //deal in fence
      decd_cache_illegal               = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @3102
end

//----------------------------------------------------------
//           Performance Extension Full Decoder
//----------------------------------------------------------
// &CombBeg; @3107
always @( x_inst[14:12]
       or x_inst[31:25])
begin
  //initialize decoded information value
  decd_perf_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_perf_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_perf_src0_vld              = 1'b0;
  decd_perf_src1_vld              = 1'b0;
  decd_perf_src1_imm_vld          = 1'b0;
  decd_perf_src2_vld              = 1'b0;
  decd_perf_src2_imm_vld          = 1'b0;
  decd_perf_dst0_vld              = 1'b0;
  decd_perf_dst1_vld              = 1'b0;
  decd_perf_srcf1_vld             = 1'b0;
  decd_perf_srcf2_vld             = 1'b0;
  decd_perf_dstf_vld              = 1'b0;
  //illegal instruction
  decd_perf_illegal               = 1'b0;

  casez({x_inst[31:25],x_inst[14:12]})
    //32-bits instructions decode logic
    10'b00000??001:begin //addsl
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_ADDSL;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src2_imm_vld          = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b000100?001:begin //srri
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SRRI;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b0001010001:begin //srriw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SRRIW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b1000000001:begin //tstnbz
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_TSTNBZ;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b1000001001:begin //rev
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_REV;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b1000010001:begin //ff0
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FF0;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b1000011001:begin //ff1
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FF1;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b100010?001:begin //tst
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_TST;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b1001000001:begin //revw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_REVW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b0100000001:begin //mveqz
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_MVEQZ;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b0100001001:begin //mvnez
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_MVNEZ;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b0010000001:begin //mula
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_MULA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b0010001001:begin //muls
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_MULS;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b0010010001:begin //mulaw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_MULAW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b0010011001:begin //mulsw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_MULSW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b0010100001:begin //mulah
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_MULAH;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b0010101001:begin //mulsh
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_MULSH;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b???????010:begin //ext
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_EXT;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b???????011:begin //extu
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_EXTU;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b00000??100:begin //lrb
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LRB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b00100??100:begin //lrh
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LRH;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b01000??100:begin //lrw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LRW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b01100??100:begin //lrd
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LRD;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b10000??100:begin //lrbu
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LRBU;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b10100??100:begin //lrhu
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LRHU;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b11000??100:begin //lrwu
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LRWU;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b00010??100:begin //lurb
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LURB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b00110??100:begin //lurh
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LURH;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b01010??100:begin //lurw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LURW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b01110??100:begin //lurd
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LURD;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b10010??100:begin //lurbu
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LURBU;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b10110??100:begin //lurhu
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LURHU;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b11010??100:begin //lurwu
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LURWU;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      end
    10'b00001??100:begin //lbib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LBIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b00011??100:begin //lbia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LBIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b00101??100:begin //lhib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LHIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b00111??100:begin //lhia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LHIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b01001??100:begin //lwib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LWIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b01011??100:begin //lwia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LWIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b01101??100:begin //ldib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LDIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b01111??100:begin //ldia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LDIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b10001??100:begin //lbuib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LBUIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b10011??100:begin //lbuia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LBUIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b10101??100:begin //lhuib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LHUIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b10111??100:begin //lhuia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LHUIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b11001??100:begin //lwuib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LWUIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b11011??100:begin //lwuia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_LWUIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_dst0_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b11100??100:begin //lwd
      //deal in fence / split
      end
    10'b11110??100:begin //lwud
      //deal in fence / split
      end
    10'b11111??100:begin //ldd
      //deal in fence / split
      end
    10'b00000??101:begin //srb
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SRB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      end
    10'b00100??101:begin //srh
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SRH;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      end
    10'b01000??101:begin //srw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SRW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      end
    10'b01100??101:begin //srd
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SRD;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      end
    10'b00010??101:begin //surb
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SURB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      end
    10'b00110??101:begin //surh
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SURH;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      end
    10'b01010??101:begin //surw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SURW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      end
    10'b01110??101:begin //surd
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SURD;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      end
    10'b00001??101:begin //sbib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SBIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b00011??101:begin //sbia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SBIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b00101??101:begin //shib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SHIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b00111??101:begin //shia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SHIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b01001??101:begin //swib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SWIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b01011??101:begin //swia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SWIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b01101??101:begin //sdib
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SDIB;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b01111??101:begin //sdia
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_SDIA;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_imm_vld          = 1'b1;
      decd_perf_src2_vld              = 1'b1;
      decd_perf_dst1_vld              = 1'b1;
      end
    10'b11100??101:begin //swd
      //deal in fence / split
      end
    10'b11111??101:begin //sdd
      //deal in fence / split
      end
    10'b01000??110:begin //flrw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FLRW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dstf_vld              = 1'b1;
      end
    10'b01100??110:begin //flrd
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FLRD;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dstf_vld              = 1'b1;
      end
    10'b01010??110:begin //flurw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FLURW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dstf_vld              = 1'b1;
      end
    10'b01110??110:begin //flurd
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FLURD;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_dstf_vld              = 1'b1;
      end
    10'b01000??111:begin //fsrw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FSRW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_srcf2_vld             = 1'b1;
      end
    10'b01100??111:begin //fsrd
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FSRD;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_srcf2_vld             = 1'b1;
      end
    10'b01010??111:begin //fsurw
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FSURW;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_srcf2_vld             = 1'b1;
      end
    10'b01110??111:begin //fsurd
      decd_perf_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_perf_func[`FUNC_WIDTH-1:0] = `FUNC_FSURD;
      decd_perf_src0_vld              = 1'b1;
      decd_perf_src1_vld              = 1'b1;
      decd_perf_srcf2_vld             = 1'b1;
      end

    default: begin                //invalid instruction
      //deal in fence
      decd_perf_illegal               = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @3673
end


//==========================================================
//                 Vector inst info
//==========================================================
assign decd_vec_inst = 1'b0;
assign decd_vec_opivv = (x_inst[14:12] == 3'b000);
assign decd_vec_opivx = (x_inst[14:12] == 3'b100);
assign decd_vec_opivi = (x_inst[14:12] == 3'b011);
assign decd_vec_opmvv = (x_inst[14:12] == 3'b010);
assign decd_vec_opmvx = (x_inst[14:12] == 3'b110);
assign decd_vec_opfvv = (x_inst[14:12] == 3'b001);
assign decd_vec_opfvf = (x_inst[14:12] == 3'b101);
assign decd_vec_opcfg = (x_inst[14:12] == 3'b111);
assign decd_vec_opiv  = decd_vec_opivv || decd_vec_opivx || decd_vec_opivi;
assign decd_vec_opmv  = decd_vec_opmvv || decd_vec_opmvx;
assign decd_vec_opfv  = decd_vec_opfvv || decd_vec_opfvf;
assign decd_vec_opvx  = decd_vec_opivx || decd_vec_opmvx;

assign decd_inst_vec = decd_vec_inst;

assign decd_vec_ls_func[3:0]      = {x_inst[25],x_inst[31:29]} & {4{decd_inst_vls}};
assign decd_vec_special_func[4:0] = {x_inst[25],      //vm
                                     decd_vec_opvx,   //vx
                                     decd_vec_opivi,  //vi
                                     decd_vec_opfvf,  //vf
                                     decd_srcv0_srcv1_switch}; //reverse

assign vec_mfvr_inst = (x_inst[31:26] == 6'b001100) && decd_vec_opmvv ||  //vext.x.v
                       (x_inst[31:26] == 6'b010100) && decd_vec_opmvv ||  //vmpopc
                       (x_inst[31:26] == 6'b010101) && decd_vec_opmvv ||  //vmfirst
                       (x_inst[31:26] == 6'b001100) && decd_vec_opfvv;    //vfmv.f.s

//==========================================================
//       Decode Vector Source Register Index(Including FP)
//==========================================================
//----------------------------------------------------------
//               Vector Source Register Index
//----------------------------------------------------------
// &CombBeg; @3717
always @( x_decd_srcf0_reg[4:0]
       or decd_inst_vec
       or decd_srcv0_srcv1_switch
       or x_inst[24:15])
begin
casez({decd_inst_vec,decd_srcv0_srcv1_switch})
  2'b0?  : x_decd_srcv0_reg[4:0] = x_decd_srcf0_reg[4:0];
  2'b10  : x_decd_srcv0_reg[4:0] = x_inst[24:20];
  2'b11  : x_decd_srcv0_reg[4:0] = x_inst[19:15];
  default: x_decd_srcv0_reg[4:0] = {5{1'bx}};
endcase
// &CombEnd; @3724
end


// &CombBeg; @3727
always @( x_decd_srcf1_reg[4:0]
       or decd_vec_lsu
       or x_inst[11:7]
       or x_vlmul[1:0]
       or decd_inst_vec
       or decd_srcv1_srcv2_switch
       or decd_srcv0_srcv1_switch
       or x_inst[24:15])
begin
casez({decd_vec_lsu,decd_inst_vec,decd_srcv0_srcv1_switch,decd_srcv1_srcv2_switch})
  4'b1??? : x_decd_srcv1_reg[4:0] = x_inst[11:7] + (5'b00001 << x_vlmul[1:0]); 
  4'b00?? : x_decd_srcv1_reg[4:0] = x_decd_srcf1_reg[4:0];
  4'b0100 : x_decd_srcv1_reg[4:0] = x_inst[19:15];
  4'b0101 : x_decd_srcv1_reg[4:0] = x_inst[11:7];
  4'b0110 : x_decd_srcv1_reg[4:0] = x_inst[24:20];
  4'b0111 : x_decd_srcv1_reg[4:0] = x_inst[11:7];
   default: x_decd_srcv1_reg[4:0] = {5{1'bx}};
endcase
// &CombEnd; @3737
end

// &CombBeg; @3739
always @( x_decd_srcf2_reg[4:0]
       or x_inst[11:7]
       or decd_inst_vec
       or decd_srcv1_srcv2_switch
       or decd_srcv0_srcv1_switch
       or x_inst[24:15])
begin
casez({decd_inst_vec,decd_srcv0_srcv1_switch,decd_srcv1_srcv2_switch})
  3'b0??  : x_decd_srcv2_reg[4:0] = x_decd_srcf2_reg[4:0];
  3'b100  : x_decd_srcv2_reg[4:0] = x_inst[11:7];
  3'b101  : x_decd_srcv2_reg[4:0] = x_inst[19:15];
  3'b110  : x_decd_srcv2_reg[4:0] = x_inst[11:7];
  3'b111  : x_decd_srcv2_reg[4:0] = x_inst[24:20];
  default: x_decd_srcv2_reg[4:0] = {5{1'bx}};
endcase
// &CombEnd; @3748
end

assign decd_srcv0_srcv1_switch = ((x_inst[31:26]==6'b000010)                    //vsub
                              || (x_inst[31:26]==6'b010010)                     //vsbc
                              || (x_inst[31:26]==6'b010011)                     //vmsbc
                              || (x_inst[31:26]==6'b011010)                     //vmsltu
                              || (x_inst[31:26]==6'b011011)                     //vmslt
                              || (x_inst[31:26]==6'b100010)                     //vssubu
                              || (x_inst[31:26]==6'b100011)                     //vssub
                              || (x_inst[31:26]==6'b100110))&& decd_vec_opiv    //vasub
                              ||((x_inst[31:26]==6'b101001)                     //vmadd
                              || (x_inst[31:26]==6'b101011)                     //vmsub
                              || (x_inst[31:26]==6'b110010)                     //vwsubu
                              || (x_inst[31:26]==6'b110011)                     //vwsub
                              || (x_inst[31:26]==6'b110110)                     //vwsubu.w
                              || (x_inst[31:26]==6'b110111))&& decd_vec_opmv    //vwsub.w
                              ||((x_inst[31:29]==3'b101   )                     //vfmacc
                              || (x_inst[31:28]==4'b1111  )                     //vfwmacc
                              || (x_inst[31:26]== 6'b100111))&& decd_vec_opfv   //vfrsub 
                              ||((x_inst[31:26]==6'b011101)                     //vmfgt
                              || (x_inst[31:26]==6'b011111)                     //vmfge
                              || (x_inst[31:26]== 6'b100001))&& decd_vec_opfvf  //vrfdiv
                              ||((x_inst[31:26]== 6'b110001)
                              || (x_inst[31:26]== 6'b110011))&& decd_vec_opfvv;

assign decd_srcv1_srcv2_switch = ((x_inst[31:26]== 6'b101001)
                               || (x_inst[31:26]== 6'b101011))&& decd_vec_opmv    
                               || (x_inst[31:28]== 4'b1010) && decd_vec_opfv
                               || (x_inst[31:27]== 5'b11000) && decd_vec_opivv//vwred 
                               || (x_inst[31:29]== 3'b000) && decd_vec_opmvv; //vred

//==========================================================
//            Decode Destination Register Index
//==========================================================
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic
assign x_decd_dstv_reg[4:0]   = (decd_inst_vec) ? x_inst[11:7] : x_decd_dstf_reg[4:0];

//==========================================================
//                 Illegal inst Decoder
//==========================================================
assign decd_vec_vmunary0   =(x_inst[31:26]==6'b010110);
assign decd_vec_vfunary0   =(x_inst[31:26]==6'b100010);
assign decd_vec_vfunary1   =(x_inst[31:26]==6'b100011);

assign decd_vmunary0_vld = (x_inst[19:15] == 5'b00001) //vmbf
                      ||(x_inst[19:15] == 5'b00010) //vmif
                      ||(x_inst[19:15] == 5'b00011) //vmof
                      ||(x_inst[19:15] == 5'b10000) //viota
                      ||(x_inst[19:15] == 5'b10001);//vid

assign decd_vfunary0_vld_norm = (x_inst[19:17] == 3'b000);

assign decd_vfunary0_vld_wide = (x_inst[19:17] == 3'b010) 
                           ||(x_inst[19:15] == 5'b01100);

assign decd_vfunary0_vld_narr = (x_inst[19:17] == 3'b100) 
                           ||(x_inst[19:15] == 5'b10100);

assign decd_vfunary0_vld = decd_vfunary0_vld_norm || decd_vfunary0_vld_wide || decd_vfunary0_vld_narr;

assign decd_vec_inst_funary=(decd_vec_vfunary0 || decd_vec_vfunary1) && decd_vec_opfvv;

assign decd_vec_inst_narr  =(x_inst[31:28]==4'b1011) && (decd_vec_opivv || decd_vec_opivx || decd_vec_opivi) //narrow shift
                      ||  decd_vec_vfunary0 && x_inst[19] && (decd_vec_opfvv);     //narrow fcvt

assign decd_vec_inst_wide_w=(x_inst[31:28]==4'b1101)                    //.w wide
                      && (decd_vec_opmvv || decd_vec_opmvx || decd_vec_opfvv || decd_vec_opfvf);

assign decd_vec_inst_wide  =(x_inst[31:30]==2'b11)                     //widen inst
                      && (decd_vec_opivv || decd_vec_opivx || decd_vec_opmvv 
                       || decd_vec_opmvx || decd_vec_opfvv || decd_vec_opfvf) 
                       || decd_vec_vfunary0 && (x_inst[19:18]==2'b01)  //widen fcnvt           
                      && (decd_vec_opfvv);

assign decd_vec_inst_mask  = (x_inst[31:30]==2'b01) && (decd_vec_opmvv);

assign decd_vec_inst_scalar= (x_inst[31:27]==5'b00110)
                       && (decd_vec_opmvv || decd_vec_opmvx || decd_vec_opfvv || decd_vec_opfvf);

assign decd_vec_inst_vred_n = (x_inst[31:29]==3'b000) && (decd_vec_opmvv)
                        || (x_inst[31:29]==3'b000) && x_inst[26] && (decd_vec_opfvv);

assign decd_vec_inst_vred_w = (x_inst[31:28]==4'b1100)&& (decd_vec_opivv)
                        || (x_inst[31:28]==4'b1100) && x_inst[26] && (decd_vec_opfvv);

assign decd_vec_inst_vred   = decd_vec_inst_vred_n || decd_vec_inst_vred_w;

assign decd_vec_inst_comp = (x_inst[31:28]==4'b0100) && x_inst[26]
                      && (decd_vec_opivv || decd_vec_opivx || decd_vec_opivi)
                      || (x_inst[31:29]==3'b011) 
                      && (decd_vec_opivv || decd_vec_opivx || decd_vec_opivi
                      ||  decd_vec_opfvv || decd_vec_opfvf); 
//----------------------------------------------------------
//              SRCV0 VREG ILLEGAL JUDGE
//----------------------------------------------------------
assign decd_vreg_src0_norm  = !decd_vec_inst_narr && !decd_vec_inst_wide_w
                        &&!(decd_vec_inst_mask && !(x_inst[29:26]==4'b0111)) //not compress inst 
                        && !decd_vec_inst_scalar;

assign decd_vreg_illegal_type[0]= decd_vec_inst_narr   && decd_vreg_ill[3] 
                       || decd_vec_inst_wide_w && decd_vreg_ill[3]
                       || decd_vreg_src0_norm  && decd_vreg_ill[0];

//----------------------------------------------------------
//              SRCV1 VREG ILLEGAL JUDGE
//----------------------------------------------------------
assign decd_vreg_src1_norm  = !decd_vec_inst_mask && !decd_vec_inst_vred
                        && !decd_vec_inst_scalar && !decd_vec_inst_funary
                        &&!(decd_vec_opivx || decd_vec_opivi || decd_vec_opmvx || decd_vec_opfvf);

assign decd_vreg_illegal_type[1] = decd_vreg_src1_norm && decd_vreg_ill[1];

//----------------------------------------------------------
//              DSTV VREG ILLEGAL JUDGE
//----------------------------------------------------------

assign decd_vreg_dst_norm = !decd_vec_inst_vred &&!decd_vec_inst_wide
                      &&(!decd_vec_inst_mask || decd_vec_inst_vcompress 
                       || decd_vec_inst_viota|| decd_vec_inst_vid)
                      && !decd_vec_inst_scalar
                      && !decd_vec_inst_comp;

assign decd_vreg_illegal_type[2]= decd_vec_inst_wide && !decd_vec_inst_vred_w && decd_vreg_ill[4]
                        ||decd_vreg_dst_norm && decd_vreg_ill[2];

assign decd_vreg_illegal = (|decd_vreg_illegal_type[2:0]) && !decd_vec_opcfg;
//----------------------------------------------------------
//               Vreg illegal corncerning LMUL
//----------------------------------------------------------
assign decd_vreg_ill[0] = (x_vlmul[1:0]==2'b01) &&  x_inst[20]    ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[21:20] ||
                       (x_vlmul[1:0]==2'b11) && |x_inst[22:20];  //normal src0 vreg misalgin

assign decd_vreg_ill[1] = (x_vlmul[1:0]==2'b01) &&  x_inst[15]    ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[16:15] ||
                       (x_vlmul[1:0]==2'b11) && |x_inst[17:15];  //normal src1 vreg misalgin

assign decd_vreg_ill[2] = (x_vlmul[1:0]==2'b01) &&  x_inst[7]     ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[8 : 7] ||
                       (x_vlmul[1:0]==2'b11) && |x_inst[9 : 7];  //normal dest vreg misalgin

assign decd_vreg_ill[3] = (x_vlmul[1:0]==2'b00) &&  x_inst[20]    ||
                       (x_vlmul[1:0]==2'b01) && |x_inst[21:20] ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[22:20];  //widen/narrow src0 vreg misalgin

assign decd_vreg_ill[4] = (x_vlmul[1:0]==2'b00) &&  x_inst[7]     ||
                       (x_vlmul[1:0]==2'b01) && |x_inst[8 : 7] ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[9 : 7];  //widen/narrow dest vreg misalgin


assign decd_vec_inst_viota     = decd_vec_vmunary0 && decd_vec_opmvv && (x_inst[19:15]==5'b10000);
assign decd_vec_inst_vid       = decd_vec_vmunary0 && decd_vec_opmvv && (x_inst[19:15]==5'b10001);
assign decd_vec_inst_vcompress =(x_inst[31:26]==6'b010111) && decd_vec_opmvv;
assign decd_vec_inst_slideup   =(x_inst[31:26]==6'b001110) &&(decd_vec_opivx || decd_vec_opivi || decd_vec_opmvx);
assign decd_vec_inst_slidedown =(x_inst[31:26]==6'b001111) &&(decd_vec_opivx || decd_vec_opivi || decd_vec_opmvx);
assign decd_vec_inst_vrgather  =(x_inst[31:26]==6'b001100) &&(decd_vec_opivv || decd_vec_opivx || decd_vec_opivi);
assign decd_vec_inst_adc       =(x_inst[31:28]==4'b0100  ) &&(decd_vec_opivv || decd_vec_opivx || decd_vec_opivi);
//----------------------------------------------------------
//              SRCV0 OVERLAP ILLEGAL JUDGE
//----------------------------------------------------------
assign decd_ovlp_illegal_type[0]= decd_vec_inst_narr  && decd_ovlp_ill[0] 
                       || decd_vec_inst_wide  && !decd_vec_inst_wide_w && !decd_vec_inst_vred && decd_ovlp_ill[0]
                       || decd_vec_inst_comp  && decd_ovlp_ill[2]
                       ||(decd_vec_inst_viota || decd_vec_inst_slideup 
                       || decd_vec_inst_vcompress|| decd_vec_inst_vrgather) && decd_ovlp_ill[4]; 

//----------------------------------------------------------
//              SRCV1 OVERLAP ILLEGAL JUDGE
//----------------------------------------------------------
assign decd_ovlp_illegal_type[1] =(decd_vec_inst_wide  && !decd_vec_inst_vred && !(decd_vec_vfunary0 && decd_vec_opfvv) && decd_ovlp_ill[1]
                        || decd_vec_inst_comp  && decd_ovlp_ill[3]
                        ||(decd_vec_inst_vcompress|| decd_vec_inst_vrgather) && decd_ovlp_ill[5])
                        &&!(decd_vec_opivx || decd_vec_opivi || decd_vec_opmvx || decd_vec_opfvf);

//----------------------------------------------------------
//              SRCVM OVERLAP ILLEGAL JUDGE
//----------------------------------------------------------

assign decd_ovlp_illegal_type[2]= decd_vec_inst_adc  &&  decd_ovlp_ill[6]
                       || decd_vec_inst_wide && !decd_vec_inst_vred && decd_ovlp_ill[7]
                       ||(decd_vec_inst_viota || decd_vec_inst_slideup 
                       || decd_vec_inst_slidedown || decd_vec_inst_vrgather) && decd_ovlp_ill[7]
                       || decd_vec_inst_vid  &&  decd_ovlp_ill[8]
                       || decd_ovlp_ill[8] && !decd_vec_opcfg && !decd_vec_inst_mask;

assign decd_ovlp_illegal = |decd_ovlp_illegal_type[2:0];

//----------------------------------------------------------
//               VREG ovrelap illegal
//----------------------------------------------------------
assign decd_ovlp_ill[0] = (x_vlmul[1:0]==2'b00) && (x_inst[24:21]==x_inst[11: 8]) ||
                          (x_vlmul[1:0]==2'b01) && (x_inst[24:22]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b10) && (x_inst[24:23]==x_inst[11:10]); //vsrc0 overlap with dest when narrow/widen

assign decd_ovlp_ill[1] = (x_vlmul[1:0]==2'b00) && (x_inst[19:16]==x_inst[11: 8]) ||
                          (x_vlmul[1:0]==2'b01) && (x_inst[19:17]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b10) && (x_inst[19:18]==x_inst[11:10]); //vsrc1 overlap with dest when narrow/widen

assign decd_ovlp_ill[2]  =(x_vlmul[1:0]==2'b01) && (x_inst[24:21]==x_inst[11: 8]) || //vsrc0 overlap width dest when lmul>1
                          (x_vlmul[1:0]==2'b10) && (x_inst[24:22]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b11) && (x_inst[24:23]==x_inst[11:10]);

assign decd_ovlp_ill[3]  =(x_vlmul[1:0]==2'b01) && (x_inst[19:16]==x_inst[11: 8]) || //vsrc1 overlap width dest when lmul>1
                          (x_vlmul[1:0]==2'b10) && (x_inst[19:17]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b11) && (x_inst[19:18]==x_inst[11:10]);

assign decd_ovlp_ill[4] = (x_vlmul[1:0]==2'b00) && (x_inst[24:20]==x_inst[11: 7]) || //vsrc0 overlap with dest in all case
                          (x_vlmul[1:0]==2'b01) && (x_inst[24:21]==x_inst[11: 8]) ||
                          (x_vlmul[1:0]==2'b10) && (x_inst[24:22]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b11) && (x_inst[24:23]==x_inst[11:10]);

assign decd_ovlp_ill[5] = (x_vlmul[1:0]==2'b00) && (x_inst[19:15]==x_inst[11: 7]) || //vsrc1 overlap with dest in all case
                          (x_vlmul[1:0]==2'b01) && (x_inst[19:16]==x_inst[11: 8]) ||
                          (x_vlmul[1:0]==2'b10) && (x_inst[19:17]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b11) && (x_inst[19:18]==x_inst[11:10]);

assign decd_ovlp_ill[6]  =(x_inst[11: 7]==5'b0) && !(x_vlmul[1:0]==2'b00);//src3 overlap with dest when LMUL>1
assign decd_ovlp_ill[7]  =(x_inst[11: 7]==5'b0) && !x_inst[25]; //src3 overlap with dest when masked
assign decd_ovlp_ill[8]  =(x_inst[11: 7]==5'b0) && !x_inst[25] && !(x_vlmul[1:0]==2'b00); //src3 overlap with dest when masked and LMUL>1

//----------------------------------------------------------
//               LMUL/SEW illegal for widen and narrow
//----------------------------------------------------------
assign decd_size_ill_case[0] = ((x_vlmul[1:0]==2'b11)||(x_vsew[1]==1'b1))
                           && decd_vec_inst_narr || fcvt_f_x_narrow_il; 

assign decd_size_ill_case[1] = ((x_vlmul[1:0]==2'b11)||(x_vsew[1]==1'b1)) 
                           && decd_vec_inst_wide && !decd_vec_inst_vred_w;

assign decd_size_ill_case[2] = ((x_vsew[1:0]==2'b11)||(x_vsew[1:0]==2'b10))
                           && decd_vec_inst_vred_w; 

assign decd_size_ill_case[3] = (x_vsew[1:0]==2'b00) && (decd_vec_opfvv&&!fcvt_f_x_widden || decd_vec_opfvf) || (x_vsew[1:0]== 2'b11);
assign fcvt_f_x_widden       = (x_inst[31:26] == 6'b100010) && ((x_inst[18])&&(x_inst[16]) ||
                                ((x_inst[19] && ~|x_inst[17:16])));
assign fcvt_f_x_narrow_il    = decd_vec_opfvv && (x_inst[31:26] == 6'b100010) && (x_inst[19]) && (x_vsew[1:0]==2'b00)&&(|x_inst[17:16]);
assign decd_size_illegal = |decd_size_ill_case[3:0];
//----------------------------------------------------------
//               vstart illegal for normal inst
//----------------------------------------------------------
assign decd_start_illegal = |cp0_idu_vstart[6:0] && !decd_vec_opcfg;

assign decd_vill_illegal  = cp0_idu_vill &&  !decd_vec_opcfg;  //VLSU inst should also consider this

assign decd_vs_illegal = (cp0_idu_vs[1:0]==2'b0);

assign decd_vec_inst_ac_fcsr =((x_inst[31:28]==4'b1000) //vsaddu vsadd vssubu vssub
                          ||(x_inst[31:28]==4'b1001) && !(x_inst[27:26]==2'b01)  //vaadd vasub vsmul
                          ||(x_inst[31:27]==5'b10101)  //vssrl vssra
                          ||(x_inst[31:27]==5'b10111)  //vnclip vnclipu
                          ||(x_inst[31:28]==4'b1111))  //vwsmaccu vwsmacc vwsmaccsu vwsmaccus
                          &&(decd_vec_opivv || decd_vec_opivx || decd_vec_opivi);

assign decd_vec_fp_ac_fcsr   = decd_vec_opfvf 
                         || ((x_inst[31:29] == 3'b000) //vfadd vfsub 
                             || (x_inst[31:30] == 2'b11) //vfwadd vfwsub vfwmul vfwmacc...
                             || (x_inst[31:28] == 4'b1001) //vfmul
                             || (x_inst[31:27] == 5'b10000) //vfdiv vfrdiv
                             || (x_inst[31:29] == 3'b101)   //vfmacc...
                             || (x_inst[31:29] == 3'b011)   //vfeq...
                             || (x_inst[31:26] == 6'b100011) && !x_inst[19] //vfsqrt
                             || (x_inst[31:26] == 6'b100010) //vfcvt
                             || (x_inst[31:27] == 5'b00110)) //vfmv
                            && decd_vec_opfvv;

assign decd_fs_illegal = (cp0_idu_fs[1:0]==2'b0) 
                      && (decd_vec_inst_ac_fcsr
                          || decd_vec_fp_ac_fcsr);

assign decd_fp_rounding_illegal = ((cp0_idu_frm[2:0] == 3'b101) ||
                                   (cp0_idu_frm[2:0] == 3'b110) ||
                                   (cp0_idu_frm[2:0] == 3'b111))
                               && (decd_vec_opfvv || decd_vec_opfvf);   
//----------------------------------------------------------
//               ALL type of VECTOR illegal instructions
//----------------------------------------------------------
assign decd_v_illegal = decd_code_illegal || decd_vreg_illegal ||
                        decd_ovlp_illegal || decd_size_illegal ||
                        decd_start_illegal|| decd_vill_illegal ||
                        decd_vs_illegal   || decd_fs_illegal   ||
                        decd_fp_rounding_illegal;

//----------------------------------------------------------
//                Decode vec mask Instruction
//----------------------------------------------------------
assign x_decd_srcvm_vld = decd_vec_inst &&  !x_inst[25] && !decd_vec_opcfg ||
                     decd_vec_inst &&  (x_inst[31:28]==4'b0100) &&  //vadc/vmadc/vsbc/vmsbc
                     (decd_vec_opivv || decd_vec_opivx || decd_vec_opivi) ||
                    ((x_inst[6:0]== 7'b0000111) || (x_inst[6:0]== 7'b0100111))  //vld/vst
                     && !x_inst[25] && ( (x_inst[14:12]==3'b000) || x_inst[14] && |x_inst[13:12]);

//----------------------------------------------------------
//                    Decode for vfcvt
//----------------------------------------------------------
assign vfcvt_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{(x_inst[19:15] == 5'b00000)}} & `FUNC_VFCVTXUF  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b00001)}} & `FUNC_VFCVTXF   |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b00010)}} & `FUNC_VFCVTFXU  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b00011)}} & `FUNC_VFCVTFX   |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01000)}} & `FUNC_VFWCVTXUF |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01001)}} & `FUNC_VFWCVTXF  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01010)}} & `FUNC_VFWCVTFXU |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01011)}} & `FUNC_VFWCVTFX  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01100)}} & `FUNC_VFWCVTFF  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10000)}} & `FUNC_VFNCVTXUF |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10001)}} & `FUNC_VFNCVTXF  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10010)}} & `FUNC_VFNCVTFXU |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10011)}} & `FUNC_VFNCVTFX  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10100)}} & `FUNC_VFNCVTFF;

//----------------------------------------------------------
//                  Vector Full Decoder
//----------------------------------------------------------
// &CombBeg; @4079
always @( x_inst[31:19]
       or x_vsew[1:0]
       or decd_vfunary0_vld
       or x_vlmul[1:0]
       or x_inst[19:12]
       or decd_vmunary0_vld
       or vfcvt_func[19:0])
begin
  //initialize decoded information value
  decd_v_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_v_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_v_src0_vld              = 1'b0;
  decd_v_src1_vld              = 1'b0;
  decd_v_src2_vld              = 1'b0;
  decd_v_dst0_vld              = 1'b0;
  decd_v_srcf0_vld             = 1'b0;
  decd_v_srcf1_vld             = 1'b0;
  decd_v_srcf2_vld             = 1'b0;
  decd_v_dstf_vld              = 1'b0;
  decd_v_dste_vld              = 1'b0;
  decd_v_srcv0_vld             = 1'b0;
  decd_v_srcv1_vld             = 1'b0;
  decd_v_srcv2_vld             = 1'b0;
  decd_v_dstv_vld              = 1'b0;
  decd_v_dstv_late_vld         = 1'b0;
  //illegal instruction
  decd_code_illegal            = 1'b0;
  casez({x_inst[31:26],x_inst[14:12]})
    9'b0?????_111:begin //vsetvli(rs1 in src1)
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSETVLI;
      decd_v_src1_vld              = 1'b1;
      decd_v_dst0_vld              = 1'b1;
      end
    9'b100000_111:begin //vsetvl (rs1 in src1, rs2 in src0)
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSETVL;
      decd_v_src1_vld              = 1'b1;
      decd_v_src0_vld              = 1'b1;
      decd_v_dst0_vld              = 1'b1;
      decd_code_illegal            = x_inst[25];
      end
    9'b000000_000:begin //vadd.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000000_100:begin //vadd.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000000_011:begin //vadd.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000010_000:begin //vsub.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000010_100:begin //vsub.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSUB;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000011_100:begin //vrsub.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;      
      end
    9'b000011_011:begin //vrsub.vi 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VRSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000100_000:begin //vminu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMINU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000100_100:begin //vminu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMINU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;      
      end
    9'b000101_000:begin //vmin.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMIN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000101_100:begin //vmin.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMIN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000110_000:begin //vmaxu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMAXU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000110_100:begin //vmaxu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMAXU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000111_000:begin //vmax.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMAX;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b000111_100:begin //vmax.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMAX;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001001_000:begin //vand.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VAND;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001001_100:begin //vand.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VAND;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001001_011:begin //vand.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VAND;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001010_000:begin //vor.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VORR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001010_100:begin //vor.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VORR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001010_011:begin //vor.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VORR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001011_000:begin //vxor.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VXOR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001011_100:begin //vxor.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VXOR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001011_011:begin //vxor.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VXOR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001100_000:begin //vrgather.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VRGATHERVV;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b001100_100:begin //vrgather.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VRGATHERVK;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001100_011:begin //vrgather.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VRGATHERVK;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001110_100:begin //vslideup.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSLIDEUP;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001110_011:begin //vslideup.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSLIDEUP;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001111_100:begin //vslidedown.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSLIDEDOWN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b001111_011:begin //vslidedown.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSLIDEDOWN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b010000_000:begin //vadc.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VADC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b010000_100:begin //vadc.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VADC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b010000_011:begin //vadc.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VADC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b010001_000:begin //vmadc.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMADC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_code_illegal            = !x_inst[25];
      end
    9'b010001_100:begin //vmadc.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMADC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_code_illegal            = !x_inst[25];
      end
    9'b010001_011:begin //vmadc.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMADC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_code_illegal            = !x_inst[25];
      end
    9'b010010_000:begin //vsbc.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSBC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b010010_100:begin //vsbc.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSBC;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b010011_000:begin //vmsbc.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSBC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_code_illegal            = !x_inst[25];
      end
    9'b010011_100:begin //vmsbc.vx always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSBC;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_code_illegal            = !x_inst[25];
      end
    9'b010111_000:begin //vmerge/vmv.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = x_inst[25] ? `FUNC_VMOV : `FUNC_VMGE;
      decd_v_srcv0_vld             = !x_inst[25];
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = x_inst[25] && |x_inst[24:20];
      end
    9'b010111_100:begin //vmerge.vx always split, vmv.vx not split if LMUL=1 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = x_inst[25] ? `FUNC_VMOV : `FUNC_VMGE;
      decd_v_srcv0_vld             = !x_inst[25];
      decd_v_src1_vld              = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = x_inst[25] && |x_inst[24:20];
      end
    9'b010111_011:begin //vmerge/vmv.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = x_inst[25] ? `FUNC_VMOV : `FUNC_VMGE;
      decd_v_srcv0_vld             = !x_inst[25];
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = x_inst[25] && |x_inst[24:20];
      end
    9'b011000_000:begin //vmseq.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSEQ;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011000_100:begin //vmseq.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSEQ;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011000_011:begin //vmseq.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSEQ;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011001_000:begin //vmsne.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSNE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011001_100:begin //vmsne.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSNE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011001_011:begin //vmsne.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSNE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011010_000:begin //vmsltu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLTU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011010_100:begin //vmsltu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLTU;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011011_000:begin //vmslt.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLT;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011011_100:begin //vmslt.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLT;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011100_000:begin //vmsleu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLEU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011100_100:begin //vmsleu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLEU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011100_011:begin //vmsleu.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLEU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011101_000:begin //vmsle.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011101_100:begin //vmsle.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011101_011:begin //vmsle.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSLE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011110_100:begin //vmsgtu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSGTU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011110_011:begin //vmsgtu.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSGTU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011111_100:begin //vmsgt.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSGT;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b011111_011:begin //vmsgt.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMSGT;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      end
    9'b100000_000:begin //vsaddu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSADDU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100000_100:begin //vsaddu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSADDU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100000_011:begin //vsaddu.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSADDU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100001_000:begin //vsadd.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100001_100:begin //vsadd.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100001_011:begin //vsadd.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100010_000:begin //vssubu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSUBU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100010_100:begin //vssubu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSUBU;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100011_000:begin //vssub.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100011_100:begin //vssub.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSUB;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100100_000:begin //vaadd.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VAADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100100_100:begin //vaadd.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VAADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100100_011:begin //vaadd.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VAADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100101_000:begin //vsll.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSLL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100101_100:begin //vsll.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSLL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100101_011:begin //vsll.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSLL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100110_000:begin //vasub.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VASUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100110_100:begin //vasub.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VASUB;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100111_000:begin //vsmul.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      decd_v_dste_vld              = 1'b1;
      end
    9'b100111_100:begin //vsmul.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      decd_v_dste_vld              = 1'b1;
      end
    9'b101000_000:begin //vsrl.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSRL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101000_100:begin //vsrl.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSRL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101000_011:begin //vsrl.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSRL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101001_000:begin //vsra.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSRA;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101001_100:begin //vsra.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSRA;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101001_011:begin //vsra.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSRA;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101010_000:begin //vssrl.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSRL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101010_100:begin //vssrl.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSRL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101010_011:begin //vssrl.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSRL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101011_000:begin //vssra.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSRA;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101011_100:begin //vssra.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSRA;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101011_011:begin //vssra.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSSRA;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b101100_000:begin //vnsrl.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNSRL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101100_100:begin //vnsrl.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNSRL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101100_011:begin //vnsrl.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNSRL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101101_000:begin //vnsra.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNSRA;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101101_100:begin //vnsra.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNSRA;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101101_011:begin //vnsra.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNSRA;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101110_000:begin //vnclipu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNCLIPU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dste_vld              = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101110_100:begin //vnclipu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNCLIPU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dste_vld              = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101110_011:begin //vnclipu.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNCLIPU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dste_vld              = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101111_000:begin //vnclip.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNCLIP;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dste_vld              = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101111_100:begin //vnclip.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNCLIP;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dste_vld              = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b101111_011:begin //vnclip.vi
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VSHIFT;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNCLIP;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dste_vld              = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b110000_000:begin //vwredusumu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWREDSUMU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b110001_000:begin //vwredusum.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWREDSUM;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b111100_000:begin //vwsmaccu.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSMACCU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111100_100:begin //vwsmaccu.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSMACCU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111101_000:begin //vwsmacc.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111101_100:begin //vwsmacc.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111110_000:begin //vwsmaccsu.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSMACCSU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111110_100:begin //vwsmaccsu.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSMACCSU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    //9'b111111_000:begin //vwsmaccus.vv 
    //  decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
    //  decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSMACCUS;
    //  decd_v_srcv0_vld             = 1'b1;
    //  decd_v_srcv1_vld             = 1'b1;
    //  decd_v_srcv2_vld             = 1'b1;
    //  decd_v_dstv_vld              = 1'b1;
    //  decd_v_dste_vld              = 1'b1;
    //  end
    9'b111111_100:begin //vwsmaccus.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSMACCUS;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000000_010:begin //vredsum.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREDSUM;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b000001_010:begin //vredand.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREDAND;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b000010_010:begin //vredor.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREDORR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b000011_010:begin //vredxor.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREDXOR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b000100_010:begin //vredminu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREDMINU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b000101_010:begin //vredmin.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREDMIN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b000110_010:begin //vredmaxu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREDMAXU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b000111_010:begin //vredmax.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VREDU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREDMAX;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b001100_010:begin //vext.x.v(mfvr) only rs1==x0
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VEXT;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b0;
      decd_v_dst0_vld              = 1'b1;  //write GPR
      decd_code_illegal            = !x_inst[25];
      end
    9'b001101_110:begin //vmv.s.x(mtvr)
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC; 
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMV;
      decd_v_srcv0_vld             = 1'b0;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25] || |x_inst[24:20];
      end
    9'b001110_110:begin //vslide1up.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSLIDE1UP;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001111_110:begin //vslide1down.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VSLIDE1DOWN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      end
    9'b010100_010:begin //vmpopc
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMPOP;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dst0_vld              = 1'b1;
      decd_code_illegal            = |x_inst[19:15];
      end
    9'b010101_010:begin //vmfirst
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMFIRST;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dst0_vld              = 1'b1;     
      decd_code_illegal            = |x_inst[19:15];
      end
    9'b010110_010:begin //VMUNARY0;vmsbf vmsif vmsof viota vid
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMUNARY0;
      decd_v_srcv0_vld             = !(x_inst[19:15]==5'b10001);
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !decd_vmunary0_vld || (x_inst[19:15]==5'b10001) && |x_inst[24:20];
      end
    9'b010111_010:begin //vcompress
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VPERMU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VCOMPRESS;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_late_vld         = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b011000_010:begin //vmandnot
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMANDN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b011001_010:begin //vmand
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMAND;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b011010_010:begin //vmor
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMORR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b011011_010:begin //vmxor
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMXOR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b011100_010:begin //vmornot
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMORRN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b011101_010:begin //vmnand
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMNAND;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b011110_010:begin //vmnor
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMNORR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
    9'b011111_010:begin //vmxnor
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMISC;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMNXOR;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b0;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25];
      end
  9'b100000_010:begin //vdivu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VDIVU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VDIVU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100000_110:begin //vdivu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VDIVU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VDIVU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100001_010:begin //vdiv.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VDIVU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VDIV;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100001_110:begin //vdiv.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VDIVU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VDIV;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100010_010:begin //vremu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VDIVU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREMU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100010_110:begin //vremu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VDIVU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREMU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100011_010:begin //vrem.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VDIVU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREM;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b100011_110:begin //vrem.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VDIVU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VREM;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end      
    9'b100100_010:begin //vmulhu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMULHU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b100100_110:begin //vmulhu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMULHU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b100101_010:begin //vmul.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b100101_110:begin //vmul.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b100110_010:begin //vmulhsu.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMULHSU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b100110_110:begin //vmulhsu.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMULHSU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b100111_010:begin //vmulh.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMULH;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b100111_110:begin //vmulh.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMULH;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b101001_010:begin //vmadd.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b101001_110:begin //vmadd.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMADD;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b101011_010:begin //vnmsub.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNMSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b101011_110:begin //vnmsub.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNMSUB;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b101101_010:begin //vmacc.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b101101_110:begin //vmacc.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b101111_010:begin //vnmsac.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNMSAC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b101111_110:begin //vnmsac.vx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VNMSAC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = !(x_vsew[1:0]==2'b11);
      decd_v_dstv_late_vld         = (x_vsew[1:0]==2'b11);
      end
    9'b110000_010:begin //vwaddu.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWADDU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110000_110:begin //vwaddu.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWADDU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110001_010:begin //vwadd.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110001_110:begin //vwadd.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110010_010:begin //vwsubu.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSUBU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110010_110:begin //vwsubu.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSUBU;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110011_010:begin //vwsub.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110011_110:begin //vwsub.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSUB;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110100_010:begin //vwaddu.w.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWADDUW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110100_110:begin //vwaddu.w.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWADDUW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110101_010:begin //vwadd.w.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWADDW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110101_110:begin //vwadd.w.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWADDW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110110_010:begin //vwsubu.w.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSUBUW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110110_110:begin //vwsubu.w.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSUBUW;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110111_010:begin //vwsub.w.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSUBW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b110111_110:begin //vwsub.w.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWSUBW;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111000_010:begin //vwmulu.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMULU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111000_110:begin //vwmulu.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMULU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111010_010:begin //vwmulsu.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMULSU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111010_110:begin //vwmulsu.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMULSU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111011_010:begin //vwmul.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111011_110:begin //vwmul.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111100_010:begin //vwmaccu.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMACCU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111100_110:begin //vwmaccu.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMACCU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111101_010:begin //vwmacc.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111101_110:begin //vwmacc.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111110_010:begin //vwmaccsu.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMACCSU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111110_110:begin //vwmaccsu.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMACCSU;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      end
    9'b111111_110:begin //vwmaccus.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VMULU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VWMACCUS;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_src1_vld              = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      end
//VECTOR FPU INST
    9'b000000_001:begin //vfadd.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000000_101:begin //vfadd.vf
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000001_001:begin //vfredsum.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = x_vsew[1:0]==2'b11 ? `FUNC_VFREDSUM64 : `FUNC_VFREDSUM;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000010_001:begin //vfsub.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000010_101:begin //vfsub.vf
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000011_001:begin //vfredosum.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFOREDSUM;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000100_001:begin //vfmin.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMIN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000100_101:begin //vfmin.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMIN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000101_001:begin //vfredmin.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = x_vsew[1:0]==2'b11 ? `FUNC_VFREDMIN64 :`FUNC_VFREDMIN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000110_001:begin //vfmax.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMAX;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000110_101:begin //vfmax.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMAX;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b000111_001:begin //vfredmax.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = (x_vsew[1:0]==2'b11) ? `FUNC_VFREDMAX64 : `FUNC_VFREDMAX;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b001000_001:begin //vfsgnj.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFSPU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFSGNJ;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001000_101:begin //vfsgnj.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFSPU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFSGNJ;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001001_001:begin //vfsgnjn.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFSPU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFSGNJN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001001_101:begin //vfsgnjn.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFSPU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFSGNJN;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001010_001:begin //vfsgnjx.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFSPU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFSGNJX;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001010_101:begin //vfsgnjx.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFSPU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFSGNJX;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      end
    9'b001100_001:begin //vfmv.f.s
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFSPU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMVFS;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_dstf_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25] || |x_inst[19:15];
      end
    9'b001101_101:begin //vfmv.s.f
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFSPU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMVSF;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_code_illegal            = !x_inst[25] || |x_inst[24:20];
      end
    9'b010111_101:begin //vfmerge.vfm/vmv.vf
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFSPU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMERG;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv0_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      decd_code_illegal            = x_inst[25] && |x_inst[24:20];
      end
    9'b011000_001:begin //vmfeq.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFEQ;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011000_101:begin //vmfeq.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFEQ;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011001_001:begin //vmfle.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFLE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011001_101:begin //vmfle.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFLE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011010_001:begin //vmford.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFORD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011010_101:begin //vmford.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFORD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011011_001:begin //vmflt.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFLT;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011011_101:begin //vmflt.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFLT;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011100_001:begin //vmfne.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011100_101:begin //vmfne.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNE;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011101_101:begin //vmfgt.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFLT;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b011111_101:begin //vmfge.vx 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFLE;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = (x_vlmul[1:0]==2'b00);
      decd_v_dstv_late_vld         =!(x_vlmul[1:0]==2'b00);
      decd_v_dste_vld              = 1'b1;
      end
    9'b100000_001:begin //vfdiv.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFDSU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFDIV;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100000_101:begin //vfdiv.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFDSU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFDIV;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100001_101:begin //vfrdiv.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFDSU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFDIV;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100010_001:begin //VFUNARY0 vfcvt.xxxx
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFCVT;
      decd_v_func[`FUNC_WIDTH-1:0] = vfcvt_func[`FUNC_WIDTH-1:0];
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;//all cvt srcv12 switch
      decd_v_dstv_vld              = !x_inst[19];//not narrowing
      decd_v_dstv_late_vld         =  x_inst[19];//narrowing
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dste_vld              = 1'b1;
      decd_code_illegal            = !decd_vfunary0_vld;
      end
    9'b100011_001:begin //VFUNARY1 vfclass/vfsqrt.vv
      decd_v_eu[`EU_WIDTH-1:0]     = x_inst[19]? `EU_VFSPU : `EU_VFDSU;
      decd_v_func[`FUNC_WIDTH-1:0] = x_inst[19]? `FUNC_VFCLASS  : `FUNC_VFSQRT;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b0;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = !x_inst[19];
      decd_code_illegal            = |x_inst[18:15];
      end
    9'b100100_001:begin //vfmul.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100100_101:begin //vfmul.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b100111_101:begin //vfrsub.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFSUB;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101000_001:begin //vfmadd.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101000_101:begin //vfmadd.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMADD;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101001_001:begin //vfnmadd.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNMADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101001_101:begin //vfnmadd.vf
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNMADD;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101010_001:begin //vfmsub.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101010_101:begin //vfmsub.vf always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMSUB;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101011_001:begin //vfnmsub.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNMSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101011_101:begin //vfnmsub.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNMSUB;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101100_001:begin //vfmacc.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101100_101:begin //vfmacc.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMACC;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101101_001:begin //vfnmacc.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101101_101:begin //vfnmacc.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNMACC;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101110_001:begin //vfmsac.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMSAC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101110_101:begin //vfmsac.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFMSAC;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101111_001:begin //vfnmsac.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNMSAC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b101111_101:begin //vfnmsac.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFNMSAC;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110000_001:begin //vfwadd.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110000_101:begin //vfwadd.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWADD;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110001_001:begin //vfwredsum.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWREDSUM;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110010_001:begin //vfwsub.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110010_101:begin //vfwsub.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWSUB;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110011_001:begin //vfwredosum.vv
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWOREDSUM;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      //decd_v_dstv_vld              = 1'b1;
      decd_v_dstv_late_vld         = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110100_001:begin //vfwadd.w.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWADDW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110100_101:begin //vfwadd.w.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWADDW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110110_001:begin //vfwsub.w.vv 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWSUBW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b110110_101:begin //fwsub.w.vf 
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFALU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWSUBW;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111000_001:begin //vfwmul.vv always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111000_101:begin //vfwmul.vf always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWMUL;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcf1_vld             = 1'b1;
      decd_v_srcv2_vld             = !x_inst[25];
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111100_001:begin //vfwmacc.vv always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111100_101:begin //vfwmacc.vf always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWMACC;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111101_001:begin //vfwnmacc.vv always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWNMACC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111101_101:begin //vfwnmacc.vf always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWNMACC;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111110_001:begin //vfwmsac.vv always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWMSAC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111110_101:begin //vfwmsac.vf always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWMSAC;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111111_001:begin //vfwmnsac.vv always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWNMSAC;
      decd_v_srcv0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    9'b111111_101:begin //vfwmnsac.vf always split
      decd_v_eu[`EU_WIDTH-1:0]     = `EU_VFMAU;
      decd_v_func[`FUNC_WIDTH-1:0] = `FUNC_VFWNMSAC;
      decd_v_srcf0_vld             = 1'b1;
      decd_v_srcv1_vld             = 1'b1;
      decd_v_srcv2_vld             = 1'b1;
      decd_v_dstv_vld              = 1'b1;
      decd_v_dste_vld              = 1'b1;
      end
    default: begin                //invalid instruction
      //deal in fence
      decd_code_illegal            = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @6545
end


//when vl is 0, signal dp to mask decoded inst into nop
//assign decd_vec_nop = (cp0_idu_vl[7:0]==8'b0) && !decd_vec_opcfg && !vec_mfvr_inst;
assign decd_vec_nop = (cp0_idu_vl_zero) && !decd_vec_opcfg && !vec_mfvr_inst;

// &CombBeg; @6552
always @( decd_v_illegal
       or decd_vec_nop
       or decd_v_eu[9:0]
       or decd_v_srcv0_vld
       or decd_v_src2_vld
       or decd_v_dstv_vld
       or decd_v_dste_vld
       or decd_v_srcf1_vld
       or decd_v_srcv2_vld
       or decd_v_func[19:0]
       or decd_v_dstv_late_vld
       or decd_v_srcf2_vld
       or decd_v_dstf_vld
       or decd_v_src1_vld
       or decd_v_src0_vld
       or decd_v_srcf0_vld
       or decd_v_dst0_vld
       or decd_v_srcv1_vld)
begin
  if(decd_vec_nop) begin
    //initialize decoded information value
    decd_vec_eu[`EU_WIDTH-1:0]     = `EU_CP0;
    decd_vec_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
    //operand prepare information: valid, and types
    decd_vec_src0_vld              = decd_v_src0_vld;
    decd_vec_src1_vld              = decd_v_src1_vld;
    decd_vec_src2_vld              = decd_v_src2_vld;
    decd_vec_dst0_vld              = decd_v_dst0_vld;
    decd_vec_srcf0_vld             = decd_v_srcf0_vld;
    decd_vec_srcf1_vld             = decd_v_srcf1_vld;
    decd_vec_srcf2_vld             = decd_v_srcf2_vld;
    decd_vec_dstf_vld              = decd_v_dstf_vld;
    decd_vec_dste_vld              = decd_v_dste_vld;
    decd_vec_srcv0_vld             = decd_v_srcv0_vld;
    decd_vec_srcv1_vld             = decd_v_srcv1_vld;
    decd_vec_srcv2_vld             = decd_v_srcv2_vld;
    decd_vec_dstv_vld              = decd_v_dstv_vld;
    decd_vec_dstv_late_vld         = decd_v_dstv_late_vld;
    //illegal instruction
    decd_vec_illegal               = decd_v_illegal;
  end
  else begin
    decd_vec_eu[`EU_WIDTH-1:0]     = decd_v_eu[`EU_WIDTH-1:0];
    decd_vec_func[`FUNC_WIDTH-1:0] = decd_v_func[`FUNC_WIDTH-1:0];
    //operand prepare information: valid, and types
    decd_vec_src0_vld              = decd_v_src0_vld;
    decd_vec_src1_vld              = decd_v_src1_vld;
    decd_vec_src2_vld              = decd_v_src2_vld;
    decd_vec_dst0_vld              = decd_v_dst0_vld;
    decd_vec_srcf0_vld             = decd_v_srcf0_vld;
    decd_vec_srcf1_vld             = decd_v_srcf1_vld;
    decd_vec_srcf2_vld             = decd_v_srcf2_vld;
    decd_vec_dstf_vld              = decd_v_dstf_vld;
    decd_vec_dste_vld              = decd_v_dste_vld;
    decd_vec_srcv0_vld             = decd_v_srcv0_vld;
    decd_vec_srcv1_vld             = decd_v_srcv1_vld;
    decd_vec_srcv2_vld             = decd_v_srcv2_vld;
    decd_vec_dstv_vld              = decd_v_dstv_vld;
    decd_vec_dstv_late_vld         = decd_v_dstv_late_vld;
    //illegal instruction
    decd_vec_illegal               = decd_v_illegal;
  end
// &CombEnd; @6596
end


//================================================
//        assertion
//================================================
// &Force("nonport","flag"); @6612
// &Force("nonport","clk"); @6613
// &Force("nonport","rst"); @6614
// &Force("input","forever_cpuclk"); @6654
// &Force("input","ctrl_dis_inst_vld"); @6655
// &Force("input","ctrl_dp_ex1_stall"); @6656
// &Force("input","split_dp_inst_sel"); @6657
// &Force("input","ifu_idu_id_expt_acc_error"); @6658
// &Force("input","ifu_idu_id_expt_page_fault"); @6659
// &Force("input","idu_ex1_expt_illegal"); @6660
// &Force("input","cp0_rtu_ex1_expt_vec"); @6661
// &Force("bus","cp0_rtu_ex1_expt_vec",3,0); @6662


// &ModuleEnd; @6714
endmodule


