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
module aq_cp0_rst_ctrl(
  cp0_ifu_bht_inv,
  cp0_ifu_icache_inv_addr,
  cp0_ifu_icache_inv_req,
  cp0_ifu_icache_inv_type,
  cp0_ifu_rst_inv_done,
  cp0_lsu_icc_addr,
  cp0_lsu_icc_op,
  cp0_lsu_icc_req,
  cp0_lsu_icc_type,
  cp0_mmu_tlb_all_inv,
  cp0_mmu_tlb_asid,
  cp0_mmu_tlb_asid_all_inv,
  cp0_mmu_tlb_va,
  cp0_mmu_tlb_va_all_inv,
  cp0_mmu_tlb_va_asid_inv,
  cp0_rtu_fence_idle,
  cpurst_b,
  ifu_cp0_bht_inv_done,
  ifu_cp0_icache_inv_done,
  ifu_cp0_rst_inv_req,
  inv_sm_clk,
  inv_sm_clk_en,
  iui_special_rs1,
  iui_special_rs2,
  lsu_cp0_icc_done,
  mmu_cp0_tlb_inv_done,
  regs_special_bht_inv,
  regs_special_dcache_clr,
  regs_special_dcache_inv,
  regs_special_dcache_req,
  regs_special_icache_inv,
  rst_top_op_done,
  sfence_clr_asid_all,
  sfence_clr_va_all,
  sfence_clr_va_asid,
  special_cacheop_op,
  special_cacheop_type,
  special_dcacheop_req,
  special_fence_dcache_req,
  special_fence_icache_req,
  special_fence_mmu_req,
  special_icacheop_req,
  special_op_done
);


// &Ports; @25
input           cpurst_b;                
input           ifu_cp0_bht_inv_done;    
input           ifu_cp0_icache_inv_done; 
input           ifu_cp0_rst_inv_req;     
input           inv_sm_clk;              
input   [63:0]  iui_special_rs1;         
input   [63:0]  iui_special_rs2;         
input           lsu_cp0_icc_done;        
input           mmu_cp0_tlb_inv_done;    
input           regs_special_bht_inv;    
input           regs_special_dcache_clr; 
input           regs_special_dcache_inv; 
input           regs_special_dcache_req; 
input           regs_special_icache_inv; 
input           sfence_clr_asid_all;     
input           sfence_clr_va_all;       
input           sfence_clr_va_asid;      
input   [1 :0]  special_cacheop_op;      
input   [1 :0]  special_cacheop_type;    
input           special_dcacheop_req;    
input           special_fence_dcache_req; 
input           special_fence_icache_req; 
input           special_fence_mmu_req;   
input           special_icacheop_req;    
output          cp0_ifu_bht_inv;         
output  [63:0]  cp0_ifu_icache_inv_addr; 
output          cp0_ifu_icache_inv_req;  
output  [1 :0]  cp0_ifu_icache_inv_type; 
output          cp0_ifu_rst_inv_done;    
output  [63:0]  cp0_lsu_icc_addr;        
output  [1 :0]  cp0_lsu_icc_op;          
output          cp0_lsu_icc_req;         
output  [1 :0]  cp0_lsu_icc_type;        
output          cp0_mmu_tlb_all_inv;     
output  [15:0]  cp0_mmu_tlb_asid;        
output          cp0_mmu_tlb_asid_all_inv; 
output  [26:0]  cp0_mmu_tlb_va;          
output          cp0_mmu_tlb_va_all_inv;  
output          cp0_mmu_tlb_va_asid_inv; 
output          cp0_rtu_fence_idle;      
output          inv_sm_clk_en;           
output          rst_top_op_done;         
output          special_op_done;         

// &Regs; @26
reg     [1 :0]  bht_cur_state;           
reg     [1 :0]  bht_next_state;          
reg     [1 :0]  dcache_cur_state;        
reg     [1 :0]  dcache_next_state;       
reg     [1 :0]  dcache_op;               
reg     [1 :0]  icache_cur_state;        
reg     [1 :0]  icache_next_state;       
reg     [1 :0]  mmu_cur_state;           
reg     [1 :0]  mmu_next_state;          
reg             mmu_tlb_all_inv;         
reg             mmu_tlb_asid_all_inv;    
reg             mmu_tlb_va_all_inv;      
reg             mmu_tlb_va_asid_inv;     
reg     [1 :0]  rst_cache_inv;           
reg     [1 :0]  rst_cache_inv_nxt;       

// &Wires; @27
wire            bht_op_done;             
wire            bht_op_req;              
wire            bht_sm_done;             
wire            bht_sm_idle;             
wire            bht_sm_wfc;              
wire            cp0_ifu_bht_inv;         
wire    [63:0]  cp0_ifu_icache_inv_addr; 
wire            cp0_ifu_icache_inv_req;  
wire    [1 :0]  cp0_ifu_icache_inv_type; 
wire            cp0_ifu_rst_inv_done;    
wire    [63:0]  cp0_lsu_icc_addr;        
wire    [1 :0]  cp0_lsu_icc_op;          
wire            cp0_lsu_icc_req;         
wire    [1 :0]  cp0_lsu_icc_type;        
wire            cp0_mmu_tlb_all_inv;     
wire    [15:0]  cp0_mmu_tlb_asid;        
wire            cp0_mmu_tlb_asid_all_inv; 
wire    [26:0]  cp0_mmu_tlb_va;          
wire            cp0_mmu_tlb_va_all_inv;  
wire            cp0_mmu_tlb_va_asid_inv; 
wire            cp0_rtu_fence_idle;      
wire            cpurst_b;                
wire            dcache_op_done;          
wire            dcache_op_req;           
wire            dcache_sm_done;          
wire            dcache_sm_idle;          
wire            dcache_sm_wfc;           
wire    [1 :0]  dcache_type;             
wire            fence_dcache_req;        
wire            fence_icache_req;        
wire            fence_mmu_req;           
wire            icache_op_done;          
wire            icache_op_req;           
wire            icache_sm_done;          
wire            icache_sm_idle;          
wire            icache_sm_wfc;           
wire    [1 :0]  icache_type;             
wire            ifu_cp0_bht_inv_done;    
wire            ifu_cp0_icache_inv_done; 
wire            ifu_cp0_rst_inv_req;     
wire            inv_sm_clk;              
wire            inv_sm_clk_en;           
wire    [63:0]  iui_special_rs1;         
wire    [63:0]  iui_special_rs2;         
wire            lsu_cp0_icc_done;        
wire            mmu_cp0_tlb_inv_done;    
wire            mmu_op_done;             
wire            mmu_op_req;              
wire            mmu_sm_done;             
wire            mmu_sm_idle;             
wire            mmu_sm_wfc;              
wire            op_done;                 
wire            regs_special_bht_inv;    
wire            regs_special_dcache_clr; 
wire            regs_special_dcache_inv; 
wire            regs_special_dcache_req; 
wire            regs_special_icache_inv; 
wire            reset_req;               
wire            rst_inv_done;            
wire            rst_sm_idle;             
wire            rst_top_op_done;         
wire            sfence_clr_asid_all;     
wire            sfence_clr_va_all;       
wire            sfence_clr_va_asid;      
wire    [1 :0]  special_cacheop_op;      
wire    [1 :0]  special_cacheop_type;    
wire            special_dcacheop_req;    
wire            special_fence_dcache_req; 
wire            special_fence_icache_req; 
wire            special_fence_mmu_req;   
wire            special_icacheop_req;    
wire            special_op_done;         


parameter RST_IDLE = 2'b00;
parameter RST_WFC  = 2'b01;
parameter RST_DONE = 2'b10;

//==========================================================
//                       FSM of Reset
//==========================================================
always @(posedge inv_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    rst_cache_inv[1:0] <= RST_IDLE;
  else
    rst_cache_inv[1:0] <= rst_cache_inv_nxt[1:0];
end

// &CombBeg; @44
always @( rst_cache_inv
       or rst_inv_done
       or ifu_cp0_rst_inv_req)
begin
case(rst_cache_inv)
  RST_IDLE:
  begin
    if(ifu_cp0_rst_inv_req)
      rst_cache_inv_nxt = RST_WFC;
    else
      rst_cache_inv_nxt = RST_IDLE;
  end
  RST_WFC:
  begin
    if(rst_inv_done)
      rst_cache_inv_nxt = RST_IDLE;
    else
      rst_cache_inv_nxt = RST_WFC;
  end
  default:
  begin
    rst_cache_inv_nxt = RST_IDLE;
  end
endcase
// &CombEnd; @65
end

assign rst_inv_done = op_done;
assign rst_sm_idle = rst_cache_inv == RST_IDLE;

//==========================================================
//                      Operation Ctrl
//==========================================================
//----------------------------------------------------------
//                     Operation Source
//----------------------------------------------------------
assign reset_req          = ifu_cp0_rst_inv_req;
assign fence_icache_req   = special_fence_icache_req;
assign fence_dcache_req   = special_fence_dcache_req;
assign fence_mmu_req      = special_fence_mmu_req;

//----------------------------------------------------------
//                    Opertion Generate
//----------------------------------------------------------
assign icache_op_req = reset_req
                    || fence_icache_req
                    || regs_special_icache_inv;
assign bht_op_req    = reset_req
                    || regs_special_bht_inv;
assign dcache_op_req = reset_req
                    || fence_dcache_req
                    || regs_special_dcache_req;
assign mmu_op_req    = reset_req
                    || fence_mmu_req;

//----------------------------------------------------------
//                      Operation Done
//----------------------------------------------------------
assign icache_op_done = icache_sm_idle && !icache_op_req
                     || icache_sm_done;
assign bht_op_done    = bht_sm_idle    && !bht_op_req
                     || bht_sm_done;
assign dcache_op_done = dcache_sm_idle && !dcache_op_req
                     || dcache_sm_done;
assign mmu_op_done    = mmu_sm_idle    && !mmu_op_req
                     || mmu_sm_done;

assign op_done = icache_op_done
              && bht_op_done
              && dcache_op_done
              && mmu_op_done;

//==========================================================
//                      FSM of ICACHE
//==========================================================
always @(posedge inv_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    icache_cur_state[1:0] <= RST_IDLE;
  else
    icache_cur_state[1:0] <= icache_next_state[1:0];
end

// &CombBeg; @123
always @( icache_op_req
       or ifu_cp0_icache_inv_done
       or op_done
       or icache_cur_state)
begin
case(icache_cur_state)
  RST_IDLE:
  begin
    if(icache_op_req)
      icache_next_state = RST_WFC;
    else
      icache_next_state = RST_IDLE;
  end
  RST_WFC:
  begin
    if(ifu_cp0_icache_inv_done)
      icache_next_state = RST_DONE;
    else
      icache_next_state = RST_WFC;
  end
  RST_DONE:
  begin
    if (op_done)
      icache_next_state = RST_IDLE;
    else
      icache_next_state = RST_DONE;
  end
  default:
  begin
    icache_next_state = RST_IDLE;
  end
endcase
// &CombEnd; @151
end

assign icache_sm_idle = icache_cur_state == RST_IDLE;
assign icache_sm_wfc  = icache_cur_state == RST_WFC;
assign icache_sm_done = icache_cur_state == RST_DONE;

assign icache_type[1:0] = special_icacheop_req ? special_cacheop_type
                                               : 2'b0; // ALL

//==========================================================
//                        FSM of BHT
//==========================================================
always @(posedge inv_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_cur_state[1:0] <= RST_IDLE;
  else
    bht_cur_state[1:0] <= bht_next_state[1:0];
end

// &CombBeg; @171
always @( bht_op_req
       or ifu_cp0_bht_inv_done
       or op_done
       or bht_cur_state)
begin
case(bht_cur_state)
  RST_IDLE:
  begin
    if(bht_op_req)
      bht_next_state = RST_WFC;
    else
      bht_next_state = RST_IDLE;
  end
  RST_WFC:
  begin
    if(ifu_cp0_bht_inv_done)
      bht_next_state = RST_DONE;
    else
      bht_next_state = RST_WFC;
  end
  RST_DONE:
  begin
    if (op_done)
      bht_next_state = RST_IDLE;
    else
      bht_next_state = RST_DONE;
  end
  default:
  begin
    bht_next_state = RST_IDLE;
  end
endcase
// &CombEnd; @199
end

assign bht_sm_idle = bht_cur_state == RST_IDLE;
assign bht_sm_wfc  = bht_cur_state == RST_WFC;
assign bht_sm_done = bht_cur_state == RST_DONE;


//==========================================================
//                      FSM of DCACHE
//==========================================================
always @(posedge inv_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dcache_cur_state[1:0] <= RST_IDLE;
  else
    dcache_cur_state[1:0] <= dcache_next_state[1:0];
end

// &CombBeg; @217
always @( dcache_op_req
       or op_done
       or lsu_cp0_icc_done
       or dcache_cur_state)
begin
case(dcache_cur_state)
  RST_IDLE:
  begin
    if(dcache_op_req)
      dcache_next_state = RST_WFC;
    else
      dcache_next_state = RST_IDLE;
  end
  RST_WFC:
  begin
    if(lsu_cp0_icc_done)
      dcache_next_state = RST_DONE;
    else
      dcache_next_state = RST_WFC;
  end
  RST_DONE:
  begin
    if (op_done)
      dcache_next_state = RST_IDLE;
    else
      dcache_next_state = RST_DONE;
  end
  default:
  begin
    dcache_next_state = RST_IDLE;
  end
endcase
// &CombEnd; @245
end

assign dcache_sm_idle = dcache_cur_state == RST_IDLE;
assign dcache_sm_wfc  = dcache_cur_state == RST_WFC;
assign dcache_sm_done = dcache_cur_state == RST_DONE;

assign dcache_type[1:0] = special_dcacheop_req ? special_cacheop_type[1:0]
                                               : 2'b0; // ALL
// &CombBeg @253
always @( special_dcacheop_req
       or special_cacheop_op[1:0]
       or regs_special_dcache_clr
       or fence_dcache_req
       or regs_special_dcache_req
       or regs_special_dcache_inv)
begin
if (regs_special_dcache_req)
  dcache_op[1:0] = {regs_special_dcache_clr, regs_special_dcache_inv};
else if (special_dcacheop_req)
  dcache_op[1:0] = special_cacheop_op[1:0];
else if (fence_dcache_req)
  dcache_op[1:0] = 2'b10; // CLR
else
  dcache_op[1:0] = 2'b01; // INV
// &CombEnd; @262
end

//==========================================================
//                        FSM of MMU
//==========================================================
always @(posedge inv_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mmu_cur_state[1:0] <= RST_IDLE;
  else
    mmu_cur_state[1:0] <= mmu_next_state[1:0];
end

// &CombBeg; @275
always @( mmu_cp0_tlb_inv_done
       or mmu_op_req
       or op_done
       or mmu_cur_state)
begin
case(mmu_cur_state)
  RST_IDLE:
  begin
    if(mmu_op_req)
      mmu_next_state = RST_WFC;
    else
      mmu_next_state = RST_IDLE;
  end
  RST_WFC:
  begin
    if(mmu_cp0_tlb_inv_done)
      mmu_next_state = RST_DONE;
    else
      mmu_next_state = RST_WFC;
  end
  RST_DONE:
  begin
    if (op_done)
      mmu_next_state = RST_IDLE;
    else
      mmu_next_state = RST_DONE;
  end
  default:
  begin
    mmu_next_state = RST_IDLE;
  end
endcase
// &CombEnd; @303
end

assign mmu_sm_idle = mmu_cur_state == RST_IDLE;
assign mmu_sm_wfc  = mmu_cur_state == RST_WFC;
assign mmu_sm_done = mmu_cur_state == RST_DONE;

// &CombBeg; @309
always @( sfence_clr_asid_all
       or sfence_clr_va_all
       or sfence_clr_va_asid)
begin
case({sfence_clr_va_all, sfence_clr_asid_all, sfence_clr_va_asid})
  3'b100: begin
    mmu_tlb_all_inv      = 1'b0;
    mmu_tlb_asid_all_inv = 1'b0;
    mmu_tlb_va_all_inv   = 1'b1;
    mmu_tlb_va_asid_inv  = 1'b0;
  end
  3'b010: begin
    mmu_tlb_all_inv      = 1'b0;
    mmu_tlb_asid_all_inv = 1'b1;
    mmu_tlb_va_all_inv   = 1'b0;
    mmu_tlb_va_asid_inv  = 1'b0;
  end
  3'b001: begin
    mmu_tlb_all_inv      = 1'b0;
    mmu_tlb_asid_all_inv = 1'b0;
    mmu_tlb_va_all_inv   = 1'b0;
    mmu_tlb_va_asid_inv  = 1'b1;
  end
  default: begin
    mmu_tlb_all_inv      = 1'b1;
    mmu_tlb_asid_all_inv = 1'b0;
    mmu_tlb_va_all_inv   = 1'b0;
    mmu_tlb_va_asid_inv  = 1'b0;
  end
endcase
// &CombEnd; @336
end
//==========================================================
//                           ICG
//==========================================================
assign inv_sm_clk_en = !op_done
                    || !mmu_sm_idle
                    || !dcache_sm_idle
                    || !icache_sm_idle
                    || !bht_sm_idle
                    || !rst_sm_idle;

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign special_op_done = op_done;

//----------------------------------------------------------
//                         For IFU
//----------------------------------------------------------
assign cp0_ifu_bht_inv = bht_sm_wfc;

assign cp0_ifu_icache_inv_req        = icache_sm_wfc;
assign cp0_ifu_icache_inv_type[1:0]  = icache_type[1:0];
assign cp0_ifu_icache_inv_addr[63:0] = {iui_special_rs1[63:1], 1'b0};

assign cp0_ifu_rst_inv_done = rst_inv_done;

//----------------------------------------------------------
//                         For MMU
//----------------------------------------------------------
assign cp0_mmu_tlb_all_inv      = mmu_sm_wfc && mmu_tlb_all_inv;
assign cp0_mmu_tlb_asid_all_inv = mmu_sm_wfc && mmu_tlb_asid_all_inv;
assign cp0_mmu_tlb_va_all_inv   = mmu_sm_wfc && mmu_tlb_va_all_inv;
assign cp0_mmu_tlb_va_asid_inv  = mmu_sm_wfc && mmu_tlb_va_asid_inv;

// &Force("bus", "iui_special_rs1", 63, 0); @374
// &Force("bus", "iui_special_rs2", 63, 0); @375
assign cp0_mmu_tlb_va[26:0] = iui_special_rs1[38:12];
assign cp0_mmu_tlb_asid[15:0] = iui_special_rs2[15:0];

//----------------------------------------------------------
//                         For LSU
//----------------------------------------------------------
assign cp0_lsu_icc_req        = dcache_sm_wfc;
assign cp0_lsu_icc_type[1:0]  = dcache_type[1:0];
assign cp0_lsu_icc_op[1:0]    = dcache_op[1:0];
assign cp0_lsu_icc_addr[63:0] = iui_special_rs1[63:0];

//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign cp0_rtu_fence_idle = op_done;

assign rst_top_op_done = op_done;

// &ModuleEnd; @394
endmodule



