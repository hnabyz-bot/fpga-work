

################################################################################
## (c) Copyright 2014 - 2023 Advanced Micro Devices, Inc. All rights reserved.	 
##   	                                						 
## This file contains confidential and proprietary information	 
## of Advanced Micro Devices, Inc. and is protected under U.S. and	        	 
## international copyright and other intellectual property    	 
## laws.							                             
##   							                                 
## DISCLAIMER							                         
## This disclaimer is not a license and does not grant any	     
## rights to the materials distributed herewith. Except as	     
## otherwise provided in a valid license issued to you by	     
## AMD, and to the maximum extent permitted by applicable	
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND	     
## WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES	 
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING	 
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-	     
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and	     
## (2) AMD shall not be liable (whether in contract or tort,	 
## including negligence, or under any other theory of		     
## liability) for any loss or damage of any kind or nature	     
## related to, arising under or in connection with these	     
## materials, including for any direct, or any indirect,	    
## special, incidental, or consequential loss or damage		     
## (including loss of data, profits, goodwill, or any type of	 
## loss or damage suffered as a result of any action brought	 
## by a third party) even if such damage or loss was		     
## reasonably foreseeable or AMD had been advised of the	     
## possibility of the same.					                     
##   							                                 
## CRITICAL APPLICATIONS					                     
## AMD products are not designed or intended to be fail-	     
## safe, or for use in any application requiring fail-safe	     
## performance, such as life-support or safety devices or	     
## systems, Class III medical devices, nuclear facilities,	     
## applications related to the deployment of airbags, or any	  
## other applications that could lead to death, personal	      
## injury, or severe property or environmental damage		     
## (individually and collectively, "Critical			          
## Applications"). Customer assumes the sole risk and		     
## liability of any use of AMD products in Critical		     
## Applications, subject only to applicable laws and	  	     
## regulations governing limitations on product liability.	     
##   							                                 
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS	     
## PART OF THIS FILE AT ALL TIMES. 				                 
################################################################################
## XDC generated for artix7-xc7a35t-fgg484-1 device

## False path constraint for synchronizer
#set_false_path -to [get_pins -hier *cdc_to*/D]

set_disable_timing -from T -to O [get_cells -hierarchical -filter { PRIMITIVE_TYPE == IO.OBUF.OBUFTDS }]
set_false_path -to [get_pins -filter {REF_PIN_NAME=~T1} -of_objects [get_cells -hierarchical -filter { NAME =~ */bd_26df_mipi_dphy_0_0_tx_support_i/master_tx.bd_26df_mipi_dphy_0_0_tx_ioi_i/gen_clk_obuftds_inst.clk_fwd*}]]
set_false_path -to [get_pins -filter {REF_PIN_NAME=~T1} -of_objects [get_cells -hierarchical -filter { NAME =~ */bd_26df_mipi_dphy_0_0_tx_support_i/master_tx.bd_26df_mipi_dphy_0_0_tx_ioi_i/gen_dl0_obuftds_inst.dl0_oserdese2_master*}]]
set_false_path -to [get_pins -filter {REF_PIN_NAME=~T1} -of_objects [get_cells -hierarchical -filter { NAME =~ */bd_26df_mipi_dphy_0_0_tx_support_i/master_tx.bd_26df_mipi_dphy_0_0_tx_ioi_i/dl1_obufds_inst.gen_dl1_obuftds_inst.dl1_oserdese2_master*}]]
set_false_path -to [get_pins -filter {REF_PIN_NAME=~T1} -of_objects [get_cells -hierarchical -filter { NAME =~ */bd_26df_mipi_dphy_0_0_tx_support_i/master_tx.bd_26df_mipi_dphy_0_0_tx_ioi_i/dl2_obufds_inst.gen_dl2_obuftds_inst.dl2_oserdese2_master*}]]
set_false_path -to [get_pins -filter {REF_PIN_NAME=~T1} -of_objects [get_cells -hierarchical -filter { NAME =~ */bd_26df_mipi_dphy_0_0_tx_support_i/master_tx.bd_26df_mipi_dphy_0_0_tx_ioi_i/dl3_obufds_inst.gen_dl3_obuftds_inst.dl3_oserdese2_master*}]]


#################################################
## Rx DE-Skew Related constraints 
#################################################










create_waiver -internal -scope -type CDC -id {CDC-11} -user "mipi_dphy" -tag "1088530" -description "Waiving the CDC-11 , its a condition where same flop output is going to multiple synchrzrs . As the instances are created based on conditions we cannot use same synchrizr & fan-out is bound to happen & it will not cause any functional issue as its taken care in design" -from [get_pins -hier *en_hs_datapath_reg/C]
create_waiver -internal -scope -type CDC -id {CDC-11} -user "mipi_dphy" -tag "1090987" -description "Waiving the CDC-11 , as there are two different cores i.e. CSI2tx/ DSI2 controller ,  DPHY and the fanout to two different synchrzers is inevitable" -from [get_pins -hier *init_done_reg/C]




#################################################
