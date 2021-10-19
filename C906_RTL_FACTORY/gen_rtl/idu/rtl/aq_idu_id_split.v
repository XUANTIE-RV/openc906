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

// &Depend("aq_idu_cfig.h"); @24
// &ModuleBeg; @25
module aq_idu_id_split(
  cp0_idu_cskyee,
  cp0_idu_icg_en,
  cp0_idu_ucme,
  cp0_yy_clk_en,
  cp0_yy_priv_mode,
  cpurst_b,
  ctrl_xx_dis_stall,
  dp_split_inst,
  forever_cpuclk,
  ifu_idu_id_inst_vld,
  iu_yy_xx_cancel,
  pad_yy_icg_scan_en,
  rtu_idu_flush_fe,
  rtu_yy_xx_dbgon,
  split_ctrl_id_stall,
  split_ctrl_inst_vld,
  split_dp_inst_data,
  split_dp_inst_sel,
  split_top_cur_state_no_idle
);

// &Ports; @26
input            cp0_idu_cskyee;             
input            cp0_idu_icg_en;             
input            cp0_idu_ucme;               
input            cp0_yy_clk_en;              
input   [1  :0]  cp0_yy_priv_mode;           
input            cpurst_b;                   
input            ctrl_xx_dis_stall;          
input   [31 :0]  dp_split_inst;              
input            forever_cpuclk;             
input            ifu_idu_id_inst_vld;        
input            iu_yy_xx_cancel;            
input            pad_yy_icg_scan_en;         
input            rtu_idu_flush_fe;           
input            rtu_yy_xx_dbgon;            
output           split_ctrl_id_stall;        
output           split_ctrl_inst_vld;        
output  [264:0]  split_dp_inst_data;         
output           split_dp_inst_sel;          
output  [3  :0]  split_top_cur_state_no_idle; 

// &Regs; @27
reg     [264:0]  amo_amo_inst_data;          
reg     [2  :0]  amo_cur_state;              
reg     [264:0]  amo_fence_aq_inst_data;     
reg     [264:0]  amo_fence_rl_inst_data;     
reg     [264:0]  amo_inst_data;              
reg     [264:0]  amo_lr_inst_data;           
reg     [2  :0]  amo_next_state;             
reg     [264:0]  amo_sc_inst_data;           
reg              che_cur_state;              
reg     [264:0]  che_inst_dcache_data;       
reg     [264:0]  che_inst_icache_data;       
reg              che_next_state;             
reg              fnc_cur_state;              
reg     [264:0]  fnc_inst_sfence_data;       
reg     [264:0]  fnc_inst_sync_data;         
reg              fnc_next_state;             
reg              lsd_cur_state;              
reg     [264:0]  lsd_inst_load_data;         
reg     [264:0]  lsd_inst_store_data;        
reg              lsd_next_state;             
reg     [264:0]  split_dp_inst_data;         

// &Wires; @28
wire             amo_aq_inst;                
wire             amo_fence_aq_inst_length;   
wire             amo_fence_rl_inst_length;   
wire             amo_inst;                   
wire             amo_inst_vld;               
wire    [4  :0]  amo_rd;                     
wire             amo_rl_inst;                
wire    [4  :0]  amo_rs1;                    
wire    [4  :0]  amo_rs2;                    
wire             amo_sm_start;               
wire             amo_split_stall;            
wire             amo_split_type;             
wire             amo_word;                   
wire    [264:0]  che_inst_data;              
wire             che_inst_vld;               
wire             che_sm_start;               
wire             che_split_stall;            
wire             che_split_type;             
wire             che_va;                     
wire             cp0_idu_cskyee;             
wire             cp0_idu_icg_en;             
wire             cp0_idu_ucme;               
wire             cp0_yy_clk_en;              
wire    [1  :0]  cp0_yy_priv_mode;           
wire             cpurst_b;                   
wire             ctrl_xx_dis_stall;          
wire    [31 :0]  dp_split_inst;              
wire    [264:0]  fnc_inst_data;              
wire             fnc_inst_vld;               
wire             fnc_sm_start;               
wire             fnc_split_stall;            
wire             fnc_split_type;             
wire             forever_cpuclk;             
wire             ifu_idu_id_inst_vld;        
wire             iu_yy_xx_cancel;            
wire             lr_inst;                    
wire    [11 :0]  lsd_inst0_offset;           
wire    [11 :0]  lsd_inst1_offset;           
wire             lsd_inst1_sel;              
wire    [264:0]  lsd_inst_data;              
wire             lsd_inst_vld;               
wire             lsd_load;                   
wire             lsd_sm_start;               
wire             lsd_split_stall;            
wire             lsd_split_type;             
wire             lsd_word;                   
wire             pad_yy_icg_scan_en;         
wire             rtu_idu_flush_fe;           
wire             rtu_yy_xx_dbgon;            
wire             sc_inst;                    
wire             split_clk;                  
wire             split_clk_en;               
wire             split_ctrl_id_stall;        
wire             split_ctrl_inst_vld;        
wire             split_dp_inst_sel;          
wire    [264:0]  split_inst_data;            
wire    [3  :0]  split_top_cur_state_no_idle; 
wire    [19 :0]  zvamo_func;                 
wire             zvamo_inst;                 


//==========================================================
//            Load store double (lsd) instructions
//==========================================================
//----------------------------------------------------------
//                   lsd split inst
//----------------------------------------------------------
//full decode split type
assign lsd_split_type =
  cp0_idu_cskyee
  && (({dp_split_inst[31:27],dp_split_inst[14:12],dp_split_inst[6:0]} == 15'b11100_100_0001011) //lwd
   || ({dp_split_inst[31:27],dp_split_inst[14:12],dp_split_inst[6:0]} == 15'b11110_100_0001011) //lwud
   || ({dp_split_inst[31:27],dp_split_inst[14:12],dp_split_inst[6:0]} == 15'b11111_100_0001011) //ldd
   || ({dp_split_inst[31:27],dp_split_inst[14:12],dp_split_inst[6:0]} == 15'b11100_101_0001011) //swd
   || ({dp_split_inst[31:27],dp_split_inst[14:12],dp_split_inst[6:0]} == 15'b11111_101_0001011));//sdd

//----------------------------------------------------------
//           lsd split variables initial value
//----------------------------------------------------------
assign lsd_sm_start           = ifu_idu_id_inst_vld
                                && lsd_split_type;

assign lsd_load               = !dp_split_inst[12];
assign lsd_word               = !dp_split_inst[27];

assign lsd_inst0_offset[11:0] = lsd_word ? {7'b0,dp_split_inst[26:25],3'b0}
                                         : {6'b0,dp_split_inst[26:25],4'b0};
assign lsd_inst1_offset[11:0] = lsd_word ? lsd_inst0_offset[11:0] + {8'b0,4'd4}
                                         : lsd_inst0_offset[11:0] + {8'b0,4'd8};

//----------------------------------------------------------
//              FSM of inst lsd ctrl logic
//----------------------------------------------------------
// State Description:
// LSD_IDLE  : id stage instruction 0 is not multi load store
//            (lsd) or the first cycle to start lsd FSM
// LSD_SPLIT : the lsd instruction is spliting
parameter LSD_IDLE  = 1'b0;
parameter LSD_SPLIT = 1'b1;

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    lsd_cur_state <= LSD_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    lsd_cur_state <= LSD_IDLE;
  else if(!ctrl_xx_dis_stall)
    lsd_cur_state <= lsd_next_state;
  else
    lsd_cur_state <= lsd_cur_state;
end

// &CombBeg; @81
always @( lsd_sm_start
       or lsd_cur_state)
begin
  case(lsd_cur_state)
  LSD_IDLE  : if(lsd_sm_start)
                lsd_next_state = LSD_SPLIT;
              else
                lsd_next_state = LSD_IDLE;
  LSD_SPLIT :   lsd_next_state = LSD_IDLE;
  default   :   lsd_next_state = LSD_IDLE;
  endcase
// &CombEnd; @90
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
assign lsd_inst_vld    = 1'b1;

assign lsd_split_stall = (lsd_next_state != LSD_IDLE);

assign lsd_inst1_sel   = (lsd_cur_state == LSD_SPLIT);

//----------------------------------------------------------
//               Split Instruction : load
//----------------------------------------------------------
//split inst 0: lw/ld/lwu rd,(rs1),sign_ext(imm5<<imm2)
//split inst 1: lw/ld/lwu rd+1,(rs1),sign_ext(imm5<<imm2+4/8)
// &CombBeg; @106
always @( dp_split_inst[11:7]
       or lsd_inst0_offset[11:0]
       or lsd_inst1_offset[11:0]
       or dp_split_inst[24:15]
       or dp_split_inst[28:27]
       or lsd_inst1_sel)
begin
  lsd_inst_load_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  lsd_inst_load_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_LSU;
  lsd_inst_load_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = dp_split_inst[27]
                                                         ? `FUNC_LD
                                                         : dp_split_inst[28]
                                                           ? `FUNC_LWU
                                                           : `FUNC_LW;
  lsd_inst_load_data[`IDU_SRC0_VLD]                     = 1'b1;
  lsd_inst_load_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]      = {1'b0,dp_split_inst[19:15]};
  lsd_inst_load_data[`IDU_SRC1_IMM_VLD]                 = 1'b1;
  lsd_inst_load_data[`IDU_SRC1_IMM:`IDU_SRC1_IMM-63]     = lsd_inst1_sel
                                                         ? {{52{lsd_inst1_offset[11]}},
                                                                lsd_inst1_offset[11:0]}
                                                         : {{52{lsd_inst0_offset[11]}},
                                                                lsd_inst0_offset[11:0]};
  lsd_inst_load_data[`IDU_DST0_VLD]                     = 1'b1;
  lsd_inst_load_data[`IDU_DST0_REG:`IDU_DST0_REG-5]      = lsd_inst1_sel
                                                         ? {1'b0,dp_split_inst[24:20]}
                                                         : {1'b0,dp_split_inst[11:7]};
  lsd_inst_load_data[`IDU_SPLIT]                        = !lsd_inst1_sel;
  lsd_inst_load_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @130
end

//----------------------------------------------------------
//               Split Instruction: store
//----------------------------------------------------------
//split inst 0: sw/sd/swu rs2,(rs1),sign_ext(imm5<<imm2)
//split inst 1: sw/sd/swu rs2+1,(rs1),sign_ext(imm5<<imm2+4/8)
// &CombBeg; @137
always @( dp_split_inst[11:7]
       or lsd_inst0_offset[11:0]
       or lsd_inst1_offset[11:0]
       or dp_split_inst[24:15]
       or dp_split_inst[27]
       or lsd_inst1_sel)
begin
  lsd_inst_store_data[`IDU_WIDTH-1:0]                   = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  lsd_inst_store_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_LSU;
  lsd_inst_store_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = dp_split_inst[27]
                                                         ? `FUNC_SD
                                                         : `FUNC_SW; 
  lsd_inst_store_data[`IDU_SRC0_VLD]                    = 1'b1;
  lsd_inst_store_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]     = {1'b0,dp_split_inst[19:15]};
  lsd_inst_store_data[`IDU_SRC1_IMM_VLD]                = 1'b1;
  lsd_inst_store_data[`IDU_SRC1_IMM:`IDU_SRC1_IMM-63]    = lsd_inst1_sel
                                                         ? {{52{lsd_inst1_offset[11]}},
                                                                lsd_inst1_offset[11:0]}
                                                         : {{52{lsd_inst0_offset[11]}},
                                                                lsd_inst0_offset[11:0]};
  lsd_inst_store_data[`IDU_SRC2_VLD]                    = 1'b1;
  lsd_inst_store_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]     = lsd_inst1_sel
                                                         ? {1'b0,dp_split_inst[24:20]}
                                                         : {1'b0,dp_split_inst[11:7]};
  lsd_inst_store_data[`IDU_SPLIT]                       = !lsd_inst1_sel;
  lsd_inst_store_data[`IDU_LENGTH]                      = 1'b1;
  end 
// &CombEnd; @159
end

//----------------------------------------------------------
//                 Split Instruction Data
//----------------------------------------------------------
assign lsd_inst_data[`IDU_WIDTH-1:0] = lsd_load
                                      ? lsd_inst_load_data[`IDU_WIDTH-1:0]
                                      : lsd_inst_store_data[`IDU_WIDTH-1:0];

//==========================================================
//                 Atomic (amo) instructions
//==========================================================
//----------------------------------------------------------
//                   amo split inst
//----------------------------------------------------------
//full decode split type
assign amo_split_type =
      (dp_split_inst[6:0] == 7'b0101111)
  && (({dp_split_inst[31:27],dp_split_inst[24:20]} == 10'b00010_00000) //lr.w/d
    || (dp_split_inst[31:27] == 5'b00011) //sc.w/d
    || (dp_split_inst[31:27] == 5'b00000) //amoadd.w/d
    || (dp_split_inst[31:27] == 5'b00001) //amoswap.w/d
    || (dp_split_inst[31:27] == 5'b00100) //amoxor.w/d
    || (dp_split_inst[31:27] == 5'b01000) //amoor.w/d
    || (dp_split_inst[31:27] == 5'b01100) //amoand.w/d
    || (dp_split_inst[31:27] == 5'b10000) //amomin.w/d
    || (dp_split_inst[31:27] == 5'b10100) //amomax.w/d
    || (dp_split_inst[31:27] == 5'b11000) //amominu.w/d
    || (dp_split_inst[31:27] == 5'b11100)); //amomaxu.w/d

//----------------------------------------------------------
//           amo split variables initial value
//----------------------------------------------------------
assign amo_sm_start       = ifu_idu_id_inst_vld
                            && amo_split_type;

assign amo_inst           = dp_split_inst[6:0]   == 7'b0101111;
assign amo_word           = !dp_split_inst[12];
assign amo_aq_inst        = dp_split_inst[26] && !zvamo_inst;
assign amo_rl_inst        = dp_split_inst[25] && !zvamo_inst;

assign lr_inst            = amo_inst && (dp_split_inst[31:27] ==  5'b00010);
assign sc_inst            = amo_inst && (dp_split_inst[31:27] ==  5'b00011);

//assign amo_swap           = dp_split_inst[31:27] ==  5'b00001;
//assign amo_add            = dp_split_inst[31:27] ==  5'b00000;
//assign amo_xor            = dp_split_inst[31:27] ==  5'b00100;
//assign amo_and            = dp_split_inst[31:27] ==  5'b01100;
//assign amo_or             = dp_split_inst[31:27] ==  5'b01000;
//assign amo_min            = dp_split_inst[31:27] ==  5'b10000;
//assign amo_minu           = dp_split_inst[31:27] ==  5'b11000;
//assign amo_max            = dp_split_inst[31:27] ==  5'b10100;
//assign amo_maxu           = dp_split_inst[31:27] ==  5'b11100;

assign amo_rs1[4:0]       = dp_split_inst[19:15];
assign amo_rs2[4:0]       = dp_split_inst[24:20];
assign amo_rd[4:0]        = dp_split_inst[11:7];

//for zvamo
assign zvamo_inst         = dp_split_inst[14:13] == 2'b11;

assign zvamo_func[`FUNC_WIDTH-1:0] = `FUNC_ZVAMO
                                   | {dp_split_inst[25],{`FUNC_WIDTH-17{1'b0}},!dp_split_inst[26],11'b0,dp_split_inst[13:12],{2{1'b0}}};

//----------------------------------------------------------
//              FSM of inst amo ctrl logic
//----------------------------------------------------------
// State Description:
// AMO_IDLE  : id stage instruction 0 is not multi load store
//            (amo) or the first cycle to start amo FSM
// AMO_SPLIT : the amo instruction is spliting
// UPDATE: amo itself will not split anymore
parameter AMO_IDLE  = 3'd0;
parameter AMO_AMO   = 3'd1;
parameter AMO_LR    = 3'd4;
parameter AMO_SC    = 3'd5;
parameter AMO_AQ    = 3'd6;

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    amo_cur_state[2:0] <= AMO_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    amo_cur_state[2:0] <= AMO_IDLE;
  else if(!ctrl_xx_dis_stall)
    amo_cur_state[2:0] <= amo_next_state[2:0];
  else
    amo_cur_state[2:0] <= amo_cur_state[2:0];
end

// &CombBeg; @249
always @( amo_cur_state[2:0]
       or lr_inst
       or sc_inst
       or amo_aq_inst
       or amo_rl_inst
       or amo_sm_start)
begin
  case(amo_cur_state[2:0])
  AMO_IDLE  : if(amo_sm_start && amo_rl_inst && lr_inst)
                amo_next_state[2:0] = AMO_LR;
              else if(amo_sm_start && amo_rl_inst && sc_inst)
                amo_next_state[2:0] = AMO_SC;
              else if(amo_sm_start && amo_rl_inst)
                amo_next_state[2:0] = AMO_AMO;
              else if(amo_sm_start && lr_inst && amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else if(amo_sm_start && lr_inst)
                amo_next_state[2:0] = AMO_IDLE;
              else if(amo_sm_start && sc_inst && amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else if(amo_sm_start && sc_inst)
                amo_next_state[2:0] = AMO_IDLE;
              else if(amo_sm_start && amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else
                amo_next_state[2:0] = AMO_IDLE;
  AMO_AMO   : if(amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else
                amo_next_state[2:0] = AMO_IDLE;
  AMO_LR    : if(amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else
                amo_next_state[2:0] = AMO_IDLE;
  AMO_SC    : if(amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else
                amo_next_state[2:0] = AMO_IDLE;
  AMO_AQ    :   amo_next_state[2:0] = AMO_IDLE;
  default   :   amo_next_state[2:0] = AMO_IDLE;
  endcase
// &CombEnd; @284
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
assign amo_inst_vld    = 1'b1;

assign amo_split_stall = (amo_next_state[2:0] != AMO_IDLE);

//----------------------------------------------------------
//                  Split Instruction fence
//----------------------------------------------------------
//split inst 0: fence iorw,iorw
assign amo_fence_rl_inst_length                           = 1'b1;
// &CombBeg; @298
always @( amo_fence_rl_inst_length)
begin
  amo_fence_rl_inst_data[`IDU_WIDTH-1:0]                   = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_fence_rl_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_CP0;
  amo_fence_rl_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = `FUNC_FENCE;
  amo_fence_rl_inst_data[`IDU_SPLIT]                       = 1'b1;
  amo_fence_rl_inst_data[`IDU_LENGTH]                      = amo_fence_rl_inst_length;
  end
// &CombEnd; @306
end

//split inst last: fence iorw,iorw
assign amo_fence_aq_inst_length                           = 1'b1;
// &CombBeg; @310
always @( amo_fence_aq_inst_length)
begin
  amo_fence_aq_inst_data[`IDU_WIDTH-1:0]                   = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_fence_aq_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_CP0;
  amo_fence_aq_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = `FUNC_FENCE;
  amo_fence_aq_inst_data[`IDU_LENGTH]                      = amo_fence_aq_inst_length;
  end
// &CombEnd; @317
end

//----------------------------------------------------------
//                  Split Instruction lr
//----------------------------------------------------------
//split inst 0: lr
// &CombBeg; @323
always @( amo_rd[4:0]
       or amo_rs1[4:0]
       or amo_aq_inst
       or amo_word)
begin
  amo_lr_inst_data[`IDU_WIDTH-1:0]                         = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_lr_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]             = `EU_LSU;
  amo_lr_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]       = amo_word
                                                            ? `FUNC_LR_W
                                                            : `FUNC_LR_D;
  amo_lr_inst_data[`IDU_SRC0_VLD]                          = 1'b1;
  amo_lr_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]           = {1'b0,amo_rs1[4:0]};
  amo_lr_inst_data[`IDU_DST0_VLD]                          = 1'b1;
  amo_lr_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5]           = {1'b0,amo_rd[4:0]};
  amo_lr_inst_data[`IDU_SPLIT]                             = amo_aq_inst;
  amo_lr_inst_data[`IDU_LENGTH]                            = 1'b1;
  end
// &CombEnd; @337
end

//----------------------------------------------------------
//                  Split Instruction sc
//----------------------------------------------------------
//split inst 0: sc
// &CombBeg; @343
always @( amo_rs2[4:0]
       or amo_rd[4:0]
       or amo_rs1[4:0]
       or amo_aq_inst
       or amo_word)
begin
  amo_sc_inst_data[`IDU_WIDTH-1:0]                         = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_sc_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]             = `EU_LSU;
  amo_sc_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]       = amo_word
                                                            ? `FUNC_SC_W
                                                            : `FUNC_SC_D;
  amo_sc_inst_data[`IDU_SRC0_VLD]                          = 1'b1;
  amo_sc_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]           = {1'b0,amo_rs1[4:0]};
  amo_sc_inst_data[`IDU_SRC2_VLD]                          = 1'b1;
  amo_sc_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]           = {1'b0,amo_rs2[4:0]};
  amo_sc_inst_data[`IDU_DST0_VLD]                          = 1'b1;
  amo_sc_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5]           = {1'b0,amo_rd[4:0]};
  amo_sc_inst_data[`IDU_SPLIT]                             = amo_aq_inst;
  amo_sc_inst_data[`IDU_LENGTH]                            = 1'b1;
  end
// &CombEnd; @359
end

//----------------------------------------------------------
//                  Split Instruction amo
//----------------------------------------------------------
// &CombBeg; @364
always @( amo_rs2[4:0]
       or zvamo_inst
       or amo_rd[4:0]
       or dp_split_inst[31:25]
       or amo_rs1[4:0]
       or amo_aq_inst
       or amo_word
       or zvamo_func[19:0])
begin
  amo_amo_inst_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_amo_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = zvamo_inst
                                                          ? `EU_VLSU
                                                          : `EU_LSU;
  amo_amo_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = zvamo_inst
                                                          ? zvamo_func[`FUNC_WIDTH-1:0]
                                                          : amo_word
                                                            ? `FUNC_AMO_W
                                                            : `FUNC_AMO_D;
  amo_amo_inst_data[`IDU_SRC0_VLD]                      = 1'b1;
  amo_amo_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]      = {1'b0,amo_rs1[4:0]};
  amo_amo_inst_data[`IDU_SRC2_VLD]                      = !zvamo_inst;
  amo_amo_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]      = {1'b0,amo_rs2[4:0]};
  amo_amo_inst_data[`IDU_DST0_VLD]                      = !zvamo_inst;
  amo_amo_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5]      = {1'b0,amo_rd[4:0]};
  amo_amo_inst_data[`IDU_SPLIT]                         = amo_aq_inst;
  amo_amo_inst_data[`IDU_LENGTH]                        = 1'b1;
  amo_amo_inst_data[`IDU_SRC1_IMM_VLD]                  = 1'b1;
  amo_amo_inst_data[`IDU_SRC1_IMM:`IDU_SRC1_IMM-63]     = {59'b0,dp_split_inst[31:27]};
//zvamo
  amo_amo_inst_data[`IDU_SRCV0_VLD]                     = zvamo_inst;
  amo_amo_inst_data[`IDU_SRCV0_REG:`IDU_SRCV0_REG-4]    = amo_rs2[4:0];
  amo_amo_inst_data[`IDU_SRCV2_VLD]                     = zvamo_inst;
  amo_amo_inst_data[`IDU_SRCV2_REG:`IDU_SRCV2_REG-4]    = amo_rd[4:0];
  amo_amo_inst_data[`IDU_SRCVM_VLD]                     = zvamo_inst && !dp_split_inst[25];
  amo_amo_inst_data[`IDU_DSTV_VLD]                      = zvamo_inst && dp_split_inst[26];
  amo_amo_inst_data[`IDU_DSTV_REG:`IDU_DSTV_REG-4]      = amo_rd[4:0];
  end
// &CombEnd; @394
end

//----------------------------------------------------------
//              Pipedown Instrction Selection
//----------------------------------------------------------
// &CombBeg; @399
always @( amo_amo_inst_data[264:0]
       or amo_cur_state[2:0]
       or amo_sc_inst_data[264:0]
       or amo_lr_inst_data[264:0]
       or lr_inst
       or amo_fence_aq_inst_data[264:0]
       or sc_inst
       or amo_rl_inst
       or amo_fence_rl_inst_data[264:0])
begin
  case(amo_cur_state[2:0])
  AMO_IDLE  : if(amo_rl_inst)
                amo_inst_data[`IDU_WIDTH-1:0] = amo_fence_rl_inst_data[`IDU_WIDTH-1:0];
              else if(lr_inst)
                amo_inst_data[`IDU_WIDTH-1:0] = amo_lr_inst_data[`IDU_WIDTH-1:0];
              else if(sc_inst)
                amo_inst_data[`IDU_WIDTH-1:0] = amo_sc_inst_data[`IDU_WIDTH-1:0];
              else
                amo_inst_data[`IDU_WIDTH-1:0] = amo_amo_inst_data[`IDU_WIDTH-1:0];
  AMO_AMO   :   amo_inst_data[`IDU_WIDTH-1:0] = amo_amo_inst_data[`IDU_WIDTH-1:0];
  AMO_LR    :   amo_inst_data[`IDU_WIDTH-1:0] = amo_lr_inst_data[`IDU_WIDTH-1:0];
  AMO_SC    :   amo_inst_data[`IDU_WIDTH-1:0] = amo_sc_inst_data[`IDU_WIDTH-1:0];
  AMO_AQ    :   amo_inst_data[`IDU_WIDTH-1:0] = amo_fence_aq_inst_data[`IDU_WIDTH-1:0];
  default   :   amo_inst_data[`IDU_WIDTH-1:0] = {`IDU_WIDTH{1'bx}};
  endcase
// &CombEnd; @415
end

//==========================================================
//                Cache (che) instructions
//==========================================================
//----------------------------------------------------------
//                   che split inst
//----------------------------------------------------------
//full decode split type
assign che_split_type =
  cp0_idu_cskyee
  && (({dp_split_inst[31:20],dp_split_inst[14:0]} == 27'b0000001_10000_000_00000_0001011) //icache.iva
            && (cp0_yy_priv_mode[1:0] != 2'b0 || cp0_idu_ucme || rtu_yy_xx_dbgon)
   || ({dp_split_inst[31:20],dp_split_inst[14:0]} == 27'b0000001_11000_000_00000_0001011)  //icache.ipa
            && (cp0_yy_priv_mode[1:0] != 2'b0 || rtu_yy_xx_dbgon));

//----------------------------------------------------------
//           che split variables initial value
//----------------------------------------------------------
assign che_sm_start           = ifu_idu_id_inst_vld
                                && che_split_type;

assign che_va                 = !dp_split_inst[23];

//----------------------------------------------------------
//              FSM of inst che ctrl logic
//----------------------------------------------------------
// State Description:
// CHE_IDLE  : id stage instruction 0 is not multi load store
//            (che) or the first cycle to start che FSM
// CHE_SPLIT : the che instruction is spliting
parameter CHE_IDLE  = 1'b0;
parameter CHE_SPLIT = 1'b1;

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    che_cur_state <= CHE_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    che_cur_state <= CHE_IDLE;
  else if(!ctrl_xx_dis_stall)
    che_cur_state <= che_next_state;
  else
    che_cur_state <= che_cur_state;
end

// &CombBeg; @461
always @( che_sm_start
       or che_cur_state)
begin
  case(che_cur_state)
  CHE_IDLE  : if(che_sm_start)
                che_next_state = CHE_SPLIT;
              else
                che_next_state = CHE_IDLE;
  CHE_SPLIT :   che_next_state = CHE_IDLE;
  default   :   che_next_state = CHE_IDLE;
  endcase
// &CombEnd; @470
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
assign che_inst_vld    = 1'b1;

assign che_split_stall = (che_next_state != CHE_IDLE);

//----------------------------------------------------------
//               Split Instruction : dcache
//----------------------------------------------------------
//split inst 0: dcache cva/cpa
// &CombBeg; @483
always @( dp_split_inst[19:15]
       or che_va)
begin
  che_inst_dcache_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  che_inst_dcache_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_LSU;
  che_inst_dcache_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = che_va ? `FUNC_DCACHE_CVA : `FUNC_DCACHE_CPA;
  che_inst_dcache_data[`IDU_SRC0_VLD]                     = 1'b1;
  che_inst_dcache_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]      = {1'b0,dp_split_inst[19:15]};
  che_inst_dcache_data[`IDU_SPLIT]                        = 1'b1;
  che_inst_dcache_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @493
end

//----------------------------------------------------------
//               Split Instruction: icache
//----------------------------------------------------------
//split inst 1: icache ipa/iva
// &CombBeg; @499
always @( dp_split_inst[19:15]
       or che_va)
begin
  che_inst_icache_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  che_inst_icache_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_CP0;
  che_inst_icache_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = che_va ? `FUNC_ICACHE_IVA : `FUNC_ICACHE_IPA;
  che_inst_icache_data[`IDU_SRC0_VLD]                     = 1'b1;
  che_inst_icache_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]      = {1'b0,dp_split_inst[19:15]};
  che_inst_icache_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @508
end

//----------------------------------------------------------
//                 Split Instruction Data
//----------------------------------------------------------
assign che_inst_data[`IDU_WIDTH-1:0] = (che_cur_state == CHE_SPLIT)
                                      ? che_inst_icache_data[`IDU_WIDTH-1:0]
                                      : che_inst_dcache_data[`IDU_WIDTH-1:0];


//==========================================================
//                 Fence (fnc) Instructions
//==========================================================
//----------------------------------------------------------
//                      fnc split inst
//----------------------------------------------------------
//full decode split type
assign fnc_split_type =
    {dp_split_inst[31:25],dp_split_inst[14:0]} == 22'b0001001_000_00000_1110011; //sfence.vma

//----------------------------------------------------------
//           fnc split variables initial value
//----------------------------------------------------------
assign fnc_sm_start           = ifu_idu_id_inst_vld
                                && fnc_split_type;

//----------------------------------------------------------
//              FSM of inst fnc ctrl logic
//----------------------------------------------------------
// State Description:
// FNC_IDLE  : id stage instruction 0 is not multi load store
//            (fnc) or the first cycle to start fnc FSM
// FNC_SPLIT : the fnc instruction is spliting
parameter FNC_IDLE  = 1'b0;
parameter FNC_SPLIT = 1'b1;

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fnc_cur_state <= FNC_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    fnc_cur_state <= FNC_IDLE;
  else if(!ctrl_xx_dis_stall)
    fnc_cur_state <= fnc_next_state;
  else
    fnc_cur_state <= fnc_cur_state;
end

// &CombBeg; @556
always @( fnc_sm_start
       or fnc_cur_state)
begin
  case(fnc_cur_state)
  FNC_IDLE  : if(fnc_sm_start)
                fnc_next_state = FNC_SPLIT;
              else
                fnc_next_state = FNC_IDLE;
  FNC_SPLIT :   fnc_next_state = FNC_IDLE;
  default   :   fnc_next_state = FNC_IDLE;
  endcase
// &CombEnd; @565
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
assign fnc_inst_vld    = 1'b1;

assign fnc_split_stall = (fnc_next_state != FNC_IDLE);

//----------------------------------------------------------
//               Split Instruction : sfence
//----------------------------------------------------------
//split inst 0: sfence
// &CombBeg; @578
always @( dp_split_inst[24:15])
begin
  fnc_inst_sfence_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  fnc_inst_sfence_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_CP0;
  fnc_inst_sfence_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = `FUNC_SFENCE;
  fnc_inst_sfence_data[`IDU_SRC0_VLD]                     = 1'b1;
  fnc_inst_sfence_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]     = {1'b0,dp_split_inst[19:15]};
  fnc_inst_sfence_data[`IDU_SRC1_VLD]                     = 1'b1;
  fnc_inst_sfence_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5]     = {1'b0,dp_split_inst[24:20]};
  fnc_inst_sfence_data[`IDU_SPLIT]                        = 1'b1;
  fnc_inst_sfence_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @590
end

//----------------------------------------------------------
//               Split Instruction: sync
//----------------------------------------------------------
//split inst 1: sync
// &CombBeg; @596
always @( dp_split_inst[19:15])
begin
  fnc_inst_sync_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  fnc_inst_sync_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_CP0;
  fnc_inst_sync_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = `FUNC_SYNCI;
  fnc_inst_sync_data[`IDU_SRC0_VLD]                     = 1'b1;
  fnc_inst_sync_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]     = {1'b0,dp_split_inst[19:15]};
  fnc_inst_sync_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @605
end

//----------------------------------------------------------
//                 Split Instruction Data
//----------------------------------------------------------
assign fnc_inst_data[`IDU_WIDTH-1:0] = (fnc_cur_state == FNC_SPLIT)
                                      ? fnc_inst_sync_data[`IDU_WIDTH-1:0]
                                      : fnc_inst_sfence_data[`IDU_WIDTH-1:0];

//==========================================================
//               Split Instructions Selection
//==========================================================
//----------------------------------------------------------
//              MUX between split instructions
//----------------------------------------------------------
assign split_ctrl_inst_vld =
            lsd_split_type && lsd_inst_vld
         || amo_split_type && amo_inst_vld
         || che_split_type && che_inst_vld
         || fnc_split_type && fnc_inst_vld;

assign split_ctrl_id_stall =
            lsd_split_type && lsd_split_stall
         || amo_split_type && amo_split_stall
         || che_split_type && che_split_stall
         || fnc_split_type && fnc_split_stall;

assign split_inst_data[`IDU_WIDTH-1:0] =
         {`IDU_WIDTH{lsd_split_type}} & lsd_inst_data[`IDU_WIDTH-1:0]
       | {`IDU_WIDTH{amo_split_type}} & amo_inst_data[`IDU_WIDTH-1:0]
       | {`IDU_WIDTH{che_split_type}} & che_inst_data[`IDU_WIDTH-1:0]
       | {`IDU_WIDTH{fnc_split_type}} & fnc_inst_data[`IDU_WIDTH-1:0];

assign split_dp_inst_sel =
            lsd_split_type
         || amo_split_type
         || che_split_type
         || fnc_split_type;

//----------------------------------------------------------
//                    Packet Inst data
//----------------------------------------------------------
// &CombBeg; @647
always @( split_inst_data[264:0]
       or dp_split_inst[31:0])
begin
  split_dp_inst_data[`IDU_WIDTH-1:0]                    = split_inst_data[`IDU_WIDTH-1:0];
  if(1'b1) begin
  split_dp_inst_data[`IDU_OPCODE:`IDU_OPCODE-31]        = (dp_split_inst[1:0] == 2'b11)
                                                          ? dp_split_inst[31:0]
                                                          : {16'b0, dp_split_inst[15:0]};
  end 
// &CombEnd; @654
end

//----------------------------------------------------------
//                      For Debug info
//----------------------------------------------------------
assign split_top_cur_state_no_idle[0] = (lsd_cur_state != LSD_IDLE);
assign split_top_cur_state_no_idle[1] = (amo_cur_state[2:0] != AMO_IDLE);
assign split_top_cur_state_no_idle[2] = (che_cur_state != CHE_IDLE);
assign split_top_cur_state_no_idle[3] = (fnc_cur_state != FNC_IDLE);

//==========================================================
//                 Instance of Gated Cell
//==========================================================
assign split_clk_en = ifu_idu_id_inst_vld
                      && (amo_split_type
                       || lsd_split_type
                       || che_split_type
                       || fnc_split_type)
                      || (lsd_cur_state != LSD_IDLE)
                      || (amo_cur_state[2:0] != AMO_IDLE)
                      || (che_cur_state != CHE_IDLE)
                      || (fnc_cur_state != FNC_IDLE);
// &Instance("gated_clk_cell", "x_split_clk_gated_clk_cell"); @676
gated_clk_cell  x_split_clk_gated_clk_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (split_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (split_clk_en      ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @677
//          .external_en (1'b0), @678
//          .global_en   (cp0_yy_clk_en), @679
//          .module_en   (cp0_idu_icg_en), @680
//          .local_en    (split_clk_en), @681
//          .clk_out     (split_clk)); @682


//================================================
//        assertion
//================================================
// &Force("nonport","flag"); @698
// &Force("nonport","clk"); @699
// &Force("nonport","rst"); @700
// &ModuleEnd; @729
endmodule


