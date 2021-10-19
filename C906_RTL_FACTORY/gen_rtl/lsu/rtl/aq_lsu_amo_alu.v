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

// &Depend("cpu_cfig.h"); @18

// &ModuleBeg; @20
module aq_lsu_amo_alu(
  amo_alu_stb_id,
  amo_alu_stb_rst,
  amo_alu_stb_rst_vld,
  cp0_lsu_icg_en,
  cpurst_b,
  da_amo_alu_func,
  da_amo_alu_size,
  da_amo_alu_src0,
  da_amo_src_vld,
  da_amo_stb_id,
  forever_cpuclk,
  ifu_lsu_warm_up,
  pad_yy_icg_scan_en,
  stb_amo_alu_src1
);

// &Ports; @21
input           cp0_lsu_icg_en;     
input           cpurst_b;           
input   [4 :0]  da_amo_alu_func;    
input   [1 :0]  da_amo_alu_size;    
input   [63:0]  da_amo_alu_src0;    
input           da_amo_src_vld;     
input   [1 :0]  da_amo_stb_id;      
input           forever_cpuclk;     
input           ifu_lsu_warm_up;    
input           pad_yy_icg_scan_en; 
input   [63:0]  stb_amo_alu_src1;   
output  [1 :0]  amo_alu_stb_id;     
output  [63:0]  amo_alu_stb_rst;    
output          amo_alu_stb_rst_vld; 

// &Regs; @22
reg     [64:0]  alu_adder_rs0;      
reg     [64:0]  alu_adder_rs1_raw;  
reg     [63:0]  alu_rst;            
reg     [63:0]  amo_rst_ff;         
reg             amo_rst_vld_ff;     
reg     [1 :0]  amo_stb_id_ff;      

// &Wires; @23
wire    [64:0]  alu_adder_add_rst;  
wire            alu_adder_cin;      
wire            alu_adder_op_sub;   
wire    [64:0]  alu_adder_rs1;      
wire            alu_adder_rst_sel;  
wire            alu_adder_sel;      
wire    [63:0]  alu_adder_src0;     
wire    [63:0]  alu_adder_src1;     
wire    [63:0]  alu_logic_and_rst;  
wire    [63:0]  alu_logic_or_rst;   
wire    [63:0]  alu_logic_rst;      
wire            alu_logic_rst_sel;  
wire            alu_logic_sel;      
wire    [63:0]  alu_logic_src0;     
wire    [63:0]  alu_logic_src1;     
wire    [63:0]  alu_logic_xor_rst;  
wire            alu_rst_src0_sel;   
wire            alu_src_rst_sel;    
wire    [63:0]  alu_src_sel_rst;    
wire            amo_add;            
wire    [1 :0]  amo_alu_stb_id;     
wire    [63:0]  amo_alu_stb_rst;    
wire            amo_alu_stb_rst_vld; 
wire            amo_and;            
wire            amo_clk;            
wire            amo_clk_en;         
wire            amo_dw;             
wire            amo_max;            
wire            amo_maxu;           
wire            amo_min;            
wire            amo_minu;           
wire    [4 :0]  amo_op;             
wire            amo_or;             
wire    [1 :0]  amo_size;           
wire            amo_src_vld;        
wire    [1 :0]  amo_stb_id;         
wire            amo_swap;           
wire            amo_wd;             
wire            amo_xor;            
wire            cp0_lsu_icg_en;     
wire            cpurst_b;           
wire    [4 :0]  da_amo_alu_func;    
wire    [1 :0]  da_amo_alu_size;    
wire    [63:0]  da_amo_alu_src0;    
wire            da_amo_src_vld;     
wire    [1 :0]  da_amo_stb_id;      
wire            dw_sign_ext;        
wire            dw_unsign_ext;      
wire            forever_cpuclk;     
wire            ifu_lsu_warm_up;    
wire            pad_yy_icg_scan_en; 
wire    [63:0]  src0_data;          
wire    [63:0]  src1_data;          
wire    [63:0]  stb_amo_alu_src1;   
wire            unsign_ext;         
wire            wd_sign_ext;        
wire            wd_unsign_ext;      


parameter WORD  = 2'b10;
parameter DWORD = 2'b11;
//================================================
//        input interface
//================================================
assign amo_src_vld     = da_amo_src_vld;
assign amo_stb_id[1:0] = da_amo_stb_id[1:0];

assign src0_data[63:0] = da_amo_alu_src0[63:0]; 
assign src1_data[63:0] = stb_amo_alu_src1[63:0]; 

assign amo_op[4:0]   = da_amo_alu_func[4:0];
assign amo_size[1:0] = da_amo_alu_size[1:0];
//================================================
//        operand decode
//================================================
//----------------decode--------------------
//size decode
assign amo_wd = (amo_size[1:0] == WORD);
assign amo_dw = (amo_size[1:0] == DWORD);

//op decode
assign amo_add  = (amo_op[4:0] == 5'b00000);
assign amo_swap = (amo_op[4:0] == 5'b00001);
assign amo_xor  = (amo_op[4:0] == 5'b00100);
assign amo_and  = (amo_op[4:0] == 5'b01100);
assign amo_or   = (amo_op[4:0] == 5'b01000);
assign amo_min  = (amo_op[4:0] == 5'b10000);
assign amo_minu = (amo_op[4:0] == 5'b11000);
assign amo_max  = (amo_op[4:0] == 5'b10100);
assign amo_maxu = (amo_op[4:0] == 5'b11100);

//----------------src ext prepare-----------------
assign unsign_ext = amo_minu || amo_maxu;

assign dw_sign_ext   = amo_dw && !unsign_ext;
assign dw_unsign_ext = amo_dw && unsign_ext;
assign wd_sign_ext   = amo_wd && !unsign_ext;
assign wd_unsign_ext = amo_wd && unsign_ext;

//----------------adder op prepare-----------------
assign alu_adder_op_sub = !amo_add;
//================================================
//        ALU adder op
//================================================
//for power,use operand mux
//adder func:
//max/min/add
assign alu_adder_sel = amo_add 
                       || amo_min 
                       || amo_minu 
                       || amo_max 
                       || amo_maxu; 

assign alu_adder_src0[63:0] = {64{alu_adder_sel}} & src0_data[63:0];
assign alu_adder_src1[63:0] = {64{alu_adder_sel}} & src1_data[63:0];
//----------------src0 prepare--------------------
// &CombBeg; @82
always @( alu_adder_src0[63:0]
       or dw_unsign_ext
       or dw_sign_ext
       or wd_unsign_ext
       or wd_sign_ext)
begin
  case({dw_sign_ext,dw_unsign_ext,wd_sign_ext,wd_unsign_ext})
    4'b0001: alu_adder_rs0[64:0] = {33'b0, alu_adder_src0[31:0]};                    // unsign 32 op
    4'b0010: alu_adder_rs0[64:0] = {{33{alu_adder_src0[31]}}, alu_adder_src0[31:0]}; // sign 32 op
    4'b0100: alu_adder_rs0[64:0] = {1'b0, alu_adder_src0[63:0]};                     // unsign 64 op
    4'b1000: alu_adder_rs0[64:0] = {alu_adder_src0[63], alu_adder_src0[63:0]};       // sign 64 op
    default: alu_adder_rs0[64:0] = {65{1'bx}};
  endcase
// &CombEnd; @90
end
//----------------src1 prepare--------------------
// &CombBeg; @92
always @( dw_unsign_ext
       or dw_sign_ext
       or wd_unsign_ext
       or alu_adder_src1[63:0]
       or wd_sign_ext)
begin
  case({dw_sign_ext,dw_unsign_ext,wd_sign_ext,wd_unsign_ext})
    4'b0001: alu_adder_rs1_raw[64:0] = {33'b0, alu_adder_src1[31:0]};                    // unsign 32 op
    4'b0010: alu_adder_rs1_raw[64:0] = {{33{alu_adder_src1[31]}}, alu_adder_src1[31:0]}; // sign 32 op
    4'b0100: alu_adder_rs1_raw[64:0] = {1'b0, alu_adder_src1[63:0]};                     // unsign 64 op
    4'b1000: alu_adder_rs1_raw[64:0] = {alu_adder_src1[63], alu_adder_src1[63:0]};       // sign 64 op
    default: alu_adder_rs1_raw[64:0] = {65{1'bx}};
  endcase
// &CombEnd; @100
end

assign alu_adder_rs1[64:0]      = alu_adder_op_sub   ? ~alu_adder_rs1_raw[64:0] : alu_adder_rs1_raw[64:0];
//----------------ALU adder---------------------------
assign alu_adder_add_rst[64:0] = alu_adder_rs0[64:0] + alu_adder_rs1[64:0] + {64'b0, alu_adder_op_sub};
assign alu_adder_cin           = alu_adder_add_rst[64];
//================================================
//        ALU src sel op
//================================================
//logic func:
//min/max/swap
//min/max sel use adder rst
assign alu_rst_src0_sel = ((amo_max || amo_maxu) ^ alu_adder_cin)
                          && !amo_swap;

assign alu_src_sel_rst[63:0] = alu_rst_src0_sel
                               ? src0_data[63:0]
                               : src1_data[63:0];

//================================================
//        ALU logic op
//================================================
//----------------src prepare-------------------------
//for power,use operand mux
//logic func:
//or, xor, and
assign alu_logic_sel = amo_xor || amo_or || amo_and;
assign alu_logic_src0[63:0] = {64{alu_logic_sel}} & src0_data[63:0];
assign alu_logic_src1[63:0] = {64{alu_logic_sel}} & src1_data[63:0];
//----------------ALU logic---------------------------
assign alu_logic_and_rst[63:0] = alu_logic_src0[63:0] & alu_logic_src1[63:0];
assign alu_logic_xor_rst[63:0] = alu_logic_src0[63:0] ^ alu_logic_src1[63:0];
assign alu_logic_or_rst[63:0]  = alu_logic_src0[63:0] | alu_logic_src1[63:0];

assign alu_logic_rst[63:0] = {64{amo_and}} & alu_logic_and_rst[63:0] |
                             {64{amo_xor}} & alu_logic_xor_rst[63:0] |
                             {64{amo_or}}  & alu_logic_or_rst[63:0];
//================================================
//        ALU rst select
//================================================
//--------------ALU rst prepare-------------------
assign alu_adder_rst_sel = amo_add;
assign alu_logic_rst_sel = alu_logic_sel;
assign alu_src_rst_sel   = amo_swap 
                           || amo_min 
                           || amo_minu 
                           || amo_max 
                           || amo_maxu; 

// &CombBeg; @149
always @( alu_adder_add_rst[63:0]
       or alu_adder_rst_sel
       or alu_logic_rst[63:0]
       or alu_src_rst_sel
       or alu_src_sel_rst[63:0]
       or alu_logic_rst_sel)
begin
  case({alu_src_rst_sel,alu_logic_rst_sel,alu_adder_rst_sel})
    3'b001 :  alu_rst[63:0] = alu_adder_add_rst[63:0];
    3'b010 :  alu_rst[63:0] = alu_logic_rst[63:0];
    3'b100 :  alu_rst[63:0] = alu_src_sel_rst[63:0];
    default:  alu_rst[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @156
end
//================================================
//        data flop
//================================================
//for timing,flop rst data before fwd
assign amo_clk_en = amo_src_vld || amo_rst_vld_ff || ifu_lsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_amo_gated_clk"); @163
gated_clk_cell  x_aq_lsu_amo_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (amo_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (amo_clk_en        ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @164
//          .external_en (1'b0), @165
//          .global_en   (1'b1), @166
//          .module_en   (cp0_lsu_icg_en), @167
//          .local_en    (amo_clk_en), @168
//          .clk_out     (amo_clk)); @169

always@(posedge amo_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    amo_rst_vld_ff <= 1'b0;
  else
    amo_rst_vld_ff <= amo_src_vld;
end

always@(posedge amo_clk)
begin
  if (amo_src_vld || ifu_lsu_warm_up)
  begin 
    amo_rst_ff[63:0]   <=  alu_rst[63:0];
    amo_stb_id_ff[1:0] <=  amo_stb_id[1:0];
  end
end

//================================================
//        output interface
//================================================
assign amo_alu_stb_rst_vld   = amo_rst_vld_ff;
assign amo_alu_stb_id[1:0]   = amo_stb_id_ff[1:0];
assign amo_alu_stb_rst[63:0] = amo_rst_ff[63:0];


// &ModuleEnd; @196
endmodule



