//-----------------------------------------------------------------------------
// (c) Copyright 2014 - 2023 Advanced Micro Devices, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Advanced Micro Devices, Inc. and is protected under U.S. and 
//  international copyright and other intellectual property
//  laws.
//  
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  AMD, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) AMD shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or AMD had been advised of the
//  possibility of the same.
//  
//  CRITICAL APPLICATIONS
//  AMD products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of AMD products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//  
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES.
//-----------------------------------------------------------------------------
// Filename   : bd_26df_mipi_csi2_tx_ctrl_0_0.ttcl
// Description: MIPI CSI2 TX Wrapper file
//---------------------------------------------------------------------------
`timescale 1ps/1ps
`include "mipi_csi2_tx_ctrl_v1_0_6_defines.v"
(* DowngradeIPIdentifiedWarnings="yes" *)
module bd_26df_mipi_csi2_tx_ctrl_0_0
#(
  parameter C_S_AXI_ADDR_WIDTH        = 7                       ,
  parameter C_S_AXI_DATA_WIDTH        = 32                      ,
  parameter C_AXIS_TDATA_WIDTH        = 48 ,
  parameter C_AXIS_TUSER_WIDTH        = 96 ,
  parameter C_CSI_LANES               = 4 ,
  parameter C_CSI_DATATYPE            = 'h2A ,        
  parameter C_CSI_LINE_BUFR_DEPTH     = 8192 ,      
  parameter C_CSI_CLK_PRE             = 1 ,      
  parameter C_CSI_PIXEL_MODE          = 2 ,   
  parameter C_CSI_EN_ACTIVELANES      = 0 ,   
  parameter C_EN_REG_BASED_FE_GEN     = 0 ,   
  parameter C_CSI_CRC_ENABLE          = 1 ,   
  parameter C_CSI_VID_INTERFACE       = 0    
) (
// system
 input            s_axis_aclk                     ,
 input            s_axis_aresetn                  ,
 output           master_reset_4dphy              ,
//Slave Interface
 input  [7 :0]    s_axi_awaddr                    ,
 input            s_axi_awvalid                   ,
 output           s_axi_awready                   ,
 input  [31:0]    s_axi_wdata                     ,
 input  [3:0]     s_axi_wstrb                     ,
 input            s_axi_wvalid                    ,
 output           s_axi_wready                    ,
 output [1:0]     s_axi_bresp                     ,
 output           s_axi_bvalid                    ,
 input            s_axi_bready                    ,
 input  [7 :0]    s_axi_araddr                    ,
 input            s_axi_arvalid                   ,
 output           s_axi_arready                   ,
 output [31:0]    s_axi_rdata                     ,
 output [1:0]     s_axi_rresp                     ,
 output           s_axi_rvalid                    ,
 input            s_axi_rready                    ,
 input            cl_txclkactive                  ,
 input            dphy_init_done                  ,
 input            dl_tx_stop_st                  ,


 //AXIS Interface
 output                             s_axis_tready ,
 input                              s_axis_tvalid ,
 input                              s_axis_tlast  ,
 input [C_AXIS_TDATA_WIDTH-1:0]     s_axis_tdata  ,
 input [(C_AXIS_TDATA_WIDTH/8)-1:0] s_axis_tkeep  ,
 input [1:0]                        s_axis_tdest  ,
 input [C_AXIS_TUSER_WIDTH-1:0]     s_axis_tuser  ,
 

 //PPI Interface
 input           txbyteclkhs                      ,
 input           txclkesc                         ,
 input           core_clk_in                      ,
 output          cl_enable                        ,
 output          cl_txrequesths                   ,
 output          cl_txulpsclk                     ,
 output          cl_txulpsexit                    ,
 output    [7:0] dl0_txdatahs                     ,
 output          dl0_txrequesths                  ,
 output          dl0_forcetxstopmode              ,
 output          dl0_enable                       ,
 output          dl0_txskewcalhs                  ,
 input           dl0_txreadyhs                    ,
 output          dl0_txulpsesc                    ,  
 output          dl0_txrequestesc                 ,  
 output          dl0_txulpsexit                   ,  
 input           dl0_ulpsactivenot                ,
 

 output    [7:0] dl1_txdatahs                     ,
 output          dl1_txrequesths                  ,
 input           dl1_txreadyhs                    ,
 output          dl1_forcetxstopmode              ,
 output          dl1_enable                       ,
 output          dl1_txulpsesc                    ,  
 output          dl1_txrequestesc                 ,  
 output          dl1_txulpsexit                   ,  
 input           dl1_ulpsactivenot                ,
 output          dl1_txskewcalhs                  ,
 
 output    [7:0] dl2_txdatahs                     ,
 output          dl2_txrequesths                  ,
 input           dl2_txreadyhs                    ,
 output          dl2_forcetxstopmode              ,
 output          dl2_enable                       ,
 output          dl2_txulpsesc                    ,  
 output          dl2_txrequestesc                 ,  
 output          dl2_txulpsexit                   ,  
 input           dl2_ulpsactivenot                ,
 output          dl2_txskewcalhs                  ,

 
 output    [7:0] dl3_txdatahs                     ,
 output          dl3_txrequesths                  ,
 input           dl3_txreadyhs                    ,
 output          dl3_forcetxstopmode              ,
 output          dl3_enable                       ,
 output          dl3_txulpsesc                    ,  
 output          dl3_txrequestesc                 ,  
 output          dl3_txulpsexit                   ,  
 input           dl3_ulpsactivenot                ,
 output          dl3_txskewcalhs                  ,

 //Interrupt 
 output          interrupt         
);

wire master_reset_4dphy_w;

assign master_reset_4dphy = ~master_reset_4dphy_w;

bd_26df_mipi_csi2_tx_ctrl_0_0_core inst 
(
 .s_axis_aclk   (s_axis_aclk      ),
 .s_axis_aresetn(s_axis_aresetn   ),
 .s_axi_awaddr  (s_axi_awaddr     ),
 .s_axi_awvalid (s_axi_awvalid    ),
 .s_axi_awready (s_axi_awready    ),
 .s_axi_wdata   (s_axi_wdata      ),
 .s_axi_wstrb   (s_axi_wstrb      ),
 .s_axi_wvalid  (s_axi_wvalid     ),
 .s_axi_wready  (s_axi_wready     ),
 .s_axi_bresp   (s_axi_bresp      ),
 .s_axi_bvalid  (s_axi_bvalid     ),
 .s_axi_bready  (s_axi_bready     ),
 .s_axi_araddr  (s_axi_araddr     ),
 .s_axi_arvalid (s_axi_arvalid    ),
 .s_axi_arready (s_axi_arready    ),
 .s_axi_rdata   (s_axi_rdata      ),
 .s_axi_rresp   (s_axi_rresp      ),
 .s_axi_rvalid  (s_axi_rvalid     ),
 .s_axi_rready  (s_axi_rready     ),
 .cl_txclkactive(cl_txclkactive   ),
 .dphy_init_done(dphy_init_done   ),
 .dl_tx_stop_st (dl_tx_stop_st    ),
 .s_axis_tready(s_axis_tready      ),
 .s_axis_tvalid(s_axis_tvalid      ),
 .s_axis_tlast (s_axis_tlast       ),
 .s_axis_tdata (s_axis_tdata       ),
 .s_axis_tkeep (s_axis_tkeep       ),
 .s_axis_tdest (s_axis_tdest       ),
 .s_axis_tuser (s_axis_tuser       ),
 
 .txbyteclkhs  (txbyteclkhs        ),       
 .txclkesc  (txclkesc              ),       
 .core_clk_in  (core_clk_in        ),       
 .cl_enable          (cl_enable           ),
 .cl_txrequesths     (cl_txrequesths      ),
 .cl_txulpsclk       (cl_txulpsclk        ),
 .cl_txulpsexit      (cl_txulpsexit       ),
 .dl0_txdatahs       (dl0_txdatahs        ),
 .dl0_txrequesths    (dl0_txrequesths     ),
 .dl0_forcetxstopmode(dl0_forcetxstopmode ),
 .dl0_enable         (dl0_enable          ),
 .dl0_txskewcalhs    (dl0_txskewcalhs      ),  
 .dl0_txreadyhs      (dl0_txreadyhs       ),
 .dl0_txulpsesc      (dl0_txulpsesc       ),
 .dl0_txrequestesc   (dl0_txrequestesc    ),
 .dl0_txulpsexit     (dl0_txulpsexit      ),
 .dl0_ulpsactivenot  (dl0_ulpsactivenot   ),
 
 .dl1_txdatahs       (dl1_txdatahs        ),  
 .dl1_txrequesths    (dl1_txrequesths     ), 
 .dl1_txreadyhs      (dl1_txreadyhs       ), 
 .dl1_forcetxstopmode(dl1_forcetxstopmode ), 
 .dl1_enable         (dl1_enable          ),
 .dl1_txulpsesc      (dl1_txulpsesc       ),
 .dl1_txrequestesc   (dl1_txrequestesc    ),
 .dl1_txulpsexit     (dl1_txulpsexit      ),
 .dl1_ulpsactivenot  (dl1_ulpsactivenot   ), 
 .dl1_txskewcalhs    (dl1_txskewcalhs      ),  
 
 .dl2_txdatahs        (dl2_txdatahs        ), 
 .dl2_txrequesths     (dl2_txrequesths     ), 
 .dl2_txreadyhs       (dl2_txreadyhs       ), 
 .dl2_forcetxstopmode (dl2_forcetxstopmode ), 
 .dl2_enable          (dl2_enable          ),
 .dl2_txulpsesc       (dl2_txulpsesc       ),
 .dl2_txrequestesc    (dl2_txrequestesc    ),
 .dl2_txulpsexit      (dl2_txulpsexit      ),
 .dl2_ulpsactivenot   (dl2_ulpsactivenot   ), 
 .dl2_txskewcalhs    (dl2_txskewcalhs      ),  
 
 .dl3_txdatahs        (dl3_txdatahs        ), 
 .dl3_txrequesths     (dl3_txrequesths     ), 
 .dl3_txreadyhs       (dl3_txreadyhs       ), 
 .dl3_forcetxstopmode (dl3_forcetxstopmode ), 
 .dl3_enable          (dl3_enable          ),
 .dl3_txulpsesc       (dl3_txulpsesc       ),
 .dl3_txrequestesc    (dl3_txrequestesc    ),
 .dl3_txulpsexit      (dl3_txulpsexit      ),
 .dl3_ulpsactivenot   (dl3_ulpsactivenot   ),
 .dl3_txskewcalhs    (dl3_txskewcalhs      ),  
 //Interrupt 
 .master_reset_4dphy  (master_reset_4dphy_w  ),
 .interrupt           (interrupt           )
);
endmodule
                                   

