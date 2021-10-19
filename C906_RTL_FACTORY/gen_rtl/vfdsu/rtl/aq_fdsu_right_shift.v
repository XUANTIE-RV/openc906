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
module aq_fdsu_right_shift(
  frac_num_in,
  frac_shift_cnt,
  frac_shift_num
);

// &Ports; @23
input   [15:0]  frac_num_in;   
input   [2 :0]  frac_shift_cnt; 
output  [15:0]  frac_shift_num; 

// &Regs; @24
reg     [15:0]  frac_shift_num; 

// &Wires; @25
wire    [15:0]  frac_num_in;   
wire    [2 :0]  frac_shift_cnt; 

// &Force("bus","frac_num_in",15,0); @26
// &CombBeg; @27
always @( frac_num_in[15:1]
       or frac_shift_cnt[2:0])
begin
casez(frac_shift_cnt[2:0])
  3'b111:  frac_shift_num[15:0] = {1'b0,frac_num_in[15:1]};
  3'b110:  frac_shift_num[15:0] = {2'b0,frac_num_in[15:2]};
  3'b101:  frac_shift_num[15:0] = {3'b0,frac_num_in[15:3]};
  3'b100:  frac_shift_num[15:0] = {4'b0,frac_num_in[15:4]};
  3'b011:  frac_shift_num[15:0] = {5'b0,frac_num_in[15:5]};
  3'b010:  frac_shift_num[15:0] = {6'b0,frac_num_in[15:6]};
  3'b001:  frac_shift_num[15:0] = {7'b0,frac_num_in[15:7]};
  3'b000:  frac_shift_num[15:0] = {8'b0,frac_num_in[15:8]};
  default: frac_shift_num[15:0] = {16{1'b0}};
endcase
// &CombEnd; @39
end

// &ModuleEnd; @41
endmodule


