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

// &ModuleBeg; @21
module booth_code_54_bit(
  A,
  code,
  h,
  product,
  sn
);

// &Ports; @22
input   [53:0]  A;      
input   [2 :0]  code;   
output  [1 :0]  h;      
output  [53:0]  product; 
output          sn;     

// &Regs; @23
reg     [1 :0]  h;      
reg     [53:0]  product; 
reg             sn;     

// &Wires; @24
wire    [53:0]  A;      
wire    [2 :0]  code;   


parameter SRC_WIDTH = 54;

// &CombBeg; @28
always @( code[2:0]
       or A[53:0])
begin
case(code[2:0])
3'b000 : product[SRC_WIDTH-1:0] =    {SRC_WIDTH{1'b0}};
3'b001 : product[SRC_WIDTH-1:0] =  {A[SRC_WIDTH-1:0]};
3'b010 : product[SRC_WIDTH-1:0] =  {A[SRC_WIDTH-1:0]};
3'b011 : product[SRC_WIDTH-1:0] =  {A[SRC_WIDTH-2:0],1'b0};
3'b100 : product[SRC_WIDTH-1:0] = {~A[SRC_WIDTH-2:0],1'b0};
3'b101 : product[SRC_WIDTH-1:0] = {~A[SRC_WIDTH-1:0]};
3'b110 : product[SRC_WIDTH-1:0] = {~A[SRC_WIDTH-1:0]};
3'b111 : product[SRC_WIDTH-1:0] =    {SRC_WIDTH{1'b0}};
default: product[SRC_WIDTH-1:0] =    {SRC_WIDTH{1'bx}};
endcase
// &CombEnd; @40
end

// &CombBeg; @42
always @( code[2:0]
       or A[53])
begin
case(code[2:0])
3'b000 : sn =  1'b1;
3'b001 : sn = ~A[SRC_WIDTH-1];
3'b010 : sn = ~A[SRC_WIDTH-1];
3'b011 : sn = ~A[SRC_WIDTH-1];
3'b100 : sn =  A[SRC_WIDTH-1];
3'b101 : sn =  A[SRC_WIDTH-1];
3'b110 : sn =  A[SRC_WIDTH-1];
3'b111 : sn =  1'b1;
default: sn =  1'bx;
endcase
// &CombEnd; @54
end

// &CombBeg; @56
always @( code[2:0])
begin
case(code[2:0])
3'b000 : h[1:0] = 2'b00;
3'b001 : h[1:0] = 2'b00;
3'b010 : h[1:0] = 2'b00;
3'b011 : h[1:0] = 2'b00;
3'b100 : h[1:0] = 2'b10;
3'b101 : h[1:0] = 2'b01;
3'b110 : h[1:0] = 2'b01;
3'b111 : h[1:0] = 2'b00;
default: h[1:0] = {2{1'bx}};
endcase
// &CombEnd; @68
end

// &ModuleEnd; @70
endmodule


