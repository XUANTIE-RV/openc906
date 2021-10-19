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
module aq_rtu_rbus(
  cp0_rtu_ex1_cmplt,
  cp0_rtu_ex1_cmplt_dp,
  cp0_rtu_ex1_vs_dirty,
  cp0_rtu_ex1_vs_dirty_dp,
  cp0_rtu_ex1_wb_data,
  cp0_rtu_ex1_wb_dp,
  cp0_rtu_ex1_wb_preg,
  cp0_rtu_ex1_wb_vld,
  iu_rtu_div_data,
  iu_rtu_div_preg,
  iu_rtu_div_wb_dp,
  iu_rtu_div_wb_vld,
  iu_rtu_ex1_alu_data,
  iu_rtu_ex1_alu_preg,
  iu_rtu_ex1_alu_wb_dp,
  iu_rtu_ex1_alu_wb_vld,
  iu_rtu_ex1_bju_data,
  iu_rtu_ex1_bju_preg,
  iu_rtu_ex1_bju_wb_dp,
  iu_rtu_ex1_bju_wb_vld,
  iu_rtu_ex3_mul_data,
  iu_rtu_ex3_mul_preg,
  iu_rtu_ex3_mul_wb_vld,
  lsu_rtu_ex1_data,
  lsu_rtu_ex1_dest_reg,
  lsu_rtu_ex1_wb_dp,
  lsu_rtu_ex1_wb_vld,
  lsu_rtu_ex2_data,
  lsu_rtu_ex2_data_vld,
  lsu_rtu_ex2_dest_reg,
  rbus_wb_rbus_wb_data,
  rbus_wb_rbus_wb_dp,
  rbus_wb_rbus_wb_preg,
  rbus_wb_rbus_wb_vld,
  retire_rbus_fs_dirty,
  retire_rbus_vs_dirty,
  rtu_cp0_fs_dirty_updt,
  rtu_cp0_fs_dirty_updt_dp,
  rtu_cp0_vl,
  rtu_cp0_vl_vld,
  rtu_cp0_vs_dirty_updt,
  rtu_cp0_vs_dirty_updt_dp,
  rtu_idu_fwd0_data,
  rtu_idu_fwd0_reg,
  rtu_idu_fwd0_vld,
  rtu_idu_fwd1_data,
  rtu_idu_fwd1_reg,
  rtu_idu_fwd1_vld,
  rtu_idu_fwd2_data,
  rtu_idu_fwd2_reg,
  rtu_idu_fwd2_vld,
  rtu_iu_div_wb_grant,
  rtu_iu_div_wb_grant_for_full,
  rtu_iu_mul_wb_grant,
  rtu_iu_mul_wb_grant_for_full,
  vlsu_rtu_vl_updt_data,
  vlsu_rtu_vl_updt_vld,
  vpu_rtu_ex1_cmplt,
  vpu_rtu_ex1_cmplt_dp,
  vpu_rtu_ex1_fp_dirty,
  vpu_rtu_ex1_vec_dirty
);


// &Ports; @25
input           cp0_rtu_ex1_cmplt;           
input           cp0_rtu_ex1_cmplt_dp;        
input           cp0_rtu_ex1_vs_dirty;        
input           cp0_rtu_ex1_vs_dirty_dp;     
input   [63:0]  cp0_rtu_ex1_wb_data;         
input           cp0_rtu_ex1_wb_dp;           
input   [5 :0]  cp0_rtu_ex1_wb_preg;         
input           cp0_rtu_ex1_wb_vld;          
input   [63:0]  iu_rtu_div_data;             
input   [5 :0]  iu_rtu_div_preg;             
input           iu_rtu_div_wb_dp;            
input           iu_rtu_div_wb_vld;           
input   [63:0]  iu_rtu_ex1_alu_data;         
input   [5 :0]  iu_rtu_ex1_alu_preg;         
input           iu_rtu_ex1_alu_wb_dp;        
input           iu_rtu_ex1_alu_wb_vld;       
input   [63:0]  iu_rtu_ex1_bju_data;         
input   [5 :0]  iu_rtu_ex1_bju_preg;         
input           iu_rtu_ex1_bju_wb_dp;        
input           iu_rtu_ex1_bju_wb_vld;       
input   [63:0]  iu_rtu_ex3_mul_data;         
input   [5 :0]  iu_rtu_ex3_mul_preg;         
input           iu_rtu_ex3_mul_wb_vld;       
input   [63:0]  lsu_rtu_ex1_data;            
input   [5 :0]  lsu_rtu_ex1_dest_reg;        
input           lsu_rtu_ex1_wb_dp;           
input           lsu_rtu_ex1_wb_vld;          
input   [63:0]  lsu_rtu_ex2_data;            
input           lsu_rtu_ex2_data_vld;        
input   [5 :0]  lsu_rtu_ex2_dest_reg;        
input           retire_rbus_fs_dirty;        
input           retire_rbus_vs_dirty;        
input   [7 :0]  vlsu_rtu_vl_updt_data;       
input           vlsu_rtu_vl_updt_vld;        
input           vpu_rtu_ex1_cmplt;           
input           vpu_rtu_ex1_cmplt_dp;        
input           vpu_rtu_ex1_fp_dirty;        
input           vpu_rtu_ex1_vec_dirty;       
output  [63:0]  rbus_wb_rbus_wb_data;        
output          rbus_wb_rbus_wb_dp;          
output  [5 :0]  rbus_wb_rbus_wb_preg;        
output          rbus_wb_rbus_wb_vld;         
output          rtu_cp0_fs_dirty_updt;       
output          rtu_cp0_fs_dirty_updt_dp;    
output  [7 :0]  rtu_cp0_vl;                  
output          rtu_cp0_vl_vld;              
output          rtu_cp0_vs_dirty_updt;       
output          rtu_cp0_vs_dirty_updt_dp;    
output  [63:0]  rtu_idu_fwd0_data;           
output  [5 :0]  rtu_idu_fwd0_reg;            
output          rtu_idu_fwd0_vld;            
output  [63:0]  rtu_idu_fwd1_data;           
output  [5 :0]  rtu_idu_fwd1_reg;            
output          rtu_idu_fwd1_vld;            
output  [63:0]  rtu_idu_fwd2_data;           
output  [5 :0]  rtu_idu_fwd2_reg;            
output          rtu_idu_fwd2_vld;            
output          rtu_iu_div_wb_grant;         
output          rtu_iu_div_wb_grant_for_full; 
output          rtu_iu_mul_wb_grant;         
output          rtu_iu_mul_wb_grant_for_full; 

// &Regs; @26
reg     [63:0]  rbus_ex1_data;               
reg     [63:0]  rbus_ex1_fwd_data;           
reg     [5 :0]  rbus_ex1_fwd_preg;           
reg     [5 :0]  rbus_ex1_preg;               
reg     [63:0]  rbus_wb_data;                
reg     [5 :0]  rbus_wb_preg;                
reg             rbus_wb_vld;                 

// &Wires; @27
wire            cp0_rtu_ex1_cmplt;           
wire            cp0_rtu_ex1_cmplt_dp;        
wire            cp0_rtu_ex1_vs_dirty;        
wire            cp0_rtu_ex1_vs_dirty_dp;     
wire    [63:0]  cp0_rtu_ex1_wb_data;         
wire            cp0_rtu_ex1_wb_dp;           
wire    [5 :0]  cp0_rtu_ex1_wb_preg;         
wire            cp0_rtu_ex1_wb_vld;          
wire    [63:0]  iu_rtu_div_data;             
wire    [5 :0]  iu_rtu_div_preg;             
wire            iu_rtu_div_wb_dp;            
wire            iu_rtu_div_wb_vld;           
wire    [63:0]  iu_rtu_ex1_alu_data;         
wire    [5 :0]  iu_rtu_ex1_alu_preg;         
wire            iu_rtu_ex1_alu_wb_dp;        
wire            iu_rtu_ex1_alu_wb_vld;       
wire    [63:0]  iu_rtu_ex1_bju_data;         
wire    [5 :0]  iu_rtu_ex1_bju_preg;         
wire            iu_rtu_ex1_bju_wb_dp;        
wire            iu_rtu_ex1_bju_wb_vld;       
wire    [63:0]  iu_rtu_ex3_mul_data;         
wire    [5 :0]  iu_rtu_ex3_mul_preg;         
wire            iu_rtu_ex3_mul_wb_vld;       
wire    [63:0]  lsu_rtu_ex1_data;            
wire    [5 :0]  lsu_rtu_ex1_dest_reg;        
wire            lsu_rtu_ex1_wb_dp;           
wire            lsu_rtu_ex1_wb_vld;          
wire    [63:0]  lsu_rtu_ex2_data;            
wire            lsu_rtu_ex2_data_vld;        
wire    [5 :0]  lsu_rtu_ex2_dest_reg;        
wire    [63:0]  rbus_alu_data;               
wire    [5 :0]  rbus_alu_reg;                
wire            rbus_alu_wb_dp;              
wire            rbus_alu_wb_vld;             
wire    [63:0]  rbus_bju_data;               
wire    [5 :0]  rbus_bju_reg;                
wire            rbus_bju_wb_dp;              
wire            rbus_bju_wb_vld;             
wire    [63:0]  rbus_cp0_data;               
wire    [5 :0]  rbus_cp0_reg;                
wire            rbus_cp0_wb_dp;              
wire            rbus_cp0_wb_vld;             
wire    [63:0]  rbus_div_data;               
wire    [5 :0]  rbus_div_preg;               
wire            rbus_div_wb_dp;              
wire            rbus_div_wb_grant;           
wire            rbus_div_wb_grant_for_full;  
wire            rbus_div_wb_vld;             
wire            rbus_ex1_alu_fwd_vld;        
wire            rbus_ex1_bju_fwd_vld;        
wire    [2 :0]  rbus_ex1_fwd_source_vld;     
wire            rbus_ex1_fwd_vld;            
wire            rbus_ex1_lsu_fwd_vld;        
wire            rbus_ex1_wb_dp;              
wire    [1 :0]  rbus_ex1_wb_source_vld;      
wire            rbus_ex1_wb_vld;             
wire    [63:0]  rbus_lsu_data;               
wire    [63:0]  rbus_lsu_fwd_data;           
wire    [5 :0]  rbus_lsu_fwd_preg;           
wire            rbus_lsu_fwd_vld;            
wire    [5 :0]  rbus_lsu_reg;                
wire            rbus_lsu_wb_dp;              
wire            rbus_lsu_wb_vld;             
wire    [63:0]  rbus_mul_data;               
wire    [63:0]  rbus_mul_fwd_data;           
wire    [5 :0]  rbus_mul_fwd_preg;           
wire            rbus_mul_fwd_vld;            
wire    [5 :0]  rbus_mul_preg;               
wire            rbus_mul_wb_dp;              
wire            rbus_mul_wb_grant;           
wire            rbus_mul_wb_grant_for_full;  
wire            rbus_mul_wb_vld;             
wire    [63:0]  rbus_wb_rbus_wb_data;        
wire            rbus_wb_rbus_wb_dp;          
wire    [5 :0]  rbus_wb_rbus_wb_preg;        
wire            rbus_wb_rbus_wb_vld;         
wire    [2 :0]  rbus_wb_source_vld;          
wire            rbus_wb_vld_dp;              
wire            retire_rbus_fs_dirty;        
wire            retire_rbus_vs_dirty;        
wire            rtu_cp0_fs_dirty_updt;       
wire            rtu_cp0_fs_dirty_updt_dp;    
wire    [7 :0]  rtu_cp0_vl;                  
wire            rtu_cp0_vl_vld;              
wire            rtu_cp0_vs_dirty_updt;       
wire            rtu_cp0_vs_dirty_updt_dp;    
wire    [63:0]  rtu_idu_fwd0_data;           
wire    [5 :0]  rtu_idu_fwd0_reg;            
wire            rtu_idu_fwd0_vld;            
wire    [63:0]  rtu_idu_fwd1_data;           
wire    [5 :0]  rtu_idu_fwd1_reg;            
wire            rtu_idu_fwd1_vld;            
wire    [63:0]  rtu_idu_fwd2_data;           
wire    [5 :0]  rtu_idu_fwd2_reg;            
wire            rtu_idu_fwd2_vld;            
wire            rtu_iu_div_wb_grant;         
wire            rtu_iu_div_wb_grant_for_full; 
wire            rtu_iu_mul_wb_grant;         
wire            rtu_iu_mul_wb_grant_for_full; 
wire    [7 :0]  vlsu_rtu_vl_updt_data;       
wire            vlsu_rtu_vl_updt_vld;        
wire            vpu_rtu_ex1_cmplt;           
wire            vpu_rtu_ex1_cmplt_dp;        
wire            vpu_rtu_ex1_fp_dirty;        
wire            vpu_rtu_ex1_vec_dirty;       


//==========================================================
//                         Forward
//==========================================================
// Forward source:
//   * EX1 ALU & EX1 BJU & EX1 LSU
//   * MUL
//   * LSU

//----------------------------------------------------------
//                       EX1 Forward
//----------------------------------------------------------
// EX1 Forward includes:
//   * EX1 ALU
//   * EX1 BJU
//   * EX1 LSU
assign rbus_ex1_fwd_source_vld[2:0] = {rbus_alu_wb_dp,
                                       rbus_bju_wb_dp,
                                       rbus_lsu_wb_dp};

// &CombBeg; @48
always @( rbus_ex1_fwd_source_vld[2:0]
       or rbus_lsu_data[63:0]
       or rbus_alu_reg[5:0]
       or rbus_bju_reg[5:0]
       or rbus_alu_data[63:0]
       or rbus_lsu_reg[5:0]
       or rbus_bju_data[63:0])
begin
  case(rbus_ex1_fwd_source_vld[2:0])
    3'b001: // LSU
    begin
      rbus_ex1_fwd_preg[5:0]  = rbus_lsu_reg[5:0];
      rbus_ex1_fwd_data[63:0] = rbus_lsu_data[63:0];
    end
    3'b010: // BJU
    begin
      rbus_ex1_fwd_preg[5:0]  = rbus_bju_reg[5:0];
      rbus_ex1_fwd_data[63:0] = rbus_bju_data[63:0];
    end
    3'b100: // ALU
    begin
      rbus_ex1_fwd_preg[5:0]  = rbus_alu_reg[5:0];
      rbus_ex1_fwd_data[63:0] = rbus_alu_data[63:0];
    end
    default:
    begin
      rbus_ex1_fwd_preg[5:0]  = {6{1'bx}};
      rbus_ex1_fwd_data[63:0] = {64{1'bx}};
    end
  endcase
// &CombEnd; @71
end

assign rbus_ex1_alu_fwd_vld = iu_rtu_ex1_alu_wb_dp;
assign rbus_ex1_bju_fwd_vld = iu_rtu_ex1_bju_wb_dp;
assign rbus_ex1_lsu_fwd_vld = lsu_rtu_ex1_wb_dp;

assign rbus_ex1_fwd_vld        = rbus_ex1_alu_fwd_vld
                              || rbus_ex1_bju_fwd_vld
                              || rbus_ex1_lsu_fwd_vld;

//----------------------------------------------------------
//                       MUL Forward
//----------------------------------------------------------
assign rbus_mul_fwd_vld        = iu_rtu_ex3_mul_wb_vld;
assign rbus_mul_fwd_preg[5:0]  = iu_rtu_ex3_mul_preg[5:0];
assign rbus_mul_fwd_data[63:0] = iu_rtu_ex3_mul_data[63:0];

//----------------------------------------------------------
//                       LSU Forward
//----------------------------------------------------------
assign rbus_lsu_fwd_vld        = lsu_rtu_ex2_data_vld;
assign rbus_lsu_fwd_preg[5:0]  = lsu_rtu_ex2_dest_reg[5:0];
assign rbus_lsu_fwd_data[63:0] = lsu_rtu_ex2_data[63:0];

//==========================================================
//                    WriteBack Arbiter
//==========================================================
// 1. ex1 data
// 2. div data
// 3. mul data
// 4. vector (in WB)

//----------------------------------------------------------
//                      EX1 WriteBack
//----------------------------------------------------------
// 1. ALU
// 2. BJU
// 3. CP0
// 4. EX1 LSU
assign rbus_alu_wb_dp      = iu_rtu_ex1_alu_wb_dp;
assign rbus_alu_wb_vld     = iu_rtu_ex1_alu_wb_vld;
assign rbus_alu_reg[5:0]   = iu_rtu_ex1_alu_preg[5:0];
assign rbus_alu_data[63:0] = iu_rtu_ex1_alu_data[63:0];

assign rbus_bju_wb_dp      = iu_rtu_ex1_bju_wb_dp;
assign rbus_bju_wb_vld     = iu_rtu_ex1_bju_wb_vld;
assign rbus_bju_reg[5:0]   = iu_rtu_ex1_bju_preg[5:0];
assign rbus_bju_data[63:0] = iu_rtu_ex1_bju_data[63:0];

assign rbus_cp0_wb_dp      = cp0_rtu_ex1_wb_dp;
assign rbus_cp0_wb_vld     = cp0_rtu_ex1_wb_vld;
assign rbus_cp0_reg[5:0]   = cp0_rtu_ex1_wb_preg[5:0];
assign rbus_cp0_data[63:0] = cp0_rtu_ex1_wb_data[63:0];

assign rbus_lsu_wb_dp      = lsu_rtu_ex1_wb_dp;
assign rbus_lsu_wb_vld     = lsu_rtu_ex1_wb_vld;
assign rbus_lsu_reg[5:0]   = lsu_rtu_ex1_dest_reg[5:0];
assign rbus_lsu_data[63:0] = lsu_rtu_ex1_data[63:0];

// fwd_vld includes: alu_wb_dp, bju_wb_dp, lsu_wb_dp.
assign rbus_ex1_wb_source_vld[1:0] = {rbus_ex1_fwd_vld,
                                      rbus_cp0_wb_dp};

assign rbus_ex1_wb_dp  = |rbus_ex1_wb_source_vld[1:0];
assign rbus_ex1_wb_vld = rbus_alu_wb_vld
                      || rbus_bju_wb_vld
                      || rbus_cp0_wb_vld
                      || rbus_lsu_wb_vld;

// &CombBeg; @140
always @( rbus_cp0_data[63:0]
       or rbus_cp0_reg[5:0]
       or rbus_ex1_fwd_data[63:0]
       or rbus_ex1_wb_source_vld[1:0]
       or rbus_ex1_fwd_preg[5:0])
begin
  case(rbus_ex1_wb_source_vld[1:0])
    2'b01: // CP0
    begin
      rbus_ex1_preg[5:0]  = rbus_cp0_reg[5:0];
      rbus_ex1_data[63:0] = rbus_cp0_data[63:0];
    end
    2'b10: // ALU, BJU, LSU
    begin
      rbus_ex1_preg[5:0]  = rbus_ex1_fwd_preg[5:0];
      rbus_ex1_data[63:0] = rbus_ex1_fwd_data[63:0];
    end
    default:
    begin
      rbus_ex1_preg[5:0]  = {6{1'bx}};
      rbus_ex1_data[63:0] = {64{1'bx}};
    end
  endcase
// &CombEnd; @158
end

assign rbus_div_wb_dp      = iu_rtu_div_wb_dp;
assign rbus_div_wb_vld     = iu_rtu_div_wb_vld;
assign rbus_div_preg[5:0]  = iu_rtu_div_preg[5:0];
assign rbus_div_data[63:0] = iu_rtu_div_data[63:0];

assign rbus_mul_wb_dp      = iu_rtu_ex3_mul_wb_vld;
assign rbus_mul_wb_vld     = iu_rtu_ex3_mul_wb_vld;
assign rbus_mul_preg[5:0]  = iu_rtu_ex3_mul_preg[5:0];
assign rbus_mul_data[63:0] = iu_rtu_ex3_mul_data[63:0];

//----------------------------------------------------------
//                         Arbiter
//----------------------------------------------------------
assign rbus_wb_source_vld[2:0] = {rbus_ex1_wb_dp,
                                  rbus_div_wb_dp && rbus_div_wb_grant,
                                  rbus_mul_wb_dp && rbus_mul_wb_grant};
assign rbus_wb_vld_dp = |rbus_wb_source_vld[2:0];

// &CombBeg; @178
always @( rbus_div_wb_dp
       or rbus_mul_wb_vld
       or rbus_ex1_wb_vld
       or rbus_div_wb_vld
       or rbus_ex1_wb_dp
       or rbus_mul_data[63:0]
       or rbus_div_preg[5:0]
       or rbus_ex1_preg[5:0]
       or rbus_mul_wb_dp
       or rbus_ex1_data[63:0]
       or rbus_mul_preg[5:0]
       or rbus_div_data[63:0])
begin
  if (rbus_ex1_wb_dp) begin
    rbus_wb_vld         = rbus_ex1_wb_vld;
    rbus_wb_preg[5:0]   = rbus_ex1_preg[5:0];
    rbus_wb_data[63:0]  = rbus_ex1_data[63:0];
  end
  else if (rbus_div_wb_dp) begin
    rbus_wb_vld         = rbus_div_wb_vld;
    rbus_wb_preg[5:0]   = rbus_div_preg[5:0];
    rbus_wb_data[63:0]  = rbus_div_data[63:0];
  end
  else if (rbus_mul_wb_dp) begin
    rbus_wb_vld         = rbus_mul_wb_vld;
    rbus_wb_preg[5:0]   = rbus_mul_preg[5:0];
    rbus_wb_data[63:0]  = rbus_mul_data[63:0];
  end
  else begin
    rbus_wb_vld         = 1'b0;
    rbus_wb_preg[5:0]   = 6'b0;
    rbus_wb_data[63:0]  = 64'b0;
  end
// &CombEnd; @199
end

//----------------------------------------------------------
//                     WriteBack Grant
//----------------------------------------------------------
assign rbus_div_wb_grant = !rbus_ex1_wb_dp;
assign rbus_mul_wb_grant = !rbus_ex1_wb_dp && !rbus_div_wb_dp;

assign rbus_div_wb_grant_for_full = 1'b1;
assign rbus_mul_wb_grant_for_full = !rbus_div_wb_vld;

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign rtu_idu_fwd0_vld        = rbus_ex1_fwd_vld;
assign rtu_idu_fwd0_reg[5:0]   = rbus_ex1_fwd_preg[5:0];
assign rtu_idu_fwd0_data[63:0] = rbus_ex1_fwd_data[63:0];

assign rtu_idu_fwd1_vld        = rbus_mul_fwd_vld;
assign rtu_idu_fwd1_reg[5:0]   = rbus_mul_fwd_preg[5:0];
assign rtu_idu_fwd1_data[63:0] = rbus_mul_fwd_data[63:0];

assign rtu_idu_fwd2_vld        = rbus_lsu_fwd_vld;
assign rtu_idu_fwd2_reg[5:0]   = rbus_lsu_fwd_preg[5:0];
assign rtu_idu_fwd2_data[63:0] = rbus_lsu_fwd_data[63:0];

//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign rbus_wb_rbus_wb_vld         = rbus_wb_vld;
assign rbus_wb_rbus_wb_dp          = rbus_wb_vld_dp;
assign rbus_wb_rbus_wb_preg[5:0]   = rbus_wb_preg[5:0];
assign rbus_wb_rbus_wb_data[63:0]  = rbus_wb_data[63:0];

//----------------------------------------------------------
//                          For IU
//----------------------------------------------------------
assign rtu_iu_div_wb_grant = rbus_div_wb_grant;
assign rtu_iu_mul_wb_grant = rbus_mul_wb_grant;

assign rtu_iu_div_wb_grant_for_full = rbus_div_wb_grant_for_full;
assign rtu_iu_mul_wb_grant_for_full = rbus_mul_wb_grant_for_full;

//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign rtu_cp0_vl_vld      = vlsu_rtu_vl_updt_vld;
assign rtu_cp0_vl[7:0]     = vlsu_rtu_vl_updt_data[7:0];

assign rtu_cp0_fs_dirty_updt    = vpu_rtu_ex1_fp_dirty && vpu_rtu_ex1_cmplt
                               || retire_rbus_fs_dirty;
assign rtu_cp0_fs_dirty_updt_dp = vpu_rtu_ex1_fp_dirty && vpu_rtu_ex1_cmplt_dp
                               || retire_rbus_fs_dirty;

assign rtu_cp0_vs_dirty_updt    = vpu_rtu_ex1_vec_dirty && vpu_rtu_ex1_cmplt
                               || cp0_rtu_ex1_vs_dirty  && cp0_rtu_ex1_cmplt
                               || retire_rbus_vs_dirty;
assign rtu_cp0_vs_dirty_updt_dp = vpu_rtu_ex1_vec_dirty && vpu_rtu_ex1_cmplt_dp
                               || cp0_rtu_ex1_vs_dirty_dp && cp0_rtu_ex1_cmplt_dp
                               || retire_rbus_vs_dirty;

// &ModuleEnd; @263
endmodule



