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
module aq_cp0_float_csr(
  cp0_idu_frm,
  cp0_idu_vill,
  cp0_idu_vl_zero,
  cp0_idu_vlmul,
  cp0_idu_vsew,
  cp0_idu_vstart,
  cp0_rtu_vstart_eq_0,
  cp0_vpu_xx_bf16,
  cp0_vpu_xx_dqnan,
  cp0_vpu_xx_rm,
  cp0_yy_clk_en,
  cpurst_b,
  fcsr_local_en,
  fcsr_value,
  fflags_local_en,
  fflags_value,
  float_clk,
  forever_cpuclk,
  frm_local_en,
  frm_value,
  fs_dirty_upd_gate,
  fxcr_local_en,
  fxcr_value,
  iui_inst_rs2,
  iui_regs_csr_wen,
  iui_regs_wdata,
  iui_vsetvl_bypass,
  iui_vsetvl_data,
  pad_yy_icg_scan_en,
  regs_clk,
  regs_xx_icg_en,
  rtu_cp0_fflags,
  rtu_cp0_fflags_updt,
  rtu_cp0_vl,
  rtu_cp0_vl_vld,
  rtu_cp0_vstart,
  rtu_cp0_vstart_vld,
  rtu_cp0_vxsat,
  rtu_cp0_vxsat_vld,
  special_regs_vill,
  special_regs_vsetvl_dp,
  special_vsetvl_illegal,
  vl_value,
  vlenb_value,
  vs_dirty_upd_gate,
  vstart_value,
  vtype_value,
  vxrm_value,
  vxsat_value
);


// &Ports; @25
input           cp0_yy_clk_en;         
input           cpurst_b;              
input           fcsr_local_en;         
input           fflags_local_en;       
input           forever_cpuclk;        
input           frm_local_en;          
input           fs_dirty_upd_gate;     
input           fxcr_local_en;         
input   [63:0]  iui_inst_rs2;          
input           iui_regs_csr_wen;      
input   [63:0]  iui_regs_wdata;        
input           iui_vsetvl_bypass;     
input   [4 :0]  iui_vsetvl_data;       
input           pad_yy_icg_scan_en;    
input           regs_clk;              
input           regs_xx_icg_en;        
input   [4 :0]  rtu_cp0_fflags;        
input           rtu_cp0_fflags_updt;   
input   [7 :0]  rtu_cp0_vl;            
input           rtu_cp0_vl_vld;        
input   [6 :0]  rtu_cp0_vstart;        
input           rtu_cp0_vstart_vld;    
input           rtu_cp0_vxsat;         
input           rtu_cp0_vxsat_vld;     
input           special_regs_vill;     
input           special_regs_vsetvl_dp; 
input           special_vsetvl_illegal; 
input           vs_dirty_upd_gate;     
output  [2 :0]  cp0_idu_frm;           
output          cp0_idu_vill;          
output          cp0_idu_vl_zero;       
output  [1 :0]  cp0_idu_vlmul;         
output  [1 :0]  cp0_idu_vsew;          
output  [6 :0]  cp0_idu_vstart;        
output          cp0_rtu_vstart_eq_0;   
output          cp0_vpu_xx_bf16;       
output          cp0_vpu_xx_dqnan;      
output  [2 :0]  cp0_vpu_xx_rm;         
output  [63:0]  fcsr_value;            
output  [63:0]  fflags_value;          
output          float_clk;             
output  [63:0]  frm_value;             
output  [63:0]  fxcr_value;            
output  [63:0]  vl_value;              
output  [63:0]  vlenb_value;           
output  [63:0]  vstart_value;          
output  [63:0]  vtype_value;           
output  [63:0]  vxrm_value;            
output  [63:0]  vxsat_value;           

// &Regs; @26
reg     [4 :0]  fcsr_fflags;           
reg     [2 :0]  fcsr_frm;              
reg             fxcr_bf16;             
reg             fxcr_dqnan;            
reg             fxcr_fe;               

// &Wires; @27
wire    [2 :0]  cp0_idu_frm;           
wire            cp0_idu_vill;          
wire            cp0_idu_vl_zero;       
wire    [1 :0]  cp0_idu_vlmul;         
wire    [1 :0]  cp0_idu_vsew;          
wire    [6 :0]  cp0_idu_vstart;        
wire            cp0_rtu_vstart_eq_0;   
wire            cp0_vpu_xx_bf16;       
wire            cp0_vpu_xx_dqnan;      
wire    [2 :0]  cp0_vpu_xx_rm;         
wire            cp0_yy_clk_en;         
wire            cpurst_b;              
wire            fcsr_local_en;         
wire    [63:0]  fcsr_value;            
wire    [1 :0]  fcsr_vxrm;             
wire            fcsr_vxsat;            
wire            fflags_local_en;       
wire    [63:0]  fflags_value;          
wire            float_clk;             
wire            float_clk_en;          
wire            forever_cpuclk;        
wire            frm_local_en;          
wire    [63:0]  frm_value;             
wire            fs_dirty_upd_gate;     
wire            fxcr_local_en;         
wire    [63:0]  fxcr_value;            
wire    [63:0]  iui_inst_rs2;          
wire            iui_regs_csr_wen;      
wire    [63:0]  iui_regs_wdata;        
wire            iui_vsetvl_bypass;     
wire    [4 :0]  iui_vsetvl_data;       
wire            pad_yy_icg_scan_en;    
wire            regs_clk;              
wire            regs_vstart_eq_0;      
wire            regs_xx_icg_en;        
wire    [4 :0]  rtu_cp0_fflags;        
wire            rtu_cp0_fflags_updt;   
wire            rtu_cp0_vl_vld;        
wire            rtu_cp0_vstart_vld;    
wire            rtu_cp0_vxsat_vld;     
wire            special_regs_vill;     
wire            special_regs_vsetvl_dp; 
wire            special_vsetvl_illegal; 
wire            vl_bypass_zero;        
wire    [63:0]  vl_value;              
wire    [7 :0]  vl_vl;                 
wire    [63:0]  vlenb_value;           
wire            vs_dirty_upd_gate;     
wire    [63:0]  vstart_value;          
wire    [6 :0]  vstart_vstart;         
wire    [63:0]  vtype_value;           
wire            vtype_vill;            
wire    [1 :0]  vtype_vlmul;           
wire    [2 :0]  vtype_vsew;            
wire    [63:0]  vxrm_value;            
wire    [63:0]  vxsat_value;           


//==========================================================
//                     Float and Vector
//==========================================================
//----------------------------------------------------------
//                   User Floating-Point
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | fflags     | Float accured expt. |                    |
// | frm        | Float dyn rnd mode. |                    |
// | fcsr       | ctrl and status.    |                    |
// | fxcr       | ext ctrl and status | T-Head Extension   |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//                       User Vector
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | vstart     | Vec start position. |                    |
// | vxsat      | FP sat flag.        |                    |
// | vxrm       | FP round mode.      |                    |
// | vl         | Vector length.      |                    |
// | vtype      | Vector data type.   |                    |
// | vlenb      | VLEN/8              |                    |
// |------------|---------------------|--------------------|

// &Force("bus", "iui_regs_wdata", 63, 0); @58
//==========================================================
//                    Define the FFLAGS
//==========================================================
always @ (posedge float_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    fcsr_fflags[4:0] <= 5'b0;
  end
  else if (fcsr_local_en) begin
    fcsr_fflags[4:0] <= iui_regs_wdata[4:0];
  end
  else if (fflags_local_en) begin
    fcsr_fflags[4:0] <= iui_regs_wdata[4:0];
  end
  else if (fxcr_local_en) begin
    fcsr_fflags[4:0] <= iui_regs_wdata[4:0];
  end
  else if (rtu_cp0_fflags_updt) begin
    fcsr_fflags[4:0] <= fcsr_fflags[4:0] | rtu_cp0_fflags[4:0];
  end
  else begin
    fcsr_fflags[4:0] <= fcsr_fflags[4:0];
  end
end
// &Force("input", "rtu_cp0_fflags_updt"); @86
// &Force("input", "rtu_cp0_fflags"); &Force("bus", "rtu_cp0_fflags", 4, 0); @87

assign fflags_value[63:0] = {59'b0, fcsr_fflags[4:0]};

//==========================================================
//                      Define the FRM
//==========================================================
always @ (posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    fcsr_frm[2:0] <= 3'b0;
  end
  else if (fcsr_local_en) begin
    fcsr_frm[2:0] <= iui_regs_wdata[7:5];
  end
  else if (frm_local_en) begin
    fcsr_frm[2:0] <= iui_regs_wdata[2:0];
  end
  else if (fxcr_local_en) begin
    fcsr_frm[2:0] <= iui_regs_wdata[26:24];
  end
  else begin
    fcsr_frm[2:0] <= fcsr_frm[2:0];
  end
end

assign frm_value[63:0] = {61'b0, fcsr_frm[2:0]};

//==========================================================
//                     Define the FCSR
//==========================================================
assign fcsr_value[63:0]   = {32'b0, 21'b0, fcsr_vxrm[1:0], fcsr_vxsat,
                             fcsr_frm[2:0], fcsr_fflags[4:0]};

//==========================================================
//                     Define the FXCR
//==========================================================
always @ (posedge float_clk or negedge cpurst_b)
begin 
  if (!cpurst_b)
    fxcr_fe <= 1'b0;
  else if (fxcr_local_en)
    fxcr_fe <= iui_regs_wdata[5];
  else if (rtu_cp0_fflags_updt)
    fxcr_fe <= fxcr_fe || (|rtu_cp0_fflags[4:0]);
  else
    fxcr_fe <= fxcr_fe;
end

always @ (posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    fxcr_dqnan <= 1'b0;
    fxcr_bf16  <= 1'b0;
  end
  else if (fxcr_local_en) begin
    fxcr_dqnan <= iui_regs_wdata[23];
    fxcr_bf16  <= iui_regs_wdata[31];
  end
  else begin
    fxcr_dqnan <= fxcr_dqnan;
    fxcr_bf16  <= fxcr_bf16;
  end
end

assign fxcr_value[63:0] = {32'b0, fxcr_bf16,
                           4'b0, fcsr_frm[2:0], fxcr_dqnan,
                           17'b0, fxcr_fe, fcsr_fflags[4:0]};

//==========================================================
//                    Define the VSTART
//==========================================================
// &Force("input", "rtu_cp0_vstart_vld"); @188
// &Force("input", "rtu_cp0_vstart"); &Force("bus", "rtu_cp0_vstart", 6, 0); @189
assign vstart_vstart[6:0] = 7'b0;

assign regs_vstart_eq_0 = vstart_vstart[6:0] == 7'b0;

assign vstart_value[63:0] = {57'b0, vstart_vstart[6:0]};

//==========================================================
//                     Define the VXSAT
//==========================================================
// &Force("input", "rtu_cp0_vxsat_vld"); @215
// &Force("input", "rtu_cp0_vxsat"); @216
assign fcsr_vxsat = 1'b0;

assign vxsat_value[63:0] = {63'b0, fcsr_vxsat};

//==========================================================
//                     Define the VXRM
//==========================================================
assign fcsr_vxrm[1:0] = 2'b0;

assign vxrm_value[63:0] = {62'b0, fcsr_vxrm[1:0]};

//==========================================================
//                      Define the VL
//==========================================================
// &Force("input", "rtu_cp0_vl_vld"); @259
// &Force("input", "rtu_cp0_vl"); &Force("bus", "rtu_cp0_vl", 7, 0); @260
assign vl_vl[7:0] = 8'b0;

assign vl_value[63:0] = {56'b0, vl_vl[7:0]};

//==========================================================
//                     Define the VTYPE
//==========================================================
assign vtype_vill       = 1'b1;
assign vtype_vsew[2:0]  = 3'b0;
assign vtype_vlmul[1:0] = 2'b0;

assign vtype_value[63:0] = {vtype_vill, 56'b0, 2'b0,
                            vtype_vsew[2:0], vtype_vlmul[1:0]};

//==========================================================
//                     Define the VLENB
//==========================================================
assign vlenb_value[63:0] = 64'd16; //VLEN 128 bit

//==========================================================
//                           ICG
//==========================================================
assign float_clk_en = iui_regs_csr_wen
                   || special_regs_vsetvl_dp
                   || rtu_cp0_fflags_updt
                   || rtu_cp0_vstart_vld
                   || rtu_cp0_vxsat_vld
                   || rtu_cp0_vl_vld
                   || fs_dirty_upd_gate
                   || vs_dirty_upd_gate;
// &Instance("gated_clk_cell", "x_float_clk"); @316
gated_clk_cell  x_float_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (float_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (float_clk_en      ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @317
//          .external_en (1'b0), @318
//          .global_en   (cp0_yy_clk_en), @319
//          .module_en   (regs_xx_icg_en), @320
//          .local_en    (float_clk_en), @321
//          .clk_out     (float_clk)); @322
// &Force("output", "float_clk"); @323

// &Force("output", "vec_clk"); @327

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------

assign cp0_idu_frm[2:0]    = fcsr_frm[2:0];
//assign cp0_idu_vill        = vtype_vill;
//assign cp0_idu_vl[7:0]     = vl_vl[7:0];
//assign cp0_idu_vlmul[1:0]  = vtype_vlmul[1:0];
//assign cp0_idu_vsew[1:0]   = vtype_vsew[1:0];
//assign cp0_idu_vstart[6:0] = vstart_vstart[6:0];

assign cp0_idu_vill        =  iui_vsetvl_bypass ? special_regs_vill : vtype_vill;
assign cp0_idu_vl_zero     =  iui_vsetvl_bypass ? vl_bypass_zero : vl_vl[7:0] == 8'b0 ;
//assign cp0_idu_vl_zero     =  1'b0;
assign vl_bypass_zero      = special_vsetvl_illegal || ~|iui_inst_rs2[63:0];
assign cp0_idu_vlmul[1:0]  =  iui_vsetvl_bypass ? iui_vsetvl_data[1:0] : vtype_vlmul[1:0];
assign cp0_idu_vsew[1:0]   =  iui_vsetvl_bypass ? iui_vsetvl_data[3:2] : vtype_vsew[1:0];
assign cp0_idu_vstart[6:0] =  iui_vsetvl_bypass ? 7'b0 : vstart_vstart[6:0];
// &Force("bus","iui_vsetvl_data",4,0); @361
//----------------------------------------------------------
//                         For LSU
//----------------------------------------------------------

//----------------------------------------------------------
//                         For VPU
//----------------------------------------------------------
assign cp0_vpu_xx_rm[2:0]    = fcsr_frm[2:0];
assign cp0_vpu_xx_dqnan      = fxcr_dqnan;
assign cp0_vpu_xx_bf16       = fxcr_bf16;


//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign cp0_rtu_vstart_eq_0 = regs_vstart_eq_0;

// &ModuleEnd; @390
endmodule



