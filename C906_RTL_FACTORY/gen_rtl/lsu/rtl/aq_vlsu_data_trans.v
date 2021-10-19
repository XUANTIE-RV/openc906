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

// &Depend("cpu_cfig.h"); @18

// &ModuleBeg; @20
module aq_vlsu_data_trans(
  byte_reorder,
  data_read,
  data_read_in,
  data_write,
  data_write_in,
  mux_reorder
);

// &Ports; @21
input   [2 :0]  byte_reorder;          
input   [63:0]  data_read_in;          
input   [63:0]  data_write_in;         
input   [3 :0]  mux_reorder;           
output  [63:0]  data_read;             
output  [63:0]  data_write;            

// &Regs; @22
reg     [63:0]  data_read_aft_reorder; 
reg     [63:0]  data_read_aft_trans;   
reg     [63:0]  data_write_aft_reorder; 
reg     [63:0]  data_write_bf_trans;   

// &Wires; @23
wire    [2 :0]  byte_exchange;         
wire    [2 :0]  byte_reorder;          
wire    [63:0]  data_read;             
wire    [63:0]  data_read_in;          
wire    [63:0]  data_read_ori;         
wire    [63:0]  data_write;            
wire    [63:0]  data_write_in;         
wire    [63:0]  data_write_ori;        
wire    [3 :0]  mux_reorder;           
wire    [3 :0]  reorder;               


parameter BYTE        = 2'b00,
          HALF        = 2'b01,
          WORD        = 2'b10,
          DWORD       = 2'b11;

//================================================
//        input interface
//================================================
assign data_read_ori[`LSU_DATAW-1:0]  = data_read_in[`LSU_DATAW-1:0]; 
assign data_write_ori[`LSU_DATAW-1:0] = data_write_in[`LSU_DATAW-1:0]; 
assign reorder[3:0]        = mux_reorder[3:0];
assign byte_exchange[2:0]  = byte_reorder[2:0];
//================================================
//        write data
//================================================
//----------------reorder-------------------------
// &CombBeg; @41
always @( data_write_bf_trans[31:16 ]
       or data_write_bf_trans[63:48 ]
       or data_write_bf_trans[63:0]
       or data_write_bf_trans[47:32 ]
       or reorder[3:0])
begin
  case(reorder[3:0])
//  4'h1:data_write_aft_reorder[`LSU_DATAW-1:0] = {data_write_bf_trans[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_write_bf_trans[2*`VLSU_BLKW-1:`VLSU_BLKW],
//                                                 data_write_bf_trans[`LSU_DATAW-1:3*`VLSU_BLKW],data_write_bf_trans[`VLSU_BLKW-1:0]};
//  4'h2:data_write_aft_reorder[`LSU_DATAW-1:0] = {data_write_bf_trans[`VLSU_BLKW-1:0],data_write_bf_trans[`LSU_DATAW-1:3*`VLSU_BLKW],
//                                                 data_write_bf_trans[2*`VLSU_BLKW-1:`VLSU_BLKW],data_write_bf_trans[3*`VLSU_BLKW-1:2*`VLSU_BLKW]};
  4'h3:data_write_aft_reorder[`LSU_DATAW-1:0] = {data_write_bf_trans[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_write_bf_trans[`LSU_DATAW-1:3*`VLSU_BLKW],
                                                 data_write_bf_trans[2*`VLSU_BLKW-1:`VLSU_BLKW],data_write_bf_trans[`VLSU_BLKW-1:0]};
  4'h4:data_write_aft_reorder[`LSU_DATAW-1:0] = {data_write_bf_trans[`VLSU_BLKW-1:0],data_write_bf_trans[2*`VLSU_BLKW-1:`VLSU_BLKW],
                                                 data_write_bf_trans[`LSU_DATAW-1:3*`VLSU_BLKW],data_write_bf_trans[3*`VLSU_BLKW-1:2*`VLSU_BLKW]};
  4'h5:data_write_aft_reorder[`LSU_DATAW-1:0] = {data_write_bf_trans[`LSU_DATAW-1:3*`VLSU_BLKW],data_write_bf_trans[3*`VLSU_BLKW-1:2*`VLSU_BLKW],
                                                 data_write_bf_trans[`VLSU_BLKW-1:0],data_write_bf_trans[2*`VLSU_BLKW-1:`VLSU_BLKW]};
  4'h6:data_write_aft_reorder[`LSU_DATAW-1:0] = {data_write_bf_trans[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_write_bf_trans[`LSU_DATAW-1:3*`VLSU_BLKW],
                                                 data_write_bf_trans[`VLSU_BLKW-1:0],data_write_bf_trans[2*`VLSU_BLKW-1:`VLSU_BLKW]};
//  4'h7:data_write_aft_reorder[`LSU_DATAW-1:0] = {data_write_bf_trans[`LSU_DATAW-1:3*`VLSU_BLKW],data_write_bf_trans[`VLSU_BLKW-1:0],
//                                                 data_write_bf_trans[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_write_bf_trans[2*`VLSU_BLKW-1:`VLSU_BLKW]};
//  4'h8:data_write_aft_reorder[`LSU_DATAW-1:0] = {data_write_bf_trans[2*`VLSU_BLKW-1:`VLSU_BLKW],data_write_bf_trans[3*`VLSU_BLKW-1:2*`VLSU_BLKW],
//                                                 data_write_bf_trans[`VLSU_BLKW-1:0],data_write_bf_trans[`LSU_DATAW-1:3*`VLSU_BLKW]};
  4'h9:data_write_aft_reorder[`LSU_DATAW-1:0] = {data_write_bf_trans[2*`VLSU_BLKW-1:`VLSU_BLKW],data_write_bf_trans[`VLSU_BLKW-1:0],
                                                 data_write_bf_trans[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_write_bf_trans[`LSU_DATAW-1:3*`VLSU_BLKW]};
  default:data_write_aft_reorder[`LSU_DATAW-1:0] = data_write_bf_trans[`LSU_DATAW-1:0];
  endcase
// &CombEnd; @69
end

// &CombBeg; @73
// &CombEnd; @114
//byte write exchange
// &CombBeg; @117
always @( data_write_ori[63:0]
       or byte_exchange[2:0])
begin
  case(byte_exchange[2:0])
  3'h1:data_write_bf_trans[63:0] = {data_write_ori[63:56],data_write_ori[47:40],
                                    data_write_ori[31:24],data_write_ori[15:8],
                                    data_write_ori[55:48],data_write_ori[39:32],
                                    data_write_ori[23:16],data_write_ori[7:0]};
  3'h2:data_write_bf_trans[63:0] = {data_write_ori[63:48],
                                    data_write_ori[39:32],data_write_ori[15:8],
                                    data_write_ori[47:40],data_write_ori[23:16],
                                    data_write_ori[31:24],data_write_ori[7:0]};
  3'h3:data_write_bf_trans[63:0] = {data_write_ori[63:56],data_write_ori[31:24],
                                    data_write_ori[47:40],data_write_ori[15:8],
                                    data_write_ori[55:48],data_write_ori[23:16],
                                    data_write_ori[39:32],data_write_ori[7:0]};
  3'h4:data_write_bf_trans[63:0] = {data_write_ori[63:48],data_write_ori[31:16],
                                    data_write_ori[47:32],data_write_ori[15:0]};
  default:data_write_bf_trans[63:0] = data_write_ori[63:0];
  endcase
// &CombEnd; @135
end

//================================================
//        read data
//================================================
//----------------reorder-------------------------
// &CombBeg; @142
always @( data_read_ori[63:48 ]
       or data_read_ori[63:0]
       or reorder[3:0]
       or data_read_ori[47:32 ]
       or data_read_ori[31:16 ])
begin
  case(reorder[3:0])
  4'h1:data_read_aft_reorder[`LSU_DATAW-1:0] = {data_read_ori[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_read_ori[2*`VLSU_BLKW-1:`VLSU_BLKW],
                                                data_read_ori[`LSU_DATAW-1:3*`VLSU_BLKW],data_read_ori[`VLSU_BLKW-1:0]};
  4'h2:data_read_aft_reorder[`LSU_DATAW-1:0] = {data_read_ori[`VLSU_BLKW-1:0],data_read_ori[`LSU_DATAW-1:3*`VLSU_BLKW],
                                                data_read_ori[2*`VLSU_BLKW-1:`VLSU_BLKW],data_read_ori[3*`VLSU_BLKW-1:2*`VLSU_BLKW]};
  4'h3:data_read_aft_reorder[`LSU_DATAW-1:0] = {data_read_ori[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_read_ori[`LSU_DATAW-1:3*`VLSU_BLKW],
                                                data_read_ori[2*`VLSU_BLKW-1:`VLSU_BLKW],data_read_ori[`VLSU_BLKW-1:0]};
  4'h4:data_read_aft_reorder[`LSU_DATAW-1:0] = {data_read_ori[`VLSU_BLKW-1:0],data_read_ori[2*`VLSU_BLKW-1:`VLSU_BLKW],
                                                data_read_ori[`LSU_DATAW-1:3*`VLSU_BLKW],data_read_ori[3*`VLSU_BLKW-1:2*`VLSU_BLKW]};
  4'h5:data_read_aft_reorder[`LSU_DATAW-1:0] = {data_read_ori[`LSU_DATAW-1:3*`VLSU_BLKW],data_read_ori[3*`VLSU_BLKW-1:2*`VLSU_BLKW],
                                                data_read_ori[`VLSU_BLKW-1:0],data_read_ori[2*`VLSU_BLKW-1:`VLSU_BLKW]};
  4'h6:data_read_aft_reorder[`LSU_DATAW-1:0] = {data_read_ori[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_read_ori[`LSU_DATAW-1:3*`VLSU_BLKW],
                                                data_read_ori[`VLSU_BLKW-1:0],data_read_ori[2*`VLSU_BLKW-1:`VLSU_BLKW]};
  4'h7:data_read_aft_reorder[`LSU_DATAW-1:0] = {data_read_ori[`LSU_DATAW-1:3*`VLSU_BLKW],data_read_ori[`VLSU_BLKW-1:0],
                                                data_read_ori[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_read_ori[2*`VLSU_BLKW-1:`VLSU_BLKW]};
  4'h8:data_read_aft_reorder[`LSU_DATAW-1:0] = {data_read_ori[2*`VLSU_BLKW-1:`VLSU_BLKW],data_read_ori[3*`VLSU_BLKW-1:2*`VLSU_BLKW],
                                                data_read_ori[`VLSU_BLKW-1:0],data_read_ori[`LSU_DATAW-1:3*`VLSU_BLKW]};
  4'h9:data_read_aft_reorder[`LSU_DATAW-1:0] = {data_read_ori[2*`VLSU_BLKW-1:`VLSU_BLKW],data_read_ori[`VLSU_BLKW-1:0],
                                                data_read_ori[3*`VLSU_BLKW-1:2*`VLSU_BLKW],data_read_ori[`LSU_DATAW-1:3*`VLSU_BLKW]};
  default:data_read_aft_reorder[`LSU_DATAW-1:0] = data_read_ori[`LSU_DATAW-1:0];
  endcase
// &CombEnd; @170
end

// &CombBeg; @174
// &CombEnd; @213
//byte read exchange
// &CombBeg; @216
always @( data_read_aft_reorder[63:0]
       or byte_exchange[1:0])
begin
  case(byte_exchange[1:0])
  2'h1:data_read_aft_trans[63:0] = {data_read_aft_reorder[63:56],data_read_aft_reorder[47:40],
                                    data_read_aft_reorder[55:48],data_read_aft_reorder[39:32],
                                    data_read_aft_reorder[31:24],data_read_aft_reorder[15:8],
                                    data_read_aft_reorder[23:16],data_read_aft_reorder[7:0]};
  2'h2:data_read_aft_trans[63:0] = {data_read_aft_reorder[63:48],
                                    data_read_aft_reorder[47:40],data_read_aft_reorder[31:24],
                                    data_read_aft_reorder[15:8],data_read_aft_reorder[39:32],
                                    data_read_aft_reorder[23:16],data_read_aft_reorder[7:0]};
  2'h3:data_read_aft_trans[63:0] = {data_read_aft_reorder[63:56],data_read_aft_reorder[47:40],
                                    data_read_aft_reorder[31:24],data_read_aft_reorder[15:8],
                                    data_read_aft_reorder[55:48],data_read_aft_reorder[39:32],
                                    data_read_aft_reorder[23:16],data_read_aft_reorder[7:0]};
  default:data_read_aft_trans[63:0] = data_read_aft_reorder[63:0];
  endcase
// &CombEnd; @232
end


//================================================
//        output interface
//================================================
assign data_read[`LSU_DATAW-1:0]  = data_read_aft_trans[`LSU_DATAW-1:0];
assign data_write[`LSU_DATAW-1:0] = data_write_aft_reorder[`LSU_DATAW-1:0];


// &ModuleEnd; @243
endmodule



