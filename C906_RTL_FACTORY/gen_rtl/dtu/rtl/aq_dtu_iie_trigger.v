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
module aq_dtu_iie_trigger(
  cp0_dtu_icg_en,
  cp0_dtu_satp,
  cp0_dtu_wdata,
  cp0_write_tdata1,
  cp0_write_tdata2,
  cp0_write_tdata3,
  cp0_yy_clk_en,
  cpurst_b,
  exception_codes_onehot,
  expt_vld,
  forever_cpuclk,
  generate_timing0,
  icount_enable,
  int_vld,
  m_mode,
  mcontext,
  pad_yy_icg_scan_en,
  rtu_dtu_retire_vld,
  rtu_yy_xx_dbgon,
  s_mode,
  scontext,
  set_trigger_hit,
  tcontrol,
  tdata1,
  tdata1_action0,
  tdata1_action1,
  tdata2,
  tdata3,
  tinfo,
  trigger_match,
  trigger_selected,
  u_mode
);

// &Ports; @21
input           cp0_dtu_icg_en;               
input   [63:0]  cp0_dtu_satp;                 
input   [63:0]  cp0_dtu_wdata;                
input           cp0_write_tdata1;             
input           cp0_write_tdata2;             
input           cp0_write_tdata3;             
input           cp0_yy_clk_en;                
input           cpurst_b;                     
input   [31:0]  exception_codes_onehot;       
input           expt_vld;                     
input           forever_cpuclk;               
input           generate_timing0;             
input           int_vld;                      
input           m_mode;                       
input   [63:0]  mcontext;                     
input           pad_yy_icg_scan_en;           
input           rtu_dtu_retire_vld;           
input           rtu_yy_xx_dbgon;              
input           s_mode;                       
input   [63:0]  scontext;                     
input           set_trigger_hit;              
input   [63:0]  tcontrol;                     
input           trigger_selected;             
input           u_mode;                       
output          icount_enable;                
output  [63:0]  tdata1;                       
output          tdata1_action0;               
output          tdata1_action1;               
output  [63:0]  tdata2;                       
output  [63:0]  tdata3;                       
output  [63:0]  tinfo;                        
output          trigger_match;                

// &Regs; @22
reg     [17:0]  legal_tdata2_lowbits;         
reg             scontext_enable;              
reg     [0 :0]  tdata1_action;                
reg             tdata1_dmode;                 
reg             tdata1_icount_hit;            
reg             tdata1_ietrigger_hit;         
reg             tdata1_m;                     
reg             tdata1_s;                     
reg     [2 :0]  tdata1_type;                  
reg             tdata1_u;                     
reg     [17:0]  tdata2_lowbits;               
reg             tdata3_mselect;               
reg     [12:0]  tdata3_mvalue;                
reg     [1 :0]  tdata3_sselect;               
reg     [33:0]  tdata3_svalue;                

// &Wires; @23
wire            action_is_legal;              
wire            action_legal;                 
wire    [13:0]  count_legal;                  
wire            cp0_dtu_icg_en;               
wire    [63:0]  cp0_dtu_satp;                 
wire    [63:0]  cp0_dtu_wdata;                
wire            cp0_write_tdata1;             
wire            cp0_write_tdata2;             
wire            cp0_write_tdata3;             
wire            cp0_yy_clk_en;                
wire            cpurst_b;                     
wire            dmode_legal;                  
wire            etrigger_enable;              
wire    [17:0]  etrigger_legal_tdata2_lowbits; 
wire            etrigger_match;               
wire    [31:0]  exception_codes_onehot;       
wire            expt_codes_match;             
wire            expt_vld;                     
wire            forever_cpuclk;               
wire            generate_timing0;             
wire            icount_enable;                
wire            icount_match;                 
wire    [63:0]  icount_tdata1;                
wire    [63:0]  ietrigger_tdata1;             
wire            iie_clk;                      
wire            iie_clk_en;                   
wire            int_codes_match;              
wire            int_vld;                      
wire            itrigger_enable;              
wire    [17:0]  itrigger_legal_tdata2_lowbits; 
wire            itrigger_match;               
wire            m_enable;                     
wire            m_mode;                       
wire    [63:0]  mcontext;                     
wire            mcontext_enable;              
wire            mcontext_must_match;          
wire            ms_context_enable;            
wire            msu_mode_enable;              
wire            not_dbg_mode_enable;          
wire            pad_yy_icg_scan_en;           
wire            rtu_dtu_retire_vld;           
wire            rtu_yy_xx_dbgon;              
wire            s_enable;                     
wire            s_mode;                       
wire    [63:0]  scontext;                     
wire            set_trigger_hit;              
wire    [1 :0]  sselect_legal;                
wire    [63:0]  tcontrol;                     
wire            tcontrol_enable;              
wire    [63:0]  tdata1;                       
wire            tdata1_action0;               
wire            tdata1_action1;               
wire    [63:0]  tdata2;                       
wire    [63:0]  tdata3;                       
wire            tdata_writable;               
wire    [63:0]  tinfo;                        
wire            trigger_enable;               
wire            trigger_match;                
wire            trigger_selected;             
wire            type_is_icount;               
wire            type_is_legal;                
wire    [3 :0]  type_legal;                   
wire            type_will_be_icount;          
wire            u_enable;                     
wire            u_mode;                       
wire            wrtie_tdata1;                 


//XLEN
parameter XLEN = `TDT_DM_CORE_MAX_XLEN;

//tdata1 parameter
parameter TYPE  = XLEN-1;
parameter DMODE = XLEN-5;

//icount, itrigger, etrigger parameter
parameter COUNT      = 23;
parameter ICONUT_HIT = 24;
parameter I_E_TRIGGER_HIT = XLEN-6;
parameter M          = 9;
parameter S          = 7;
parameter U          = 6;
parameter ACTION = 5;

//tdata3 parameter
parameter MVALUE     = 63;
parameter MSELECT    = 50;
parameter SVALUE     = 35;
parameter SSELECT    = 1;

//tcontrol parameter
//parameter MPTE       = 7;
parameter MTE        = 3;

//=========================================================
//                       tdata1 wdata legalization
//=========================================================

//type
assign type_is_legal = cp0_dtu_wdata[TYPE:TYPE-3] == 4'd3 || cp0_dtu_wdata[TYPE:TYPE-3] == 4'd4 || 
                       cp0_dtu_wdata[TYPE:TYPE-3] == 4'd5;
assign type_legal[3:0] = type_is_legal ? cp0_dtu_wdata[TYPE:TYPE-3] : 4'd5;

//dmode
assign dmode_legal = rtu_yy_xx_dbgon ? cp0_dtu_wdata[DMODE] : tdata1[DMODE];

//dmode only writable in debug mode

//---------------------------------------------------------
//            icount tdata1 wdata legalization
//---------------------------------------------------------
//count
assign count_legal[13:0] = 14'd1;//count is hard-wired to 1

//---------------------------------------------------------
//      icount,itrigger,etrigger action legalization
//---------------------------------------------------------
assign action_is_legal   = cp0_dtu_wdata[ACTION:1] == 5'd0 && dmode_legal;
//if (1)action <= 1 and (2)dmode=1, action can be set to 0 or 1.
assign action_legal = action_is_legal ? cp0_dtu_wdata[0] : 1'b0;

//---------------------------------------------------------
//                choose legal wdata
//---------------------------------------------------------
//assign icount_tdata1_legal[XLEN-1:0] = {type_legal[3:0],dmode_legal,{XLEN-30{1'b0}},
//                                        cp0_dtu_wdata[ICONUT_HIT],count_legal[13:0],
//                                        cp0_dtu_wdata[M],1'b0,cp0_dtu_wdata[S],
//                                         cp0_dtu_wdata[U],action_legal[5:0]};
//assign ietrigger_tdata1_legal[XLEN-1:0] = {type_legal[3:0],dmode_legal,cp0_dtu_wdata[I_E_TRIGGER_HIT],
//                                           {XLEN-16{1'b0}},cp0_dtu_wdata[M],1'b0,cp0_dtu_wdata[S],
//                                           cp0_dtu_wdata[U],action_legal[5:0]};
//assign tdata1_legal[XLEN-1:0] = type_legal[3:0] == 4'd3 ? icount_tdata1_legal[XLEN-1:0] :
//                                                          ietrigger_tdata1_legal[XLEN-1:0];

//=========================================================
//                    write trigger CSR
//=========================================================

//---------------------------------------------------------
//                    write tdata1
//---------------------------------------------------------

assign tdata_writable = !tdata1[DMODE] && (m_mode || rtu_yy_xx_dbgon) ||
                         tdata1[DMODE] && rtu_yy_xx_dbgon;
assign wrtie_tdata1 = cp0_write_tdata1 && trigger_selected && tdata_writable;

always @(posedge iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      begin
          tdata1_type[2:0]   <= 3'd5;
          tdata1_dmode       <= 1'b0;
          tdata1_m           <= 1'b0;
          tdata1_s           <= 1'b0;
          tdata1_u           <= 1'b0;
          tdata1_action      <= 1'b0;
       end
  else if(wrtie_tdata1)
      begin
          tdata1_type[2:0]   <= type_legal[2:0];
          tdata1_dmode       <= dmode_legal;
          tdata1_m           <= cp0_dtu_wdata[M];
          tdata1_s           <= cp0_dtu_wdata[S];
          tdata1_u           <= cp0_dtu_wdata[U];
          tdata1_action      <= action_legal;
       end
end

assign type_is_icount      = tdata1_type[2:0] == 3'd3;
assign type_will_be_icount = type_legal[2:0] == 3'd3;
always @(posedge iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      tdata1_icount_hit <= 1'b0;
  else if(set_trigger_hit && type_is_icount)
      tdata1_icount_hit <= 1'b1;
  else if(wrtie_tdata1 && type_will_be_icount)
      tdata1_icount_hit <= cp0_dtu_wdata[ICONUT_HIT];
end

always @(posedge iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      tdata1_ietrigger_hit <= 1'b0;
  else if(set_trigger_hit && !type_is_icount)
      tdata1_ietrigger_hit <= 1'b1;
  else if(wrtie_tdata1 && !type_will_be_icount)
      tdata1_ietrigger_hit <= cp0_dtu_wdata[I_E_TRIGGER_HIT];
end

assign icount_tdata1[XLEN-1:0] = {1'b0,tdata1_type[2:0],tdata1_dmode,{XLEN-30{1'b0}},tdata1_icount_hit,
                                  count_legal[13:0],tdata1_m,1'b0,tdata1_s,tdata1_u,
                                  5'b0,tdata1_action};
assign ietrigger_tdata1[XLEN-1:0] = {1'b0,tdata1_type[2:0],tdata1_dmode,tdata1_ietrigger_hit,
                                     {XLEN-16{1'b0}},tdata1_m,1'b0,tdata1_s,tdata1_u,
                                     5'b0,tdata1_action};
assign tdata1[XLEN-1:0] = type_is_icount ? icount_tdata1[XLEN-1:0] :
                                           ietrigger_tdata1[XLEN-1:0];
//always @(posedge iie_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    tdata1[XLEN-1:0] <= {XLEN{1'b0}};
//  else if(set_trigger_hit && type_legal[3:0] == 4'd3) 
//    tdata1[XLEN-1:0] <= {tdata1[XLEN-1:ICONUT_HIT+1],1'b1,tdata1[ICONUT_HIT-1:0]};
//  else if(set_trigger_hit && (type_legal[3:0] == 4'd4 || type_legal[3:0] == 4'd5))
//    tdata1[XLEN-1:0] <= {tdata1[XLEN-1:I_E_TRIGGER_HIT+1],1'b1,tdata1[I_E_TRIGGER_HIT-1:0]};
//  else if(wrtie_tdata1)
//    tdata1[XLEN-1:0] <= tdata1_legal[XLEN-1:0];
//end
// &Force("output","tdata1");&Force("bus","tdata1",XLEN-1,0); @166
assign tdata1_action0 = !tdata1[ACTION-5];
assign tdata1_action1 = tdata1[ACTION-5];
//---------------------------------------------------------
//                    write tdata2
//---------------------------------------------------------
assign itrigger_legal_tdata2_lowbits[17:0] = {cp0_dtu_wdata[17],5'b0,cp0_dtu_wdata[11],1'b0,cp0_dtu_wdata[9],1'b0,
                                              cp0_dtu_wdata[7],1'b0,cp0_dtu_wdata[5],1'b0,cp0_dtu_wdata[3],1'b0,cp0_dtu_wdata[1],1'b0};
assign etrigger_legal_tdata2_lowbits[17:0] = {2'b0,cp0_dtu_wdata[15],1'b0,cp0_dtu_wdata[13:11],1'b0,cp0_dtu_wdata[9:1],1'b0};
// &CombBeg; @175
always @( tdata1_type[2:0]
       or etrigger_legal_tdata2_lowbits[17:0]
       or itrigger_legal_tdata2_lowbits[17:0])
begin
 case(tdata1_type[2:0])
     3'd3:legal_tdata2_lowbits[17:0] = 18'b0;
     3'd4:legal_tdata2_lowbits[17:0] = itrigger_legal_tdata2_lowbits[17:0];
     3'd5:legal_tdata2_lowbits[17:0] = etrigger_legal_tdata2_lowbits[17:0];
     default:legal_tdata2_lowbits[17:0] = {18{1'bx}};
  endcase
// &CombEnd; @182
end

always @(posedge iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tdata2_lowbits[17:0] <= {18{1'b0}};
  else if(cp0_write_tdata2 && trigger_selected && tdata_writable)
    tdata2_lowbits[17:0] <= legal_tdata2_lowbits[17:0];
end
assign tdata2[XLEN-1:0] = {{XLEN-18{1'b0}},tdata2_lowbits[17:0]};
// &Force("output","tdata2");&Force("bus","tdata2",XLEN-1,0); @192
//---------------------------------------------------------
//                    write tdata3
//---------------------------------------------------------
//tdata3 wdata legalization
assign sselect_legal[1:0] = cp0_dtu_wdata[SSELECT:0] == 2'b11 ? 2'b00 : cp0_dtu_wdata[SSELECT:0];

//write tdata3
always @(posedge iie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    begin
        tdata3_mvalue[12:0] <= 13'b0;
        tdata3_mselect      <= 1'b0;
        tdata3_svalue[33:0] <= 34'b0;
        tdata3_sselect[1:0] <= 2'b0;
    end
  else if(cp0_write_tdata3 && trigger_selected && tdata_writable)
    begin
        tdata3_mvalue[12:0] <= cp0_dtu_wdata[MVALUE:MVALUE-12];
        tdata3_mselect      <= cp0_dtu_wdata[MSELECT];
        tdata3_svalue[33:0] <= cp0_dtu_wdata[SVALUE:SVALUE-33];
        tdata3_sselect[1:0] <= sselect_legal[1:0];
    end
end
assign tdata3[XLEN-1:0] = {tdata3_mvalue[12:0],tdata3_mselect,{14{1'b0}},
                       tdata3_svalue[33:0],tdata3_sselect[1:0]};
// &Force("output","tdata3");&Force("bus","tdata3",XLEN-1,0); @219
//---------------------------------------------------------
//                    tinfo(read only)
//---------------------------------------------------------
assign tinfo = {{XLEN-6{1'b0}},6'b111000};
// &Force("output","tinfo");&Force("bus","tinfo",XLEN-1,0); @224
//icount type = 3; itrigger type = 4; etrigger type = 5;

//=========================================================
//                        decode
//=========================================================
//---------------------------------------------------------
//                  generate trigger enable signal
//---------------------------------------------------------
//tcontrol enable
//assign tdata1_action[5:0] = tdata1[ACTION:0];

assign tcontrol_enable =  !(!tcontrol[MTE] && !tdata1_action[0] && m_mode);//!(MTE=0 && action=0)
// &Force("bus","tcontrol",63,0); @237

//m s context enable
assign mcontext_must_match = tdata3[MSELECT] && m_mode;
assign mcontext_enable = mcontext_must_match ? tdata3[MVALUE:MVALUE-12] == mcontext[12:0] : 1'b1;
// &Force("bus","mcontext",63,0); @242

// &Force("input","cp0_dtu_satp");&Force("bus","cp0_dtu_satp",63,0); @244
// &CombBeg; @245
always @( tdata3[35:0]
       or scontext[33:0]
       or s_mode
       or cp0_dtu_satp[59:44])
begin
if(tdata3[SSELECT:0] == 2'd1 && s_mode)
  scontext_enable = tdata3[SVALUE:SVALUE-33] == scontext[33:0];
else if(tdata3[1:0] == 2'd2 && s_mode)
  scontext_enable = cp0_dtu_satp[59:44] == tdata3[SVALUE-18:SVALUE-33];
else
  scontext_enable = 1'b1;
// &CombEnd; @252
end
// &Force("bus","scontext",63,0); @253

assign ms_context_enable = mcontext_enable && scontext_enable;

//m s u mode enable
assign m_enable = tdata1[M] && m_mode;
assign s_enable = tdata1[S] && s_mode;
assign u_enable = tdata1[U] && u_mode;

assign msu_mode_enable = m_enable || s_enable || u_enable;

//trigger can't match in debug mode
assign not_dbg_mode_enable = !rtu_yy_xx_dbgon;

//trigger enable
assign trigger_enable = tcontrol_enable && ms_context_enable &&
                        msu_mode_enable && not_dbg_mode_enable;

//=========================================================
//               trigger match logic
//=========================================================

//icount
assign icount_enable = type_is_icount && trigger_enable;
assign icount_match  = icount_enable && rtu_dtu_retire_vld;
// &Force("output","icount_enable"); @278
// //&Force("output","icount_match"); @279

//itrigger
// &Force("bus","exception_codes_onehot","31","0"); @282
assign itrigger_enable       = tdata1_type[2:0] == 3'd4 && trigger_enable;
//assign int_codes_match       = |(int_codes[17:0] & tdata2[17:0]);
assign int_codes_match       = |(exception_codes_onehot[17:0] & tdata2[17:0]);
assign itrigger_match        = itrigger_enable && int_codes_match && int_vld;
// //&Force("output","itrigger_match"); @287

//etrigger
assign etrigger_enable       = tdata1_type[2:0] == 3'd5 && trigger_enable;
//assign expt_codes_match      = |(expt_codes[15:0] & tdata2[15:0]);
assign expt_codes_match      = |(exception_codes_onehot[15:0] & tdata2[15:0]);
assign etrigger_match        = etrigger_enable && expt_codes_match && expt_vld;
// //&Force("output","etrigger_match"); @294

//final match
assign trigger_match =!generate_timing0 && ( icount_match || itrigger_match || etrigger_match);

//==========================================================
//                     gate clk
//==========================================================
assign iie_clk_en = trigger_selected && 
                    (cp0_write_tdata1   || cp0_write_tdata2   || cp0_write_tdata3) ||
                     //cp0_write_tcontrol || cp0_write_mcontext || cp0_write_scontext ) ||
                    //cp0_dtu_mexpt_vld ||
                    //cp0_dtu_mret_vld  ||
                    set_trigger_hit;
// &Force("nonport","iie_clk_en"); @308

// &Instance("gated_clk_cell", "x_reg_gated_clk"); @310
gated_clk_cell  x_reg_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (iie_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (iie_clk_en        ),
  .module_en          (cp0_dtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @311
//          .external_en (1'b0), @312
//          .global_en   (cp0_yy_clk_en), @313
//          .module_en   (cp0_dtu_icg_en), @314
//          .local_en    (iie_clk_en), @315
//          //.local_en    (1'b1), @316
//          .clk_out     (iie_clk)); @317

// &ModuleEnd; @319
endmodule


