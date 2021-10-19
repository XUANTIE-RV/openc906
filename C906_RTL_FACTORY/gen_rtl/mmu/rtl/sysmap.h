// *****************************************************************************
// *                                                                           *
// * C-Sky Microsystems Confidential                                           *
// * -------------------------------                                           *
// * This file and all its contents are prsrcties of C-Sky Microsystems. The  *
// * information contained herein is confidential and proprietary and is not   *
// * to be disclosed outside of C-Sky Microsystems except under a              *
// * Non-Disclosure Agreement (NDA).                                           *
// *                                                                           *
// *****************************************************************************
// FILE NAME       : ct_mmu_sysmap.vp
// AUTHOR          : Ziyi Hao
// ORIGINAL TIME   :
// FUNCTION        : I-uTLB:
//                 : 1. 16-entry utlb 
//                 : 2. translate Va to PA
//                 : 3. visit jTLB when uTLB miss
//                 : 4. refill uTLB with PLRU algorithm
// RESET           : 
// DFT             :
// DFP             :
// VERIFICATION    :
// RELEASE HISTORY :
// $Id: sysmap.h,v 1.4 2020/10/19 01:03:12 sunc Exp $
// *****************************************************************************

// ADDR is 28-bit, 4K address
// Flag includes: Strong Order, Cacheable, Bufferable, Shareable, Security

  `define SYSMAP_BASE_ADDR0  28'h8ffff
  `define SYSMAP_FLG0        5'b01111
  
  `define SYSMAP_BASE_ADDR1  28'hbffff
  `define SYSMAP_FLG1        5'b10011
  
  `define SYSMAP_BASE_ADDR2  28'hcffff
  `define SYSMAP_FLG2        5'b00011
  
  `define SYSMAP_BASE_ADDR3  28'heffff
  `define SYSMAP_FLG3        5'b01101
  
  `define SYSMAP_BASE_ADDR4  28'hfffff
  `define SYSMAP_FLG4        5'b01111
  
  `define SYSMAP_BASE_ADDR5  28'h3ffffff
  `define SYSMAP_FLG5        5'b01111
  
  `define SYSMAP_BASE_ADDR6  28'h4ffffff 
  `define SYSMAP_FLG6        5'b10010

  `define SYSMAP_BASE_ADDR7  28'hfffffff 
  `define SYSMAP_FLG7        5'b01111

//End ct_mmu_sysmap
