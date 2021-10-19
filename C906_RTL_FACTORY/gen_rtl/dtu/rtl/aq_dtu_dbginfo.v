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
module aq_dtu_dbginfo(
  cp0_dtu_addr,
  cp0_dtu_debug_info,
  cp0_dtu_icg_en,
  cp0_dtu_rreg,
  cp0_yy_clk_en,
  cpurst_b,
  dbgfifo_regs_data,
  dtu_rtu_async_halt_req,
  forever_cpuclk,
  idu_dtu_debug_info,
  ifu_dtu_debug_info,
  iu_dtu_debug_info,
  lsu_dtu_debug_info,
  mmu_dtu_debug_info,
  pad_yy_icg_scan_en,
  rtu_dtu_debug_info,
  vidu_dtu_debug_info,
  vpu_dtu_dbg_info
);

// &Ports; @21
input   [11 :0]  cp0_dtu_addr;           
input   [5  :0]  cp0_dtu_debug_info;     
input            cp0_dtu_icg_en;         
input            cp0_dtu_rreg;           
input            cp0_yy_clk_en;          
input            cpurst_b;               
input            dtu_rtu_async_halt_req; 
input            forever_cpuclk;         
input   [14 :0]  idu_dtu_debug_info;     
input   [20 :0]  ifu_dtu_debug_info;     
input   [8  :0]  iu_dtu_debug_info;      
input   [93 :0]  lsu_dtu_debug_info;     
input   [15 :0]  mmu_dtu_debug_info;     
input            pad_yy_icg_scan_en;     
input   [14 :0]  rtu_dtu_debug_info;     
input   [7  :0]  vidu_dtu_debug_info;    
input   [28 :0]  vpu_dtu_dbg_info;       
output  [63 :0]  dbgfifo_regs_data;      

// &Regs; @22
reg     [1  :0]  dbg_rptr;               
reg     [212:0]  xx_dbg_info_reg;        

// &Wires; @23
wire    [11 :0]  cp0_dtu_addr;           
wire    [5  :0]  cp0_dtu_debug_info;     
wire             cp0_dtu_icg_en;         
wire             cp0_dtu_rreg;           
wire             cp0_read_dbginfo;       
wire             cp0_yy_clk_en;          
wire             cpurst_b;               
wire             dbg_info_record;        
wire    [63 :0]  dbgfifo_regs_data;      
wire             dbginfo_clk;            
wire             dbginfo_clk_en;         
wire    [63 :0]  dbginfo_out;            
wire             dtu_rtu_async_halt_req; 
wire             forever_cpuclk;         
wire    [14 :0]  idu_dtu_debug_info;     
wire    [20 :0]  ifu_dtu_debug_info;     
wire    [8  :0]  iu_dtu_debug_info;      
wire    [93 :0]  lsu_dtu_debug_info;     
wire    [15 :0]  mmu_dtu_debug_info;     
wire             pad_yy_icg_scan_en;     
wire    [14 :0]  rtu_dtu_debug_info;     
wire    [7  :0]  vidu_dtu_debug_info;    
wire    [28 :0]  vpu_dtu_dbg_info;       
wire    [212:0]  xx_dbg_info;            
wire    [239:0]  xx_dbg_info_reg_padding; 


parameter DBG_WIDTH  = `TDT_DM_CORE_MAX_XLEN;
parameter DBGINFO_RPTR_WIDTH = 2;
parameter DBGINFO_READ_WIDTH = 60;
parameter DBGINFO_DEPTH = 4;

//==========================================================
//                    DBGINFO FIFO Read
//==========================================================
//csky vperl_off
wire  [DBGINFO_READ_WIDTH -1:0] dbginfo_reg[DBGINFO_DEPTH-1:0];

genvar i;

generate
  for (i = 0; i < DBGINFO_DEPTH; i = i+1)
  begin: DBG_FIFO
    assign dbginfo_reg[i][DBGINFO_READ_WIDTH -1:0] = xx_dbg_info_reg_padding[DBGINFO_READ_WIDTH *i+DBGINFO_READ_WIDTH-1:DBGINFO_READ_WIDTH *i];
  end
endgenerate
//vperl_on

//assign cp0_read_dbginfo = cp0_dtu_rreg && cp0_dtu_addr[11:0] == 12'hfe1 && rtu_yy_xx_dbgon;

//always @(posedge dbginfo_clk or negedge cpurst_b)
//begin
//  if (!cpurst_b)
//    dbginfo_dout[DBG_WIDTH -1:0] <= {DBG_WIDTH{1'b0}};
//vperl_off
//  else if (cp0_read_dbginfo)
//    dbginfo_dout[DBG_WIDTH -1:0] <= {dbginfo_reg[dbg_rptr[DBGINFO_RPTR_WIDTH-1:0]][DBGINFO_READ_WIDTH-1:0],dbg_rptr[DBGINFO_RPTR_WIDTH-1:0]};
//vperl_on
//  else
//    dbginfo_dout[DBG_WIDTH -1:0] <= dbginfo_dout[DBG_WIDTH-1:0];
//end

assign dbginfo_out[DBG_WIDTH-1:0] = {dbginfo_reg[dbg_rptr[DBGINFO_RPTR_WIDTH-1:0]][DBGINFO_READ_WIDTH-1:0],2'b0,dbg_rptr[DBGINFO_RPTR_WIDTH-1:0]};

//csky vperl_on
// &Force("nonport","dbginfo_out"); @63
assign dbgfifo_regs_data[DBG_WIDTH -1:0] = dbginfo_out[DBG_WIDTH-1:0];

assign cp0_read_dbginfo = cp0_dtu_rreg && cp0_dtu_addr[11:0] == 12'hfe1;
//==========================================================
//                    DBGINFO FIFO Write
//==========================================================
assign dbg_info_record = dtu_rtu_async_halt_req;

parameter DBG_INFO_WIDTH = 213;

// assign xx_dbg_info[DBG_INFO_WIDTH-1:0] = {DBG_INFO_WIDTH{1'b0}};

assign xx_dbg_info[DBG_INFO_WIDTH-1:0] = {
         mmu_dtu_debug_info[15:0],
         cp0_dtu_debug_info[5:0],
         vpu_dtu_dbg_info[28:0],
         rtu_dtu_debug_info[14:0],
         iu_dtu_debug_info[8:0],
         lsu_dtu_debug_info[93:0],
         vidu_dtu_debug_info[7:0],
         idu_dtu_debug_info[14:0],
         ifu_dtu_debug_info[20:0]
};

always @ (posedge dbginfo_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    xx_dbg_info_reg[DBG_INFO_WIDTH-1:0] <= {DBG_INFO_WIDTH{1'b0}};
  else if (dbg_info_record)
    xx_dbg_info_reg[DBG_INFO_WIDTH-1:0] <= xx_dbg_info[DBG_INFO_WIDTH-1:0];
end

assign xx_dbg_info_reg_padding[DBGINFO_READ_WIDTH *DBGINFO_DEPTH-1:0] = {
           {(DBGINFO_READ_WIDTH *DBGINFO_DEPTH-DBG_INFO_WIDTH){1'b0}},
           xx_dbg_info_reg[DBG_INFO_WIDTH-1:0]
         };
// &Force("nonport", "xx_dbg_info_reg"); @100
// &Force("nonport", "xx_dbg_info_reg_padding"); @101

//==========================================================
//                DBGINFO FIFO Read Pointer
//==========================================================
always @ (posedge dbginfo_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dbg_rptr[DBGINFO_RPTR_WIDTH-1:0] <= {DBGINFO_RPTR_WIDTH{1'b0}};
  else if (cp0_read_dbginfo)
    dbg_rptr[DBGINFO_RPTR_WIDTH-1:0] <= dbg_rptr[DBGINFO_RPTR_WIDTH-1:0] + 1'b1;
end

//==========================================================
//                     gate clk
//==========================================================
assign dbginfo_clk_en = dtu_rtu_async_halt_req ||
                        cp0_read_dbginfo;
// &Force("nonport","dbginfo_clk_en"); @119

// &Instance("gated_clk_cell", "x_reg_gated_clk"); @121
gated_clk_cell  x_reg_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dbginfo_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (dbginfo_clk_en    ),
  .module_en          (cp0_dtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @122
//          .external_en (1'b0), @123
//          .global_en   (cp0_yy_clk_en), @124
//          .module_en   (cp0_dtu_icg_en), @125
//          .local_en    (dbginfo_clk_en), @126
//          //.local_en    (1'b1), @127
//          .clk_out     (dbginfo_clk)); @128

// &ModuleEnd; @130
endmodule


