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
module aq_cp0_info_csr(
  biu_cp0_coreid,
  cpurst_b,
  iui_regs_csr_en,
  marchid_value,
  mcpuid_local_en,
  mcpuid_value,
  mhartid_value,
  mimpid_value,
  misa_value,
  mvendorid_value,
  regs_clk,
  regs_mxl
);


// &Ports; @25
input   [2 :0]  biu_cp0_coreid;         
input           cpurst_b;               
input           iui_regs_csr_en;        
input           mcpuid_local_en;        
input           regs_clk;               
output  [63:0]  marchid_value;          
output  [63:0]  mcpuid_value;           
output  [63:0]  mhartid_value;          
output  [63:0]  mimpid_value;           
output  [63:0]  misa_value;             
output  [63:0]  mvendorid_value;        
output  [1 :0]  regs_mxl;               

// &Regs; @26
reg     [2 :0]  index;                  
reg     [63:0]  mcpuid_value;           

// &Wires; @27
wire    [2 :0]  biu_cp0_coreid;         
wire    [31:0]  cpuid_index0_value;     
wire    [31:0]  cpuid_index1_value;     
wire    [31:0]  cpuid_index2_value;     
wire    [31:0]  cpuid_index3_value;     
wire    [31:0]  cpuid_index4_value;     
wire            cpuid_index5_core_num_1; 
wire            cpuid_index5_core_num_2; 
wire            cpuid_index5_core_num_3; 
wire    [31:0]  cpuid_index5_value;     
wire    [31:0]  cpuid_index6_value;     
wire            cpurst_b;               
wire    [25:0]  extensions;             
wire            index_max;              
wire    [2 :0]  index_next_val;         
wire            iui_regs_csr_en;        
wire    [63:0]  marchid_value;          
wire            mcpuid_local_en;        
wire    [63:0]  mhartid_value;          
wire    [63:0]  mimpid_value;           
wire            misa_fd;                
wire    [63:0]  misa_value;             
wire            misa_vector;            
wire    [63:0]  mvendorid_value;        
wire    [1 :0]  mxl;                    
wire            regs_clk;               
wire    [1 :0]  regs_mxl;               



//==========================================================
//              Machine information Registers
//==========================================================
// |-----------|---------------------|--------------------|
// |   Name    |    Description      |        Note        |
// |-----------|---------------------|--------------------|
// | mvendoird | Vendor ID.          |                    |
// | marchid   | Architecture ID.    |                    |
// | mimpid    | Implementation ID.  |                    |
// | mhartid   | Hardware thread ID. |                    |
// | misa      | ISA and entensions. | Machine Trap Setup |
// | mcpuid    | CPU ID v5.          | T-Head Extension   |
// |-----------|---------------------|--------------------|

//----------------------------------------------------------
//                   Define the MVENDORID
//----------------------------------------------------------
//  Machine Vendor ID Register
//  64-bit readonly
//  Providing the JEDEC ID of T-Head
//----------------------------------------------------------
assign mvendorid_value[63:0] = 64'h5B7;

//----------------------------------------------------------
//                    Define the MARCHID
//----------------------------------------------------------
//  Machine Architecture ID Register
//  64-bit readonly
//  *Currently not implemented, need to be defined
//----------------------------------------------------------
assign marchid_value[63:0] = 64'b0;

//----------------------------------------------------------
//                    Define the MIMPID
//----------------------------------------------------------
//  Machine Implementation ID Register
//  64-bit readonly
//  Providing the implementation ID of the version of core
//  *Currently not implemented, need to be defined
//==========================================================
assign mimpid_value[63:0] = 64'b0;

//----------------------------------------------------------
//                    Define the MHARTID
//----------------------------------------------------------
//  Machine Hart ID Register
//  64-bit readonly
//  Providing the Hart ID of the current core
//----------------------------------------------------------
assign mhartid_value[63:0] = {61'b0, biu_cp0_coreid[2:0]};

//----------------------------------------------------------
//                     Define the MISA
//----------------------------------------------------------
//  Machine Status Register
//  32-bit Machine Mode Read/Write
//  Providing the ISA extension infor of the current core
//  the definiton for MISA register is listed as follows
//----------------------------------------------------------
// [63:62]     [61:26]     [25:0]
//   MXL       Reserved  Extensions
// RV64, MXL is 2.
assign mxl[1:0] = 2'b10;

//  RV64 IMAFDC (G) + S Mode + U mode + Non-Standard Ex
//  + Vector (Configurable)
// [23] [21] [20] [18] [12] [8] [7] [5] [3] [2] [0]
//  X    V    U    S    M    I   H   F   D   C   A
assign misa_vector = 1'b0;
assign misa_fd     = 1'b1;
assign extensions[25:0] = {2'b0, 2'b10, misa_vector, 1'b1, 4'b0100,
                                4'b0001, 4'b0001, 1'b0, 1'b0, 
                                misa_fd,1'b0,misa_fd,3'b101};
assign misa_value[63:0] = {mxl[1:0], 36'b0, extensions[25:0]};

//----------------------------------------------------------
//                    Define the MCPUID
//----------------------------------------------------------
//----------- Index Register -----------
assign index_max = (index[2:0] == 3'd6);
assign index_next_val[2:0] = (index_max) ? 3'd0
                                         : index[2:0] + 3'd1;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    index[2:0] <= 3'b0;
  else if(iui_regs_csr_en && mcpuid_local_en)
    index[2:0] <= index_next_val[2:0];
  else
    index[2:0] <= index[2:0];
end

//--------- Implement of CPUID ---------
// &CombBeg; @132
always @( cpuid_index1_value[31:0]
       or cpuid_index2_value[31:0]
       or cpuid_index5_value[31:0]
       or index[2:0]
       or cpuid_index6_value[31:0]
       or cpuid_index0_value[31:0]
       or cpuid_index4_value[31:0]
       or cpuid_index3_value[31:0])
begin
  case(index[2:0])
  3'b000   : mcpuid_value[63:0] = {32'b0, cpuid_index0_value[31:0]};
  3'b001   : mcpuid_value[63:0] = {32'b0, cpuid_index1_value[31:0]};
  3'b010   : mcpuid_value[63:0] = {32'b0, cpuid_index2_value[31:0]};
  3'b011   : mcpuid_value[63:0] = {32'b0, cpuid_index3_value[31:0]};
  3'b100   : mcpuid_value[63:0] = {32'b0, cpuid_index4_value[31:0]};
  3'b101   : mcpuid_value[63:0] = {32'b0, cpuid_index5_value[31:0]};
  3'b110   : mcpuid_value[63:0] = {32'b0, cpuid_index6_value[31:0]};
  default  : mcpuid_value[63:0] = 64'b0;
  endcase
// &CombEnd; @143
end

//---------------------------------------------------------
//                    Index 0
//---------------------------------------------------------
    assign cpuid_index0_value[31:28] = 4'b0000;

//------------------------------------------------
//                     Arch  
//------------------------------------------------
    assign cpuid_index0_value[27:26] = 2'b10;   // CSKY V3 ISA Arch

//------------------------------------------------
//                     Family
//------------------------------------------------
    assign cpuid_index0_value[25:22] = 4'b0100; // C Series Family

//------------------------------------------------
//                     Class 
//------------------------------------------------
    assign cpuid_index0_value[21:18] = 4'b0100; // C906 Class

//------------------------------------------------
//                     Model 
//------------------------------------------------
    assign cpuid_index0_value[17:12] = 6'b0; 
    assign cpuid_index0_value[11] = 1'b0;
    assign cpuid_index0_value[10] = 1'b0;  
    assign cpuid_index0_value[9] = 1'b0;
    assign cpuid_index0_value[8] = 1'b1;  //FPU
//------------------------------------------------
//                    ISA Revision
//------------------------------------------------
//Revision 0:
//  Initial revision
    assign cpuid_index0_value[7:3] = 5'b00001; 

//------------------------------------------------
//                     Version
//------------------------------------------------
    assign cpuid_index0_value[2:0] = 3'b101; //CPID Rev.5.0

//---------------------------------------------------------
//                    Index 1
//---------------------------------------------------------
    assign cpuid_index1_value[31:28] = 4'b0001;

//------------------------------------------------
//                    Revision
//------------------------------------------------
    assign cpuid_index1_value[27:24] = `REVISION;

//------------------------------------------------
//                  Sub Version
//------------------------------------------------
    assign cpuid_index1_value[23:18] = `SUB_VERSION;

//------------------------------------------------
//                     Patch
//------------------------------------------------
    assign cpuid_index1_value[17:12] = `PATCH;

//------------------------------------------------
//                    PRODUCT ID
//------------------------------------------------
    assign cpuid_index1_value[11:0] = `PRODUCT_ID;

//---------------------------------------------------------
//                    Index 2
//---------------------------------------------------------
    assign cpuid_index2_value[31:28] = 4'b0010;

//---------------------------------------------------------
//                    BUS0 
//---------------------------------------------------------
    assign cpuid_index2_value[27:24] = 4'b0110; //AXI128

//---------------------------------------------------------
//                    BUS1
//---------------------------------------------------------
    assign cpuid_index2_value[23:20] = 4'b0;

//---------------------------------------------------------
//                    PLIC
//---------------------------------------------------------
    assign cpuid_index2_value[19] = 1'b1;

//---------------------------------------------------------
//                    CLINT
//---------------------------------------------------------
  assign cpuid_index2_value[18] = 1'b1;

//------------------------------------------------
//                    Reserved 
//------------------------------------------------
    assign cpuid_index2_value[17:16] = 2'b0;

//---------------------------------------------------------
//                    COPROCESSOR
//---------------------------------------------------------
    assign cpuid_index2_value[15:1] = 15'b0;

    assign cpuid_index2_value[0]     = 1'b1;

//---------------------------------------------------------
//                    Index 3
//---------------------------------------------------------
    assign cpuid_index3_value[31:28] = 4'b0011;

//------------------------------------------------
//                    Reserved 
//------------------------------------------------
    assign cpuid_index3_value[27:25] = 3'b0;


//------------------------------------------------
//                    IBP 
//------------------------------------------------
    assign cpuid_index3_value[24:22] = 3'b0;

//------------------------------------------------
//                      BTB
//------------------------------------------------
    assign cpuid_index3_value[21:19] = 3'b000; 

//------------------------------------------------
//                      BHT   
//------------------------------------------------
    assign cpuid_index3_value[18:16] = 3'b100; //16K BHT 

//------------------------------------------------
//                      DSPM 
//------------------------------------------------
    assign cpuid_index3_value[15:12] = 4'b0000; 

//------------------------------------------------
//                      ISPM 
//------------------------------------------------
    assign cpuid_index3_value[11:8] = 4'b0000; 

//------------------------------------------------
//                     DCACHE
//------------------------------------------------
    assign cpuid_index3_value[7:4]   = 4'b0110;

//------------------------------------------------
//                     ICACHE
//------------------------------------------------
    assign cpuid_index3_value[3:0]   = 4'b0110;

//---------------------------------------------------------
//                    Index 4
//---------------------------------------------------------
    assign cpuid_index4_value[31:28] = 4'b0100;

//------------------------------------------------
//                 ICache Way Info
//------------------------------------------------
    assign cpuid_index4_value[27:26] = 2'b0; // 2-Way

//------------------------------------------------
//                ICache Line Size
//------------------------------------------------
    assign cpuid_index4_value[25:24] = 2'b10; // 64-Bytes

//------------------------------------------------
//                   ICache ECC
//------------------------------------------------
    assign cpuid_index4_value[23:22] = 2'b0; // NO ECC

//------------------------------------------------
//                 DCache Way Info
//------------------------------------------------
    assign cpuid_index4_value[21:20] = 2'b1; // 4-Way

//------------------------------------------------
//                DCache Line Size
//------------------------------------------------
    assign cpuid_index4_value[19:18] = 2'b10; // 64-Bytes

//------------------------------------------------
//                   DCache ECC
//------------------------------------------------
    assign cpuid_index4_value[17:16] = 2'b0; // NO ECC

//------------------------------------------------
//                    Reserved
//------------------------------------------------
    assign cpuid_index4_value[15:12] = 4'b0; 

//------------------------------------------------
//                    WAY
//------------------------------------------------
    assign cpuid_index4_value[11:8] = 4'b0000;

//------------------------------------------------
//                    Reserved
//------------------------------------------------
    assign cpuid_index4_value[7:6] = 2'b0;

//------------------------------------------------
//                    ECC
//------------------------------------------------
    assign cpuid_index4_value[5:4] = 2'b0;

//------------------------------------------------
//                  L2 CACHE
//------------------------------------------------
    assign cpuid_index4_value[3:0] = 4'b0000;

//---------------------------------------------------------
//                    Index 5
//---------------------------------------------------------
    assign cpuid_index5_value[31:28] = 4'b0101;

//------------------------------------------------
//                    Reserved
//------------------------------------------------
    assign cpuid_index5_value[27:4] = 24'b0;

//------------------------------------------------
//                    SLAVEIF
//------------------------------------------------
    assign cpuid_index5_value[3] = 1'b0;

//------------------------------------------------
//                    CORENUM
//------------------------------------------------
    assign cpuid_index5_core_num_1 = 1'b0;
    assign cpuid_index5_core_num_2 = 1'b0;
    assign cpuid_index5_core_num_3 = 1'b0;
    assign cpuid_index5_value[2:0] = {2'b0, cpuid_index5_core_num_1}
                                   + {2'b0, cpuid_index5_core_num_2}
                                   + {2'b0, cpuid_index5_core_num_3};
  
//---------------------------------------------------------
//                    Index 6
//---------------------------------------------------------
    assign cpuid_index6_value[31:28] = 4'b0110;

//------------------------------------------------
//                    Reserved
//------------------------------------------------
    assign cpuid_index6_value[27:12] = 16'b0;

//------------------------------------------------
//                    MMU_TLB
//------------------------------------------------
    assign cpuid_index6_value[11:8] = 4'b0111;

//------------------------------------------------
//                    MGU ZONE SIZE
//------------------------------------------------
    assign cpuid_index6_value[7:4] = 4'b0101; // PMP 4K

//------------------------------------------------
//                    MGU ZONE NUM
//------------------------------------------------
      assign cpuid_index6_value[3:0] = 4'b0011;

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign regs_mxl[1:0] = mxl[1:0];

// &ModuleEnd; @566
endmodule



