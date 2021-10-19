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
module aq_f_spsram_64x98(
  A,
  CEN,
  CLK,
  D,
  GWEN,
  Q,
  WEN
);

// &Ports; @25
input   [5 :0]  A;           
input           CEN;         
input           CLK;         
input   [97:0]  D;           
input           GWEN;        
input   [97:0]  WEN;         
output  [97:0]  Q;           

// &Regs; @26
reg     [5 :0]  addr_holding; 

// &Wires; @27
wire    [5 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [97:0]  D;           
wire            GWEN;        
wire    [97:0]  Q;           
wire    [97:0]  WEN;         
wire    [5 :0]  addr;        
wire    [47:0]  ram0_din;    
wire    [47:0]  ram0_dout;   
wire            ram0_wen;    
wire    [47:0]  ram1_din;    
wire    [47:0]  ram1_dout;   
wire            ram1_wen;    
wire    [1 :0]  ram2_din;    
wire    [1 :0]  ram2_dout;   
wire            ram2_wen;    


parameter ADDR_WIDTH  = 6;
parameter WRAP_SIZE_1 = 48;
parameter WRAP_SIZE_2 = 2;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("nonport","ram2_wen"); @36
// &Force("bus","WEN",97,0); @37
assign ram0_wen = !CEN && !WEN[47] && !GWEN;
assign ram1_wen = !CEN && !WEN[95] && !GWEN;
assign ram2_wen = !CEN && !WEN[97] && !GWEN;

//din
// &Force("nonport","ram0_din"); @43
// &Force("nonport","ram1_din"); @44
// &Force("nonport","ram2_din"); @45
// &Force("bus","D",2*WRAP_SIZE_1+1,0); @46
assign ram0_din[WRAP_SIZE_1-1:0] = D[WRAP_SIZE_1-1:0];
assign ram1_din[WRAP_SIZE_1-1:0] = D[2*WRAP_SIZE_1-1:WRAP_SIZE_1];
assign ram2_din[WRAP_SIZE_2-1:0] = D[2*WRAP_SIZE_1+1:2*WRAP_SIZE_1];
//address
// &Force("nonport","addr"); @51
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @62
// &Force("nonport","ram1_dout"); @63
// &Force("nonport","ram2_dout"); @64

assign Q[WRAP_SIZE_1-1:0]               = ram0_dout[WRAP_SIZE_1-1:0];
assign Q[2*WRAP_SIZE_1-1:WRAP_SIZE_1]   = ram1_dout[WRAP_SIZE_1-1:0];
assign Q[2*WRAP_SIZE_1+1:2*WRAP_SIZE_1] = ram2_dout[WRAP_SIZE_2-1:0];


fpga_ram #(WRAP_SIZE_1,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

fpga_ram #(WRAP_SIZE_1,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));
// &ModuleEnd; @91
endmodule


