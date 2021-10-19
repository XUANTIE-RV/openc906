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
module aq_fadd_shift_sub_h_double(
  data_in,
  data_out,
  shift_cnt
);

// &Ports; @24
input   [53:0]  data_in;       
input   [5 :0]  shift_cnt;     
output  [53:0]  data_out;      

// &Regs; @25
reg     [53:0]  data_shift;    

// &Wires; @26
wire    [5 :0]  cnt;           
wire    [53:0]  data_in;       
wire    [53:0]  data_out;      
wire    [53:0]  data_shift_pre; 
wire    [5 :0]  shift_cnt;     


assign data_shift_pre[53:0] = data_in[53:0];
assign data_out[53:0] = data_shift[53:0];

assign cnt[5:0] = shift_cnt[5:0];


// &CombBeg; @34
always @( cnt[5:0]
       or data_shift_pre[53:0])
begin
case(cnt[5:0])
  6'd0 : data_shift[53:0]  = data_shift_pre[53:0];
  6'd1 : data_shift[53:0]  = {data_shift_pre[52:0], 1'b0};
  6'd2 : data_shift[53:0]  = {data_shift_pre[51:0], 2'b0};
  6'd3 : data_shift[53:0]  = {data_shift_pre[50:0], 3'b0};
  6'd4 : data_shift[53:0]  = {data_shift_pre[49:0], 4'b0};
  6'd5 : data_shift[53:0]  = {data_shift_pre[48:0], 5'b0};
  6'd6 : data_shift[53:0]  = {data_shift_pre[47:0], 6'b0};
  6'd7 : data_shift[53:0]  = {data_shift_pre[46:0], 7'b0};
  6'd8 : data_shift[53:0]  = {data_shift_pre[45:0], 8'b0};
  6'd9 : data_shift[53:0]  = {data_shift_pre[44:0], 9'b0};
  6'd10 : data_shift[53:0] = {data_shift_pre[43:0], 10'b0};
  6'd11 : data_shift[53:0] = {data_shift_pre[42:0], 11'b0};
  6'd12 : data_shift[53:0] = {data_shift_pre[41:0], 12'b0};
  6'd13 : data_shift[53:0] = {data_shift_pre[40:0], 13'b0};
  6'd14 : data_shift[53:0] = {data_shift_pre[39:0], 14'b0};
  6'd15 : data_shift[53:0] = {data_shift_pre[38:0], 15'b0};
  6'd16 : data_shift[53:0] = {data_shift_pre[37:0], 16'b0};
  6'd17 : data_shift[53:0] = {data_shift_pre[36:0], 17'b0};
  6'd18 : data_shift[53:0] = {data_shift_pre[35:0], 18'b0};
  6'd19 : data_shift[53:0] = {data_shift_pre[34:0], 19'b0};
  6'd20 : data_shift[53:0] = {data_shift_pre[33:0], 20'b0};
  6'd21 : data_shift[53:0] = {data_shift_pre[32:0], 21'b0};
  6'd22 : data_shift[53:0] = {data_shift_pre[31:0], 22'b0};
  6'd23 : data_shift[53:0] = {data_shift_pre[30:0], 23'b0};
  6'd24 : data_shift[53:0] = {data_shift_pre[29:0], 24'b0};
  6'd25 : data_shift[53:0] = {data_shift_pre[28:0], 25'b0};
  6'd26 : data_shift[53:0] = {data_shift_pre[27:0], 26'b0};
  6'd27 : data_shift[53:0] = {data_shift_pre[26:0], 27'b0};
  6'd28 : data_shift[53:0] = {data_shift_pre[25:0], 28'b0};
  6'd29 : data_shift[53:0] = {data_shift_pre[24:0], 29'b0};
  6'd30 : data_shift[53:0] = {data_shift_pre[23:0], 30'b0};
  6'd31 : data_shift[53:0] = {data_shift_pre[22:0], 31'b0};
  6'd32 : data_shift[53:0] = {data_shift_pre[21:0], 32'b0};
  6'd33 : data_shift[53:0] = {data_shift_pre[20:0], 33'b0};
  6'd34 : data_shift[53:0] = {data_shift_pre[19:0], 34'b0};
  6'd35 : data_shift[53:0] = {data_shift_pre[18:0], 35'b0};
  6'd36 : data_shift[53:0] = {data_shift_pre[17:0], 36'b0};
  6'd37 : data_shift[53:0] = {data_shift_pre[16:0], 37'b0};
  6'd38 : data_shift[53:0] = {data_shift_pre[15:0], 38'b0};
  6'd39 : data_shift[53:0] = {data_shift_pre[14:0], 39'b0};
  6'd40 : data_shift[53:0] = {data_shift_pre[13:0], 40'b0};
  6'd41 : data_shift[53:0] = {data_shift_pre[12:0], 41'b0};
  6'd42 : data_shift[53:0] = {data_shift_pre[11:0], 42'b0};
  6'd43 : data_shift[53:0] = {data_shift_pre[10:0], 43'b0};
  6'd44 : data_shift[53:0] = {data_shift_pre[9:0], 44'b0};
  6'd45 : data_shift[53:0] = {data_shift_pre[8:0], 45'b0};
  6'd46 : data_shift[53:0] = {data_shift_pre[7:0], 46'b0};
  6'd47 : data_shift[53:0] = {data_shift_pre[6:0], 47'b0};
  6'd48 : data_shift[53:0] = {data_shift_pre[5:0], 48'b0};
  6'd49 : data_shift[53:0] = {data_shift_pre[4:0], 49'b0};
  6'd50 : data_shift[53:0] = {data_shift_pre[3:0], 50'b0};
  6'd51 : data_shift[53:0] = {data_shift_pre[2:0], 51'b0};
  6'd52 : data_shift[53:0] = {data_shift_pre[1:0], 52'b0};
  6'd53 : data_shift[53:0] = {data_shift_pre[0], 53'b0};
  default: data_shift[53:0] = 54'b0;   
endcase
// &CombEnd; @92
end

// &ModuleEnd; @94
endmodule


