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
module aq_cp0_prtc_csr(
  cp0_dtu_satp,
  cp0_mmu_satp_data,
  cp0_mmu_satp_wen,
  cpurst_b,
  iui_regs_wdata,
  mmu_cp0_cmplt,
  mmu_cp0_data,
  mmu_value,
  pmp_cp0_data,
  pmp_value,
  regs_clk,
  regs_iui_smcir_stall,
  satp_local_en,
  satp_value,
  smcir_local_en,
  smcir_local_en_raw
);


// &Ports; @25
input           cpurst_b;            
input   [63:0]  iui_regs_wdata;      
input           mmu_cp0_cmplt;       
input   [63:0]  mmu_cp0_data;        
input   [63:0]  pmp_cp0_data;        
input           regs_clk;            
input           satp_local_en;       
input           smcir_local_en;      
input           smcir_local_en_raw;  
output  [63:0]  cp0_dtu_satp;        
output  [63:0]  cp0_mmu_satp_data;   
output          cp0_mmu_satp_wen;    
output  [63:0]  mmu_value;           
output  [63:0]  pmp_value;           
output          regs_iui_smcir_stall; 
output  [63:0]  satp_value;          

// &Regs; @26
reg     [15:0]  satp_asid;           
reg     [3 :0]  satp_mode;           
reg     [27:0]  satp_ppn;            

// &Wires; @27
wire    [63:0]  cp0_dtu_satp;        
wire    [63:0]  cp0_mmu_satp_data;   
wire            cp0_mmu_satp_wen;    
wire            cpurst_b;            
wire    [63:0]  iui_regs_wdata;      
wire            mmu_cp0_cmplt;       
wire    [63:0]  mmu_cp0_data;        
wire    [63:0]  mmu_value;           
wire    [63:0]  pmp_cp0_data;        
wire    [63:0]  pmp_value;           
wire            regs_clk;            
wire            regs_iui_smcir_stall; 
wire            satp_local_en;       
wire    [63:0]  satp_value;          
wire            smcir_local_en_raw;  



//==========================================================
//                Protection and Translation
//==========================================================
//----------------------------------------------------------
//            Machine Protection and Translation
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | pmpcfg0    | PMP configuration.  |                    |
// | pmpcfg2    | PMP configuration.  |                    |
// | pmpaddr0-15| PMP addr.           |                    |
// |------------|---------------------|--------------------|
// CSR above is instanced in PMP.

//----------------------------------------------------------
//          Supervisor Protection and Translation
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | satp       | S addr.             |                    |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//            Supervisor MMU Control and Status
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | smcir      | MMU control         | T-Head Extension   |
// | smir       | MMU index           | T-Head Extension   |
// | smeh       | MMU entry high      | T-Head Extension   |
// | smel       | MMU entry low       | T-Head Extension   |
// |------------|---------------------|--------------------|
// CSR above is instanced in MMU

parameter VPN_WIDTH  = 39-12;  // VPN
parameter PPN_WIDTH  = 40-12;  // PPN
parameter FLG_WIDTH  = 14;     // Flags
parameter PGS_WIDTH  = 3;      // Page Size
parameter ASID_WIDTH = 16;     // Flags
//==========================================================
//              Define of PMPCFGx and PMPADDRx
//==========================================================
assign pmp_value[63:0] = pmp_cp0_data[63:0];

//==========================================================
//                      Define of SATP
//==========================================================
//  the definiton for STAP register is listed as follows
//  =======================================================
//  |63  60|59        44|43        28|27                 0|
//  +------+------------+---------------------------------+
//  | Mode |    ASID    |  Reserved  |         PPN        |
//  =======================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    satp_mode[3:0]            <= {4{1'b0}};
  else if(satp_local_en && iui_regs_wdata[62:60] == 3'b0)
    satp_mode[3:0]            <= {iui_regs_wdata[63],3'b0};
end

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    satp_asid[ASID_WIDTH-1:0] <= {ASID_WIDTH{1'b0}};
    satp_ppn[PPN_WIDTH-1:0]   <= {PPN_WIDTH{1'b0}};
  end
  else if(satp_local_en)
  begin
    satp_asid[ASID_WIDTH-1:0] <= iui_regs_wdata[59:44];
    satp_ppn[PPN_WIDTH-1:0]   <= iui_regs_wdata[PPN_WIDTH-1:0];
  end
end

assign satp_value[63:0] = {satp_mode[3:0],satp_asid[ASID_WIDTH-1:0],
                          16'b0,satp_ppn[PPN_WIDTH-1:0]};
// &Force("output", "satp_value"); &Force("bus", "satp_value", 63, 0); @110

//==========================================================
//             Define of MMU Control and Status
//==========================================================
assign mmu_value[63:0] = mmu_cp0_data[63:0];

//==========================================================
//                        MMU Stall
//==========================================================
assign regs_iui_smcir_stall = smcir_local_en_raw && !mmu_cp0_cmplt;
// &Force("input", "smcir_local_en"); @121

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For MMU
//----------------------------------------------------------
assign cp0_mmu_satp_data[63:0] = satp_value[63:0];
assign cp0_mmu_satp_wen        = satp_local_en;

//----------------------------------------------------------
//                         For DTU
//----------------------------------------------------------
assign cp0_dtu_satp[63:0]      = satp_value[63:0];

// &ModuleEnd; @137
endmodule



