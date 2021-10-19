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

// &ModuleBeg; @24
module aq_vfmau_frac_shift_double(
  ex2_data_for_shift,
  ex2_shift_data_out,
  ex2_shift_index
);

// &Ports; @25
input   [52 :0]  ex2_data_for_shift; 
input   [6  :0]  ex2_shift_index;   
output  [110:0]  ex2_shift_data_out; 

// &Regs; @26
reg     [110:0]  shift_data;        

// &Wires; @27
wire    [110:0]  data_for_shift;    
wire    [52 :0]  ex2_data_for_shift; 
wire    [110:0]  ex2_shift_data_out; 
wire    [6  :0]  ex2_shift_index;   
wire    [6  :0]  shift_index;       


parameter DATA_WIDTH  = 111;
parameter DOUBLE_FRAC =  52;
parameter SINGLE_FRAC =  23;

assign data_for_shift[DATA_WIDTH-1:0] = {1'b0,ex2_data_for_shift[DOUBLE_FRAC:0], {DOUBLE_FRAC{1'b0}}, 5'b0};

assign shift_index[6:0] = ex2_shift_index[6:0];

// &CombBeg; @43
always @( data_for_shift[110: 54]
       or data_for_shift[110: 18]
       or data_for_shift[110: 90]
       or data_for_shift[110: 24]
       or data_for_shift[110: 95]
       or data_for_shift[110: 13]
       or data_for_shift[110: 29]
       or data_for_shift[110: 49]
       or data_for_shift[110: 41]
       or data_for_shift[110: 28]
       or data_for_shift[110: 77]
       or data_for_shift[110: 26]
       or data_for_shift[110: 65]
       or data_for_shift[110: 83]
       or data_for_shift[92:0]
       or data_for_shift[110: 91]
       or data_for_shift[110: 48]
       or data_for_shift[110: 85]
       or data_for_shift[110: 51]
       or data_for_shift[110: 45]
       or data_for_shift[110: 22]
       or data_for_shift[110: 62]
       or data_for_shift[110: 76]
       or data_for_shift[110: 17]
       or data_for_shift[110: 21]
       or data_for_shift[110: 87]
       or data_for_shift[110: 99]
       or data_for_shift[110: 94]
       or data_for_shift[110:  9]
       or data_for_shift[110: 86]
       or data_for_shift[110: 15]
       or data_for_shift[110: 42]
       or data_for_shift[110: 53]
       or data_for_shift[110: 14]
       or data_for_shift[110: 60]
       or data_for_shift[110: 88]
       or data_for_shift[110:0]
       or data_for_shift[110: 68]
       or data_for_shift[110: 71]
       or data_for_shift[110:  1]
       or data_for_shift[110: 79]
       or data_for_shift[110: 23]
       or data_for_shift[110: 69]
       or data_for_shift[110: 61]
       or data_for_shift[110: 31]
       or data_for_shift[110:  8]
       or data_for_shift[110: 66]
       or data_for_shift[110: 58]
       or data_for_shift[110: 78]
       or data_for_shift[110: 52]
       or data_for_shift[110: 80]
       or data_for_shift[110:  3]
       or data_for_shift[110: 50]
       or data_for_shift[110: 84]
       or data_for_shift[110: 55]
       or data_for_shift[110: 75]
       or data_for_shift[110: 34]
       or data_for_shift[110: 93]
       or data_for_shift[110:  7]
       or data_for_shift[110: 33]
       or data_for_shift[110: 10]
       or data_for_shift[110: 97]
       or data_for_shift[110: 19]
       or data_for_shift[110: 43]
       or data_for_shift[110: 64]
       or data_for_shift[110:  4]
       or data_for_shift[110: 30]
       or data_for_shift[110: 25]
       or data_for_shift[110: 92]
       or data_for_shift[110: 44]
       or data_for_shift[110: 40]
       or data_for_shift[110:  6]
       or data_for_shift[110: 82]
       or data_for_shift[110: 98]
       or data_for_shift[110: 46]
       or data_for_shift[110: 81]
       or data_for_shift[110: 72]
       or data_for_shift[110: 20]
       or data_for_shift[110: 39]
       or data_for_shift[110: 57]
       or data_for_shift[110: 96]
       or data_for_shift[110: 47]
       or data_for_shift[110: 56]
       or data_for_shift[110: 67]
       or data_for_shift[110: 11]
       or data_for_shift[110:  5]
       or data_for_shift[110: 59]
       or data_for_shift[110: 37]
       or data_for_shift[110: 89]
       or shift_index[6:0]
       or data_for_shift[110: 12]
       or data_for_shift[110: 16]
       or data_for_shift[110:  2]
       or data_for_shift[110: 70]
       or data_for_shift[110: 74]
       or data_for_shift[110: 27]
       or data_for_shift[110: 73]
       or data_for_shift[110: 63]
       or data_for_shift[110: 38]
       or data_for_shift[110: 32]
       or data_for_shift[110: 35]
       or data_for_shift[110: 36])
begin
case(shift_index[6:0])
7'b000_0000: shift_data[DATA_WIDTH-1:0] =  {            data_for_shift[DATA_WIDTH-1:  1], data_for_shift[0]    };
7'b000_0001: shift_data[DATA_WIDTH-1:0] =  {{  1{1'b0}},data_for_shift[DATA_WIDTH-1:  2],|data_for_shift[1  :0]};
7'b000_0010: shift_data[DATA_WIDTH-1:0] =  {{  2{1'b0}},data_for_shift[DATA_WIDTH-1:  3],|data_for_shift[2  :0]};
7'b000_0011: shift_data[DATA_WIDTH-1:0] =  {{  3{1'b0}},data_for_shift[DATA_WIDTH-1:  4],|data_for_shift[3  :0]};
7'b000_0100: shift_data[DATA_WIDTH-1:0] =  {{  4{1'b0}},data_for_shift[DATA_WIDTH-1:  5],|data_for_shift[4  :0]};
7'b000_0101: shift_data[DATA_WIDTH-1:0] =  {{  5{1'b0}},data_for_shift[DATA_WIDTH-1:  6],|data_for_shift[5  :0]};
7'b000_0110: shift_data[DATA_WIDTH-1:0] =  {{  6{1'b0}},data_for_shift[DATA_WIDTH-1:  7],|data_for_shift[6  :0]};
7'b000_0111: shift_data[DATA_WIDTH-1:0] =  {{  7{1'b0}},data_for_shift[DATA_WIDTH-1:  8],|data_for_shift[7  :0]};
7'b000_1000: shift_data[DATA_WIDTH-1:0] =  {{  8{1'b0}},data_for_shift[DATA_WIDTH-1:  9],|data_for_shift[8  :0]};
7'b000_1001: shift_data[DATA_WIDTH-1:0] =  {{  9{1'b0}},data_for_shift[DATA_WIDTH-1: 10],|data_for_shift[9  :0]};
7'b000_1010: shift_data[DATA_WIDTH-1:0] =  {{ 10{1'b0}},data_for_shift[DATA_WIDTH-1: 11],|data_for_shift[10 :0]};
7'b000_1011: shift_data[DATA_WIDTH-1:0] =  {{ 11{1'b0}},data_for_shift[DATA_WIDTH-1: 12],|data_for_shift[11 :0]};
7'b000_1100: shift_data[DATA_WIDTH-1:0] =  {{ 12{1'b0}},data_for_shift[DATA_WIDTH-1: 13],|data_for_shift[12 :0]};
7'b000_1101: shift_data[DATA_WIDTH-1:0] =  {{ 13{1'b0}},data_for_shift[DATA_WIDTH-1: 14],|data_for_shift[13 :0]};
7'b000_1110: shift_data[DATA_WIDTH-1:0] =  {{ 14{1'b0}},data_for_shift[DATA_WIDTH-1: 15],|data_for_shift[14 :0]};
7'b000_1111: shift_data[DATA_WIDTH-1:0] =  {{ 15{1'b0}},data_for_shift[DATA_WIDTH-1: 16],|data_for_shift[15 :0]};
7'b001_0000: shift_data[DATA_WIDTH-1:0] =  {{ 16{1'b0}},data_for_shift[DATA_WIDTH-1: 17],|data_for_shift[16 :0]};
7'b001_0001: shift_data[DATA_WIDTH-1:0] =  {{ 17{1'b0}},data_for_shift[DATA_WIDTH-1: 18],|data_for_shift[17 :0]};
7'b001_0010: shift_data[DATA_WIDTH-1:0] =  {{ 18{1'b0}},data_for_shift[DATA_WIDTH-1: 19],|data_for_shift[18 :0]};
7'b001_0011: shift_data[DATA_WIDTH-1:0] =  {{ 19{1'b0}},data_for_shift[DATA_WIDTH-1: 20],|data_for_shift[19 :0]};
7'b001_0100: shift_data[DATA_WIDTH-1:0] =  {{ 20{1'b0}},data_for_shift[DATA_WIDTH-1: 21],|data_for_shift[20 :0]};
7'b001_0101: shift_data[DATA_WIDTH-1:0] =  {{ 21{1'b0}},data_for_shift[DATA_WIDTH-1: 22],|data_for_shift[21 :0]};
7'b001_0110: shift_data[DATA_WIDTH-1:0] =  {{ 22{1'b0}},data_for_shift[DATA_WIDTH-1: 23],|data_for_shift[22 :0]};
7'b001_0111: shift_data[DATA_WIDTH-1:0] =  {{ 23{1'b0}},data_for_shift[DATA_WIDTH-1: 24],|data_for_shift[23 :0]};
7'b001_1000: shift_data[DATA_WIDTH-1:0] =  {{ 24{1'b0}},data_for_shift[DATA_WIDTH-1: 25],|data_for_shift[24 :0]};
7'b001_1001: shift_data[DATA_WIDTH-1:0] =  {{ 25{1'b0}},data_for_shift[DATA_WIDTH-1: 26],|data_for_shift[25 :0]};
7'b001_1010: shift_data[DATA_WIDTH-1:0] =  {{ 26{1'b0}},data_for_shift[DATA_WIDTH-1: 27],|data_for_shift[26 :0]};
7'b001_1011: shift_data[DATA_WIDTH-1:0] =  {{ 27{1'b0}},data_for_shift[DATA_WIDTH-1: 28],|data_for_shift[27 :0]};
7'b001_1100: shift_data[DATA_WIDTH-1:0] =  {{ 28{1'b0}},data_for_shift[DATA_WIDTH-1: 29],|data_for_shift[28 :0]};
7'b001_1101: shift_data[DATA_WIDTH-1:0] =  {{ 29{1'b0}},data_for_shift[DATA_WIDTH-1: 30],|data_for_shift[29 :0]};
7'b001_1110: shift_data[DATA_WIDTH-1:0] =  {{ 30{1'b0}},data_for_shift[DATA_WIDTH-1: 31],|data_for_shift[30 :0]};
7'b001_1111: shift_data[DATA_WIDTH-1:0] =  {{ 31{1'b0}},data_for_shift[DATA_WIDTH-1: 32],|data_for_shift[31 :0]};
7'b010_0000: shift_data[DATA_WIDTH-1:0] =  {{ 32{1'b0}},data_for_shift[DATA_WIDTH-1: 33],|data_for_shift[32 :0]};
7'b010_0001: shift_data[DATA_WIDTH-1:0] =  {{ 33{1'b0}},data_for_shift[DATA_WIDTH-1: 34],|data_for_shift[33 :0]};
7'b010_0010: shift_data[DATA_WIDTH-1:0] =  {{ 34{1'b0}},data_for_shift[DATA_WIDTH-1: 35],|data_for_shift[34 :0]};
7'b010_0011: shift_data[DATA_WIDTH-1:0] =  {{ 35{1'b0}},data_for_shift[DATA_WIDTH-1: 36],|data_for_shift[35 :0]};
7'b010_0100: shift_data[DATA_WIDTH-1:0] =  {{ 36{1'b0}},data_for_shift[DATA_WIDTH-1: 37],|data_for_shift[36 :0]};
7'b010_0101: shift_data[DATA_WIDTH-1:0] =  {{ 37{1'b0}},data_for_shift[DATA_WIDTH-1: 38],|data_for_shift[37 :0]};
7'b010_0110: shift_data[DATA_WIDTH-1:0] =  {{ 38{1'b0}},data_for_shift[DATA_WIDTH-1: 39],|data_for_shift[38 :0]};
7'b010_0111: shift_data[DATA_WIDTH-1:0] =  {{ 39{1'b0}},data_for_shift[DATA_WIDTH-1: 40],|data_for_shift[39 :0]};
7'b010_1000: shift_data[DATA_WIDTH-1:0] =  {{ 40{1'b0}},data_for_shift[DATA_WIDTH-1: 41],|data_for_shift[40 :0]};
7'b010_1001: shift_data[DATA_WIDTH-1:0] =  {{ 41{1'b0}},data_for_shift[DATA_WIDTH-1: 42],|data_for_shift[41 :0]};
7'b010_1010: shift_data[DATA_WIDTH-1:0] =  {{ 42{1'b0}},data_for_shift[DATA_WIDTH-1: 43],|data_for_shift[42 :0]};
7'b010_1011: shift_data[DATA_WIDTH-1:0] =  {{ 43{1'b0}},data_for_shift[DATA_WIDTH-1: 44],|data_for_shift[43 :0]};
7'b010_1100: shift_data[DATA_WIDTH-1:0] =  {{ 44{1'b0}},data_for_shift[DATA_WIDTH-1: 45],|data_for_shift[44 :0]};
7'b010_1101: shift_data[DATA_WIDTH-1:0] =  {{ 45{1'b0}},data_for_shift[DATA_WIDTH-1: 46],|data_for_shift[45 :0]};
7'b010_1110: shift_data[DATA_WIDTH-1:0] =  {{ 46{1'b0}},data_for_shift[DATA_WIDTH-1: 47],|data_for_shift[46 :0]};
7'b010_1111: shift_data[DATA_WIDTH-1:0] =  {{ 47{1'b0}},data_for_shift[DATA_WIDTH-1: 48],|data_for_shift[47 :0]};
7'b011_0000: shift_data[DATA_WIDTH-1:0] =  {{ 48{1'b0}},data_for_shift[DATA_WIDTH-1: 49],|data_for_shift[48 :0]};
7'b011_0001: shift_data[DATA_WIDTH-1:0] =  {{ 49{1'b0}},data_for_shift[DATA_WIDTH-1: 50],|data_for_shift[49 :0]};
7'b011_0010: shift_data[DATA_WIDTH-1:0] =  {{ 50{1'b0}},data_for_shift[DATA_WIDTH-1: 51],|data_for_shift[50 :0]};
7'b011_0011: shift_data[DATA_WIDTH-1:0] =  {{ 51{1'b0}},data_for_shift[DATA_WIDTH-1: 52],|data_for_shift[51 :0]};
7'b011_0100: shift_data[DATA_WIDTH-1:0] =  {{ 52{1'b0}},data_for_shift[DATA_WIDTH-1: 53],|data_for_shift[52 :0]};
7'b011_0101: shift_data[DATA_WIDTH-1:0] =  {{ 53{1'b0}},data_for_shift[DATA_WIDTH-1: 54],|data_for_shift[53 :0]};
7'b011_0110: shift_data[DATA_WIDTH-1:0] =  {{ 54{1'b0}},data_for_shift[DATA_WIDTH-1: 55],|data_for_shift[54 :0]};
7'b011_0111: shift_data[DATA_WIDTH-1:0] =  {{ 55{1'b0}},data_for_shift[DATA_WIDTH-1: 56],|data_for_shift[55 :0]};
7'b011_1000: shift_data[DATA_WIDTH-1:0] =  {{ 56{1'b0}},data_for_shift[DATA_WIDTH-1: 57],|data_for_shift[56 :0]};
7'b011_1001: shift_data[DATA_WIDTH-1:0] =  {{ 57{1'b0}},data_for_shift[DATA_WIDTH-1: 58],|data_for_shift[57 :0]};
7'b011_1010: shift_data[DATA_WIDTH-1:0] =  {{ 58{1'b0}},data_for_shift[DATA_WIDTH-1: 59],|data_for_shift[58 :0]};
7'b011_1011: shift_data[DATA_WIDTH-1:0] =  {{ 59{1'b0}},data_for_shift[DATA_WIDTH-1: 60],|data_for_shift[59 :0]};
7'b011_1100: shift_data[DATA_WIDTH-1:0] =  {{ 60{1'b0}},data_for_shift[DATA_WIDTH-1: 61],|data_for_shift[60 :0]};
7'b011_1101: shift_data[DATA_WIDTH-1:0] =  {{ 61{1'b0}},data_for_shift[DATA_WIDTH-1: 62],|data_for_shift[61 :0]};
7'b011_1110: shift_data[DATA_WIDTH-1:0] =  {{ 62{1'b0}},data_for_shift[DATA_WIDTH-1: 63],|data_for_shift[62 :0]};
7'b011_1111: shift_data[DATA_WIDTH-1:0] =  {{ 63{1'b0}},data_for_shift[DATA_WIDTH-1: 64],|data_for_shift[63 :0]};
7'b100_0000: shift_data[DATA_WIDTH-1:0] =  {{ 64{1'b0}},data_for_shift[DATA_WIDTH-1: 65],|data_for_shift[64 :0]};
7'b100_0001: shift_data[DATA_WIDTH-1:0] =  {{ 65{1'b0}},data_for_shift[DATA_WIDTH-1: 66],|data_for_shift[65 :0]};
7'b100_0010: shift_data[DATA_WIDTH-1:0] =  {{ 66{1'b0}},data_for_shift[DATA_WIDTH-1: 67],|data_for_shift[66 :0]};
7'b100_0011: shift_data[DATA_WIDTH-1:0] =  {{ 67{1'b0}},data_for_shift[DATA_WIDTH-1: 68],|data_for_shift[67 :0]};
7'b100_0100: shift_data[DATA_WIDTH-1:0] =  {{ 68{1'b0}},data_for_shift[DATA_WIDTH-1: 69],|data_for_shift[68 :0]};
7'b100_0101: shift_data[DATA_WIDTH-1:0] =  {{ 69{1'b0}},data_for_shift[DATA_WIDTH-1: 70],|data_for_shift[69 :0]};
7'b100_0110: shift_data[DATA_WIDTH-1:0] =  {{ 70{1'b0}},data_for_shift[DATA_WIDTH-1: 71],|data_for_shift[70 :0]};
7'b100_0111: shift_data[DATA_WIDTH-1:0] =  {{ 71{1'b0}},data_for_shift[DATA_WIDTH-1: 72],|data_for_shift[71 :0]};
7'b100_1000: shift_data[DATA_WIDTH-1:0] =  {{ 72{1'b0}},data_for_shift[DATA_WIDTH-1: 73],|data_for_shift[72 :0]};
7'b100_1001: shift_data[DATA_WIDTH-1:0] =  {{ 73{1'b0}},data_for_shift[DATA_WIDTH-1: 74],|data_for_shift[73 :0]};
7'b100_1010: shift_data[DATA_WIDTH-1:0] =  {{ 74{1'b0}},data_for_shift[DATA_WIDTH-1: 75],|data_for_shift[74 :0]};
7'b100_1011: shift_data[DATA_WIDTH-1:0] =  {{ 75{1'b0}},data_for_shift[DATA_WIDTH-1: 76],|data_for_shift[75 :0]};
7'b100_1100: shift_data[DATA_WIDTH-1:0] =  {{ 76{1'b0}},data_for_shift[DATA_WIDTH-1: 77],|data_for_shift[76 :0]};
7'b100_1101: shift_data[DATA_WIDTH-1:0] =  {{ 77{1'b0}},data_for_shift[DATA_WIDTH-1: 78],|data_for_shift[77 :0]};
7'b100_1110: shift_data[DATA_WIDTH-1:0] =  {{ 78{1'b0}},data_for_shift[DATA_WIDTH-1: 79],|data_for_shift[78 :0]};
7'b100_1111: shift_data[DATA_WIDTH-1:0] =  {{ 79{1'b0}},data_for_shift[DATA_WIDTH-1: 80],|data_for_shift[79 :0]};
7'b101_0000: shift_data[DATA_WIDTH-1:0] =  {{ 80{1'b0}},data_for_shift[DATA_WIDTH-1: 81],|data_for_shift[80 :0]};
7'b101_0001: shift_data[DATA_WIDTH-1:0] =  {{ 81{1'b0}},data_for_shift[DATA_WIDTH-1: 82],|data_for_shift[81 :0]};
7'b101_0010: shift_data[DATA_WIDTH-1:0] =  {{ 82{1'b0}},data_for_shift[DATA_WIDTH-1: 83],|data_for_shift[82 :0]};
7'b101_0011: shift_data[DATA_WIDTH-1:0] =  {{ 83{1'b0}},data_for_shift[DATA_WIDTH-1: 84],|data_for_shift[83 :0]};
7'b101_0100: shift_data[DATA_WIDTH-1:0] =  {{ 84{1'b0}},data_for_shift[DATA_WIDTH-1: 85],|data_for_shift[84 :0]};
7'b101_0101: shift_data[DATA_WIDTH-1:0] =  {{ 85{1'b0}},data_for_shift[DATA_WIDTH-1: 86],|data_for_shift[85 :0]};
7'b101_0110: shift_data[DATA_WIDTH-1:0] =  {{ 86{1'b0}},data_for_shift[DATA_WIDTH-1: 87],|data_for_shift[86 :0]};
7'b101_0111: shift_data[DATA_WIDTH-1:0] =  {{ 87{1'b0}},data_for_shift[DATA_WIDTH-1: 88],|data_for_shift[87 :0]};
7'b101_1000: shift_data[DATA_WIDTH-1:0] =  {{ 88{1'b0}},data_for_shift[DATA_WIDTH-1: 89],|data_for_shift[88 :0]};
7'b101_1001: shift_data[DATA_WIDTH-1:0] =  {{ 89{1'b0}},data_for_shift[DATA_WIDTH-1: 90],|data_for_shift[89 :0]};
7'b101_1010: shift_data[DATA_WIDTH-1:0] =  {{ 90{1'b0}},data_for_shift[DATA_WIDTH-1: 91],|data_for_shift[90 :0]};
7'b101_1011: shift_data[DATA_WIDTH-1:0] =  {{ 91{1'b0}},data_for_shift[DATA_WIDTH-1: 92],|data_for_shift[91 :0]};
7'b101_1100: shift_data[DATA_WIDTH-1:0] =  {{ 92{1'b0}},data_for_shift[DATA_WIDTH-1: 93],|data_for_shift[92 :0]};
7'b101_1101: shift_data[DATA_WIDTH-1:0] =  {{ 93{1'b0}},data_for_shift[DATA_WIDTH-1: 94],|data_for_shift[93 :0]};
7'b101_1110: shift_data[DATA_WIDTH-1:0] =  {{ 94{1'b0}},data_for_shift[DATA_WIDTH-1: 95],|data_for_shift[94 :0]};
7'b101_1111: shift_data[DATA_WIDTH-1:0] =  {{ 95{1'b0}},data_for_shift[DATA_WIDTH-1: 96],|data_for_shift[95 :0]};
7'b110_0000: shift_data[DATA_WIDTH-1:0] =  {{ 96{1'b0}},data_for_shift[DATA_WIDTH-1: 97],|data_for_shift[96 :0]};
7'b110_0001: shift_data[DATA_WIDTH-1:0] =  {{ 97{1'b0}},data_for_shift[DATA_WIDTH-1: 98],|data_for_shift[97 :0]};
7'b110_0010: shift_data[DATA_WIDTH-1:0] =  {{ 98{1'b0}},data_for_shift[DATA_WIDTH-1: 99],|data_for_shift[98 :0]};
7'b110_0011: shift_data[DATA_WIDTH-1:0] =  {{ 99{1'b0}},data_for_shift[DATA_WIDTH-1:100],|data_for_shift[99 :0]};
7'b110_0100: shift_data[DATA_WIDTH-1:0] =  {{100{1'b0}},data_for_shift[DATA_WIDTH-1:101],|data_for_shift[100:0]};
7'b110_0101: shift_data[DATA_WIDTH-1:0] =  {{101{1'b0}},data_for_shift[DATA_WIDTH-1:102],|data_for_shift[101:0]};
7'b110_0110: shift_data[DATA_WIDTH-1:0] =  {{102{1'b0}},data_for_shift[DATA_WIDTH-1:103],|data_for_shift[102:0]};
7'b110_0111: shift_data[DATA_WIDTH-1:0] =  {{103{1'b0}},data_for_shift[DATA_WIDTH-1:104],|data_for_shift[103:0]};
7'b110_1000: shift_data[DATA_WIDTH-1:0] =  {{104{1'b0}},data_for_shift[DATA_WIDTH-1:105],|data_for_shift[104:0]};
7'b110_1001: shift_data[DATA_WIDTH-1:0] =  {{105{1'b0}},data_for_shift[DATA_WIDTH-1:106],|data_for_shift[105:0]};
7'b110_1010: shift_data[DATA_WIDTH-1:0] =  {{106{1'b0}},data_for_shift[DATA_WIDTH-1:107],|data_for_shift[106:0]};
7'b110_1011: shift_data[DATA_WIDTH-1:0] =  {{107{1'b0}},data_for_shift[DATA_WIDTH-1:108],|data_for_shift[107:0]};
7'b110_1100: shift_data[DATA_WIDTH-1:0] =  {{108{1'b0}},data_for_shift[DATA_WIDTH-1:109],|data_for_shift[108:0]};
7'b110_1101: shift_data[DATA_WIDTH-1:0] =  {{109{1'b0}},data_for_shift[DATA_WIDTH-1:110],|data_for_shift[109:0]};
    default: shift_data[DATA_WIDTH-1:0] =  {DATA_WIDTH{1'bx}};
endcase
// &CombEnd; @157
end

assign ex2_shift_data_out[DATA_WIDTH-1:0] = shift_data[DATA_WIDTH-1:0];   

// &ModuleEnd; @161
endmodule



