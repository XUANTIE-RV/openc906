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
module aq_cp0_hpcp_csr(
  cp0_hpcp_mcntwen,
  cpurst_b,
  hpcp_cp0_data,
  hpcp_value,
  iui_regs_csr_write,
  iui_regs_imm,
  iui_regs_wdata,
  mcnten_local_en,
  mcnten_value,
  mcntwen_local_en,
  mcntwen_value,
  regs_clk,
  regs_scnt_inv,
  regs_smode,
  regs_ucnt_inv,
  regs_umode,
  scnten_local_en,
  scnten_value
);


// &Ports; @25
input           cpurst_b;          
input   [63:0]  hpcp_cp0_data;     
input           iui_regs_csr_write; 
input   [11:0]  iui_regs_imm;      
input   [63:0]  iui_regs_wdata;    
input           mcnten_local_en;   
input           mcntwen_local_en;  
input           regs_clk;          
input           regs_smode;        
input           regs_umode;        
input           scnten_local_en;   
output  [31:0]  cp0_hpcp_mcntwen;  
output  [63:0]  hpcp_value;        
output  [63:0]  mcnten_value;      
output  [63:0]  mcntwen_value;     
output          regs_scnt_inv;     
output          regs_ucnt_inv;     
output  [63:0]  scnten_value;      

// &Regs; @26
reg     [31:0]  cnt_sel;           
reg     [31:0]  mcnten_reg;        
reg     [31:0]  mcntwen_reg;       
reg     [31:0]  scnten_reg;        

// &Wires; @27
wire    [31:0]  cp0_hpcp_mcntwen;  
wire            cpurst_b;          
wire    [63:0]  hpcp_cp0_data;     
wire    [63:0]  hpcp_value;        
wire            iui_regs_csr_write; 
wire    [11:0]  iui_regs_imm;      
wire    [63:0]  iui_regs_wdata;    
wire            mcnten_hit;        
wire            mcnten_local_en;   
wire    [63:0]  mcnten_value;      
wire            mcntwen_hit;       
wire            mcntwen_local_en;  
wire    [63:0]  mcntwen_value;     
wire            regs_clk;          
wire            regs_scnt_inv;     
wire            regs_smode;        
wire            regs_ucnt_inv;     
wire            regs_umode;        
wire            scnten_hit;        
wire            scnten_local_en;   
wire    [63:0]  scnten_value;      


//==========================================================
//                 Counter/Timers and Setup
//==========================================================
//----------------------------------------------------------
//                  Machine Counter/Timers
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mcycle     | M cycle counter. .  |                    |
// | minstret   | M inst retire cnt.  |                    |
// | mhpmcntx   | M hpm counter.      |                    |
// |------------|---------------------|--------------------|
// Registers above is instanced in HPCP.

//----------------------------------------------------------
//                Supervisor Counter/Timers
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | scycle     | S cycle counter. .  | T-Head Extension   |
// | sinstret   | S inst retire cnt.  | T-Head Extension   |
// | shpmcntx   | S hpm counter.      | T-Head Extension   |
// |------------|---------------------|--------------------|
// Registers above is instanced in HPCP.

//----------------------------------------------------------
//                   User Counter/Timers
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | cycle      | U cycle counter. .  |                    |
// | instret    | U inst retire cnt.  |                    |
// | hpmcntx    | U hpm counter.      |                    |
// |------------|---------------------|--------------------|
// Registers above is instanced in HPCP.

//----------------------------------------------------------
//                  Machine Counter Setup
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mcntinhbt  | M counter inhibit.  | RV 1.11            |
// | mhpmevtx   | M hpm event select. |                    |
// | mcounteren | M counter enable.   | Machine Trap Setip |
// | mcntwen    | M cnt write enable. | T-Head Extension   |
// | mcntinten  | M cnt int enable.   | T-Head Extension   |
// | mcntintof  | M cnt int of.       | T-Head Extension   |
// |------------|---------------------|--------------------|
// Only mcnten, mcntwen in CP0, other in HPCP.

//----------------------------------------------------------
//                 Supervisor Counter Setup
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | scounteren | S counter enable.   | S Trap Setup       |
// | scntinten  | S cnt int enable.   | T-Head Extension   |
// | scntintof  | S cnt int of.       | T-Head Extension   |
// |------------|---------------------|--------------------|
// Only scnten in CP0, other in HPCP.

//==========================================================
//                 //Define HPCP Registers
//==========================================================
assign hpcp_value[63:0] = {hpcp_cp0_data[63:0]};

//==========================================================
//                  Define the MCOUNTEREN
//==========================================================
//  Machine Trap Vector Register
//  64-bit Machine Mode Read/Write
//  Providing the Trap Vector Base and Mode 
//  the definiton for MTVEC register is listed as follows
//  HPM31...HPM3, IR, TM, CY
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mcnten_reg[31:0] <= 32'b0;
  else if(mcnten_local_en)
    mcnten_reg[31:0] <= iui_regs_wdata[31:0];
  else
    mcnten_reg[31:0] <= mcnten_reg[31:0];
end

assign mcnten_value[63:0] = {32'b0, mcnten_reg[31:0]};

//==========================================================
//                  Define the MCOUNTERWEN
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mcntwen_reg[31:0] <= 32'b0;
  else if(mcntwen_local_en)
    mcntwen_reg[31:0] <= {iui_regs_wdata[31:2], 1'b0, iui_regs_wdata[0]};
  else
    mcntwen_reg[31:0] <= mcntwen_reg[31:0];
end

assign mcntwen_value[63:0] = {32'b0, mcntwen_reg[31:0]};

//==========================================================
//                  Define the SCOUNTEREN
//==========================================================
//  Supervisor Trap Vector Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Trap Vector Base and Mode 
//  the definiton for STVEC register is listed as follows
//  HPM31...HPM3, IR, TM, CY
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    scnten_reg[31:0] <= 32'b0;
  else if(scnten_local_en)
    scnten_reg[31:0] <= iui_regs_wdata[31:0];
  else
    scnten_reg[31:0] <= scnten_reg[31:0];
end

assign scnten_value[63:0] = {32'b0, scnten_reg[31:0]};

//==========================================================
//                   Counter Read Enable
//==========================================================
//----------------------------------------------------------
//                       Addr Decode
//----------------------------------------------------------
// &CombBeg; @163
always @( iui_regs_imm[4:0])
begin
case(iui_regs_imm[4:0])
  5'h00:   cnt_sel[31:0] = 32'h00000001;
  5'h01:   cnt_sel[31:0] = 32'h00000002;
  5'h02:   cnt_sel[31:0] = 32'h00000004;
  5'h03:   cnt_sel[31:0] = 32'h00000008;
  5'h04:   cnt_sel[31:0] = 32'h00000010;
  5'h05:   cnt_sel[31:0] = 32'h00000020;
  5'h06:   cnt_sel[31:0] = 32'h00000040;
  5'h07:   cnt_sel[31:0] = 32'h00000080;
  5'h08:   cnt_sel[31:0] = 32'h00000100;
  5'h09:   cnt_sel[31:0] = 32'h00000200;
  5'h0A:   cnt_sel[31:0] = 32'h00000400;
  5'h0B:   cnt_sel[31:0] = 32'h00000800;
  5'h0C:   cnt_sel[31:0] = 32'h00001000;
  5'h0D:   cnt_sel[31:0] = 32'h00002000;
  5'h0E:   cnt_sel[31:0] = 32'h00004000;
  5'h0F:   cnt_sel[31:0] = 32'h00008000;
  5'h10:   cnt_sel[31:0] = 32'h00010000;
  5'h11:   cnt_sel[31:0] = 32'h00020000;
  5'h12:   cnt_sel[31:0] = 32'h00040000;
  5'h13:   cnt_sel[31:0] = 32'h00080000;
  5'h14:   cnt_sel[31:0] = 32'h00100000;
  5'h15:   cnt_sel[31:0] = 32'h00200000;
  5'h16:   cnt_sel[31:0] = 32'h00400000;
  5'h17:   cnt_sel[31:0] = 32'h00800000;
  5'h18:   cnt_sel[31:0] = 32'h01000000;
  5'h19:   cnt_sel[31:0] = 32'h02000000;
  5'h1A:   cnt_sel[31:0] = 32'h04000000;
  5'h1B:   cnt_sel[31:0] = 32'h08000000;
  5'h1C:   cnt_sel[31:0] = 32'h10000000;
  5'h1D:   cnt_sel[31:0] = 32'h20000000;
  5'h1E:   cnt_sel[31:0] = 32'h40000000;
  5'h1F:   cnt_sel[31:0] = 32'h80000000;
  default: cnt_sel[31:0] = {32{1'bx}};
endcase
// &CombEnd; @199
end

// &Force("bus", "iui_regs_imm", 11, 0); @201
// &Force("bus", "iui_regs_wdata", 63, 0); @202

assign mcnten_hit = |(mcnten_reg[31:0] & cnt_sel[31:0]);
assign scnten_hit = |(scnten_reg[31:0] & cnt_sel[31:0]);

assign mcntwen_hit = |(mcntwen_reg[31:0] & cnt_sel[31:0]);

assign regs_scnt_inv = regs_smode && !mcnten_hit
                    || regs_smode && !mcntwen_hit && iui_regs_csr_write;
assign regs_ucnt_inv = regs_smode && !mcnten_hit
                    || regs_umode && !(mcnten_hit && scnten_hit);

//==========================================================
//                          Output
//==========================================================
assign cp0_hpcp_mcntwen[31:0] = mcntwen_reg[31:0];
// &ModuleEnd; @218
endmodule



