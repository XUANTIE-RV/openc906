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

// &ModuleBeg; @16
module aq_fcnvt_xtoh_sh(
  xtoh_sh_cnt,
  xtoh_sh_f_v,
  xtoh_sh_f_x,
  xtoh_sh_src
);

// &Ports; @17
input   [11:0]  xtoh_sh_cnt; 
input   [51:0]  xtoh_sh_src; 
output  [10:0]  xtoh_sh_f_v; 
output  [53:0]  xtoh_sh_f_x; 

// &Regs; @18
reg     [10:0]  xtoh_sh_f_v; 
reg     [53:0]  xtoh_sh_f_x; 

// &Wires; @19
wire    [11:0]  xtoh_sh_cnt; 
wire    [51:0]  xtoh_sh_src; 



// &CombBeg; @22
always @( xtoh_sh_src[51:0]
       or xtoh_sh_cnt[11:0])
begin
case(xtoh_sh_cnt[11:0])
  12'hff1: begin //-15
  xtoh_sh_f_v[10:0] = {2'b1,xtoh_sh_src[51:43]};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[42:0],11'b0};
  end
  12'hff0: begin //-16
  xtoh_sh_f_v[10:0] = {3'b1,xtoh_sh_src[51:44]};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[43:0],10'b0};
  end
  12'hfef: begin //-17
  xtoh_sh_f_v[10:0] = {4'b1,xtoh_sh_src[51:45]};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[44:0],9'b0};
  end
  12'hfee: begin //-18
  xtoh_sh_f_v[10:0] = {5'b1,xtoh_sh_src[51:46]};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[45:0],8'b0};
  end
  12'hfed: begin //-19
  xtoh_sh_f_v[10:0] = {6'b1,xtoh_sh_src[51:47]};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[46:0],7'b0};
  end
  12'hfec: begin //-20
  xtoh_sh_f_v[10:0] = {7'b1,xtoh_sh_src[51:48]};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[47:0],6'b0};
  end
  12'hfeb: begin //-21
  xtoh_sh_f_v[10:0] = {8'b1,xtoh_sh_src[51:49]};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[48:0],5'b0};
  end
  12'hfea: begin //-22
  xtoh_sh_f_v[10:0] = {9'b1,xtoh_sh_src[51:50]};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[49:0],4'b0};
  end
  12'hfe9: begin //-135
  xtoh_sh_f_v[10:0] = {10'b1,xtoh_sh_src[51]};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[50:0],3'b0};
  end
  12'hfe8: begin //-136
  xtoh_sh_f_v[10:0] = {11'b1};
  xtoh_sh_f_x[53:0] = {xtoh_sh_src[51:0],2'b0};
  end
  12'hfe7: begin //-137
  xtoh_sh_f_v[10:0] = 11'b0;
  xtoh_sh_f_x[53:0] = {1'b1,xtoh_sh_src[51:0],1'b0};
  end
  12'hfe6: begin //-138
  xtoh_sh_f_v[10:0] = 11'b0;
  xtoh_sh_f_x[53:0] = {2'b1,xtoh_sh_src[51:0]};
  end
  default: begin
  xtoh_sh_f_v[10:0] = 11'b0;
  xtoh_sh_f_x[53:0] = {3'b1,51'b0};
  end
endcase
// &CombEnd; @77
end


// &ModuleEnd; @80
endmodule


