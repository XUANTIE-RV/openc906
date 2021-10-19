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

// &ModuleBeg; @22
module aq_spsram_1024x16(
  A,
  CEN,
  CLK,
  D,
  GWEN,
  Q,
  WEN
);

// &Ports; @23
input   [9 :0]  A;   
input           CEN; 
input           CLK; 
input   [15:0]  D;   
input           GWEN; 
input   [15:0]  WEN; 
output  [15:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [9 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [15:0]  D;   
wire            GWEN; 
wire    [15:0]  Q;   
wire    [15:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 16;
parameter WE_WIDTH   = 16;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("aq_f_spsram_1024x16"); @43
aq_f_spsram_1024x16  x_aq_f_spsram_1024x16 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("aq_tsmc_spsram_1024x16"); @49
//   &Instance("aq_umc_spsram_1024x16"); @61

// &ModuleEnd; @65
endmodule


