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
module aq_fadd_shift_sub_single(
  data_in,
  data_out,
  shift_cnt
);

// &Ports; @23
input   [27:0]  data_in;       
input   [4 :0]  shift_cnt;     
output  [27:0]  data_out;      

// &Regs; @24
reg     [27:0]  data_shift;    

// &Wires; @25
wire    [4 :0]  cnt;           
wire    [27:0]  data_in;       
wire    [27:0]  data_out;      
wire    [27:0]  data_shift_pre; 
wire    [4 :0]  shift_cnt;     


assign data_shift_pre[27:0] = data_in[27:0];
assign data_out[27:0]       = data_shift[27:0];
assign cnt[4:0]             = shift_cnt[4:0];


// &CombBeg; @32
always @( cnt[4:0]
       or data_shift_pre[27:0])
begin
case(cnt[4:0])
  5'd0 : data_shift[27:0]   = data_shift_pre[27:0];
  5'd1 : data_shift[27:0]   = {data_shift_pre[26:0], 1'b0};
  5'd2 : data_shift[27:0]   = {data_shift_pre[25:0], 2'b0};
  5'd3 : data_shift[27:0]   = {data_shift_pre[24:0], 3'b0};
  5'd4 : data_shift[27:0]   = {data_shift_pre[23:0], 4'b0};
  5'd5 : data_shift[27:0]   = {data_shift_pre[22:0], 5'b0};
  5'd6 : data_shift[27:0]   = {data_shift_pre[21:0], 6'b0};
  5'd7 : data_shift[27:0]   = {data_shift_pre[20:0], 7'b0};
  5'd8 : data_shift[27:0]   = {data_shift_pre[19:0], 8'b0};
  5'd9 : data_shift[27:0]   = {data_shift_pre[18:0], 9'b0};
  5'd10 : data_shift[27:0]  = {data_shift_pre[17:0],10'b0};
  5'd11 : data_shift[27:0]  = {data_shift_pre[16:0],11'b0};
  5'd12 : data_shift[27:0]  = {data_shift_pre[15:0],12'b0};
  5'd13 : data_shift[27:0]  = {data_shift_pre[14:0],13'b0};
  5'd14 : data_shift[27:0]  = {data_shift_pre[13:0],14'b0};
  5'd15 : data_shift[27:0]  = {data_shift_pre[12:0],15'b0};
  5'd16 : data_shift[27:0]  = {data_shift_pre[11:0],16'b0};
  5'd17 : data_shift[27:0]  = {data_shift_pre[10:0],17'b0};
  5'd18 : data_shift[27:0]  = {data_shift_pre[9:0],18'b0};
  5'd19 : data_shift[27:0]  = {data_shift_pre[8:0],19'b0};
  5'd20 : data_shift[27:0]  = {data_shift_pre[7:0],20'b0};
  5'd21 : data_shift[27:0]  = {data_shift_pre[6:0],21'b0};
  5'd22 : data_shift[27:0]  = {data_shift_pre[5:0],22'b0};
  5'd23 : data_shift[27:0]  = {data_shift_pre[4:0],23'b0};
  5'd24 : data_shift[27:0]  = {data_shift_pre[3:0],24'b0};
  5'd25 : data_shift[27:0]  = {data_shift_pre[2:0],25'b0};
  5'd26 : data_shift[27:0]  = {data_shift_pre[1:0],26'b0};
  5'd27 : data_shift[27:0]  = {data_shift_pre[0],27'b0};
  default: data_shift[27:0] = 28'b0;
endcase
// &CombEnd; @64
end





// &ModuleEnd; @70
endmodule


