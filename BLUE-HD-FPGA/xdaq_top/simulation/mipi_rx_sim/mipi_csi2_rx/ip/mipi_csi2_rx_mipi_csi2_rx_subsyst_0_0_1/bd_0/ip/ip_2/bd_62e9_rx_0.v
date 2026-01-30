
// (c) Copyright 2014 - 2023 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Advanced Micro Devices, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

`timescale 1ps/1ps
`include "mipi_csi2_rx_ctrl_v1_0_14_defines.v"
(* DowngradeIPIdentifiedWarnings="yes" *)
module bd_62e9_rx_0 #
(
  parameter C_HS_LINE_RATE        =  400 		,
  parameter AXIS_FIFO_DCNT_WIDTH   = 13       	, //8-128,9-256,10-512,11-1024
                                                //12-2048,13-4096
                                                //14-8192,15-16384
  parameter C_CSI2RX_DBG           = 0        	,
  parameter C_DISABLE_LITE         = 0	,   
  parameter CSI_OFFLOAD_NONIMAGE   = 0        ,
  parameter C_CSI_OPT1_REGS        =  0		,
  parameter C_RCVE_DESKEW_SEQ      = "false"	,
  
  parameter C_FAMILY               = "artix7",
  parameter CMN_INC_VFB      = "true"	,
  
  parameter C_S_AXI_ADDR_WIDTH     = 8        	,
  parameter C_S_AXI_DATA_WIDTH     = 32       	,
  parameter C_CSI_OPT2_CRC      = 1			,
  parameter C_CSI_OPT3_FIXEDLANES = 1	,
  parameter CSI_LANES              = 4        		,
  parameter CSI_EN_VC_SUPPORT      = 1        ,
  parameter C_SPRT_ISP_BRIDGE        =  0		,
  
  parameter CSI_FIXED_VC           = 0        ,
  parameter C_CSI_FILTER_USERDATATYPE = 0        ,
  parameter C_EN_VCX               =  "false"		,
  parameter C_EN_CSI_V2_0          =  "true"		,
  
  parameter CSI_VC_OFF_0           = 1        ,
  parameter CSI_VC_OFF_1           = 2        ,
  parameter CSI_VC_OFF_2           = 3        ,
  parameter CSI_VC_OFF_3           = 4        ,
  parameter CSI_VC_OFF_4           = 5        ,
  parameter CSI_VC_OFF_5           = 6        ,
  parameter CSI_VC_OFF_6           = 7        ,
  parameter CSI_VC_OFF_7           = 8        ,
  parameter CSI_VC_OFF_8           = 9        ,
  parameter CSI_VC_OFF_9           = 10        ,
  parameter CSI_VC_OFF_10           = 11        ,
  parameter CSI_VC_OFF_11           = 12        ,
  parameter CSI_VC_OFF_12           = 13        ,
  parameter CSI_VC_OFF_13           = 14        ,
  parameter CSI_VC_OFF_14           = 15        ,
  parameter CSI_INV_SHUTDOWN       = 1        ,
  parameter C_MIPI_SLV_INT          = 0        ,                                            
  parameter AXIS_FIFO_DEPTH        = 8192     ,
  parameter AXIS_TDATA_WIDTH       = 64       ,
  parameter AXIS_TUSER_WIDTH       = 96       ,
  parameter AXIS_TDEST_WIDTH       = 4       
) (
// system
 input            core_clk                            ,
 input            s_axi_aclk                          ,
 input            s_axi_aresetn                       ,
//Slave Interface
 input  [C_S_AXI_ADDR_WIDTH-1:0]    s_axi_awaddr                        ,
 input            s_axi_awvalid                       ,
 output           s_axi_awready                       ,
 input  [31:0]    s_axi_wdata                         ,
 input  [3:0]     s_axi_wstrb                         ,
 input            s_axi_wvalid                        ,
 output           s_axi_wready                        ,
 output [1:0]     s_axi_bresp                         ,
 output           s_axi_bvalid                        ,
 input            s_axi_bready                        ,
 input  [C_S_AXI_ADDR_WIDTH-1:0]    s_axi_araddr                        ,
 input            s_axi_arvalid                       ,
 output           s_axi_arready                       ,
 output [31:0]    s_axi_rdata                         ,
 output [1:0]     s_axi_rresp                         ,
 output           s_axi_rvalid                        ,
 input            s_axi_rready                        ,
//PPI Clock Lane Interface-
 input            cl_stopstate                        ,
 output           cl_enable                           ,
 input            cl_rxulpsclknot                     ,

 input            vfb_full                        ,
 input            vfb_wc_full                     ,
 input            core_men_ack_vfb                ,
 output           core_men_vfb                ,
//PPI Interface-L0
 input            dl0_rxbyteclkhs                     ,
 input  [7:0]     dl0_rxdatahs                        ,
 input            dl0_rxvalidhs                       ,
 input            dl0_rxactivehs                      ,
 input            dl0_rxsynchs                        ,
 input            dl0_stopstate                       ,
 output           dl0_shutdown                        ,
 input            dl0_rxulpmesc                       ,
 input            dl0_errsoths                        ,
 input            dl0_errsotsynchs                    ,
 input            dl0_erresc                          ,
 input            dl0_errcontrol                      ,
//PPI Interface-L1
 input            dl1_rxbyteclkhs                     ,
 input  [7:0]     dl1_rxdatahs                        ,
 input            dl1_rxvalidhs                       ,
 input            dl1_rxactivehs                      ,
 input            dl1_rxsynchs                        ,
 input            dl1_stopstate                       ,
 output           dl1_shutdown                        ,
 input            dl1_rxulpmesc                       ,
 input            dl1_errsoths                        ,
 input            dl1_errsotsynchs                    ,
 input            dl1_erresc                          ,
 input            dl1_errcontrol                      ,
//PPI Interface-L2
 input            dl2_rxbyteclkhs                     ,
 input  [7:0]     dl2_rxdatahs                        ,
 input            dl2_rxvalidhs                       ,
 input            dl2_rxactivehs                      ,
 input            dl2_rxsynchs                        ,
 input            dl2_stopstate                       ,
 output           dl2_shutdown                        ,
 input            dl2_rxulpmesc                       ,
 input            dl2_errsoths                        ,
 input            dl2_errsotsynchs                    ,
 input            dl2_erresc                          ,
 input            dl2_errcontrol                      ,
//PPI Interface-L3
 input            dl3_rxbyteclkhs                     ,
 input  [7:0]     dl3_rxdatahs                        ,
 input            dl3_rxvalidhs                       ,
 input            dl3_rxactivehs                      ,
 input            dl3_rxsynchs                        ,
 input            dl3_stopstate                       ,
 output           dl3_shutdown                        ,
 input            dl3_rxulpmesc                       ,
 input            dl3_errsoths                        ,
 input            dl3_errsotsynchs                    ,
 input            dl3_erresc                          ,
 input            dl3_errcontrol                      ,
 input                               video_aclk      ,
 //AXIS Interface
 input                               m_axis_aclk      ,
 input                               m_axis_aresetn   ,
 input                               m_axis_tready    ,
 output                              m_axis_tvalid    ,
 output                              m_axis_tlast     ,
 output [AXIS_TDATA_WIDTH-1:0]       m_axis_tdata     ,
 output [(AXIS_TDATA_WIDTH/8)-1:0]   m_axis_tkeep     ,
 output [AXIS_TUSER_WIDTH-1:0]       m_axis_tuser     ,
 output [AXIS_TDEST_WIDTH-1:0]       m_axis_tdest     ,
 input mdt_tv ,
 input mdt_tr ,
 input sdt_tv ,
 input sdt_tr ,
 input vfb_tv ,
 input vfb_tr ,
 //Interrupt 
 output                              interrupt, 
 output frame_rcvd_pulse_out

);

mipi_csi2_rx_ctrl_v1_0_14_top  #(
.C_HS_LINE_RATE		           (  400  	)   ,
.C_RCVE_DESKEW_SEQ	           (  "false" 	)   ,
.C_FAMILY	               	   (  "artix7" )   ,
.CMN_INC_VFB		      	   (  "true" 	)   ,
.C_S_AXI_ADDR_WIDTH		   (  8         )   ,
.C_S_AXI_DATA_WIDTH		   (  32         )   ,
.C_CSI_OPT1_REGS		   (  0 	)   ,
.C_CSI_OPT2_CRC			   (  1 	)   ,
.C_CSI_OPT3_FIXEDLANES		   (  1 	)   ,
.CSI_LANES			   (  4         )   ,
.CSI_OFFLOAD_NONIMAGE		   (  0         )   ,
.CSI_EN_VC_SUPPORT	           (  1         )   ,
.C_SPRT_ISP_BRIDGE	           (   "false"	)   ,
.CSI_FIXED_VC		           (  0         )   ,
.C_CSI_FILTER_USERDATATYPE	   (  0         )   ,
.C_EN_VCX		           (   "false"	)   ,
.C_EN_CSI_V2_0			   (   "true"	)   ,
.CSI_VC_OFF_0		           (  1         )   ,
.CSI_VC_OFF_1		           (  2         )   ,
.CSI_VC_OFF_2		           (  3         )   ,
.CSI_VC_OFF_3		           (  4         )   ,
.CSI_VC_OFF_4		           (  5         )   ,
.CSI_VC_OFF_5		           (  6         )   ,
.CSI_VC_OFF_6		           (  7         )   ,
.CSI_VC_OFF_7		           (  8         )   ,
.CSI_VC_OFF_8		           (  9         )   ,
.CSI_VC_OFF_9		           (  10         )   ,
.CSI_VC_OFF_10		           (  11        )   ,
.CSI_VC_OFF_11		           (  12        )   ,
.CSI_VC_OFF_12		           (  13        )   ,
.CSI_VC_OFF_13		           (  14        )   ,
.CSI_VC_OFF_14		           (  15        )   ,
.CSI_INV_SHUTDOWN		   (  1     )   ,
.C_MIPI_SLV_INT		           (  0       )   ,
.C_CSI2RX_DBG		           (  0         )   ,
.AXIS_FIFO_DCNT_WIDTH		   (  13        )   , //8-128,9-256,10-512,11-1024.                                    
                                                      //12-2048,13-4096
                                                      //14-8192,15-16384
.C_DISABLE_LITE		           (  0 )	   ,                                                
.AXIS_FIFO_DEPTH		   (  8192      )   ,
.AXIS_TDATA_WIDTH		   (  64        )   ,
.AXIS_TUSER_WIDTH	           (  96        )   ,
.AXIS_TDEST_WIDTH	           (  4 		)
) mipi_csi2_rx_ctrl_v1_0_14_top_dut (
// system
.core_clk                    (  core_clk        )   ,
.s_axi_aclk                  (  s_axi_aclk      )   ,
.s_axi_aresetn               (  s_axi_aresetn   )   ,
//Slave Interface
.s_axi_awaddr                 (  s_axi_awaddr   )   ,
.s_axi_awvalid                (  s_axi_awvalid  )   ,
.s_axi_awready                (  s_axi_awready  )   ,
.s_axi_wdata                  (  s_axi_wdata    )   ,
.s_axi_wstrb                  (  s_axi_wstrb    )   ,
.s_axi_wvalid                 (  s_axi_wvalid   )   ,
.s_axi_wready                 (  s_axi_wready   )   ,
.s_axi_bresp                  (  s_axi_bresp    )   ,
.s_axi_bvalid                 (  s_axi_bvalid   )   ,
.s_axi_bready                 (  s_axi_bready   )   ,
.s_axi_araddr                 (  s_axi_araddr   )   ,
.s_axi_arvalid                (  s_axi_arvalid  )   ,
.s_axi_arready                (  s_axi_arready  )   ,
.s_axi_rdata                  (  s_axi_rdata    )   ,
.s_axi_rresp                  (  s_axi_rresp    )   ,
.s_axi_rvalid                 (  s_axi_rvalid   )   ,
.s_axi_rready                 (  s_axi_rready   )   ,
//PPI Clock Lane Interface-
.cl_stopstate                (  cl_stopstate    )   ,
.cl_enable                   (  cl_enable       )   ,
.cl_rxulpsclknot             (  cl_rxulpsclknot )   ,

.vfb_full	             (   vfb_full       )   ,
.vfb_wc_full	             (   vfb_wc_full    )   ,
.core_men_ack_vfb	     (   core_men_ack_vfb       )   ,
.core_men_vfb	             (   core_men_vfb         	)   ,
//PPI Interface-L0
.dl0_rxbyteclkhs             ( dl0_rxbyteclkhs        )   ,
.dl0_rxdatahs                ( dl0_rxdatahs            )   ,
.dl0_rxvalidhs               ( dl0_rxvalidhs       	)   ,
.dl0_rxactivehs              ( dl0_rxactivehs       	)   ,
.dl0_rxsynchs                ( dl0_rxsynchs       	)   ,
.dl0_stopstate               ( dl0_stopstate       	)   ,
.dl0_shutdown                ( dl0_shutdown       	)   ,
.dl0_rxulpmesc               ( dl0_rxulpmesc       	)   ,
.dl0_errsoths                ( dl0_errsoths       	)   ,
.dl0_errsotsynchs            ( dl0_errsotsynchs       )   ,
.dl0_erresc                  ( dl0_erresc              )   ,
.dl0_errcontrol              ( dl0_errcontrol        	)   ,
.dl0_rxskewcalhs             ( 1'b0                    )   ,
//PPI Interface-L1
.dl1_rxbyteclkhs             ( dl1_rxbyteclkhs        	)   ,
.dl1_rxdatahs                ( dl1_rxdatahs       	)   ,
.dl1_rxvalidhs               ( dl1_rxvalidhs       	)   ,
.dl1_rxactivehs              ( dl1_rxactivehs       	)   ,
.dl1_rxsynchs                ( dl1_rxsynchs       	)   ,
.dl1_stopstate               ( dl1_stopstate       	)   ,
.dl1_shutdown                ( dl1_shutdown        	)   ,
.dl1_rxulpmesc               ( dl1_rxulpmesc       	)   ,
.dl1_errsoths                ( dl1_errsoths       	)   ,
.dl1_errsotsynchs            ( dl1_errsotsynchs       	)   ,
.dl1_erresc                  ( dl1_erresc              )   ,
.dl1_errcontrol              ( dl1_errcontrol       	)   ,
//PPI Interface-L2
.dl2_rxbyteclkhs             ( dl2_rxbyteclkhs       	)   ,
.dl2_rxdatahs                ( dl2_rxdatahs            )   ,
.dl2_rxvalidhs               ( dl2_rxvalidhs       	)   ,
.dl2_rxactivehs              ( dl2_rxactivehs       	)   ,
.dl2_rxsynchs                ( dl2_rxsynchs       	)   ,
.dl2_stopstate               ( dl2_stopstate       	)   ,
.dl2_shutdown                ( dl2_shutdown       	)   ,
.dl2_rxulpmesc               ( dl2_rxulpmesc       	)   ,
.dl2_errsoths                ( dl2_errsoths        	)   ,
.dl2_errsotsynchs            ( dl2_errsotsynchs       	)   ,
.dl2_erresc                  ( dl2_erresc              )   ,
.dl2_errcontrol              ( dl2_errcontrol       	)   ,
//PPI Interface-L3
.dl3_rxbyteclkhs             ( dl3_rxbyteclkhs        	)   ,
.dl3_rxdatahs                ( dl3_rxdatahs       	)   ,
.dl3_rxvalidhs               ( dl3_rxvalidhs       	)   ,
.dl3_rxactivehs              ( dl3_rxactivehs       	)   ,
.dl3_rxsynchs                ( dl3_rxsynchs       	)   ,
.dl3_stopstate               ( dl3_stopstate       	)   ,
.dl3_shutdown                ( dl3_shutdown       	)   ,
.dl3_rxulpmesc               ( dl3_rxulpmesc        	)   ,
.dl3_errsoths                ( dl3_errsoths       	)   ,
.dl3_errsotsynchs            ( dl3_errsotsynchs       	)   ,
.dl3_erresc                  ( dl3_erresc              )   ,
.dl3_errcontrol              ( dl3_errcontrol       	)   ,
.video_aclk		     ( video_aclk	      	)   ,
 //AXIS Interface
.m_axis_aclk       (m_axis_aclk)   ,
.m_axis_aresetn    (m_axis_aresetn)   ,
.m_axis_tready     (m_axis_tready)   ,
.m_axis_tvalid     (m_axis_tvalid)   ,
.m_axis_tlast      (m_axis_tlast)   ,
.m_axis_tdata      (m_axis_tdata)   ,
.m_axis_tkeep      (m_axis_tkeep)   ,
.m_axis_tuser      (m_axis_tuser)   ,
.m_axis_tdest      (m_axis_tdest)   ,
.m_axis_eni_tready ()   ,
.m_axis_eni_tvalid ()   ,
.m_axis_eni_tlast  ()   ,
.m_axis_eni_tdata  ()   ,
.m_axis_eni_tkeep  ()   ,
.m_axis_eni_tuser  ()   ,
.m_axis_eni_tdest  ()   ,
.mdt_tv ( mdt_tv )   ,
.mdt_tr ( mdt_tr)   ,
.sdt_tv ( sdt_tv)   ,
.sdt_tr ( sdt_tr)   ,
.vfb_tv ( vfb_tv)   ,
.vfb_tr ( vfb_tr)   ,
 //Interrupt 
.interrupt         	 (interrupt		)   ,
.disable_in_progress	 (	)   ,
.ecc_status_intr	 (	)   ,
.crc_status_intr	 (	)   ,
.errsotsynchs_intr	 (	)   ,
.errsoths_intr		 (		)   ,
.linebuffer_full	 (	)   ,
.cl_stopstate_intr	 (	)   ,
.dl0_stopstate_intr	 (	)   ,
.dl1_stopstate_intr	 (	)   ,
.dl2_stopstate_intr	 (	)   ,
.dl3_stopstate_intr	 (	)   ,
.header_data		 (		)   ,
.header_valid 		 (		)   ,
.frame_rcvd_pulse_out	 (frame_rcvd_pulse_out	)
);
endmodule
