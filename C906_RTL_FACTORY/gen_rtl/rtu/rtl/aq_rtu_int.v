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
module aq_rtu_int(
  cp0_rtu_int_vld,
  dp_int_ex2_inst_split,
  dtu_rtu_int_mask,
  int_retire_int_vec,
  int_retire_int_vld
);


// &Ports; @25
input   [14:0]  cp0_rtu_int_vld;      
input           dp_int_ex2_inst_split; 
input           dtu_rtu_int_mask;     
output  [4 :0]  int_retire_int_vec;   
output          int_retire_int_vld;   

// &Regs; @26
reg     [4 :0]  int_vec;              

// &Wires; @27
wire    [14:0]  cp0_rtu_int_vld;      
wire            dp_int_ex2_inst_split; 
wire            dtu_rtu_int_mask;     
wire    [4 :0]  int_retire_int_vec;   
wire            int_retire_int_vld;   
wire            int_vld;              
wire    [14:0]  int_vld_raw;          



//==========================================================
//                        Int Source
//==========================================================
assign int_vld_raw[14:0] = cp0_rtu_int_vld[14:0];

// &CombBeg; @35
always @( int_vld_raw[14:0])
begin
casez(int_vld_raw[14:0])
  15'b1?????????????? : int_vec[4:0] = 5'd16; // mcip
  15'b01????????????? : int_vec[4:0] = 5'd18; // mhip
  15'b001???????????? : int_vec[4:0] = 5'd11; // meip
  15'b0001??????????? : int_vec[4:0] = 5'd3;  // msip
  15'b00001?????????? : int_vec[4:0] = 5'd7;  // mtip
  15'b000001????????? : int_vec[4:0] = 5'd9;  // seip
  15'b0000001???????? : int_vec[4:0] = 5'd1;  // ssip
  15'b00000001??????? : int_vec[4:0] = 5'd5;  // stip
  15'b000000001?????? : int_vec[4:0] = 5'd17; // moip
  15'b0000000001????? : int_vec[4:0] = 5'd16; // mcip
  15'b00000000001???? : int_vec[4:0] = 5'd18; // mhip
  15'b000000000001??? : int_vec[4:0] = 5'd9;  // seip
  15'b0000000000001?? : int_vec[4:0] = 5'd1;  // ssip
  15'b00000000000001? : int_vec[4:0] = 5'd5;  // stip
  15'b000000000000001 : int_vec[4:0] = 5'd17; // moip
  default      : int_vec[4:0] = {5{1'bx}};
endcase
// &CombEnd; @54
end

//==========================================================
//                        Int Judge
//==========================================================
assign int_vld = |int_vld_raw[14:0]
                 && !dtu_rtu_int_mask
                 && !dp_int_ex2_inst_split;

//==========================================================
//                          Output
//==========================================================
assign int_retire_int_vld     = int_vld;
assign int_retire_int_vec[4:0] = int_vec[4:0];

// &ModuleEnd; @69
endmodule



