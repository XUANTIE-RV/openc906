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
module aq_pmp_acc(
  mmu_pmp_chk1,
  mmu_pmp_pa,
  mmu_pmp_priv_mode,
  pmp_mmu_flg,
  pmp_mmu_hit_num,
  pmp_mmu_napot_cross,
  pmpaddr0_value,
  pmpaddr1_value,
  pmpaddr2_value,
  pmpaddr3_value,
  pmpaddr4_value,
  pmpaddr5_value,
  pmpaddr6_value,
  pmpaddr7_value,
  pmpcfg0_value,
  pmpcfg2_value
);

// &Ports; @25
input           mmu_pmp_chk1;       
input   [27:0]  mmu_pmp_pa;         
input   [1 :0]  mmu_pmp_priv_mode;  
input   [28:0]  pmpaddr0_value;     
input   [28:0]  pmpaddr1_value;     
input   [28:0]  pmpaddr2_value;     
input   [28:0]  pmpaddr3_value;     
input   [28:0]  pmpaddr4_value;     
input   [28:0]  pmpaddr5_value;     
input   [28:0]  pmpaddr6_value;     
input   [28:0]  pmpaddr7_value;     
input   [63:0]  pmpcfg0_value;      
input   [63:0]  pmpcfg2_value;      
output  [3 :0]  pmp_mmu_flg;        
output  [15:0]  pmp_mmu_hit_num;    
output          pmp_mmu_napot_cross; 

// &Regs; @26
reg     [3 :0]  pmp_mmu_flg;        
reg             pmp_mmu_napot_cross; 

// &Wires; @27
wire    [1 :0]  addr_match_mode0;   
wire    [1 :0]  addr_match_mode1;   
wire    [1 :0]  addr_match_mode2;   
wire    [1 :0]  addr_match_mode3;   
wire    [1 :0]  addr_match_mode4;   
wire    [1 :0]  addr_match_mode5;   
wire    [1 :0]  addr_match_mode6;   
wire    [1 :0]  addr_match_mode7;   
wire            cp0_mach_mode;      
wire            mmu_addr_ge_bottom0; 
wire            mmu_addr_ge_bottom1; 
wire            mmu_addr_ge_bottom2; 
wire            mmu_addr_ge_bottom3; 
wire            mmu_addr_ge_bottom4; 
wire            mmu_addr_ge_bottom5; 
wire            mmu_addr_ge_bottom6; 
wire            mmu_addr_ge_bottom7; 
wire            mmu_addr_ge_upaddr0; 
wire            mmu_addr_ge_upaddr1; 
wire            mmu_addr_ge_upaddr2; 
wire            mmu_addr_ge_upaddr3; 
wire            mmu_addr_ge_upaddr4; 
wire            mmu_addr_ge_upaddr5; 
wire            mmu_addr_ge_upaddr6; 
wire            mmu_addr_ge_upaddr7; 
wire            mmu_pmp_chk1;       
wire    [27:0]  mmu_pmp_pa;         
wire    [1 :0]  mmu_pmp_priv_mode;  
wire            napot_cross0;       
wire            napot_cross1;       
wire            napot_cross2;       
wire            napot_cross3;       
wire            napot_cross4;       
wire            napot_cross5;       
wire            napot_cross6;       
wire            napot_cross7;       
wire    [15:0]  pmp_cross;          
wire    [3 :0]  pmp_default_flg;    
wire    [15:0]  pmp_hit;            
wire            pmp_mmu_hit0;       
wire            pmp_mmu_hit1;       
wire            pmp_mmu_hit2;       
wire            pmp_mmu_hit3;       
wire            pmp_mmu_hit4;       
wire            pmp_mmu_hit5;       
wire            pmp_mmu_hit6;       
wire            pmp_mmu_hit7;       
wire    [15:0]  pmp_mmu_hit_num;    
wire    [28:0]  pmpaddr0_value;     
wire    [28:0]  pmpaddr1_value;     
wire    [28:0]  pmpaddr2_value;     
wire    [28:0]  pmpaddr3_value;     
wire    [28:0]  pmpaddr4_value;     
wire    [28:0]  pmpaddr5_value;     
wire    [28:0]  pmpaddr6_value;     
wire    [28:0]  pmpaddr7_value;     
wire    [63:0]  pmpcfg0_value;      
wire    [63:0]  pmpcfg2_value;      


// priviledged mode judgement
//assign cp0_priv_mode[1:0] = pmp_mprv_status ? cp0_pmp_mpp[1:0]
//                                              : cur_priv_mode[1:0];
assign cp0_mach_mode      = mmu_pmp_priv_mode[1:0] == 2'b11;

// get bottom compare infor from last entry
// &Force("nonport", "mmu_addr_ge_upaddr7"); @35
assign {mmu_addr_ge_bottom7, mmu_addr_ge_bottom6, 
        mmu_addr_ge_bottom5, mmu_addr_ge_bottom4,
        mmu_addr_ge_bottom3, mmu_addr_ge_bottom2,
        mmu_addr_ge_bottom1, mmu_addr_ge_bottom0} = 
       {mmu_addr_ge_upaddr6, mmu_addr_ge_upaddr5, 
        mmu_addr_ge_upaddr4, mmu_addr_ge_upaddr3,
        mmu_addr_ge_upaddr2, mmu_addr_ge_upaddr1,
        mmu_addr_ge_upaddr0, 1'b1};

// gather the hit information
assign pmp_hit[7:0] = {pmp_mmu_hit7, pmp_mmu_hit6, 
                       pmp_mmu_hit5, pmp_mmu_hit4,
                       pmp_mmu_hit3, pmp_mmu_hit2,
                       pmp_mmu_hit1, pmp_mmu_hit0}; 

assign pmp_cross[7:0] = {napot_cross7, napot_cross6, 
                         napot_cross5, napot_cross4,
                         napot_cross3, napot_cross2,
                         napot_cross1, napot_cross0}; 

// get addr match mode from pmp configure register
assign addr_match_mode0[1:0] = pmpcfg0_value[4:3]  ;
assign addr_match_mode1[1:0] = pmpcfg0_value[12:11];
assign addr_match_mode2[1:0] = pmpcfg0_value[20:19];
assign addr_match_mode3[1:0] = pmpcfg0_value[28:27];
assign addr_match_mode4[1:0] = pmpcfg0_value[36:35];
assign addr_match_mode5[1:0] = pmpcfg0_value[44:43];
assign addr_match_mode6[1:0] = pmpcfg0_value[52:51];
assign addr_match_mode7[1:0] = pmpcfg0_value[60:59];

// &ConnRule(s/_x/0/); @66
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_0"); @67
aq_pmp_comp_hit  x_aq_pmp_comp_hit_0 (
  .addr_match_mode_x    (addr_match_mode0    ),
  .mmu_addr_ge_bottom_x (mmu_addr_ge_bottom0 ),
  .mmu_addr_ge_upaddr_x (mmu_addr_ge_upaddr0 ),
  .mmu_pmp_chk1         (mmu_pmp_chk1        ),
  .mmu_pmp_pa           (mmu_pmp_pa          ),
  .napot_cross_x        (napot_cross0        ),
  .pmp_mmu_hit_x        (pmp_mmu_hit0        ),
  .pmpaddr_x_value      (pmpaddr0_value      )
);


// &ConnRule(s/_x/1/); @69
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_1"); @70
aq_pmp_comp_hit  x_aq_pmp_comp_hit_1 (
  .addr_match_mode_x    (addr_match_mode1    ),
  .mmu_addr_ge_bottom_x (mmu_addr_ge_bottom1 ),
  .mmu_addr_ge_upaddr_x (mmu_addr_ge_upaddr1 ),
  .mmu_pmp_chk1         (mmu_pmp_chk1        ),
  .mmu_pmp_pa           (mmu_pmp_pa          ),
  .napot_cross_x        (napot_cross1        ),
  .pmp_mmu_hit_x        (pmp_mmu_hit1        ),
  .pmpaddr_x_value      (pmpaddr1_value      )
);


// &ConnRule(s/_x/2/); @72
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_2"); @73
aq_pmp_comp_hit  x_aq_pmp_comp_hit_2 (
  .addr_match_mode_x    (addr_match_mode2    ),
  .mmu_addr_ge_bottom_x (mmu_addr_ge_bottom2 ),
  .mmu_addr_ge_upaddr_x (mmu_addr_ge_upaddr2 ),
  .mmu_pmp_chk1         (mmu_pmp_chk1        ),
  .mmu_pmp_pa           (mmu_pmp_pa          ),
  .napot_cross_x        (napot_cross2        ),
  .pmp_mmu_hit_x        (pmp_mmu_hit2        ),
  .pmpaddr_x_value      (pmpaddr2_value      )
);


// &ConnRule(s/_x/3/); @75
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_3"); @76
aq_pmp_comp_hit  x_aq_pmp_comp_hit_3 (
  .addr_match_mode_x    (addr_match_mode3    ),
  .mmu_addr_ge_bottom_x (mmu_addr_ge_bottom3 ),
  .mmu_addr_ge_upaddr_x (mmu_addr_ge_upaddr3 ),
  .mmu_pmp_chk1         (mmu_pmp_chk1        ),
  .mmu_pmp_pa           (mmu_pmp_pa          ),
  .napot_cross_x        (napot_cross3        ),
  .pmp_mmu_hit_x        (pmp_mmu_hit3        ),
  .pmpaddr_x_value      (pmpaddr3_value      )
);


// &ConnRule(s/_x/4/); @78
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_4"); @79
aq_pmp_comp_hit  x_aq_pmp_comp_hit_4 (
  .addr_match_mode_x    (addr_match_mode4    ),
  .mmu_addr_ge_bottom_x (mmu_addr_ge_bottom4 ),
  .mmu_addr_ge_upaddr_x (mmu_addr_ge_upaddr4 ),
  .mmu_pmp_chk1         (mmu_pmp_chk1        ),
  .mmu_pmp_pa           (mmu_pmp_pa          ),
  .napot_cross_x        (napot_cross4        ),
  .pmp_mmu_hit_x        (pmp_mmu_hit4        ),
  .pmpaddr_x_value      (pmpaddr4_value      )
);


// &ConnRule(s/_x/5/); @81
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_5"); @82
aq_pmp_comp_hit  x_aq_pmp_comp_hit_5 (
  .addr_match_mode_x    (addr_match_mode5    ),
  .mmu_addr_ge_bottom_x (mmu_addr_ge_bottom5 ),
  .mmu_addr_ge_upaddr_x (mmu_addr_ge_upaddr5 ),
  .mmu_pmp_chk1         (mmu_pmp_chk1        ),
  .mmu_pmp_pa           (mmu_pmp_pa          ),
  .napot_cross_x        (napot_cross5        ),
  .pmp_mmu_hit_x        (pmp_mmu_hit5        ),
  .pmpaddr_x_value      (pmpaddr5_value      )
);


// &ConnRule(s/_x/6/); @84
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_6"); @85
aq_pmp_comp_hit  x_aq_pmp_comp_hit_6 (
  .addr_match_mode_x    (addr_match_mode6    ),
  .mmu_addr_ge_bottom_x (mmu_addr_ge_bottom6 ),
  .mmu_addr_ge_upaddr_x (mmu_addr_ge_upaddr6 ),
  .mmu_pmp_chk1         (mmu_pmp_chk1        ),
  .mmu_pmp_pa           (mmu_pmp_pa          ),
  .napot_cross_x        (napot_cross6        ),
  .pmp_mmu_hit_x        (pmp_mmu_hit6        ),
  .pmpaddr_x_value      (pmpaddr6_value      )
);


// &ConnRule(s/_x/7/); @87
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_7"); @88
aq_pmp_comp_hit  x_aq_pmp_comp_hit_7 (
  .addr_match_mode_x    (addr_match_mode7    ),
  .mmu_addr_ge_bottom_x (mmu_addr_ge_bottom7 ),
  .mmu_addr_ge_upaddr_x (mmu_addr_ge_upaddr7 ),
  .mmu_pmp_chk1         (mmu_pmp_chk1        ),
  .mmu_pmp_pa           (mmu_pmp_pa          ),
  .napot_cross_x        (napot_cross7        ),
  .pmp_mmu_hit_x        (pmp_mmu_hit7        ),
  .pmpaddr_x_value      (pmpaddr7_value      )
);


// &Force("nonport", "mmu_addr_ge_upaddr15"); @92
// &ConnRule(s/_x/8/); @123
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_8"); @124
// &ConnRule(s/_x/9/); @126
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_9"); @127
// &ConnRule(s/_x/10/); @129
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_10"); @130
// &ConnRule(s/_x/11/); @132
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_11"); @133
// &ConnRule(s/_x/12/); @135
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_12"); @136
// &ConnRule(s/_x/13/); @138
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_13"); @139
// &ConnRule(s/_x/14/); @141
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_14"); @142
// &ConnRule(s/_x/15/); @144
// &Instance("aq_pmp_comp_hit", "x_aq_pmp_comp_hit_15"); @145
assign pmp_hit[15:8] = 8'b0;
assign pmp_cross[15:8] = 8'b0;

//----------------------------------------------------------
//priority encoder for access_deny
//----------------------------------------------------------
assign pmp_default_flg[3:0] = cp0_mach_mode ? 4'b0111 : 4'b0;

// &CombBeg; @156
always @( pmpcfg0_value[34:31]
       or pmpcfg0_value[63]
       or pmpcfg0_value[26:23]
       or pmpcfg2_value[34:31]
       or pmpcfg2_value[18:15]
       or pmpcfg0_value[10:07]
       or pmpcfg0_value[42:39]
       or pmp_default_flg[3:0]
       or pmpcfg0_value[2:0]
       or pmpcfg2_value[58:55]
       or pmpcfg0_value[58:55]
       or pmp_hit[15:0]
       or pmpcfg0_value[18:15]
       or pmpcfg0_value[50:47]
       or pmpcfg2_value[10:07]
       or pmpcfg2_value[42:39]
       or pmpcfg2_value[50:47]
       or pmpcfg2_value[26:23]
       or pmpcfg2_value[63]
       or pmpcfg2_value[2:0])
begin
  casez(pmp_hit[15:0])
    16'b???????????????1  : pmp_mmu_flg[3:0] = {pmpcfg0_value[07], pmpcfg0_value[2:0]};
    16'b??????????????10  : pmp_mmu_flg[3:0] = {pmpcfg0_value[15], pmpcfg0_value[10:8]};
    16'b?????????????100  : pmp_mmu_flg[3:0] = {pmpcfg0_value[23], pmpcfg0_value[18:16]};
    16'b????????????1000  : pmp_mmu_flg[3:0] = {pmpcfg0_value[31], pmpcfg0_value[26:24]};
    16'b???????????10000  : pmp_mmu_flg[3:0] = {pmpcfg0_value[39], pmpcfg0_value[34:32]};
    16'b??????????100000  : pmp_mmu_flg[3:0] = {pmpcfg0_value[47], pmpcfg0_value[42:40]};
    16'b?????????1000000  : pmp_mmu_flg[3:0] = {pmpcfg0_value[55], pmpcfg0_value[50:48]};
    16'b????????10000000  : pmp_mmu_flg[3:0] = {pmpcfg0_value[63], pmpcfg0_value[58:56]};
    16'b???????100000000  : pmp_mmu_flg[3:0] = {pmpcfg2_value[07], pmpcfg2_value[2:0]};
    16'b??????1000000000  : pmp_mmu_flg[3:0] = {pmpcfg2_value[15], pmpcfg2_value[10:8]};
    16'b?????10000000000  : pmp_mmu_flg[3:0] = {pmpcfg2_value[23], pmpcfg2_value[18:16]};
    16'b????100000000000  : pmp_mmu_flg[3:0] = {pmpcfg2_value[31], pmpcfg2_value[26:24]};
    16'b???1000000000000  : pmp_mmu_flg[3:0] = {pmpcfg2_value[39], pmpcfg2_value[34:32]};
    16'b??10000000000000  : pmp_mmu_flg[3:0] = {pmpcfg2_value[47], pmpcfg2_value[42:40]};
    16'b?100000000000000  : pmp_mmu_flg[3:0] = {pmpcfg2_value[55], pmpcfg2_value[50:48]};
    16'b1000000000000000  : pmp_mmu_flg[3:0] = {pmpcfg2_value[63], pmpcfg2_value[58:56]};
    16'b0000000000000000  : pmp_mmu_flg[3:0] = pmp_default_flg[3:0];
    default               : pmp_mmu_flg[3:0] = {4{1'bx}};
endcase
// &CombEnd; @177
end

//----------------------------------------------------------
//priority encoder for access cross
//----------------------------------------------------------
// &CombBeg; @182
always @( pmp_cross[15:0]
       or pmp_hit[15:0])
begin
  casez(pmp_hit[15:0])
    16'b???????????????1  : pmp_mmu_napot_cross = 1'b0;
    16'b??????????????10  : pmp_mmu_napot_cross =  pmp_cross[0]; 
    16'b?????????????100  : pmp_mmu_napot_cross = |pmp_cross[1:0]; 
    16'b????????????1000  : pmp_mmu_napot_cross = |pmp_cross[2:0]; 
    16'b???????????10000  : pmp_mmu_napot_cross = |pmp_cross[3:0]; 
    16'b??????????100000  : pmp_mmu_napot_cross = |pmp_cross[4:0]; 
    16'b?????????1000000  : pmp_mmu_napot_cross = |pmp_cross[5:0]; 
    16'b????????10000000  : pmp_mmu_napot_cross = |pmp_cross[6:0]; 
    16'b???????100000000  : pmp_mmu_napot_cross = |pmp_cross[7:0]; 
    16'b??????1000000000  : pmp_mmu_napot_cross = |pmp_cross[8:0]; 
    16'b?????10000000000  : pmp_mmu_napot_cross = |pmp_cross[9:0]; 
    16'b????100000000000  : pmp_mmu_napot_cross = |pmp_cross[10:0]; 
    16'b???1000000000000  : pmp_mmu_napot_cross = |pmp_cross[11:0]; 
    16'b??10000000000000  : pmp_mmu_napot_cross = |pmp_cross[12:0]; 
    16'b?100000000000000  : pmp_mmu_napot_cross = |pmp_cross[13:0]; 
    16'b1000000000000000  : pmp_mmu_napot_cross = |pmp_cross[14:0]; 
    16'b0000000000000000  : pmp_mmu_napot_cross = |pmp_cross[15:0]; 
    default               : pmp_mmu_napot_cross = 1'b0;
endcase
// &CombEnd; @203
end
assign pmp_mmu_hit_num[15:0] = pmp_hit[15:0];

// &ModuleEnd; @206
endmodule


