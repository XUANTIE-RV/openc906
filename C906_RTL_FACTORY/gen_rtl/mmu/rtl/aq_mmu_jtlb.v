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

// &ModuleBeg; @26
module aq_mmu_jtlb(
  arb_jtlb_cmp_va,
  arb_jtlb_data_din,
  arb_jtlb_dutlb_on,
  arb_jtlb_fifo_din,
  arb_jtlb_fifo_write,
  arb_jtlb_idx,
  arb_jtlb_iutlb_on,
  arb_jtlb_mach,
  arb_jtlb_oper_on,
  arb_jtlb_pgs,
  arb_jtlb_ptw_req,
  arb_jtlb_req,
  arb_jtlb_tag_din,
  arb_jtlb_vpn,
  arb_jtlb_way_sel,
  arb_jtlb_write,
  cp0_mmu_icg_en,
  cp0_mmu_ptw_en,
  cpurst_b,
  forever_cpuclk,
  jtlb_arb_mach,
  jtlb_arb_tc_miss,
  jtlb_arb_tc_vld,
  jtlb_arb_vpn,
  jtlb_dutlb_acc_err,
  jtlb_dutlb_pgflt,
  jtlb_dutlb_ref_cmplt,
  jtlb_dutlb_ref_pavld,
  jtlb_iutlb_acc_err,
  jtlb_iutlb_pgflt,
  jtlb_iutlb_ref_cmplt,
  jtlb_iutlb_ref_pavld,
  jtlb_ptw_mach,
  jtlb_ptw_req,
  jtlb_ptw_vpn,
  jtlb_regs_hit,
  jtlb_regs_hit_mult,
  jtlb_regs_tlbp_hit_index,
  jtlb_tlboper_asid_hit,
  jtlb_tlboper_cmplt,
  jtlb_tlboper_fifo,
  jtlb_tlboper_sel,
  jtlb_tlboper_va_hit,
  jtlb_tlbr_asid,
  jtlb_tlbr_flg,
  jtlb_tlbr_g,
  jtlb_tlbr_pgs,
  jtlb_tlbr_ppn,
  jtlb_tlbr_vpn,
  jtlb_top_utlb_pavld,
  jtlb_xx_fifo,
  jtlb_xx_mmu_on,
  jtlb_xx_ref_flg,
  jtlb_xx_ref_pgs,
  jtlb_xx_ref_ppn,
  jtlb_xx_ref_vpn,
  jtlb_xx_tc_read,
  pad_yy_icg_scan_en,
  ptw_jtlb_ref_acc_err,
  ptw_jtlb_ref_cmplt,
  ptw_jtlb_ref_data_vld,
  ptw_jtlb_ref_flg,
  ptw_jtlb_ref_mach,
  ptw_jtlb_ref_mmu_on,
  ptw_jtlb_ref_pgflt,
  ptw_jtlb_ref_pgs,
  ptw_jtlb_ref_ppn,
  ptw_jtlb_ref_vpn,
  regs_jtlb_cur_asid,
  tlboper_jtlb_asid,
  tlboper_jtlb_asid_sel,
  tlboper_jtlb_cmp_noasid,
  tlboper_jtlb_inv_asid,
  tlboper_jtlb_tlbwr_on
);

// &Ports; @27
input           arb_jtlb_cmp_va;         
input   [43:0]  arb_jtlb_data_din;       
input           arb_jtlb_dutlb_on;       
input   [1 :0]  arb_jtlb_fifo_din;       
input           arb_jtlb_fifo_write;     
input   [8 :0]  arb_jtlb_idx;            
input           arb_jtlb_iutlb_on;       
input           arb_jtlb_mach;           
input           arb_jtlb_oper_on;        
input   [2 :0]  arb_jtlb_pgs;            
input           arb_jtlb_ptw_req;        
input           arb_jtlb_req;            
input   [47:0]  arb_jtlb_tag_din;        
input   [27:0]  arb_jtlb_vpn;            
input   [1 :0]  arb_jtlb_way_sel;        
input           arb_jtlb_write;          
input           cp0_mmu_icg_en;          
input           cp0_mmu_ptw_en;          
input           cpurst_b;                
input           forever_cpuclk;          
input           pad_yy_icg_scan_en;      
input           ptw_jtlb_ref_acc_err;    
input           ptw_jtlb_ref_cmplt;      
input           ptw_jtlb_ref_data_vld;   
input   [15:0]  ptw_jtlb_ref_flg;        
input           ptw_jtlb_ref_mach;       
input           ptw_jtlb_ref_mmu_on;     
input           ptw_jtlb_ref_pgflt;      
input   [2 :0]  ptw_jtlb_ref_pgs;        
input   [27:0]  ptw_jtlb_ref_ppn;        
input   [27:0]  ptw_jtlb_ref_vpn;        
input   [15:0]  regs_jtlb_cur_asid;      
input   [15:0]  tlboper_jtlb_asid;       
input           tlboper_jtlb_asid_sel;   
input           tlboper_jtlb_cmp_noasid; 
input   [15:0]  tlboper_jtlb_inv_asid;   
input           tlboper_jtlb_tlbwr_on;   
output          jtlb_arb_mach;           
output          jtlb_arb_tc_miss;        
output          jtlb_arb_tc_vld;         
output  [27:0]  jtlb_arb_vpn;            
output          jtlb_dutlb_acc_err;      
output          jtlb_dutlb_pgflt;        
output          jtlb_dutlb_ref_cmplt;    
output          jtlb_dutlb_ref_pavld;    
output          jtlb_iutlb_acc_err;      
output          jtlb_iutlb_pgflt;        
output          jtlb_iutlb_ref_cmplt;    
output          jtlb_iutlb_ref_pavld;    
output          jtlb_ptw_mach;           
output          jtlb_ptw_req;            
output  [27:0]  jtlb_ptw_vpn;            
output          jtlb_regs_hit;           
output          jtlb_regs_hit_mult;      
output  [8 :0]  jtlb_regs_tlbp_hit_index; 
output          jtlb_tlboper_asid_hit;   
output          jtlb_tlboper_cmplt;      
output  [1 :0]  jtlb_tlboper_fifo;       
output  [1 :0]  jtlb_tlboper_sel;        
output          jtlb_tlboper_va_hit;     
output  [15:0]  jtlb_tlbr_asid;          
output  [15:0]  jtlb_tlbr_flg;           
output          jtlb_tlbr_g;             
output  [2 :0]  jtlb_tlbr_pgs;           
output  [27:0]  jtlb_tlbr_ppn;           
output  [26:0]  jtlb_tlbr_vpn;           
output          jtlb_top_utlb_pavld;     
output  [5 :0]  jtlb_xx_fifo;            
output          jtlb_xx_mmu_on;          
output  [14:0]  jtlb_xx_ref_flg;         
output  [2 :0]  jtlb_xx_ref_pgs;         
output  [27:0]  jtlb_xx_ref_ppn;         
output  [27:0]  jtlb_xx_ref_vpn;         
output          jtlb_xx_tc_read;         

// &Regs; @28
reg             ta_cmp_va;               
reg     [5 :0]  ta_jtlb_fifo_upd;        
reg             ta_mach;                 
reg     [2 :0]  ta_pgs;                  
reg             ta_vld;                  
reg     [27:0]  ta_vpn;                  
reg     [1 :0]  ta_way_sel;              
reg             ta_wen;                  
reg             tc_cmp_va;               
reg     [5 :0]  tc_jtlb_fifo;            
reg             tc_mach;                 
reg     [2 :0]  tc_pgs;                  
reg             tc_vld;                  
reg     [27:0]  tc_vpn;                  
reg     [15:0]  tc_way0_asid;            
reg     [15:0]  tc_way0_flg;             
reg             tc_way0_g;               
reg             tc_way0_hit;             
reg     [2 :0]  tc_way0_pgs;             
reg     [27:0]  tc_way0_ppn;             
reg     [26:0]  tc_way0_vpn;             
reg     [15:0]  tc_way1_asid;            
reg     [15:0]  tc_way1_flg;             
reg             tc_way1_g;               
reg             tc_way1_hit;             
reg     [2 :0]  tc_way1_pgs;             
reg     [27:0]  tc_way1_ppn;             
reg     [26:0]  tc_way1_vpn;             
reg     [1 :0]  tc_way_sel;              
reg             tc_wen;                  

// &Wires; @29
wire            arb_jtlb_cmp_va;         
wire    [43:0]  arb_jtlb_data_din;       
wire            arb_jtlb_dutlb_on;       
wire    [1 :0]  arb_jtlb_fifo_din;       
wire            arb_jtlb_fifo_write;     
wire    [8 :0]  arb_jtlb_idx;            
wire            arb_jtlb_iutlb_on;       
wire            arb_jtlb_mach;           
wire            arb_jtlb_oper_on;        
wire    [2 :0]  arb_jtlb_pgs;            
wire            arb_jtlb_ptw_req;        
wire            arb_jtlb_req;            
wire    [47:0]  arb_jtlb_tag_din;        
wire    [27:0]  arb_jtlb_vpn;            
wire    [1 :0]  arb_jtlb_way_sel;        
wire            arb_jtlb_write;          
wire    [15:0]  asid_for_va_hit;         
wire            cp0_mmu_icg_en;          
wire            cp0_mmu_ptw_en;          
wire            cpurst_b;                
wire            forever_cpuclk;          
wire            jtlb_arb_mach;           
wire            jtlb_arb_tc_miss;        
wire            jtlb_arb_tc_vld;         
wire    [27:0]  jtlb_arb_vpn;            
wire            jtlb_clk;                
wire            jtlb_clk_en;             
wire            jtlb_data_cen;           
wire    [87:0]  jtlb_data_din;           
wire    [87:0]  jtlb_data_dout;          
wire    [8 :0]  jtlb_data_idx;           
wire    [1 :0]  jtlb_data_wen;           
wire            jtlb_dutlb_acc_err;      
wire            jtlb_dutlb_pgflt;        
wire            jtlb_dutlb_ref_cmplt;    
wire            jtlb_dutlb_ref_pavld;    
wire            jtlb_iutlb_acc_err;      
wire            jtlb_iutlb_pgflt;        
wire            jtlb_iutlb_ref_cmplt;    
wire            jtlb_iutlb_ref_pavld;    
wire            jtlb_ptw_mach;           
wire            jtlb_ptw_req;            
wire    [27:0]  jtlb_ptw_vpn;            
wire            jtlb_regs_hit;           
wire            jtlb_regs_hit_mult;      
wire    [8 :0]  jtlb_regs_tlbp_hit_index; 
wire            jtlb_tag_cen;            
wire    [97:0]  jtlb_tag_din;            
wire    [97:0]  jtlb_tag_dout;           
wire    [8 :0]  jtlb_tag_idx;            
wire    [2 :0]  jtlb_tag_wen;            
wire            jtlb_tlboper_asid_hit;   
wire            jtlb_tlboper_cmplt;      
wire    [1 :0]  jtlb_tlboper_fifo;       
wire    [1 :0]  jtlb_tlboper_sel;        
wire            jtlb_tlboper_va_hit;     
wire    [15:0]  jtlb_tlbr_asid;          
wire    [15:0]  jtlb_tlbr_flg;           
wire            jtlb_tlbr_g;             
wire    [2 :0]  jtlb_tlbr_pgs;           
wire    [27:0]  jtlb_tlbr_ppn;           
wire    [26:0]  jtlb_tlbr_vpn;           
wire            jtlb_top_utlb_pavld;     
wire    [5 :0]  jtlb_xx_fifo;            
wire            jtlb_xx_mmu_on;          
wire    [14:0]  jtlb_xx_ref_flg;         
wire    [2 :0]  jtlb_xx_ref_pgs;         
wire    [27:0]  jtlb_xx_ref_ppn;         
wire    [27:0]  jtlb_xx_ref_vpn;         
wire            jtlb_xx_tc_read;         
wire            pad_yy_icg_scan_en;      
wire            ptw_jtlb_ref_acc_err;    
wire            ptw_jtlb_ref_cmplt;      
wire            ptw_jtlb_ref_data_vld;   
wire    [15:0]  ptw_jtlb_ref_flg;        
wire            ptw_jtlb_ref_mach;       
wire            ptw_jtlb_ref_mmu_on;     
wire            ptw_jtlb_ref_pgflt;      
wire    [2 :0]  ptw_jtlb_ref_pgs;        
wire    [27:0]  ptw_jtlb_ref_ppn;        
wire    [27:0]  ptw_jtlb_ref_vpn;        
wire    [15:0]  ref_flg;                 
wire            ref_mach;                
wire            ref_mmu_on;              
wire    [2 :0]  ref_pgs;                 
wire    [27:0]  ref_ppn;                 
wire    [27:0]  ref_vpn;                 
wire    [15:0]  regs_jtlb_cur_asid;      
wire    [1 :0]  ta_idx_sel;              
wire    [1 :0]  ta_jtlb_fifo;            
wire    [43:0]  ta_jtlb_way0_data;       
wire    [47:0]  ta_jtlb_way0_tag;        
wire    [43:0]  ta_jtlb_way1_data;       
wire    [47:0]  ta_jtlb_way1_tag;        
wire    [26:0]  ta_vpn_1g;               
wire    [26:0]  ta_vpn_2m;               
wire    [26:0]  ta_vpn_4k;               
wire    [26:0]  ta_vpn_masked;           
wire    [15:0]  ta_way0_asid;            
wire            ta_way0_g;               
wire            ta_way0_hit;             
wire            ta_way0_hit_pre;         
wire    [2 :0]  ta_way0_pgs;             
wire            ta_way0_vld;             
wire    [26:0]  ta_way0_vpn;             
wire    [15:0]  ta_way1_asid;            
wire            ta_way1_g;               
wire            ta_way1_hit;             
wire            ta_way1_hit_pre;         
wire    [2 :0]  ta_way1_pgs;             
wire            ta_way1_vld;             
wire    [26:0]  ta_way1_vpn;             
wire            tag_fifo_wen;            
wire    [1 :0]  tag_way_wen;             
wire    [15:0]  tc_hit_flg;              
wire            tc_hit_idx;              
wire    [27:0]  tc_hit_ppn;              
wire    [15:0]  tc_idx_asid;             
wire            tc_idx_g;                
wire    [2 :0]  tc_idx_pgs;              
wire    [26:0]  tc_idx_vpn;              
wire            tc_pa_vld;               
wire            tc_ptw_vld;              
wire            tc_tlb_hit;              
wire            tc_tlb_hit_mult;         
wire            tc_tlb_miss;             
wire            tc_tlb_miss_fin;         
wire            tc_utlb_cmplt;           
wire    [26:0]  tc_vpn_1g;               
wire    [26:0]  tc_vpn_2m;               
wire    [26:0]  tc_vpn_4k;               
wire    [26:0]  tc_vpn_masked;           
wire            tc_way0_sel;             
wire            tc_way1_sel;             
wire    [15:0]  tlboper_jtlb_asid;       
wire            tlboper_jtlb_asid_sel;   
wire            tlboper_jtlb_cmp_noasid; 
wire    [15:0]  tlboper_jtlb_inv_asid;   
wire            tlboper_jtlb_tlbwr_on;   


parameter VPN_WIDTH  = 39-12;  // VPN
parameter PPN_WIDTH  = 40-12;  // PPN
parameter FLG_WIDTH  = 16;     // Flags
parameter PGS_WIDTH  = 3;      // Page Size
parameter ASID_WIDTH = 16;     // Flags
parameter PTE_LEVEL  = 3;      // Page Table Label

// VPN width per level
parameter VPN_PERLEL = VPN_WIDTH/PTE_LEVEL; 

// Valid + VPN + ASID + PageSize + Global
parameter TAG_WIDTH  = 1+VPN_WIDTH+ASID_WIDTH+PGS_WIDTH+1;  
parameter DATA_WIDTH = PPN_WIDTH+FLG_WIDTH;  

//==========================================================
//                  Gate Cell
//==========================================================
assign jtlb_clk_en = arb_jtlb_req || ta_vld || tc_vld;
// &Instance("gated_clk_cell", "x_jtlb_gateclk"); @49
gated_clk_cell  x_jtlb_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (jtlb_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (jtlb_clk_en       ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @50
//           .external_en(1'b0          ), @51
//           .global_en  (1'b1          ), @52
//           .module_en  (cp0_mmu_icg_en), @53
//           .local_en   (jtlb_clk_en   ), @54
//           .clk_out    (jtlb_clk      ) @55
//          ); @56

//==============================================================================
//                  Input to Memory ---  RB stage (Arbiter)
//==============================================================================
//==========================================================
//                  CEN & WEN
//==========================================================
//tag cen
assign jtlb_tag_cen       = arb_jtlb_req;

//tag wen
assign tag_fifo_wen       = arb_jtlb_fifo_write;
assign tag_way_wen[1:0]   = {2{arb_jtlb_write}} & arb_jtlb_way_sel[1:0];
assign jtlb_tag_wen[2:0]  = {tag_fifo_wen, tag_way_wen[1:0]};

//data cen
assign jtlb_data_cen      = arb_jtlb_req && (|arb_jtlb_way_sel[1:0]);

//data wen
assign jtlb_data_wen[1:0] = {2{arb_jtlb_write}} & arb_jtlb_way_sel[1:0]; 


//==========================================================
//                  Input Index
//==========================================================
assign jtlb_tag_idx[8:0]  = arb_jtlb_idx[8:0];
assign jtlb_data_idx[8:0] = arb_jtlb_idx[8:0];



//==========================================================
//                  Input Data
//==========================================================
assign jtlb_tag_din[(TAG_WIDTH*2)+1:0] = {arb_jtlb_fifo_din[1:0],
                                          arb_jtlb_tag_din[TAG_WIDTH-1:0],
                                          arb_jtlb_tag_din[TAG_WIDTH-1:0]};

assign jtlb_data_din[DATA_WIDTH*2-1:0]   = {arb_jtlb_data_din[DATA_WIDTH-1:0],
                                            arb_jtlb_data_din[DATA_WIDTH-1:0]}; 

//==========================================================
//                  jTLB Memory Instance
//==========================================================
// &Instance("aq_mmu_jtlb_tag_array"); @110
aq_mmu_jtlb_tag_array  x_aq_mmu_jtlb_tag_array (
  .cp0_mmu_icg_en     (cp0_mmu_icg_en    ),
  .forever_cpuclk     (forever_cpuclk    ),
  .jtlb_tag_cen       (jtlb_tag_cen      ),
  .jtlb_tag_din       (jtlb_tag_din      ),
  .jtlb_tag_dout      (jtlb_tag_dout     ),
  .jtlb_tag_idx       (jtlb_tag_idx      ),
  .jtlb_tag_wen       (jtlb_tag_wen      ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


// &Instance("aq_mmu_jtlb_data_array"); @112
aq_mmu_jtlb_data_array  x_aq_mmu_jtlb_data_array (
  .cp0_mmu_icg_en     (cp0_mmu_icg_en    ),
  .forever_cpuclk     (forever_cpuclk    ),
  .jtlb_data_cen      (jtlb_data_cen     ),
  .jtlb_data_din      (jtlb_data_din     ),
  .jtlb_data_dout     (jtlb_data_dout    ),
  .jtlb_data_idx      (jtlb_data_idx     ),
  .jtlb_data_wen      (jtlb_data_wen     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


//==============================================================================
//                  Output from Memory --- TA stage (TLB Access)
//==============================================================================
//==========================================================
//                  TA Valid
//==========================================================
always @(posedge jtlb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ta_vld <= 1'b0;
  else if(arb_jtlb_req && !arb_jtlb_ptw_req)
    ta_vld <= 1'b1;
  else
    ta_vld <= 1'b0;
end

//==========================================================
//                  Other Control Signal
//==========================================================
always @(posedge jtlb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ta_vpn[PPN_WIDTH-1:0] <= {PPN_WIDTH{1'b0}};
    ta_cmp_va             <= 1'b0;
    ta_mach               <= 1'b0;
    ta_way_sel[1:0]       <= 2'b0;
    ta_pgs[2:0]           <= 3'b0;
    ta_wen                <= 1'b0;
  end
  else if(arb_jtlb_req)
  begin
    ta_vpn[PPN_WIDTH-1:0] <= arb_jtlb_vpn[PPN_WIDTH-1:0];
    ta_cmp_va             <= arb_jtlb_cmp_va;
    ta_mach               <= arb_jtlb_mach;
    ta_way_sel[1:0]       <= arb_jtlb_way_sel[1:0];
    ta_pgs[2:0]           <= arb_jtlb_pgs[2:0];
    ta_wen                <= arb_jtlb_write;
  end
end


//==========================================================
//                  TAG & DATA Output
//==========================================================
assign ta_jtlb_way1_tag[TAG_WIDTH-1:0] = jtlb_tag_dout[(TAG_WIDTH*2)-1:TAG_WIDTH*1];
assign ta_jtlb_way0_tag[TAG_WIDTH-1:0] = jtlb_tag_dout[(TAG_WIDTH*1)-1:TAG_WIDTH*0];

assign ta_jtlb_way1_data[DATA_WIDTH-1:0] = jtlb_data_dout[(DATA_WIDTH*2)-1:DATA_WIDTH*1];
assign ta_jtlb_way0_data[DATA_WIDTH-1:0] = jtlb_data_dout[(DATA_WIDTH*1)-1:DATA_WIDTH*0];

assign ta_jtlb_fifo[1:0]     = jtlb_tag_dout[(TAG_WIDTH*2)+1:TAG_WIDTH*2];

//==========================================================
//                  Hit Info
//==========================================================
assign {ta_way1_vld, ta_way1_vpn[VPN_WIDTH-1:0], ta_way1_asid[ASID_WIDTH-1:0],
        ta_way1_pgs[PGS_WIDTH-1:0], ta_way1_g} = ta_jtlb_way1_tag[TAG_WIDTH-1:0];

assign {ta_way0_vld, ta_way0_vpn[VPN_WIDTH-1:0], ta_way0_asid[ASID_WIDTH-1:0],
        ta_way0_pgs[PGS_WIDTH-1:0], ta_way0_g} = ta_jtlb_way0_tag[TAG_WIDTH-1:0];

assign ta_vpn_4k[VPN_WIDTH-1:0] =  ta_vpn[VPN_WIDTH-1:0];
assign ta_vpn_2m[VPN_WIDTH-1:0] = {ta_vpn[VPN_WIDTH-1:VPN_PERLEL*1], {VPN_PERLEL*1{1'b0}}};
assign ta_vpn_1g[VPN_WIDTH-1:0] = {ta_vpn[VPN_WIDTH-1:VPN_PERLEL*2], {VPN_PERLEL*2{1'b0}}};
assign ta_vpn_masked[VPN_WIDTH-1:0] = {VPN_WIDTH{ta_pgs[0]}} & ta_vpn_4k[VPN_WIDTH-1:0]
                                    | {VPN_WIDTH{ta_pgs[1]}} & ta_vpn_2m[VPN_WIDTH-1:0]
                                    | {VPN_WIDTH{ta_pgs[2]}} & ta_vpn_1g[VPN_WIDTH-1:0];
assign asid_for_va_hit[ASID_WIDTH-1:0] = tlboper_jtlb_asid_sel   
                                       ? tlboper_jtlb_asid[ASID_WIDTH-1:0]
                                       : regs_jtlb_cur_asid[ASID_WIDTH-1:0];

// way1 hit
assign ta_way1_hit_pre = ta_way1_vpn[VPN_WIDTH-1:0] == ta_vpn_masked[VPN_WIDTH-1:0]
                      && ta_way1_pgs[PGS_WIDTH-1:0] == ta_pgs[PGS_WIDTH-1:0]
                      && ta_way1_vld && !ta_mach
                      && (ta_way1_asid[ASID_WIDTH-1:0] == asid_for_va_hit[ASID_WIDTH-1:0]
                         || ta_way1_g || tlboper_jtlb_cmp_noasid);
assign ta_way1_hit = ta_way1_hit_pre && ta_cmp_va;

// way0 hit
assign ta_way0_hit_pre = ta_way0_vpn[VPN_WIDTH-1:0] == ta_vpn_masked[VPN_WIDTH-1:0]
                      && ta_way0_pgs[PGS_WIDTH-1:0] == ta_pgs[PGS_WIDTH-1:0]
                      && ta_way0_vld && !ta_mach
                      && (ta_way0_asid[ASID_WIDTH-1:0] == asid_for_va_hit[ASID_WIDTH-1:0]
                         || ta_way0_g || tlboper_jtlb_cmp_noasid);
assign ta_way0_hit = ta_way0_hit_pre && ta_cmp_va;

assign ta_idx_sel[1:0]  = ta_way_sel[1:0] & {2{!ta_cmp_va}}; 

//==============================================================================
//                  Compare for Hit --- TC stage (TLB Compare)
//==============================================================================
//==========================================================
//                  TC Valid
//==========================================================
always @(posedge jtlb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    tc_vld <= 1'b0;
  else if(ta_vld)
    tc_vld <= 1'b1;
  else
    tc_vld <= 1'b0;
end

//==========================================================
//                  Other Control Signal
//==========================================================

always @(posedge jtlb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    tc_way0_hit <= 1'b0;
    tc_way1_hit <= 1'b0;
  end
  else if(ta_vld)
  begin
    tc_way0_hit <= ta_way0_hit;
    tc_way1_hit <= ta_way1_hit;
  end
end

// &CombBeg; @238
always @( ta_pgs[2:0]
       or tc_jtlb_fifo[5:0]
       or ta_jtlb_fifo[1:0])
begin
case({ta_pgs[2:0]})
  3'b001:  ta_jtlb_fifo_upd[5:0] = {tc_jtlb_fifo[5:2], ta_jtlb_fifo[1:0]};
  3'b010:  ta_jtlb_fifo_upd[5:0] = {tc_jtlb_fifo[5:4], ta_jtlb_fifo[1:0], tc_jtlb_fifo[1:0]};
  3'b100:  ta_jtlb_fifo_upd[5:0] = {ta_jtlb_fifo[1:0], tc_jtlb_fifo[3:0]};
  default: ta_jtlb_fifo_upd[5:0] = tc_jtlb_fifo[5:0];
endcase
// &CombEnd; @245
end

always @(posedge jtlb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    tc_vpn[PPN_WIDTH-1:0] <= {PPN_WIDTH{1'b0}};
    tc_way_sel[1:0]       <= 2'b0;
    tc_pgs[2:0]           <= 3'b0;
    tc_jtlb_fifo[5:0]     <= 6'b0;
    tc_wen                <= 1'b0;
    tc_cmp_va             <= 1'b0;
    tc_mach               <= 1'b0;
  end
  else if(ta_vld)
  begin
    tc_vpn[PPN_WIDTH-1:0] <= ta_vpn[PPN_WIDTH-1:0];
    tc_way_sel[1:0]       <= ta_idx_sel[1:0];
    tc_pgs[2:0]           <= ta_pgs[2:0];
    tc_jtlb_fifo[5:0]     <= ta_jtlb_fifo_upd[5:0];
    tc_wen                <= ta_wen;
    tc_cmp_va             <= ta_cmp_va;
    tc_mach               <= ta_mach;
  end
end

assign tc_hit_idx = tc_way1_hit & !tc_way0_hit;

// 1. for ptw record fifo
// 2. for tlb_wr
assign jtlb_xx_fifo[5:0] = tc_jtlb_fifo[5:0];

//==========================================================
//                  PFN & Flag
//==========================================================
always @(posedge jtlb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    tc_way1_vpn[VPN_WIDTH-1:0]   <= {VPN_WIDTH{1'b0}};
    tc_way1_pgs[PGS_WIDTH-1:0]   <= {PGS_WIDTH{1'b0}};
    tc_way1_asid[ASID_WIDTH-1:0] <= {ASID_WIDTH{1'b0}};
    tc_way1_g                    <= 1'b0;
    tc_way1_ppn[PPN_WIDTH-1:0]   <= {PPN_WIDTH{1'b0}};
    tc_way1_flg[FLG_WIDTH-1:0]   <= {FLG_WIDTH{1'b0}};
  end
  else if(ta_vld)
  begin
    tc_way1_vpn[VPN_WIDTH-1:0]   <= ta_way1_vpn[VPN_WIDTH-1:0];
    tc_way1_pgs[PGS_WIDTH-1:0]   <= ta_way1_pgs[PGS_WIDTH-1:0];
    tc_way1_asid[ASID_WIDTH-1:0] <= ta_way1_asid[ASID_WIDTH-1:0];
    tc_way1_g                    <= ta_way1_g;
    tc_way1_ppn[PPN_WIDTH-1:0]   <= ta_jtlb_way1_data[DATA_WIDTH-1:FLG_WIDTH];
    tc_way1_flg[FLG_WIDTH-1:0]   <= ta_jtlb_way1_data[FLG_WIDTH-1:0];
  end
end

always @(posedge jtlb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    tc_way0_vpn[VPN_WIDTH-1:0]   <= {VPN_WIDTH{1'b0}};
    tc_way0_pgs[PGS_WIDTH-1:0]   <= {PGS_WIDTH{1'b0}};
    tc_way0_asid[ASID_WIDTH-1:0] <= {ASID_WIDTH{1'b0}};
    tc_way0_g                    <= 1'b0;
    tc_way0_ppn[PPN_WIDTH-1:0]   <= {PPN_WIDTH{1'b0}};
    tc_way0_flg[FLG_WIDTH-1:0]   <= {FLG_WIDTH{1'b0}};
  end
  else if(ta_vld)
  begin
    tc_way0_vpn[VPN_WIDTH-1:0]   <= ta_way0_vpn[VPN_WIDTH-1:0];
    tc_way0_pgs[PGS_WIDTH-1:0]   <= ta_way0_pgs[PGS_WIDTH-1:0];
    tc_way0_asid[ASID_WIDTH-1:0] <= ta_way0_asid[ASID_WIDTH-1:0];
    tc_way0_g                    <= ta_way0_g;
    tc_way0_ppn[PPN_WIDTH-1:0]   <= ta_jtlb_way0_data[DATA_WIDTH-1:FLG_WIDTH];
    tc_way0_flg[FLG_WIDTH-1:0]   <= ta_jtlb_way0_data[FLG_WIDTH-1:0];
  end
end

//==========================================================
//                  Result Generation
//==========================================================
// miss, hit, hit mult judge
assign tc_tlb_miss     = !tc_way1_hit && !tc_way0_hit;
assign tc_tlb_hit      = tc_way1_hit ^ tc_way0_hit;
assign tc_tlb_hit_mult = tc_way1_hit && tc_way0_hit;

assign tc_tlb_miss_fin = tc_vld && tc_cmp_va && tc_tlb_miss && tc_pgs[2];

// tc pa vld signal
assign tc_pa_vld = tc_vld && tc_tlb_hit;


assign tc_way1_sel = tc_way1_hit || tc_way_sel[1];
assign tc_way0_sel = tc_way0_hit || tc_way_sel[0];

// for tlbr
assign tc_idx_vpn[VPN_WIDTH-1:0] = {VPN_WIDTH{tc_way_sel[1]}} & tc_way1_vpn[VPN_WIDTH-1:0]
                                 | {VPN_WIDTH{tc_way_sel[0]}} & tc_way0_vpn[VPN_WIDTH-1:0];
assign tc_idx_pgs[PGS_WIDTH-1:0] = {PGS_WIDTH{tc_way_sel[1]}} & tc_way1_pgs[PGS_WIDTH-1:0]
                                 | {PGS_WIDTH{tc_way_sel[0]}} & tc_way0_pgs[PGS_WIDTH-1:0];
assign tc_idx_asid[ASID_WIDTH-1:0] = {ASID_WIDTH{tc_way_sel[1]}} & tc_way1_asid[ASID_WIDTH-1:0]
                                   | {ASID_WIDTH{tc_way_sel[0]}} & tc_way0_asid[ASID_WIDTH-1:0];
assign tc_hit_ppn[PPN_WIDTH-1:0] = {PPN_WIDTH{tc_way1_sel}} & tc_way1_ppn[PPN_WIDTH-1:0]
                                 | {PPN_WIDTH{tc_way0_sel}} & tc_way0_ppn[PPN_WIDTH-1:0];
assign tc_hit_flg[FLG_WIDTH-1:0] = {FLG_WIDTH{tc_way1_sel}} & tc_way1_flg[FLG_WIDTH-1:0]
                                 | {FLG_WIDTH{tc_way0_sel}} & tc_way0_flg[FLG_WIDTH-1:0];
assign tc_idx_g                  = tc_way_sel[1] & tc_way1_g 
                                 | tc_way_sel[0] & tc_way0_g;
assign tc_ptw_vld                = cp0_mmu_ptw_en || tc_mach;

//----------------------------------------------------------
//                  Infor to ARB
//----------------------------------------------------------
assign jtlb_arb_tc_vld  = tc_vld;
assign jtlb_arb_tc_miss = tc_tlb_miss;
assign jtlb_arb_vpn[PPN_WIDTH-1:0] = tc_vpn[PPN_WIDTH-1:0];
assign jtlb_arb_mach    = tc_mach;

//----------------------------------------------------------
//                  Req to PTW 
//----------------------------------------------------------
assign jtlb_ptw_req = tc_vld && tc_ptw_vld && tc_tlb_miss_fin && !arb_jtlb_oper_on;
assign jtlb_ptw_vpn[PPN_WIDTH-1:0] = tc_vpn[PPN_WIDTH-1:0];
assign jtlb_ptw_mach = tc_mach;

//----------------------------------------------------------
//                  Result to TLB oper
//----------------------------------------------------------
assign jtlb_xx_tc_read = !tc_wen;

// cmplt
assign jtlb_tlboper_cmplt = tc_vld && arb_jtlb_oper_on;

// for tlbp
assign jtlb_regs_hit                 = tc_tlb_hit; 
assign jtlb_regs_hit_mult            = tc_tlb_hit_mult;

assign tc_vpn_4k[VPN_WIDTH-1:0] =  tc_vpn[VPN_WIDTH-1:0];
assign tc_vpn_2m[VPN_WIDTH-1:0] = {{VPN_PERLEL*1{1'b0}}, tc_vpn[VPN_WIDTH-1:VPN_PERLEL*1]};
assign tc_vpn_1g[VPN_WIDTH-1:0] = {{VPN_PERLEL*2{1'b0}}, tc_vpn[VPN_WIDTH-1:VPN_PERLEL*2]};
assign tc_vpn_masked[VPN_WIDTH-1:0] = {VPN_WIDTH{tc_pgs[0]}} & tc_vpn_4k[VPN_WIDTH-1:0]
                                    | {VPN_WIDTH{tc_pgs[1]}} & tc_vpn_2m[VPN_WIDTH-1:0]
                                    | {VPN_WIDTH{tc_pgs[2]}} & tc_vpn_1g[VPN_WIDTH-1:0];
assign jtlb_regs_tlbp_hit_index[8:0] = {2'b0, tc_hit_idx, tc_vpn_masked[5:0]};

// for tlbr
assign jtlb_tlbr_vpn[VPN_WIDTH-1:0]   = tc_idx_vpn[VPN_WIDTH-1:0];
assign jtlb_tlbr_pgs[PGS_WIDTH-1:0]   = tc_idx_pgs[PGS_WIDTH-1:0];
assign jtlb_tlbr_asid[ASID_WIDTH-1:0] = tc_idx_asid[ASID_WIDTH-1:0];
assign jtlb_tlbr_ppn[PPN_WIDTH-1:0]   = tc_hit_ppn[PPN_WIDTH-1:0];
assign jtlb_tlbr_flg[FLG_WIDTH-1:0]   = tc_hit_flg[FLG_WIDTH-1:0];
assign jtlb_tlbr_g                    = tc_idx_g;

//for inv asid
assign jtlb_tlboper_asid_hit = (tc_idx_asid[ASID_WIDTH-1:0] == tlboper_jtlb_inv_asid[ASID_WIDTH-1:0]) && !tc_idx_g;
// wen sel for tlbwr and invva
assign jtlb_tlboper_fifo[1:0] = tc_jtlb_fifo[1:0];
assign jtlb_tlboper_sel[1:0] = tlboper_jtlb_tlbwr_on ? tc_jtlb_fifo[1:0]
                                                     : {tc_way1_hit,
                                                        tc_way0_hit};
assign jtlb_tlboper_va_hit = tc_way1_hit || tc_way0_hit;

//----------------------------------------------------------
//                  Result to uTLB
//----------------------------------------------------------
assign tc_utlb_cmplt        = tc_vld
                           && (!tc_ptw_vld && tc_pgs[2]
                              || !tc_tlb_miss);
assign jtlb_iutlb_ref_cmplt = tc_utlb_cmplt     
                                 && arb_jtlb_iutlb_on
                           || ptw_jtlb_ref_cmplt
                                 && arb_jtlb_iutlb_on; 

assign jtlb_iutlb_ref_pavld = tc_pa_vld
                                 && arb_jtlb_iutlb_on
                           || ptw_jtlb_ref_data_vld
                                 && arb_jtlb_iutlb_on;

assign jtlb_iutlb_acc_err   = ptw_jtlb_ref_acc_err
                                 && arb_jtlb_iutlb_on;

assign jtlb_iutlb_pgflt     = ptw_jtlb_ref_pgflt
                                 && arb_jtlb_iutlb_on
                           || tc_vld && tc_tlb_hit_mult
                                 && arb_jtlb_iutlb_on
                           || tc_vld && !tc_ptw_vld && tc_tlb_miss_fin
                                 && arb_jtlb_iutlb_on;


assign jtlb_dutlb_ref_cmplt = tc_utlb_cmplt 
                                 && arb_jtlb_dutlb_on
                           || ptw_jtlb_ref_cmplt
                                 && arb_jtlb_dutlb_on;

assign jtlb_dutlb_ref_pavld = tc_pa_vld
                                 && arb_jtlb_dutlb_on
                           || ptw_jtlb_ref_data_vld
                                 && arb_jtlb_dutlb_on;

assign jtlb_dutlb_pgflt     = ptw_jtlb_ref_pgflt
                                 && arb_jtlb_dutlb_on
                           || tc_vld && tc_tlb_hit_mult 
                                 && arb_jtlb_dutlb_on
                           || tc_vld && !tc_ptw_vld && tc_tlb_miss_fin
                                 && arb_jtlb_dutlb_on;

assign jtlb_dutlb_acc_err   = ptw_jtlb_ref_acc_err
                                 && arb_jtlb_dutlb_on;

//vpn & ppn & flag
assign ref_vpn[PPN_WIDTH-1:0] = ptw_jtlb_ref_cmplt ? ptw_jtlb_ref_vpn[PPN_WIDTH-1:0]
                                                   : tc_vpn[PPN_WIDTH-1:0];
assign ref_pgs[PGS_WIDTH-1:0] = ptw_jtlb_ref_cmplt ? ptw_jtlb_ref_pgs[PGS_WIDTH-1:0]
                                                   : tc_pgs[PGS_WIDTH-1:0];
assign ref_ppn[PPN_WIDTH-1:0] = ptw_jtlb_ref_cmplt ? ptw_jtlb_ref_ppn[PPN_WIDTH-1:0]
                                                   : tc_hit_ppn[PPN_WIDTH-1:0];
assign ref_flg[FLG_WIDTH-1:0] = ptw_jtlb_ref_cmplt ? ptw_jtlb_ref_flg[FLG_WIDTH-1:0]
                                                   : tc_hit_flg[FLG_WIDTH-1:0];
assign ref_mach               = ptw_jtlb_ref_cmplt && ptw_jtlb_ref_mach;
assign ref_mmu_on             = ptw_jtlb_ref_cmplt ? ptw_jtlb_ref_mmu_on
                                                   : 1'b1;

assign jtlb_xx_ref_vpn[PPN_WIDTH-1:0] = ref_vpn[PPN_WIDTH-1:0]; 
assign jtlb_xx_ref_pgs[PGS_WIDTH-1:0] = ref_pgs[PGS_WIDTH-1:0]; 
assign jtlb_xx_ref_ppn[PPN_WIDTH-1:0] = ref_ppn[PPN_WIDTH-1:0];
assign jtlb_xx_ref_flg[FLG_WIDTH-2:0] = {ref_flg[FLG_WIDTH-1:FLG_WIDTH-4],   // PMP
                                         ref_mach,                           // Machine
                                         ref_flg[FLG_WIDTH-5:FLG_WIDTH-9],   // PMA
                                         ref_flg[4:3],                       // PTW Flag U, X
                                         ref_flg[6] && ref_flg[2],           // PTE Flag W
                                         ref_flg[1],                         // PTE Flag R
                                         ref_flg[5] && ref_flg[0] || ref_mach // PTE Flag V
                                        };
assign jtlb_xx_mmu_on                 = ref_mmu_on;

assign jtlb_top_utlb_pavld = tc_pa_vld || ptw_jtlb_ref_data_vld;

// &Force("input", "arb_jtlb_tlboper_req"); @492
// &Force("nonport", "tag_din_ff_hit"); @493
// &Force("nonport", "tag_rd_way_hit"); @494

// &ModuleEnd; @532
endmodule


