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

// &ModuleBeg; @19
module aq_biu_apbif(
  apb_clk_en,
  apbif_araddr,
  apbif_arid,
  apbif_arprot,
  apbif_arready,
  apbif_arvalid,
  apbif_awaddr,
  apbif_awid,
  apbif_awprot,
  apbif_awready,
  apbif_awvalid,
  apbif_idle,
  apbif_rdata,
  apbif_rid,
  apbif_rready,
  apbif_rresp,
  apbif_rvalid,
  apbif_wdata,
  apbif_wready,
  apbif_wvalid,
  cp0_biu_icg_en,
  cpurst_b,
  forever_cpuclk,
  pad_yy_icg_scan_en,
  paddr,
  penable,
  perr_clint,
  perr_plic,
  pprot,
  prdata_clint,
  prdata_plic,
  pready_clint,
  pready_plic,
  psel_clint,
  psel_plic,
  pwdata,
  pwrite
);

// &Ports; @20
input            apb_clk_en;        
input   [39 :0]  apbif_araddr;      
input   [3  :0]  apbif_arid;        
input   [1  :0]  apbif_arprot;      
input            apbif_arvalid;     
input   [39 :0]  apbif_awaddr;      
input   [3  :0]  apbif_awid;        
input   [1  :0]  apbif_awprot;      
input            apbif_awvalid;     
input            apbif_rready;      
input   [127:0]  apbif_wdata;       
input            apbif_wvalid;      
input            cp0_biu_icg_en;    
input            cpurst_b;          
input            forever_cpuclk;    
input            pad_yy_icg_scan_en; 
input            perr_clint;        
input            perr_plic;         
input   [31 :0]  prdata_clint;      
input   [31 :0]  prdata_plic;       
input            pready_clint;      
input            pready_plic;       
output           apbif_arready;     
output           apbif_awready;     
output           apbif_idle;        
output  [127:0]  apbif_rdata;       
output  [3  :0]  apbif_rid;         
output  [1  :0]  apbif_rresp;       
output           apbif_rvalid;      
output           apbif_wready;      
output  [31 :0]  paddr;             
output           penable;           
output  [1  :0]  pprot;             
output           psel_clint;        
output           psel_plic;         
output  [31 :0]  pwdata;            
output           pwrite;            

// &Regs; @21
reg     [1  :0]  apb_cur_state;     
reg     [1  :0]  apb_next_state;    
reg     [39 :0]  apbif_addr;        
reg     [31 :0]  apbif_data;        
reg     [3  :0]  apbif_id;          
reg     [1  :0]  apbif_prot;        
reg              apbif_write;       
reg     [31 :0]  rdata;             
reg              resp_err;          
reg     [3  :0]  resp_id;           
reg              resp_vld;          
reg              resp_wt;           
reg     [1  :0]  sel;               

// &Wires; @22
wire             apb_clk_en;        
wire             apb_fsm_idle;      
wire             apb_fsm_pend;      
wire             apb_fsm_req;       
wire             apb_fsm_wdata;     
wire    [39 :0]  apbif_araddr;      
wire    [3  :0]  apbif_arid;        
wire    [1  :0]  apbif_arprot;      
wire             apbif_arready;     
wire             apbif_arvalid;     
wire    [39 :0]  apbif_awaddr;      
wire    [3  :0]  apbif_awid;        
wire    [1  :0]  apbif_awprot;      
wire             apbif_awready;     
wire             apbif_awvalid;     
wire             apbif_clk;         
wire             apbif_clk_en;      
wire             apbif_idle;        
wire    [127:0]  apbif_rdata;       
wire             apbif_req;         
wire    [39 :0]  apbif_req_addr;    
wire    [3  :0]  apbif_req_id;      
wire    [1  :0]  apbif_req_prot;    
wire             apbif_req_write;   
wire    [3  :0]  apbif_rid;         
wire             apbif_rready;      
wire    [1  :0]  apbif_rresp;       
wire             apbif_rvalid;      
wire    [127:0]  apbif_wdata;       
wire             apbif_wready;      
wire             apbif_wvalid;      
wire             arsel;             
wire             clint_hit;         
wire             cmplt;             
wire             cp0_biu_icg_en;    
wire             cpurst_b;          
wire             forever_cpuclk;    
wire             pad_yy_icg_scan_en; 
wire    [31 :0]  paddr;             
wire             penable;           
wire             perr;              
wire             perr_clint;        
wire             perr_plic;         
wire             plic_hit;          
wire    [1  :0]  pprot;             
wire    [31 :0]  prdata;            
wire    [31 :0]  prdata_clint;      
wire    [31 :0]  prdata_plic;       
wire             pready_clint;      
wire             pready_plic;       
wire             psel;              
wire             psel_clint;        
wire             psel_plic;         
wire    [31 :0]  pwdata;            
wire             pwrite;            
wire             resp_grant;        
wire             sel_none;          


parameter ADDRW = 40;
//==========================================================
//   request arbiter
//==========================================================
assign arsel                     = apbif_arvalid;
assign apbif_req                 = apbif_arvalid | apbif_awvalid;
assign apbif_req_addr[ADDRW-1:0] = arsel ? apbif_araddr[ADDRW-1:0] : apbif_awaddr[ADDRW-1:0];
assign apbif_req_prot[1:0]       = arsel ? apbif_arprot[1:0]       : apbif_awprot[1:0];
assign apbif_req_id[3:0]         = arsel ? apbif_arid[3:0]         : apbif_awid[3:0];
assign apbif_req_write           = !arsel;

assign apbif_arready = apb_fsm_idle & apb_clk_en;
assign apbif_awready = apb_fsm_idle & !arsel & apb_clk_en;
assign apbif_wready  = apb_fsm_wdata & apb_clk_en;

//==========================================================
//   APB FSM
//==========================================================
parameter IDLE  = 2'b00;
parameter WDATA = 2'b01;
parameter REQ   = 2'b10;
parameter PEND  = 2'b11;

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if(~cpurst_b)
    apb_cur_state[1:0] <= IDLE;
  else if (apb_clk_en)
    apb_cur_state[1:0] <= apb_next_state[1:0];
end

// &CombBeg; @55
always @( apbif_wvalid
       or apbif_arvalid
       or cmplt
       or apb_cur_state
       or apbif_awvalid)
begin
  case (apb_cur_state)
  IDLE: begin
    if (apbif_arvalid)
      apb_next_state = REQ;
    else if (apbif_awvalid)
      apb_next_state = WDATA;
    else
      apb_next_state = IDLE;
  end
  WDATA: begin
    if (apbif_wvalid)
      apb_next_state = REQ;
    else
      apb_next_state = WDATA;
  end
  REQ: begin
    apb_next_state = PEND;
  end
  PEND: begin
    if (cmplt)
      apb_next_state = IDLE;
    else
      apb_next_state = PEND;
  end
  default: apb_next_state = IDLE;
  endcase
// &CombEnd; @82
end

assign apb_fsm_idle  = apb_cur_state == IDLE;
assign apb_fsm_wdata = apb_cur_state == WDATA;
assign apb_fsm_req   = apb_cur_state == REQ;
assign apb_fsm_pend  = apb_cur_state == PEND;

//==========================================================
//  APB content
//==========================================================
always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)begin
    apbif_addr[ADDRW-1:0] <= {ADDRW{1'b0}}; 
    apbif_id[3:0]         <= 4'b0; 
    apbif_prot[1:0]       <= 2'b0; 
    apbif_write           <= 1'b0;
  end
  else if (apb_clk_en & apb_fsm_idle & apbif_req)begin
    apbif_addr[ADDRW-1:0] <= apbif_req_addr[ADDRW-1:0];
    apbif_id[3:0]         <= apbif_req_id[3:0];
    apbif_prot[1:0]       <= apbif_req_prot[1:0]; 
    apbif_write           <= apbif_req_write;
  end
end

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    apbif_data[31:0] <= 32'b0;
  else if (apbif_wvalid && apb_fsm_wdata && apb_clk_en) 
  begin
    if (apbif_addr[3:2] == 2'b00)
      apbif_data[31:0] <= apbif_wdata[31:0];
    else if (apbif_addr[3:2] == 2'b01)
      apbif_data[31:0] <= apbif_wdata[63:32];
    else if (apbif_addr[3:2] == 2'b10)
      apbif_data[31:0] <= apbif_wdata[95:64];
    else if (apbif_addr[3:2] == 2'b11)
      apbif_data[31:0] <= apbif_wdata[127:96];
  end
end

//==========================================================
//  APB request
//==========================================================
`define PLIC_BASE_START   1'b0
`define CLINT_BASE_START  11'h400

assign plic_hit     = (apbif_addr[26] == `PLIC_BASE_START);
assign clint_hit    = (apbif_addr[26:16] == `CLINT_BASE_START);

assign psel         = apb_fsm_req | apb_fsm_pend;
assign psel_plic    = psel & plic_hit;
assign psel_clint   = psel & clint_hit;

assign pwrite       = apbif_write;
assign paddr[31:0]  = apbif_addr[31:0];
assign pwdata[31:0] = apbif_data[31:0];
assign penable      = apb_fsm_pend;
assign pprot[1:0]   = apbif_prot[1:0];

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    sel[1:0] <= 2'b0;
  else if (apb_fsm_req)
    sel[1:0] <= {clint_hit,plic_hit};
end

//================================================
//  apb response
//================================================
assign sel_none = !(|sel[1:0]);

assign prdata[31:0] = {32{sel[0]}} & prdata_plic[31:0] |
                      {32{sel[1]}} & prdata_clint[31:0];

assign perr         = sel[0] & perr_plic  |
                      sel[1] & perr_clint | 
                      sel_none;

assign cmplt      = apb_fsm_pend & 
                   (sel[0] & pready_plic  |
                    sel[1] & pready_clint | 
                    sel_none);
assign resp_grant = apbif_write | apbif_rready;

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    resp_vld <= 1'b0;
  else if (cmplt && apb_clk_en)
    resp_vld <= 1'b1;
  else if (resp_grant)
    resp_vld <= 1'b0;
end

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)begin
    rdata[31:0]  <= 32'b0;
    resp_err     <= 1'b0;
    resp_id[3:0] <= 4'b0;
    resp_wt      <= 1'b0;
  end
  else if (cmplt && apb_clk_en) begin
    rdata[31:0]  <= prdata[31:0];
    resp_err     <= perr;
    resp_id[3:0] <= apbif_id[3:0];
    resp_wt      <= apbif_write;
  end
end

assign apbif_rvalid       = !resp_wt && resp_vld; 
assign apbif_rdata[127:0] = {4{rdata[31:0]}};
assign apbif_rresp[1:0]   = {resp_err,1'b0};
assign apbif_rid[3:0]     = resp_id[3:0];

assign apbif_idle = apb_fsm_idle & !resp_vld;

//==========================================================
//     ICG
//==========================================================
assign apbif_clk_en = apbif_req | !apb_fsm_idle | resp_vld;
    
// &Instance("gated_clk_cell", "x_apbif_gated_clk"); @208
gated_clk_cell  x_apbif_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (apbif_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (apbif_clk_en      ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @209
//          .external_en (1'b0), @210
//          .global_en   (1'b1), @211
//          .module_en   (cp0_biu_icg_en), @212
//          .local_en    (apbif_clk_en), @213
//          .clk_out     (apbif_clk)); @214

//==========================================================
//     ICG
//==========================================================
// &ModuleEnd; @226
endmodule


