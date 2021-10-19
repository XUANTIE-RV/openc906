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

// &Depend("cpu_cfig.h"); @17
// &Depend("aq_lsu_cfig.h"); @18

// &ModuleBeg; @20
module aq_lsu_arb(
  ag_arb_data_idx,
  ag_arb_data_req,
  ag_arb_data_way,
  ag_arb_tag_idx,
  ag_arb_tag_req,
  ag_arb_tag_sel,
  ag_arb_tag_way,
  arb_ag_grant,
  arb_dc_grant,
  arb_mcic_grant,
  arb_rdl_grant,
  arb_stb_grant,
  dc_arb_data_idx,
  dc_arb_data_req,
  dc_arb_data_way,
  dc_arb_tag_idx,
  dc_arb_tag_req,
  dc_arb_tag_sel,
  dc_arb_tag_way,
  dcache_data02_idx,
  dcache_data13_idx,
  dcache_data_cen_bank0,
  dcache_data_cen_bank1,
  dcache_data_cen_bank2,
  dcache_data_cen_bank3,
  dcache_data_din_bank0,
  dcache_data_din_bank1,
  dcache_data_din_bank2,
  dcache_data_din_bank3,
  dcache_data_wen,
  dcache_dirty_cen,
  dcache_dirty_din,
  dcache_dirty_idx,
  dcache_dirty_wen,
  dcache_tag_din,
  dcache_tag_idx,
  dcache_tag_req,
  dcache_tag_sel,
  dcache_tag_way,
  dcache_tag_wen,
  icc_arb_data02_idx,
  icc_arb_data0_req,
  icc_arb_data13_idx,
  icc_arb_data1_req,
  icc_arb_data2_req,
  icc_arb_data3_req,
  icc_arb_data_way,
  icc_arb_dirty_din,
  icc_arb_dirty_idx,
  icc_arb_dirty_req,
  icc_arb_dirty_wen,
  icc_arb_tag_idx,
  icc_arb_tag_req,
  icc_arb_tag_sel,
  icc_arb_tag_way,
  icc_arb_tag_wen,
  lfb_arb_data02_idx,
  lfb_arb_data0_req,
  lfb_arb_data13_idx,
  lfb_arb_data1_req,
  lfb_arb_data2_req,
  lfb_arb_data3_req,
  lfb_arb_data_din,
  lfb_arb_data_way,
  lfb_arb_data_wen,
  lfb_arb_dcache_sel,
  lfb_arb_dirty_din,
  lfb_arb_dirty_idx,
  lfb_arb_dirty_req,
  lfb_arb_dirty_wen,
  lfb_arb_tag_din,
  lfb_arb_tag_idx,
  lfb_arb_tag_req,
  lfb_arb_tag_sel,
  lfb_arb_tag_way,
  lfb_arb_tag_wen,
  mcic_arb_data_idx,
  mcic_arb_data_req,
  mcic_arb_data_way,
  mcic_arb_tag_idx,
  mcic_arb_tag_req,
  mcic_arb_tag_sel,
  mcic_arb_tag_way,
  rdl_arb_data02_idx,
  rdl_arb_data0_req,
  rdl_arb_data13_idx,
  rdl_arb_data1_req,
  rdl_arb_data2_req,
  rdl_arb_data3_req,
  rdl_arb_data_way,
  rdl_arb_dcache_sel,
  rdl_arb_dirty_din,
  rdl_arb_dirty_idx,
  rdl_arb_dirty_req,
  rdl_arb_dirty_wen,
  rdl_arb_tag_idx,
  rdl_arb_tag_req,
  rdl_arb_tag_sel,
  rdl_arb_tag_way,
  rdl_arb_tag_wen,
  stb_arb_data0_req,
  stb_arb_data1_req,
  stb_arb_data2_req,
  stb_arb_data3_req,
  stb_arb_data_din,
  stb_arb_data_idx,
  stb_arb_data_req,
  stb_arb_data_way,
  stb_arb_data_wen,
  stb_arb_dirty_idx,
  stb_arb_dirty_req,
  stb_arb_dirty_wen
);

// &Ports; @21
input   [13 :0]  ag_arb_data_idx;      
input            ag_arb_data_req;      
input   [3  :0]  ag_arb_data_way;      
input   [11 :0]  ag_arb_tag_idx;       
input            ag_arb_tag_req;       
input   [3  :0]  ag_arb_tag_sel;       
input   [3  :0]  ag_arb_tag_way;       
input   [13 :0]  dc_arb_data_idx;      
input            dc_arb_data_req;      
input   [3  :0]  dc_arb_data_way;      
input   [11 :0]  dc_arb_tag_idx;       
input            dc_arb_tag_req;       
input   [3  :0]  dc_arb_tag_sel;       
input   [3  :0]  dc_arb_tag_way;       
input   [13 :0]  icc_arb_data02_idx;   
input            icc_arb_data0_req;    
input   [13 :0]  icc_arb_data13_idx;   
input            icc_arb_data1_req;    
input            icc_arb_data2_req;    
input            icc_arb_data3_req;    
input   [3  :0]  icc_arb_data_way;     
input   [7  :0]  icc_arb_dirty_din;    
input   [13 :0]  icc_arb_dirty_idx;    
input            icc_arb_dirty_req;    
input   [7  :0]  icc_arb_dirty_wen;    
input   [11 :0]  icc_arb_tag_idx;      
input            icc_arb_tag_req;      
input   [3  :0]  icc_arb_tag_sel;      
input   [3  :0]  icc_arb_tag_way;      
input            icc_arb_tag_wen;      
input   [13 :0]  lfb_arb_data02_idx;   
input            lfb_arb_data0_req;    
input   [13 :0]  lfb_arb_data13_idx;   
input            lfb_arb_data1_req;    
input            lfb_arb_data2_req;    
input            lfb_arb_data3_req;    
input   [127:0]  lfb_arb_data_din;     
input   [3  :0]  lfb_arb_data_way;     
input   [7  :0]  lfb_arb_data_wen;     
input            lfb_arb_dcache_sel;   
input   [7  :0]  lfb_arb_dirty_din;    
input   [13 :0]  lfb_arb_dirty_idx;    
input            lfb_arb_dirty_req;    
input   [7  :0]  lfb_arb_dirty_wen;    
input   [29 :0]  lfb_arb_tag_din;      
input   [11 :0]  lfb_arb_tag_idx;      
input            lfb_arb_tag_req;      
input   [3  :0]  lfb_arb_tag_sel;      
input   [3  :0]  lfb_arb_tag_way;      
input            lfb_arb_tag_wen;      
input   [13 :0]  mcic_arb_data_idx;    
input            mcic_arb_data_req;    
input   [3  :0]  mcic_arb_data_way;    
input   [11 :0]  mcic_arb_tag_idx;     
input            mcic_arb_tag_req;     
input   [3  :0]  mcic_arb_tag_sel;     
input   [3  :0]  mcic_arb_tag_way;     
input   [13 :0]  rdl_arb_data02_idx;   
input            rdl_arb_data0_req;    
input   [13 :0]  rdl_arb_data13_idx;   
input            rdl_arb_data1_req;    
input            rdl_arb_data2_req;    
input            rdl_arb_data3_req;    
input   [3  :0]  rdl_arb_data_way;     
input            rdl_arb_dcache_sel;   
input   [7  :0]  rdl_arb_dirty_din;    
input   [13 :0]  rdl_arb_dirty_idx;    
input            rdl_arb_dirty_req;    
input   [7  :0]  rdl_arb_dirty_wen;    
input   [11 :0]  rdl_arb_tag_idx;      
input            rdl_arb_tag_req;      
input   [3  :0]  rdl_arb_tag_sel;      
input   [3  :0]  rdl_arb_tag_way;      
input            rdl_arb_tag_wen;      
input            stb_arb_data0_req;    
input            stb_arb_data1_req;    
input            stb_arb_data2_req;    
input            stb_arb_data3_req;    
input   [127:0]  stb_arb_data_din;     
input   [13 :0]  stb_arb_data_idx;     
input            stb_arb_data_req;     
input   [3  :0]  stb_arb_data_way;     
input   [7  :0]  stb_arb_data_wen;     
input   [13 :0]  stb_arb_dirty_idx;    
input            stb_arb_dirty_req;    
input   [7  :0]  stb_arb_dirty_wen;    
output           arb_ag_grant;         
output           arb_dc_grant;         
output           arb_mcic_grant;       
output           arb_rdl_grant;        
output           arb_stb_grant;        
output  [13 :0]  dcache_data02_idx;    
output  [13 :0]  dcache_data13_idx;    
output           dcache_data_cen_bank0; 
output           dcache_data_cen_bank1; 
output           dcache_data_cen_bank2; 
output           dcache_data_cen_bank3; 
output  [63 :0]  dcache_data_din_bank0; 
output  [63 :0]  dcache_data_din_bank1; 
output  [63 :0]  dcache_data_din_bank2; 
output  [63 :0]  dcache_data_din_bank3; 
output  [7  :0]  dcache_data_wen;      
output           dcache_dirty_cen;     
output  [7  :0]  dcache_dirty_din;     
output  [13 :0]  dcache_dirty_idx;     
output  [7  :0]  dcache_dirty_wen;     
output  [29 :0]  dcache_tag_din;       
output  [11 :0]  dcache_tag_idx;       
output           dcache_tag_req;       
output  [3  :0]  dcache_tag_sel;       
output  [3  :0]  dcache_tag_way;       
output           dcache_tag_wen;       

// &Regs; @22
reg     [13 :0]  dcache_data02_idx;    
reg     [13 :0]  dcache_data13_idx;    
reg     [127:0]  dcache_data_din;      
reg              dcache_data_req_bank0; 
reg              dcache_data_req_bank1; 
reg              dcache_data_req_bank2; 
reg              dcache_data_req_bank3; 
reg     [3  :0]  dcache_data_way;      
reg     [7  :0]  dcache_data_wen;      
reg     [7  :0]  dcache_dirty_din;     
reg     [13 :0]  dcache_dirty_idx;     
reg     [7  :0]  dcache_dirty_wen;     
reg     [29 :0]  dcache_tag_din;       
reg     [11 :0]  dcache_tag_idx;       
reg     [3  :0]  dcache_tag_sel;       
reg     [3  :0]  dcache_tag_way;       
reg              dcache_tag_wen;       

// &Wires; @23
wire    [13 :0]  ag_arb_data_idx;      
wire             ag_arb_data_req;      
wire    [3  :0]  ag_arb_data_way;      
wire    [11 :0]  ag_arb_tag_idx;       
wire             ag_arb_tag_req;       
wire    [3  :0]  ag_arb_tag_sel;       
wire    [3  :0]  ag_arb_tag_way;       
wire             arb_ag_grant;         
wire             arb_dc_grant;         
wire             arb_mcic_grant;       
wire             arb_rdl_grant;        
wire             arb_stb_grant;        
wire    [13 :0]  dc_arb_data_idx;      
wire             dc_arb_data_req;      
wire    [3  :0]  dc_arb_data_way;      
wire    [11 :0]  dc_arb_tag_idx;       
wire             dc_arb_tag_req;       
wire    [3  :0]  dc_arb_tag_sel;       
wire    [3  :0]  dc_arb_tag_way;       
wire             dcache_data_cen_bank0; 
wire             dcache_data_cen_bank1; 
wire             dcache_data_cen_bank2; 
wire             dcache_data_cen_bank3; 
wire    [63 :0]  dcache_data_din_bank0; 
wire    [63 :0]  dcache_data_din_bank1; 
wire    [63 :0]  dcache_data_din_bank2; 
wire    [63 :0]  dcache_data_din_bank3; 
wire    [5  :0]  dcache_data_sel;      
wire             dcache_dirty_cen;     
wire             dcache_dirty_req;     
wire    [2  :0]  dcache_dirty_sel;     
wire             dcache_tag_req;       
wire    [4  :0]  dcache_tag_req_sel;   
wire    [13 :0]  icc_arb_data02_idx;   
wire             icc_arb_data0_req;    
wire    [13 :0]  icc_arb_data13_idx;   
wire             icc_arb_data1_req;    
wire             icc_arb_data2_req;    
wire             icc_arb_data3_req;    
wire    [3  :0]  icc_arb_data_way;     
wire    [7  :0]  icc_arb_dirty_din;    
wire    [13 :0]  icc_arb_dirty_idx;    
wire             icc_arb_dirty_req;    
wire    [7  :0]  icc_arb_dirty_wen;    
wire    [11 :0]  icc_arb_tag_idx;      
wire             icc_arb_tag_req;      
wire    [3  :0]  icc_arb_tag_sel;      
wire    [3  :0]  icc_arb_tag_way;      
wire             icc_arb_tag_wen;      
wire    [13 :0]  lfb_arb_data02_idx;   
wire             lfb_arb_data0_req;    
wire    [13 :0]  lfb_arb_data13_idx;   
wire             lfb_arb_data1_req;    
wire             lfb_arb_data2_req;    
wire             lfb_arb_data3_req;    
wire    [127:0]  lfb_arb_data_din;     
wire    [3  :0]  lfb_arb_data_way;     
wire    [7  :0]  lfb_arb_data_wen;     
wire             lfb_arb_dcache_sel;   
wire    [7  :0]  lfb_arb_dirty_din;    
wire    [13 :0]  lfb_arb_dirty_idx;    
wire             lfb_arb_dirty_req;    
wire    [7  :0]  lfb_arb_dirty_wen;    
wire    [29 :0]  lfb_arb_tag_din;      
wire    [11 :0]  lfb_arb_tag_idx;      
wire             lfb_arb_tag_req;      
wire    [3  :0]  lfb_arb_tag_sel;      
wire    [3  :0]  lfb_arb_tag_way;      
wire             lfb_arb_tag_wen;      
wire    [13 :0]  mcic_arb_data_idx;    
wire             mcic_arb_data_req;    
wire    [3  :0]  mcic_arb_data_way;    
wire    [11 :0]  mcic_arb_tag_idx;     
wire             mcic_arb_tag_req;     
wire    [3  :0]  mcic_arb_tag_sel;     
wire    [3  :0]  mcic_arb_tag_way;     
wire    [13 :0]  rdl_arb_data02_idx;   
wire             rdl_arb_data0_req;    
wire    [13 :0]  rdl_arb_data13_idx;   
wire             rdl_arb_data1_req;    
wire             rdl_arb_data2_req;    
wire             rdl_arb_data3_req;    
wire    [3  :0]  rdl_arb_data_way;     
wire             rdl_arb_dcache_sel;   
wire    [7  :0]  rdl_arb_dirty_din;    
wire    [13 :0]  rdl_arb_dirty_idx;    
wire             rdl_arb_dirty_req;    
wire    [7  :0]  rdl_arb_dirty_wen;    
wire    [11 :0]  rdl_arb_tag_idx;      
wire             rdl_arb_tag_req;      
wire    [3  :0]  rdl_arb_tag_sel;      
wire    [3  :0]  rdl_arb_tag_way;      
wire             rdl_arb_tag_wen;      
wire             stb_arb_data0_req;    
wire             stb_arb_data1_req;    
wire             stb_arb_data2_req;    
wire             stb_arb_data3_req;    
wire    [127:0]  stb_arb_data_din;     
wire    [13 :0]  stb_arb_data_idx;     
wire             stb_arb_data_req;     
wire    [3  :0]  stb_arb_data_way;     
wire    [7  :0]  stb_arb_data_wen;     
wire    [13 :0]  stb_arb_dirty_idx;    
wire             stb_arb_dirty_req;    
wire    [7  :0]  stb_arb_dirty_wen;    


assign arb_ag_grant   = !lfb_arb_dcache_sel & !rdl_arb_dcache_sel & !dc_arb_tag_req & !mcic_arb_tag_req;
assign arb_dc_grant   = !lfb_arb_dcache_sel & !rdl_arb_dcache_sel;
assign arb_mcic_grant = !lfb_arb_dcache_sel & !rdl_arb_dcache_sel & !dc_arb_tag_req;
assign arb_rdl_grant  = !lfb_arb_dcache_sel;
assign arb_stb_grant  = !lfb_arb_dcache_sel & !rdl_arb_dcache_sel & !dc_arb_data_req & !mcic_arb_data_req & !ag_arb_data_req;

//================================================
//tag array request
//================================================
assign dcache_tag_req = lfb_arb_tag_req |
                        rdl_arb_tag_req | 
                        dc_arb_tag_req |
                        mcic_arb_tag_req |
                        ag_arb_tag_req |
                        icc_arb_tag_req;

assign dcache_tag_req_sel[4:0] = {lfb_arb_dcache_sel,
                                  rdl_arb_dcache_sel, 
                                  dc_arb_tag_req,
                                  mcic_arb_tag_req,
                                  ag_arb_tag_req};

// &CombBeg; @47
always @( dc_arb_tag_idx[11:0]
       or lfb_arb_tag_idx[11:0]
       or mcic_arb_tag_idx[11:0]
       or lfb_arb_tag_din[29:0]
       or icc_arb_tag_idx[11:0]
       or rdl_arb_tag_idx[11:0]
       or mcic_arb_tag_sel[3:0]
       or icc_arb_tag_sel[3:0]
       or icc_arb_tag_wen
       or icc_arb_tag_way[3:0]
       or rdl_arb_tag_wen
       or rdl_arb_tag_way[3:0]
       or rdl_arb_tag_sel[3:0]
       or dcache_tag_req_sel[4:0]
       or lfb_arb_tag_way[3:0]
       or lfb_arb_tag_wen
       or dc_arb_tag_way[3:0]
       or ag_arb_tag_sel[3:0]
       or ag_arb_tag_idx[11:0]
       or ag_arb_tag_way[3:0]
       or lfb_arb_tag_sel[3:0]
       or dc_arb_tag_sel[3:0]
       or mcic_arb_tag_way[3:0])
begin
  casez (dcache_tag_req_sel[4:0])
    5'b1????:begin 
             dcache_tag_sel[3:0]  = lfb_arb_tag_sel[3:0];
             dcache_tag_way[3:0]  = lfb_arb_tag_way[3:0];
             dcache_tag_wen       = ~lfb_arb_tag_wen;
             dcache_tag_idx[11:0] = lfb_arb_tag_idx[11:0]; 
             dcache_tag_din[29:0] = lfb_arb_tag_din[29:0]; 
             end
    5'b01???:begin
             dcache_tag_sel[3:0]  = rdl_arb_tag_sel[3:0];
             dcache_tag_way[3:0]  = rdl_arb_tag_way[3:0];
             dcache_tag_wen       = ~rdl_arb_tag_wen;
             dcache_tag_idx[11:0] = rdl_arb_tag_idx[11:0]; 
             dcache_tag_din[29:0] = 30'b0;
             end
    5'b001??:begin
             dcache_tag_sel[3:0]  = dc_arb_tag_sel[3:0];
             dcache_tag_way[3:0]  = dc_arb_tag_way[3:0];
             dcache_tag_wen       = 1'b1;
             dcache_tag_idx[11:0] = dc_arb_tag_idx[11:0]; 
             dcache_tag_din[29:0] = 30'b0; 
             end
    5'b0001?:begin
             dcache_tag_sel[3:0]  = mcic_arb_tag_sel[3:0];
             dcache_tag_way[3:0]  = mcic_arb_tag_way[3:0];
             dcache_tag_wen       = 1'b1;
             dcache_tag_idx[11:0] = mcic_arb_tag_idx[11:0]; 
             dcache_tag_din[29:0] = 30'b0; 
             end
    5'b00001:begin 
             dcache_tag_sel[3:0]  = ag_arb_tag_sel[3:0];
             dcache_tag_way[3:0]  = ag_arb_tag_way[3:0];
             dcache_tag_wen       = 1'b1;
             dcache_tag_idx[11:0] = ag_arb_tag_idx[11:0];  
             dcache_tag_din[29:0] = 30'b0;
             end
    default: begin 
             dcache_tag_sel[3:0]  = icc_arb_tag_sel[3:0];
             dcache_tag_way[3:0]  = icc_arb_tag_way[3:0];
             dcache_tag_wen       = ~icc_arb_tag_wen;
             dcache_tag_idx[11:0] = icc_arb_tag_idx[11:0]; 
             dcache_tag_din[29:0] = 30'b0;
             end
  endcase
// &CombEnd; @92
end

//================================================
//  dirty array
//================================================
assign dcache_dirty_req = lfb_arb_dirty_req |
                          rdl_arb_dirty_req |
                          stb_arb_dirty_req |
                          icc_arb_dirty_req;

assign dcache_dirty_sel[2:0] = {lfb_arb_dcache_sel,
                                rdl_arb_dcache_sel,
                                stb_arb_dirty_req};

// &CombBeg; @106
always @( rdl_arb_dirty_idx[13:0]
       or lfb_arb_dirty_wen[7:0]
       or icc_arb_dirty_din[7:0]
       or icc_arb_dirty_wen[7:0]
       or rdl_arb_dirty_din[7:0]
       or stb_arb_dirty_idx[13:0]
       or stb_arb_dirty_wen[7:0]
       or dcache_dirty_sel[2:0]
       or rdl_arb_dirty_wen[7:0]
       or icc_arb_dirty_idx[13:0]
       or lfb_arb_dirty_idx[13:0]
       or lfb_arb_dirty_din[7:0])
begin
  casez (dcache_dirty_sel[2:0])
    3'b1??:  begin 
             dcache_dirty_wen[7:0]  = ~lfb_arb_dirty_wen[7:0];
             dcache_dirty_idx[13:0] = lfb_arb_dirty_idx[13:0]; 
             dcache_dirty_din[7:0]  = lfb_arb_dirty_din[7:0] ; 
             end
    3'b01?:  begin
             dcache_dirty_wen[7:0]  = ~rdl_arb_dirty_wen[7:0];
             dcache_dirty_idx[13:0] = rdl_arb_dirty_idx[13:0]; 
             dcache_dirty_din[7:0]  = rdl_arb_dirty_din[7:0];
             end
    3'b001:  begin
             dcache_dirty_wen[7:0]  = ~stb_arb_dirty_wen[7:0];
             dcache_dirty_idx[13:0] = stb_arb_dirty_idx[13:0]; 
             dcache_dirty_din[7:0]  = {8{1'b1}};
             end
    default: begin 
             dcache_dirty_wen[7:0]  = ~icc_arb_dirty_wen[7:0];
             dcache_dirty_idx[13:0] = icc_arb_dirty_idx[13:0]; 
             dcache_dirty_din[7:0]  = icc_arb_dirty_din[7:0];
             end
  endcase
// &CombEnd; @129
end

assign dcache_dirty_cen = ~dcache_dirty_req;

//================================================
//  data array
//================================================
assign dcache_data_sel[5:0] = {lfb_arb_dcache_sel,
                               rdl_arb_dcache_sel,
                               dc_arb_data_req,  
                               mcic_arb_data_req,
                               ag_arb_data_req,  
                               stb_arb_data_req};

// &CombBeg; @143
always @( icc_arb_data3_req
       or dc_arb_data_req
       or icc_arb_data_way[3:0]
       or rdl_arb_data2_req
       or rdl_arb_data3_req
       or stb_arb_data3_req
       or rdl_arb_data13_idx[13:0]
       or lfb_arb_data1_req
       or lfb_arb_data2_req
       or mcic_arb_data_req
       or stb_arb_data_wen[7:0]
       or ag_arb_data_req
       or stb_arb_data1_req
       or icc_arb_data2_req
       or icc_arb_data0_req
       or stb_arb_data_way[3:0]
       or rdl_arb_data0_req
       or stb_arb_data2_req
       or dc_arb_data_way[3:0]
       or lfb_arb_data_din[127:0]
       or ag_arb_data_idx[13:0]
       or lfb_arb_data0_req
       or ag_arb_data_way[3:0]
       or dcache_data_sel[5:0]
       or rdl_arb_data02_idx[13:0]
       or icc_arb_data1_req
       or lfb_arb_data02_idx[13:0]
       or lfb_arb_data_wen[7:0]
       or lfb_arb_data_way[3:0]
       or icc_arb_data02_idx[13:0]
       or rdl_arb_data1_req
       or stb_arb_data_idx[13:0]
       or dc_arb_data_idx[13:0]
       or mcic_arb_data_way[3:0]
       or stb_arb_data_din[127:0]
       or lfb_arb_data13_idx[13:0]
       or mcic_arb_data_idx[13:0]
       or lfb_arb_data3_req
       or rdl_arb_data_way[3:0]
       or icc_arb_data13_idx[13:0]
       or stb_arb_data0_req)
begin
  casez (dcache_data_sel[5:0])
  6'b1?????: begin
             dcache_data_req_bank0            = lfb_arb_data0_req;
             dcache_data_req_bank1            = lfb_arb_data1_req;
             dcache_data_req_bank2            = lfb_arb_data2_req;
             dcache_data_req_bank3            = lfb_arb_data3_req;
             dcache_data02_idx[13:0]          = lfb_arb_data02_idx[13:0]; 
             dcache_data13_idx[13:0]          = lfb_arb_data13_idx[13:0]; 
             dcache_data_way[3:0]             = lfb_arb_data_way[3:0];
             dcache_data_wen[`LSU_BYTEW-1:0]  = ~lfb_arb_data_wen[`LSU_BYTEW-1:0];
             dcache_data_din[127:0]           = lfb_arb_data_din[127:0]; 
             end
  6'b01????: begin
             dcache_data_req_bank0            = rdl_arb_data0_req;
             dcache_data_req_bank1            = rdl_arb_data1_req;
             dcache_data_req_bank2            = rdl_arb_data2_req;
             dcache_data_req_bank3            = rdl_arb_data3_req;
             dcache_data02_idx[13:0]          = rdl_arb_data02_idx[13:0]; 
             dcache_data13_idx[13:0]          = rdl_arb_data13_idx[13:0]; 
             dcache_data_way[3:0]             = rdl_arb_data_way[3:0];
             dcache_data_wen[`LSU_BYTEW-1:0]  = {`LSU_BYTEW{1'b1}};
             dcache_data_din[127:0]           = 128'b0;
             end
  6'b001???: begin
             dcache_data_req_bank0            = dc_arb_data_req;
             dcache_data_req_bank1            = dc_arb_data_req;
             dcache_data_req_bank2            = dc_arb_data_req;
             dcache_data_req_bank3            = dc_arb_data_req;
             dcache_data02_idx[13:0]          = dc_arb_data_idx[13:0]; 
             dcache_data13_idx[13:0]          = dc_arb_data_idx[13:0]; 
             dcache_data_way[3:0]             = dc_arb_data_way[3:0];
             dcache_data_wen[`LSU_BYTEW-1:0]  = {`LSU_BYTEW{1'b1}};
             dcache_data_din[127:0]           = 128'b0;
             end
  6'b0001??: begin
             dcache_data_req_bank0            = mcic_arb_data_req;
             dcache_data_req_bank1            = mcic_arb_data_req;
             dcache_data_req_bank2            = mcic_arb_data_req;
             dcache_data_req_bank3            = mcic_arb_data_req;
             dcache_data02_idx[13:0]          = mcic_arb_data_idx[13:0]; 
             dcache_data13_idx[13:0]          = mcic_arb_data_idx[13:0]; 
             dcache_data_way[3:0]             = mcic_arb_data_way[3:0];
             dcache_data_wen[`LSU_BYTEW-1:0]  = {`LSU_BYTEW{1'b1}};
             dcache_data_din[127:0]           = 128'b0;
             end
  6'b00001?: begin
             dcache_data_req_bank0            = ag_arb_data_req;
             dcache_data_req_bank1            = ag_arb_data_req;
             dcache_data_req_bank2            = ag_arb_data_req;
             dcache_data_req_bank3            = ag_arb_data_req;
             dcache_data02_idx[13:0]          = ag_arb_data_idx[13:0]; 
             dcache_data13_idx[13:0]          = ag_arb_data_idx[13:0]; 
             dcache_data_way[3:0]             = ag_arb_data_way[3:0];
             dcache_data_wen[`LSU_BYTEW-1:0]  = {`LSU_BYTEW{1'b1}};
             dcache_data_din[127:0]           = 128'b0;
             end
  6'b000001: begin
             dcache_data_req_bank0            = stb_arb_data0_req;
             dcache_data_req_bank1            = stb_arb_data1_req;
             dcache_data_req_bank2            = stb_arb_data2_req;
             dcache_data_req_bank3            = stb_arb_data3_req;
             dcache_data02_idx[13:0]          = stb_arb_data_idx[13:0]; 
             dcache_data13_idx[13:0]          = stb_arb_data_idx[13:0]; 
             dcache_data_way[3:0]             = stb_arb_data_way[3:0];
             dcache_data_wen[`LSU_BYTEW-1:0]  = ~stb_arb_data_wen[`LSU_BYTEW-1:0];
             dcache_data_din[127:0]           = stb_arb_data_din[127:0]; 
             end
  default:   begin
             dcache_data_req_bank0            = icc_arb_data0_req;
             dcache_data_req_bank1            = icc_arb_data1_req;
             dcache_data_req_bank2            = icc_arb_data2_req;
             dcache_data_req_bank3            = icc_arb_data3_req;
             dcache_data02_idx[13:0]          = icc_arb_data02_idx[13:0]; 
             dcache_data13_idx[13:0]          = icc_arb_data13_idx[13:0]; 
             dcache_data_way[3:0]             = icc_arb_data_way[3:0];
             dcache_data_wen[`LSU_BYTEW-1:0]  = {`LSU_BYTEW{1'b1}};
             dcache_data_din[127:0]           = 128'b0;
             end          
  endcase
// &CombEnd; @315
end
assign dcache_data_cen_bank0 = ~dcache_data_req_bank0;
assign dcache_data_cen_bank1 = ~dcache_data_req_bank1;
assign dcache_data_cen_bank2 = ~dcache_data_req_bank2;
assign dcache_data_cen_bank3 = ~dcache_data_req_bank3;
assign dcache_data_din_bank0[63:0] = dcache_data_way[0] ? dcache_data_din[63:0]   : dcache_data_din[127:64];
assign dcache_data_din_bank1[63:0] = dcache_data_way[0] ? dcache_data_din[127:64] : dcache_data_din[63:0];
assign dcache_data_din_bank2[63:0] = dcache_data_way[2] ? dcache_data_din[63:0]   : dcache_data_din[127:64];
assign dcache_data_din_bank3[63:0] = dcache_data_way[2] ? dcache_data_din[127:64] : dcache_data_din[63:0];

// &ModuleEnd; @344
endmodule


