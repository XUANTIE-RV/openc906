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

// &ModuleBeg; @17
module aq_vdsp_8_bit_ff1(
  out,
  rem,
  src,
  zero
);

// &Ports; @18
input   [7:0]  src;   
output  [4:0]  out;   
output         rem;   
output         zero;  

// &Regs; @19
reg            rem_1; 
reg     [4:0]  result; 

// &Wires; @20
wire    [4:0]  out;   
wire           rem;   
wire    [7:0]  src;   
wire           zero;  


// &CombBeg; @22
always @( src[7:0])
begin
casez(src[7:0])
  8'b1???_????: begin rem_1 = &src[6:0]; result[4:0] = 5'b11111; end 
  8'b01??_????: begin rem_1 = &src[5:0]; result[4:0] = 5'b00000; end
  8'b001?_????: begin rem_1 = &src[4:0]; result[4:0] = 5'b00001; end
  8'b0001_????: begin rem_1 = &src[3:0]; result[4:0] = 5'b00010; end
  8'b0000_1???: begin rem_1 = &src[2:0]; result[4:0] = 5'b00011; end
  8'b0000_01??: begin rem_1 = &src[1:0]; result[4:0] = 5'b00100; end
  8'b0000_001?: begin rem_1 =  src[0]  ; result[4:0] = 5'b00101; end
  8'b0000_0001: begin rem_1 = 1'b1     ; result[4:0] = 5'b00110; end
  8'b0000_0000: begin rem_1 = 1'b1     ; result[4:0] = 5'b00111; end
  default     : begin rem_1 = 1'bx     ; result[4:0] ={5{1'bx}}; end
endcase
// &CombEnd; @35
end

assign out[4:0] = result[4:0];
assign rem      = rem_1;
assign zero     = (src[7:0]==8'b0000_0000);

// &ModuleEnd; @41
endmodule



