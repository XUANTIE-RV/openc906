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
module aq_mmu_plru(
  cp0_mmu_icg_en,
  cpurst_b,
  entry0_vld,
  entry1_vld,
  entry2_vld,
  entry3_vld,
  entry4_vld,
  entry5_vld,
  entry6_vld,
  entry7_vld,
  entry8_vld,
  entry9_vld,
  forever_cpuclk,
  pad_yy_icg_scan_en,
  plru_utlb_ref_num,
  utlb_plru_read_hit,
  utlb_plru_read_hit_vld,
  utlb_plru_refill_on,
  utlb_plru_refill_vld
);

// &Ports; @24
input           cp0_mmu_icg_en;        
input           cpurst_b;              
input           entry0_vld;            
input           entry1_vld;            
input           entry2_vld;            
input           entry3_vld;            
input           entry4_vld;            
input           entry5_vld;            
input           entry6_vld;            
input           entry7_vld;            
input           entry8_vld;            
input           entry9_vld;            
input           forever_cpuclk;        
input           pad_yy_icg_scan_en;    
input   [9 :0]  utlb_plru_read_hit;    
input           utlb_plru_read_hit_vld; 
input           utlb_plru_refill_on;   
input           utlb_plru_refill_vld;  
output  [9 :0]  plru_utlb_ref_num;     

// &Regs; @25
reg     [3 :0]  hit_num_flop;          
reg     [3 :0]  hit_num_index;         
reg             p00;                   
reg             p10;                   
reg             p11;                   
reg             p20;                   
reg             p21;                   
reg             p22;                   
reg             p23;                   
reg             p30;                   
reg             p37;                   
reg     [3 :0]  refill_num_index;      
reg     [9 :0]  refill_num_onehot;     
reg     [3 :0]  write_num;             

// &Wires; @26
wire            cp0_mmu_icg_en;        
wire            cpurst_b;              
wire            entry0_vld;            
wire            entry1_vld;            
wire            entry2_vld;            
wire            entry3_vld;            
wire            entry4_vld;            
wire            entry5_vld;            
wire            entry6_vld;            
wire            entry7_vld;            
wire            entry8_vld;            
wire            entry9_vld;            
wire            forever_cpuclk;        
wire    [9 :0]  hit_num_onehot;        
wire            lru_clk;               
wire            lru_clk_en;            
wire            p00_read_updt_val;     
wire            p00_write_updt_val;    
wire            p10_read_updt;         
wire            p10_read_updt_val;     
wire            p10_write_updt;        
wire            p10_write_updt_val;    
wire            p11_read_updt;         
wire            p11_read_updt_val;     
wire            p11_write_updt;        
wire            p11_write_updt_val;    
wire            p20_read_updt;         
wire            p20_read_updt_val;     
wire            p20_write_updt;        
wire            p20_write_updt_val;    
wire            p21_read_updt;         
wire            p21_read_updt_val;     
wire            p21_write_updt;        
wire            p21_write_updt_val;    
wire            p22_read_updt;         
wire            p22_read_updt_val;     
wire            p22_write_updt;        
wire            p22_write_updt_val;    
wire            p23_read_updt;         
wire            p23_read_updt_val;     
wire            p23_write_updt;        
wire            p23_write_updt_val;    
wire            p30_read_updt;         
wire            p30_read_updt_val;     
wire            p30_write_updt;        
wire            p30_write_updt_val;    
wire            p31;                   
wire            p32;                   
wire            p33;                   
wire            p34;                   
wire            p35;                   
wire            p36;                   
wire            p37_read_updt;         
wire            p37_read_updt_val;     
wire            p37_write_updt;        
wire            p37_write_updt_val;    
wire            pad_yy_icg_scan_en;    
wire    [3 :0]  plru_num;              
wire            plru_read_updt;        
wire    [9 :0]  plru_utlb_ref_num;     
wire            plru_write_updt;       
wire    [9 :0]  utlb_plru_read_hit;    
wire            utlb_plru_read_hit_vld; 
wire            utlb_plru_refill_on;   
wire            utlb_plru_refill_vld;  
wire    [15:0]  vld_entry_num;         



//==========================================================
//                  Gate Cell
//==========================================================
assign lru_clk_en = utlb_plru_refill_on
                 || plru_read_updt;
// &Instance("gated_clk_cell", "x_plru_gateclk"); @34
gated_clk_cell  x_plru_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (lru_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (lru_clk_en        ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @35
//           .external_en(1'b0          ), @36
//           .global_en  (1'b1          ), @37
//           .module_en  (cp0_mmu_icg_en), @38
//           .local_en   (lru_clk_en    ), @39
//           .clk_out    (lru_clk       ) @40
//          ); @41


//==========================================================
//                  Entry sel for Refill
//==========================================================
assign vld_entry_num[15:0] = {6'b0, entry9_vld, entry8_vld,
                              entry7_vld,  entry6_vld,  entry5_vld,  entry4_vld,
                              entry3_vld,  entry2_vld,  entry1_vld,  entry0_vld};  
// &CombBeg; @50
always @( plru_num[3:0]
       or vld_entry_num[15:0])
begin
casez(vld_entry_num[15:0])
  16'b???????????????0: write_num[3:0] = 4'b0000;
  16'b??????????????01: write_num[3:0] = 4'b0001;
  16'b?????????????011: write_num[3:0] = 4'b0011;
  16'b????????????0111: write_num[3:0] = 4'b0101;
  16'b???????????01111: write_num[3:0] = 4'b0111;
  16'b??????????011111: write_num[3:0] = 4'b1001;
  16'b?????????0111111: write_num[3:0] = 4'b1011;
  16'b????????01111111: write_num[3:0] = 4'b1101;
  16'b???????011111111: write_num[3:0] = 4'b1110;
  16'b??????0111111111: write_num[3:0] = 4'b1111;
  16'b??????1111111111: write_num[3:0] = plru_num[3:0];
  default             : write_num[3:0] = 4'b0;
endcase
// &CombEnd; @65
end


always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    refill_num_index[3:0] <= 4'b0;
  else if(utlb_plru_refill_on)
    refill_num_index[3:0] <= write_num[3:0];
end


// &CombBeg; @77
always @( refill_num_index[3:0])
begin
case(refill_num_index[3:0])
  4'h0: refill_num_onehot[9:0]    = 10'b0000000001;
  4'h1: refill_num_onehot[9:0]    = 10'b0000000010;
  4'h3: refill_num_onehot[9:0]    = 10'b0000000100;
  4'h5: refill_num_onehot[9:0]    = 10'b0000001000;
  4'h7: refill_num_onehot[9:0]    = 10'b0000010000;
  4'h9: refill_num_onehot[9:0]    = 10'b0000100000;
  4'hb: refill_num_onehot[9:0]    = 10'b0001000000;
  4'hd: refill_num_onehot[9:0]    = 10'b0010000000;
  4'he: refill_num_onehot[9:0]    = 10'b0100000000;
  4'hf: refill_num_onehot[9:0]    = 10'b1000000000;
  default: refill_num_onehot[9:0] = 10'b0000000001;
endcase
// &CombEnd; @91
end



//----------------------------------------------------------
//                  Final Refill Sel to uTLB
//----------------------------------------------------------
assign plru_utlb_ref_num[9:0] = refill_num_onehot[9:0];


//==========================================================
//                  Read Update
//==========================================================
// When utlb hit with different entry, updata PLRU path flop
assign hit_num_onehot[9:0] = utlb_plru_read_hit[9:0];
// &CombBeg; @106
always @( hit_num_onehot[9:0])
begin
case(hit_num_onehot[9:0])
  10'b0000000001: hit_num_index[3:0] = 4'h0;
  10'b0000000010: hit_num_index[3:0] = 4'h1;
  10'b0000000100: hit_num_index[3:0] = 4'h3;
  10'b0000001000: hit_num_index[3:0] = 4'h5;
  10'b0000010000: hit_num_index[3:0] = 4'h7;
  10'b0000100000: hit_num_index[3:0] = 4'h9;
  10'b0001000000: hit_num_index[3:0] = 4'hb;
  10'b0010000000: hit_num_index[3:0] = 4'hd;
  10'b0100000000: hit_num_index[3:0] = 4'he;
  10'b1000000000: hit_num_index[3:0] = 4'hf;
  default       : hit_num_index[3:0] = 4'h0;
endcase
// &CombEnd; @120
end


always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    hit_num_flop[3:0] <= 4'b0;
  else if(utlb_plru_read_hit_vld)
    hit_num_flop[3:0] <= hit_num_index[3:0];
end


//==========================================================
//                  PLRU Path Flop
//==========================================================
//                             P00
//                             /\
//                            /  \
//                           /    \
//                         0/      \1
//                         /        \
//                     P10            P11
//                      /\           /\
//                    0/  \1       0/  \1
//                    /    \       /    \
//                P20     P21     P22     P23
//               /\      /\       /\       /\
//             0/  \1  0/  \1   0/  \1   0/  \1
//            P30 P31  P32 P33  P34 P35  P36 P37          

assign plru_write_updt = utlb_plru_refill_vld;
assign plru_read_updt  = utlb_plru_read_hit_vld
                      && (hit_num_flop[3:0] != hit_num_index[3:0]); 


//----------------------------------------------------------
//                  Level 0 Path
//----------------------------------------------------------
// Path 0
assign p00_write_updt_val = !refill_num_index[3];
assign p00_read_updt_val  = !hit_num_index[3];

always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    p00 <= 1'b0;
  else if(plru_write_updt)
    p00 <= p00_write_updt_val;
  else if(plru_read_updt)
    p00 <= p00_read_updt_val;
end


//----------------------------------------------------------
//                  Level 1 Path
//----------------------------------------------------------
// Path 10
assign p10_write_updt     = plru_write_updt && !refill_num_index[3];
assign p10_read_updt      = plru_read_updt  && !hit_num_index[3];

assign p10_write_updt_val = (refill_num_index[3:2] == 2'b00); 
assign p10_read_updt_val  = (hit_num_index[3:2] == 2'b00);

always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    p10 <= 1'b0;
  else if(p10_write_updt)
    p10 <= p10_write_updt_val;
  else if(p10_read_updt)
    p10 <= p10_read_updt_val;
end

// Path 11
assign p11_write_updt     = plru_write_updt && refill_num_index[3];
assign p11_read_updt      = plru_read_updt  && hit_num_index[3];

assign p11_write_updt_val = (refill_num_index[3:2] == 2'b10);
assign p11_read_updt_val  = (hit_num_index[3:2] == 2'b10);

always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    p11 <= 1'b0;
  else if(p11_write_updt)
    p11 <= p11_write_updt_val;
  else if(p11_read_updt)
    p11 <= p11_read_updt_val;
end


//----------------------------------------------------------
//                  Level 2 Path
//----------------------------------------------------------
// Path 20
assign p20_write_updt     = plru_write_updt
                         && (refill_num_index[3:2] == 2'b00);
assign p20_read_updt      = plru_read_updt
                         && (hit_num_index[3:2] == 2'b00);

assign p20_write_updt_val = (refill_num_index[3:1] == 3'b000);
assign p20_read_updt_val  = (hit_num_index[3:1] == 3'b000);

always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    p20 <= 1'b0;
  else if(p20_write_updt)
    p20 <= p20_write_updt_val;
  else if(p20_read_updt)
    p20 <= p20_read_updt_val;
end

// Path 21
assign p21_write_updt     = plru_write_updt
                         && (refill_num_index[3:2] == 2'b01);
assign p21_read_updt      = plru_read_updt
                         && (hit_num_index[3:2] == 2'b01);

assign p21_write_updt_val = (refill_num_index[3:1] == 3'b010);
assign p21_read_updt_val  = (hit_num_index[3:1] == 3'b010);

always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    p21 <= 1'b0;
  else if(p21_write_updt)
    p21 <= p21_write_updt_val;
  else if(p21_read_updt)
    p21 <= p21_read_updt_val;
end

// Path 22
assign p22_write_updt     = plru_write_updt
                         && (refill_num_index[3:2] == 2'b10);
assign p22_read_updt      = plru_read_updt
                         && (hit_num_index[3:2] == 2'b10);

assign p22_write_updt_val = (refill_num_index[3:1] == 3'b100);
assign p22_read_updt_val  = (hit_num_index[3:1] == 3'b100);

always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    p22 <= 1'b0;
  else if(p22_write_updt)
    p22 <= p22_write_updt_val;
  else if(p22_read_updt)
    p22 <= p22_read_updt_val;
end

// Path 23
assign p23_write_updt     = plru_write_updt
                         && (refill_num_index[3:2] == 2'b11);
assign p23_read_updt      = plru_read_updt
                         && (hit_num_index[3:2] == 2'b11);

assign p23_write_updt_val = (refill_num_index[3:1] == 3'b110);
assign p23_read_updt_val  = (hit_num_index[3:1] == 3'b110);

always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    p23 <= 1'b0;
  else if(p23_write_updt)
    p23 <= p23_write_updt_val;
  else if(p23_read_updt)
    p23 <= p23_read_updt_val;
end


//----------------------------------------------------------
//                  Level 3 Path
//----------------------------------------------------------
//Path 30
assign p30_write_updt     = plru_write_updt
                         && (refill_num_index[3:1] == 3'b000);
assign p30_read_updt      = plru_read_updt
                         && (hit_num_index[3:1] == 3'b000);

assign p30_write_updt_val = (refill_num_index[3:0] == 4'b0000);
assign p30_read_updt_val  = (hit_num_index[3:0] == 4'b0000);

always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    p30 <= 1'b0;
  else if(p30_write_updt)
    p30 <= p30_write_updt_val;
  else if(p30_read_updt)
    p30 <= p30_read_updt_val;
end
assign p31 = 1'b1;
assign p32 = 1'b1;
assign p33 = 1'b1;
assign p34 = 1'b1;
assign p35 = 1'b1;
assign p36 = 1'b1;
////Path 31
//assign p31_write_updt     = plru_write_updt
//                         && (refill_num_index[3:1] == 3'b001);
//assign p31_read_updt      = plru_read_updt
//                         && (hit_num_index[3:1] == 3'b001);
//
//assign p31_write_updt_val = (refill_num_index[3:0] == 4'b0010);
//assign p31_read_updt_val  = (hit_num_index[3:0] == 4'b0010);
//
//always @(posedge lru_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    p31 <= 1'b0; 
//  else if(p31_write_updt)
//    p31 <= p31_write_updt_val;
//  else if(p31_read_updt)
//    p31 <= p31_read_updt_val;
//end
//  
////Path 32
//assign p32_write_updt     = plru_write_updt
//                         && (refill_num_index[3:1] == 3'b010);
//assign p32_read_updt      = plru_read_updt
//                         && (hit_num_index[3:1] == 3'b010);
//
//assign p32_write_updt_val = (refill_num_index[3:0] == 4'b0100);
//assign p32_read_updt_val  = (hit_num_index[3:0] == 4'b0100);
//
//always @(posedge lru_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    p32 <= 1'b0; 
//  else if(p32_write_updt)
//    p32 <= p32_write_updt_val;
//  else if(p32_read_updt)
//    p32 <= p32_read_updt_val;
//end 
//  
////Path 33
//assign p33_write_updt     = plru_write_updt
//                         && (refill_num_index[3:1] == 3'b011);
//assign p33_read_updt      = plru_read_updt
//                         && (hit_num_index[3:1] == 3'b011);
//
//assign p33_write_updt_val = (refill_num_index[3:0] == 4'b0110);
//assign p33_read_updt_val  = (hit_num_index[3:0] == 4'b0110);
//
//always @(posedge lru_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    p33 <= 1'b0; 
//  else if(p33_write_updt)
//    p33 <= p33_write_updt_val;
//  else if(p33_read_updt)
//    p33 <= p33_read_updt_val;
//end 
//  
////Path 34
//assign p34_write_updt     = plru_write_updt
//                         && (refill_num_index[3:1] == 3'b100);
//assign p34_read_updt      = plru_read_updt
//                         && (hit_num_index[3:1] == 3'b100);
//
//assign p34_write_updt_val = (refill_num_index[3:0] == 4'b1000);
//assign p34_read_updt_val  = (hit_num_index[3:0] == 4'b1000);
//
//always @(posedge lru_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    p34 <= 1'b0; 
//  else if(p34_write_updt)
//    p34 <= p34_write_updt_val;
//  else if(p34_read_updt)
//    p34 <= p34_read_updt_val;
//end 
//  
////Path 35
//assign p35_write_updt     = plru_write_updt
//                         && (refill_num_index[3:1] == 3'b101);
//assign p35_read_updt      = plru_read_updt
//                         && (hit_num_index[3:1] == 3'b101);
//
//assign p35_write_updt_val = (refill_num_index[3:0] == 4'b1010);
//assign p35_read_updt_val  = (hit_num_index[3:0] == 4'b1010);
//
//always @(posedge lru_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    p35 <= 1'b0; 
//  else if(p35_write_updt)
//    p35 <= p35_write_updt_val;
//  else if(p35_read_updt)
//    p35 <= p35_read_updt_val;
//end 
//  
////Path 36
//assign p36_write_updt     = plru_write_updt
//                         && (refill_num_index[3:1] == 3'b110);
//assign p36_read_updt      = plru_read_updt
//                         && (hit_num_index[3:1] == 3'b110);
//
//assign p36_write_updt_val = (refill_num_index[3:0] == 4'b1100);
//assign p36_read_updt_val  = (hit_num_index[3:0] == 4'b1100);
//
//always @(posedge lru_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    p36 <= 1'b0; 
//  else if(p36_write_updt)
//    p36 <= p36_write_updt_val;
//  else if(p36_read_updt)
//    p36 <= p36_read_updt_val;
//end 
  
//Path 37
assign p37_write_updt     = plru_write_updt
                         && (refill_num_index[3:1] == 3'b111);
assign p37_read_updt      = plru_read_updt
                         && (hit_num_index[3:1] == 3'b111);

assign p37_write_updt_val = (refill_num_index[3:0] == 4'b1110);
assign p37_read_updt_val  = (hit_num_index[3:0] == 4'b1110);

always @(posedge lru_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    p37 <= 1'b0; 
  else if(p37_write_updt)
    p37 <= p37_write_updt_val;
  else if(p37_read_updt)
    p37 <= p37_read_updt_val;
end 
  
//----------------------------------------------------------
//                  uTLB Replacement Algorithm
//----------------------------------------------------------
assign plru_num[3] =  p00;

assign plru_num[2] = !p00 &&  p10
                   || p00 &&  p11;

assign plru_num[1] = !p00 && !p10 &&  p20
                   ||!p00 &&  p10 &&  p21
                   || p00 && !p11 &&  p22
                   || p00 &&  p11 &&  p23;

assign plru_num[0] = !p00 && !p10 && !p20 && p30
                   ||!p00 && !p10 &&  p20 && p31
                   ||!p00 &&  p10 && !p21 && p32
                   ||!p00 &&  p10 &&  p21 && p33
                   || p00 && !p11 && !p22 && p34
                   || p00 && !p11 &&  p22 && p35
                   || p00 &&  p11 && !p23 && p36
                   || p00 &&  p11 &&  p23 && p37;

// &ModuleEnd; @473
endmodule


