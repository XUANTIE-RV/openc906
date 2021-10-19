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


module tr_axi_interconnect(
  axim_clk_en,
  biu_pad_araddr,
  biu_pad_arburst,
  biu_pad_arcache,
  biu_pad_arid,
  biu_pad_arlen,
  biu_pad_arlock,
  biu_pad_arprot,
  biu_pad_arsize,
  biu_pad_arvalid,
  biu_pad_awaddr,
  biu_pad_awburst,
  biu_pad_awcache,
  biu_pad_awid,
  biu_pad_awlen,
  biu_pad_awlock,
  biu_pad_awprot,
  biu_pad_awsize,
  biu_pad_awvalid,
  biu_pad_bready,
  biu_pad_rready,
  biu_pad_wdata,
  biu_pad_wid,
  biu_pad_wlast,
  biu_pad_wstrb,
  biu_pad_wvalid,
  core0_pad_lpmd_b,
  dtm_pad_jtg_tdo,
  dtm_pad_jtg_tdo_en,
  pad_biu_arready,
  pad_biu_awready,
  pad_biu_bid,
  pad_biu_bresp,
  pad_biu_bvalid,
  pad_biu_rdata,
  pad_biu_rid,
  pad_biu_rlast,
  pad_biu_rresp,
  pad_biu_rvalid,
  pad_biu_wready,
  pad_core0_dbgrq_b,
  pad_core0_rst_b,
  pad_dtm_jtg_tclk,
  pad_dtm_jtg_tdi,
  pad_dtm_jtg_tms,
  pad_dtm_jtg_trst_b,
  pad_yy_scan_enable,
  pad_yy_scan_mode,
  pad_cpu_rst_b,
  core0_pad_retire0,
  core0_pad_retire0_pc,
  per_clk,
  pll_core_cpuclk,
  xx_intc_int
);


input            axim_clk_en;            
input            pad_biu_arready;        
input            pad_biu_awready;        
input   [7  :0]  pad_biu_bid;            
input   [1  :0]  pad_biu_bresp;          
input            pad_biu_bvalid;         
input   [127:0]  pad_biu_rdata;          
input   [7  :0]  pad_biu_rid;            
input            pad_biu_rlast;          
input   [1  :0]  pad_biu_rresp;          
input            pad_biu_rvalid;         
input            pad_biu_wready;         
input            pad_core0_dbgrq_b;      
input            pad_core0_rst_b;        
input            pad_cpu_rst_b;          
input            pad_dtm_jtg_tclk;       
input            pad_dtm_jtg_tdi;        
input            pad_dtm_jtg_tms;        
input            pad_dtm_jtg_trst_b;     
input            pad_yy_scan_enable;     
input            pad_yy_scan_mode;       
input            per_clk;                
input            pll_core_cpuclk;        
input   [39 :0]  xx_intc_int;            
output  [39 :0]  biu_pad_araddr;         
output  [1  :0]  biu_pad_arburst;        
output  [3  :0]  biu_pad_arcache;        
output  [7  :0]  biu_pad_arid;           
output  [7  :0]  biu_pad_arlen;          
output           biu_pad_arlock;         
output  [2  :0]  biu_pad_arprot;         
output  [2  :0]  biu_pad_arsize;         
output           biu_pad_arvalid;        
output  [39 :0]  biu_pad_awaddr;         
output  [1  :0]  biu_pad_awburst;        
output  [3  :0]  biu_pad_awcache;        
output  [7  :0]  biu_pad_awid;           
output  [7  :0]  biu_pad_awlen;          
output           biu_pad_awlock;         
output  [2  :0]  biu_pad_awprot;         
output  [2  :0]  biu_pad_awsize;         
output           biu_pad_awvalid;        
output           biu_pad_bready;         
output           biu_pad_rready;         
output  [127:0]  biu_pad_wdata;          
output  [7  :0]  biu_pad_wid;            
output           biu_pad_wlast;          
output  [15 :0]  biu_pad_wstrb;          
output           biu_pad_wvalid;         
output  [1  :0]  core0_pad_lpmd_b;       
output           core0_pad_retire0;      
output  [39 :0]  core0_pad_retire0_pc;   
output           dtm_pad_jtg_tdo;        
output           dtm_pad_jtg_tdo_en;     


reg     [63 :0]  pad_cpu_sys_cnt;        
reg     [4  :0]  wid_fifo_create;        
reg     [4  :0]  wid_fifo_pop;           
reg     [7  :0]  wid_m1_8;               


wire             axim_clk_en;            
wire    [39 :0]  biu_pad_araddr;         
wire    [1  :0]  biu_pad_arburst;        
wire    [3  :0]  biu_pad_arcache;        
wire    [7  :0]  biu_pad_arid;           
wire    [7  :0]  biu_pad_arlen;          
wire             biu_pad_arlock;         
wire    [2  :0]  biu_pad_arprot;         
wire    [2  :0]  biu_pad_arsize;         
wire             biu_pad_arvalid;        
wire    [39 :0]  biu_pad_awaddr;         
wire    [1  :0]  biu_pad_awburst;        
wire    [3  :0]  biu_pad_awcache;        
wire    [7  :0]  biu_pad_awid;           
wire    [7  :0]  biu_pad_awlen;          
wire             biu_pad_awlock;         
wire    [2  :0]  biu_pad_awprot;         
wire    [2  :0]  biu_pad_awsize;         
wire             biu_pad_awvalid;        
wire             biu_pad_bready;         
wire             biu_pad_rready;         
wire    [127:0]  biu_pad_wdata;          
wire    [7  :0]  biu_pad_wid;            
wire             biu_pad_wlast;          
wire    [15 :0]  biu_pad_wstrb;          
wire             biu_pad_wvalid;         
wire    [228:0]  core0_pad_dispatch_info; 
wire             core0_pad_flush;        
wire             core0_pad_ipend_b;      
wire             core0_pad_halted;       
wire    [1  :0]  core0_pad_lpmd_b;       
wire    [63 :0]  core0_pad_mstatus;      
wire             core0_pad_retire0;      
wire    [39 :0]  core0_pad_retire0_pc;   
wire             core0_pad_retire1;      
wire    [6  :0]  core0_pad_retire1_iid;  
wire    [39 :0]  core0_pad_retire1_pc;   
wire             core0_pad_retire2;      
wire    [6  :0]  core0_pad_retire2_iid;  
wire    [39 :0]  core0_pad_retire2_pc;   
wire             core0_pad_wakeup_b;     
wire    [63 :0]  core0_pad_wb0_data;     
wire    [4  :0]  core0_pad_wb0_fdata;    
wire    [4  :0]  core0_pad_wb0_freg;     
wire             core0_pad_wb0_freg_vld; 
wire    [6  :0]  core0_pad_wb0_preg;     
wire    [63 :0]  core0_pad_wb0_vdata;    
wire             core0_pad_wb0_vld;      
wire    [5  :0]  core0_pad_wb0_vreg;     
wire             core0_pad_wb0_vreg_vld; 
wire    [63 :0]  core0_pad_wb1_data;     
wire    [4  :0]  core0_pad_wb1_fdata;    
wire    [4  :0]  core0_pad_wb1_freg;     
wire             core0_pad_wb1_freg_vld; 
wire    [6  :0]  core0_pad_wb1_preg;     
wire    [63 :0]  core0_pad_wb1_vdata;    
wire             core0_pad_wb1_vld;      
wire    [5  :0]  core0_pad_wb1_vreg;     
wire             core0_pad_wb1_vreg_vld; 
wire    [63 :0]  core0_pad_wb2_data;     
wire    [6  :0]  core0_pad_wb2_preg;     
wire    [63 :0]  core0_pad_wb2_vdata;    
wire             core0_pad_wb2_vld;      
wire    [5  :0]  core0_pad_wb2_vreg;     
wire             core0_pad_wb2_vreg_vld; 
wire             cpu_debug_port;         
wire             cpu_pad_no_op;          
wire             create_en;              
wire             dtm_pad_jtg_tdo;        
wire             dtm_pad_jtg_tdo_en;     
wire             pad_biu_arready;        
wire             pad_biu_awready;        
wire    [7  :0]  pad_biu_bid;            
wire    [1  :0]  pad_biu_bresp;          
wire             pad_biu_bvalid;         
wire    [127:0]  pad_biu_rdata;          
wire    [7  :0]  pad_biu_rid;            
wire             pad_biu_rlast;          
wire    [1  :0]  pad_biu_rresp;          
wire             pad_biu_rvalid;         
wire             pad_biu_wready;         
wire             pad_core0_dbgrq_b;      
wire             pad_core0_rst_b;        
wire    [39 :0]  pad_cpu_apb_base;       
wire             pad_cpu_rst_b;          
wire    [39 :0]  pad_cpu_rvba;           
wire             pad_dtm_jtg_tclk;       
wire             pad_dtm_jtg_tdi;        
wire             pad_dtm_jtg_tms;        
wire             pad_dtm_jtg_trst_b;     
wire    [240 - 1 :0]  pad_plic_int_cfg;       
wire    [240 - 1 :0]  pad_plic_int_vld;       
wire             pad_yy_bist_tst_en;     
wire             pad_yy_gate_clk_en_b;   
wire             pad_yy_scan_enable;     
wire             pad_yy_scan_mode;       
wire             per_clk;                
wire             pll_core_cpuclk;        
wire    [7  :0]  wid_0;                  
wire    [7  :0]  wid_1;                  
wire    [7  :0]  wid_10;                 
wire    [7  :0]  wid_11;                 
wire    [7  :0]  wid_12;                 
wire    [7  :0]  wid_13;                 
wire    [7  :0]  wid_14;                 
wire    [7  :0]  wid_15;                 
wire    [7  :0]  wid_16;                 
wire    [7  :0]  wid_17;                 
wire    [7  :0]  wid_18;                 
wire    [7  :0]  wid_19;                 
wire    [7  :0]  wid_2;                  
wire    [7  :0]  wid_20;                 
wire    [7  :0]  wid_21;                 
wire    [7  :0]  wid_22;                 
wire    [7  :0]  wid_23;                 
wire    [7  :0]  wid_24;                 
wire    [7  :0]  wid_25;                 
wire    [7  :0]  wid_26;                 
wire    [7  :0]  wid_27;                 
wire    [7  :0]  wid_28;                 
wire    [7  :0]  wid_29;                 
wire    [7  :0]  wid_3;                  
wire    [7  :0]  wid_30;                 
wire    [7  :0]  wid_31;                 
wire    [7  :0]  wid_4;                  
wire    [7  :0]  wid_5;                  
wire    [7  :0]  wid_6;                  
wire    [7  :0]  wid_7;                  
wire    [7  :0]  wid_8;                  
wire    [7  :0]  wid_9;                  
wire    [31 :0]  wid_entry_push;         
wire    [39 :0]  xx_intc_int;            


wire    [11:0]   tdt_dmi_paddr  ;
wire             tdt_dmi_penable;
wire    [31:0]   tdt_dmi_prdata ;
wire             tdt_dmi_pready ;
wire             tdt_dmi_psel   ;
wire             tdt_dmi_pslverr;
wire    [31:0]   tdt_dmi_pwdata ;
wire             tdt_dmi_pwrite ;

reg              sys_apb_clk;



assign create_en = biu_pad_awvalid && pad_biu_awready;

always@(posedge per_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    wid_fifo_create[4:0] <= 5'b0;
  else if (create_en)
    wid_fifo_create[4:0] <= wid_fifo_create[4:0] + 5'b1;
end

assign wid_entry_push[31:0] = {32{create_en}} & (32'b1<<wid_fifo_create[4:0]);

always@(posedge per_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    wid_fifo_pop[4:0] <= 5'b0;
  else if (biu_pad_wvalid && biu_pad_wlast&& pad_biu_wready)
    wid_fifo_pop[4:0] <= wid_fifo_pop[4:0] + 5'b1;
end


always @( wid_17[7:0]
       or wid_27[7:0]
       or wid_25[7:0]
       or wid_15[7:0]
       or wid_11[7:0]
       or wid_12[7:0]
       or wid_8[7:0]
       or wid_14[7:0]
       or wid_2[7:0]
       or wid_16[7:0]
       or wid_31[7:0]
       or wid_9[7:0]
       or wid_4[7:0]
       or wid_20[7:0]
       or wid_22[7:0]
       or wid_28[7:0]
       or wid_5[7:0]
       or wid_29[7:0]
       or wid_7[7:0]
       or wid_3[7:0]
       or wid_10[7:0]
       or wid_1[7:0]
       or wid_24[7:0]
       or wid_19[7:0]
       or wid_13[7:0]
       or wid_0[7:0]
       or wid_23[7:0]
       or wid_6[7:0]
       or wid_21[7:0]
       or wid_26[7:0]
       or wid_18[7:0]
       or wid_30[7:0]
       or wid_fifo_pop[4:0])
begin
  wid_m1_8[7:0] = 5'b0;
  case(wid_fifo_pop[4:0])
  5'b00000: wid_m1_8[7:0] = wid_0[7:0];
  5'b00001: wid_m1_8[7:0] = wid_1[7:0];
  5'b00010: wid_m1_8[7:0] = wid_2[7:0];
  5'b00011: wid_m1_8[7:0] = wid_3[7:0];
  5'b00100: wid_m1_8[7:0] = wid_4[7:0];
  5'b00101: wid_m1_8[7:0] = wid_5[7:0];
  5'b00110: wid_m1_8[7:0] = wid_6[7:0];
  5'b00111: wid_m1_8[7:0] = wid_7[7:0];
  5'b01000: wid_m1_8[7:0] = wid_8[7:0];
  5'b01001: wid_m1_8[7:0] = wid_9[7:0];
  5'b01010: wid_m1_8[7:0] = wid_10[7:0];
  5'b01011: wid_m1_8[7:0] = wid_11[7:0];
  5'b01100: wid_m1_8[7:0] = wid_12[7:0];
  5'b01101: wid_m1_8[7:0] = wid_13[7:0];
  5'b01110: wid_m1_8[7:0] = wid_14[7:0];
  5'b01111: wid_m1_8[7:0] = wid_15[7:0];

  5'b10000: wid_m1_8[7:0] = wid_16[7:0];
  5'b10001: wid_m1_8[7:0] = wid_17[7:0];
  5'b10010: wid_m1_8[7:0] = wid_18[7:0];
  5'b10011: wid_m1_8[7:0] = wid_19[7:0];
  5'b10100: wid_m1_8[7:0] = wid_20[7:0];
  5'b10101: wid_m1_8[7:0] = wid_21[7:0];
  5'b10110: wid_m1_8[7:0] = wid_22[7:0];
  5'b10111: wid_m1_8[7:0] = wid_23[7:0];
  5'b11000: wid_m1_8[7:0] = wid_24[7:0];
  5'b11001: wid_m1_8[7:0] = wid_25[7:0];
  5'b11010: wid_m1_8[7:0] = wid_26[7:0];
  5'b11011: wid_m1_8[7:0] = wid_27[7:0];
  5'b11100: wid_m1_8[7:0] = wid_28[7:0];
  5'b11101: wid_m1_8[7:0] = wid_29[7:0];
  5'b11110: wid_m1_8[7:0] = wid_30[7:0];
  5'b11111: wid_m1_8[7:0] = wid_31[7:0];
  default:  wid_m1_8[7:0] = 8'b0;
  endcase

end


wid_entry  x_wid_entry_31 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_31            ),
  .wid_entry_push     (wid_entry_push[31])
);






wid_entry  x_wid_entry_30 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_30            ),
  .wid_entry_push     (wid_entry_push[30])
);






wid_entry  x_wid_entry_29 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_29            ),
  .wid_entry_push     (wid_entry_push[29])
);






wid_entry  x_wid_entry_28 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_28            ),
  .wid_entry_push     (wid_entry_push[28])
);






wid_entry  x_wid_entry_27 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_27            ),
  .wid_entry_push     (wid_entry_push[27])
);






wid_entry  x_wid_entry_26 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_26            ),
  .wid_entry_push     (wid_entry_push[26])
);






wid_entry  x_wid_entry_25 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_25            ),
  .wid_entry_push     (wid_entry_push[25])
);






wid_entry  x_wid_entry_24 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_24            ),
  .wid_entry_push     (wid_entry_push[24])
);






wid_entry  x_wid_entry_23 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_23            ),
  .wid_entry_push     (wid_entry_push[23])
);






wid_entry  x_wid_entry_22 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_22            ),
  .wid_entry_push     (wid_entry_push[22])
);






wid_entry  x_wid_entry_21 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_21            ),
  .wid_entry_push     (wid_entry_push[21])
);






wid_entry  x_wid_entry_20 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_20            ),
  .wid_entry_push     (wid_entry_push[20])
);






wid_entry  x_wid_entry_19 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_19            ),
  .wid_entry_push     (wid_entry_push[19])
);






wid_entry  x_wid_entry_18 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_18            ),
  .wid_entry_push     (wid_entry_push[18])
);






wid_entry  x_wid_entry_17 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_17            ),
  .wid_entry_push     (wid_entry_push[17])
);






wid_entry  x_wid_entry_16 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_16            ),
  .wid_entry_push     (wid_entry_push[16])
);






wid_entry  x_wid_entry_15 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_15            ),
  .wid_entry_push     (wid_entry_push[15])
);






wid_entry  x_wid_entry_14 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_14            ),
  .wid_entry_push     (wid_entry_push[14])
);






wid_entry  x_wid_entry_13 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_13            ),
  .wid_entry_push     (wid_entry_push[13])
);






wid_entry  x_wid_entry_12 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_12            ),
  .wid_entry_push     (wid_entry_push[12])
);






wid_entry  x_wid_entry_11 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_11            ),
  .wid_entry_push     (wid_entry_push[11])
);






wid_entry  x_wid_entry_10 (
  .biu_pad_awid       (biu_pad_awid      ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .per_clk            (per_clk           ),
  .wid                (wid_10            ),
  .wid_entry_push     (wid_entry_push[10])
);






wid_entry  x_wid_entry_9 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_9            ),
  .wid_entry_push    (wid_entry_push[9])
);






wid_entry  x_wid_entry_8 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_8            ),
  .wid_entry_push    (wid_entry_push[8])
);






wid_entry  x_wid_entry_7 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_7            ),
  .wid_entry_push    (wid_entry_push[7])
);






wid_entry  x_wid_entry_6 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_6            ),
  .wid_entry_push    (wid_entry_push[6])
);






wid_entry  x_wid_entry_5 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_5            ),
  .wid_entry_push    (wid_entry_push[5])
);






wid_entry  x_wid_entry_4 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_4            ),
  .wid_entry_push    (wid_entry_push[4])
);






wid_entry  x_wid_entry_3 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_3            ),
  .wid_entry_push    (wid_entry_push[3])
);






wid_entry  x_wid_entry_2 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_2            ),
  .wid_entry_push    (wid_entry_push[2])
);






wid_entry  x_wid_entry_1 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_1            ),
  .wid_entry_push    (wid_entry_push[1])
);






wid_entry  x_wid_entry_0 (
  .biu_pad_awid      (biu_pad_awid     ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .per_clk           (per_clk          ),
  .wid               (wid_0            ),
  .wid_entry_push    (wid_entry_push[0])
);





assign biu_pad_wid[7:0] = wid_m1_8[7:0];

openC906  x_cpu_top (
  .axim_clk_en             (axim_clk_en            ),
  .biu_pad_araddr          (biu_pad_araddr         ),
  .biu_pad_arburst         (biu_pad_arburst        ),
  .biu_pad_arcache         (biu_pad_arcache        ),
  .biu_pad_arid            (biu_pad_arid           ),
  .biu_pad_arlen           (biu_pad_arlen          ),
  .biu_pad_arlock          (biu_pad_arlock         ),
  .biu_pad_arprot          (biu_pad_arprot         ),
  .biu_pad_arsize          (biu_pad_arsize         ),
  .biu_pad_arvalid         (biu_pad_arvalid        ),
  .biu_pad_awaddr          (biu_pad_awaddr         ),
  .biu_pad_awburst         (biu_pad_awburst        ),
  .biu_pad_awcache         (biu_pad_awcache        ),
  .biu_pad_awid            (biu_pad_awid           ),
  .biu_pad_awlen           (biu_pad_awlen          ),
  .biu_pad_awlock          (biu_pad_awlock         ),
  .biu_pad_awprot          (biu_pad_awprot         ),
  .biu_pad_awsize          (biu_pad_awsize         ),
  .biu_pad_awvalid         (biu_pad_awvalid        ),
  .biu_pad_bready          (biu_pad_bready         ),
  .biu_pad_rready          (biu_pad_rready         ),
  .biu_pad_wdata           (biu_pad_wdata          ),
  .biu_pad_wlast           (biu_pad_wlast          ),
  .biu_pad_wstrb           (biu_pad_wstrb          ),
  .biu_pad_wvalid          (biu_pad_wvalid         ),
  .core0_pad_halted        (core0_pad_halted       ),
  .core0_pad_lpmd_b        (                       ),
  .core0_pad_retire        (core0_pad_retire0      ),
  .core0_pad_retire_pc     (core0_pad_retire0_pc   ),

   
   
   .cpu_debug_port          (cpu_debug_port          ),


  .pad_biu_arready         (pad_biu_arready        ),
  .pad_biu_awready         (pad_biu_awready        ),
  .pad_biu_bid             (pad_biu_bid            ),
  .pad_biu_bresp           (pad_biu_bresp          ),
  .pad_biu_bvalid          (pad_biu_bvalid         ),
  .pad_biu_rdata           (pad_biu_rdata          ),
  .pad_biu_rid             (pad_biu_rid            ),
  .pad_biu_rlast           (pad_biu_rlast          ),
  .pad_biu_rresp           (pad_biu_rresp          ),
  .pad_biu_rvalid          (pad_biu_rvalid         ),
  .pad_biu_wready          (pad_biu_wready         ),
  .pad_cpu_apb_base        (pad_cpu_apb_base       ),
  .pad_cpu_rst_b           (pad_cpu_rst_b          ),
  .pad_cpu_rvba            (pad_cpu_rvba           ),
  .pad_cpu_sys_cnt         (pad_cpu_sys_cnt        ),
  .pad_plic_int_cfg        (pad_plic_int_cfg       ),
  .pad_plic_int_vld        (pad_plic_int_vld       ),
  .pad_tdt_dm_core_unavail (1'b0                   ),
  .pad_yy_dft_clk_rst_b    (1'b1                   ),
  .pad_yy_icg_scan_en      (1'b0                   ),
  .pad_yy_mbist_mode       (1'b0                   ),
  .pad_yy_scan_enable      (pad_yy_scan_enable     ),
  .pad_yy_scan_mode        (pad_yy_scan_mode       ),
  .pad_yy_scan_rst_b       (1'b1                   ),
  .pll_core_cpuclk         (pll_core_cpuclk        ),
  .sys_apb_clk             (sys_apb_clk            ),
  .sys_apb_rst_b           (pad_cpu_rst_b          ),

  .pad_tdt_dm_arready      (1'b0                    ),
.pad_tdt_dm_awready      (1'b0                    ),
.pad_tdt_dm_bid          (4'b0                    ),
.pad_tdt_dm_bresp        (2'b0                    ),
.pad_tdt_dm_bvalid       (1'b0                    ),
.pad_tdt_dm_rdata        (128'b0                  ),
.pad_tdt_dm_rid          (4'b0                    ),
.pad_tdt_dm_rlast        (1'b0                    ),
.pad_tdt_dm_rresp        (2'b0                    ),
.pad_tdt_dm_rvalid       (1'b0                    ),
.pad_tdt_dm_wready       (1'b0                    ),
.tdt_dm_pad_araddr       (                        ),
.tdt_dm_pad_arburst      (                        ),
.tdt_dm_pad_arcache      (                        ),
.tdt_dm_pad_arid         (                        ),
.tdt_dm_pad_arlen        (                        ),
.tdt_dm_pad_arlock       (                        ),
.tdt_dm_pad_arprot       (                        ),
.tdt_dm_pad_arsize       (                        ),
.tdt_dm_pad_arvalid      (                        ),
.tdt_dm_pad_awaddr       (                        ),
.tdt_dm_pad_awburst      (                        ),
.tdt_dm_pad_awcache      (                        ),
.tdt_dm_pad_awid         (                        ),
.tdt_dm_pad_awlen        (                        ),
.tdt_dm_pad_awlock       (                        ),
.tdt_dm_pad_awprot       (                        ),
.tdt_dm_pad_awsize       (                        ),
.tdt_dm_pad_awvalid      (                        ),
.tdt_dm_pad_bready       (                        ),
.tdt_dm_pad_rready       (                        ), 
.tdt_dm_pad_wdata        (                        ), 
.tdt_dm_pad_wlast        (                        ), 
.tdt_dm_pad_wstrb        (                        ), 
.tdt_dm_pad_wvalid       (                        ), 


  .tdt_dm_pad_hartreset_n  (                       ),
  .tdt_dm_pad_ndmreset_n   (                       ),
  .tdt_dmi_paddr           (tdt_dmi_paddr          ),
  .tdt_dmi_penable         (tdt_dmi_penable        ),
  .tdt_dmi_prdata          (tdt_dmi_prdata         ),
  .tdt_dmi_pready          (tdt_dmi_pready         ),
  .tdt_dmi_psel            (tdt_dmi_psel           ),
  .tdt_dmi_pslverr         (tdt_dmi_pslverr        ),
  .tdt_dmi_pwdata          (tdt_dmi_pwdata         ),
  .tdt_dmi_pwrite          (tdt_dmi_pwrite         )
);

always@(posedge pll_core_cpuclk or negedge pad_cpu_rst_b) begin
  if(!pad_cpu_rst_b)
    sys_apb_clk <= 1'b0;
  else
    sys_apb_clk <= ~sys_apb_clk;
end


// tdt_dmi_top_dummy x_c906_dtm_top(
tdt_dmi_top x_c906_dtm_top(
  .pad_tdt_dtm_jtag2_sel   (1'b0                   ),
  .pad_tdt_dtm_tap_en      (1'b1                   ),
  .pad_tdt_dtm_tclk        (pad_dtm_jtg_tclk       ),
  .pad_tdt_dtm_tdi         (pad_dtm_jtg_tdi        ),
  .pad_tdt_dtm_tms_i       (pad_dtm_jtg_tms        ),
  .pad_tdt_dtm_trst_b      (pad_dtm_jtg_trst_b     ),
  .pad_tdt_icg_scan_en     (1'b0                   ),
  .pad_yy_scan_mode        (pad_yy_scan_mode       ),
  .pad_yy_scan_rst_b       (1'b1                   ),
  .sys_apb_clk             (sys_apb_clk            ),
  .sys_apb_rst_b           (pad_cpu_rst_b          ),
  .tdt_dmi_paddr           (tdt_dmi_paddr          ),
  .tdt_dmi_penable         (tdt_dmi_penable        ),
  .tdt_dmi_prdata          (tdt_dmi_prdata         ),
  .tdt_dmi_pready          (tdt_dmi_pready         ),
  .tdt_dmi_psel            (tdt_dmi_psel           ),
  .tdt_dmi_pslverr         (tdt_dmi_pslverr        ),
  .tdt_dmi_pwdata          (tdt_dmi_pwdata         ),
  .tdt_dmi_pwrite          (tdt_dmi_pwrite         ),
  .tdt_dtm_pad_tdo         (dtm_pad_jtg_tdo        ),
  .tdt_dtm_pad_tdo_en      (dtm_pad_jtg_tdo_en     ),
  .tdt_dtm_pad_tms_o       (                       ),
  .tdt_dtm_pad_tms_oe      (                       )
);

assign core0_pad_ipend_b = 1;
assign core0_pad_wakeup_b = 1;
assign cpu_pad_no_op = 0;
// assign cpu_debug_port = 0;
assign core0_pad_lpmd_b = 1;

always@(posedge pll_core_cpuclk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    pad_cpu_sys_cnt[63:0] <= 64'b0;
  else
    pad_cpu_sys_cnt[63:0] <= pad_cpu_sys_cnt[63:0] + 1'b1;
end

// assign pad_plic_int_vld[79:0]          = {16'h0,xx_intc_int[63:0]};
assign pad_plic_int_vld          = {{240 - 40{1'b0}}, xx_intc_int[39:0]};
assign pad_plic_int_cfg          = 'b0;
//assign pad_cpu_apb_base[39:0]  = 40'h8000001fb2;
assign pad_cpu_apb_base[39:0]  = 40'h4000000000;
assign pad_cpu_rvba[39:0]      = 40'h0;



endmodule


