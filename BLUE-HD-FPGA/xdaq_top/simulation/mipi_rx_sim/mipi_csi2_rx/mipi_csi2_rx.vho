-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
-- -------------------------------------------------------------------------------
-- This file contains confidential and proprietary information
-- of AMD and is protected under U.S. and international copyright
-- and other intellectual property laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- AMD, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) AMD shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or AMD had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- AMD products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of AMD products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
--
-- DO NOT MODIFY THIS FILE.

-- MODULE VLNV: amd.com:blockdesign:mipi_csi2_rx:1.0

-- The following code must appear in the VHDL architecture header.

-- COMP_TAG     ------ Begin cut for COMPONENT Declaration ------
COMPONENT mipi_csi2_rx
  PORT (
    mipi_phy_if_0_clk_hs_n : IN STD_LOGIC;
    mipi_phy_if_0_clk_hs_p : IN STD_LOGIC;
    mipi_phy_if_0_clk_lp_n : IN STD_LOGIC;
    mipi_phy_if_0_clk_lp_p : IN STD_LOGIC;
    mipi_phy_if_0_data_hs_n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    mipi_phy_if_0_data_hs_p : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    mipi_phy_if_0_data_lp_n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    mipi_phy_if_0_data_lp_p : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    clk_100MHz : IN STD_LOGIC;
    done : OUT STD_LOGIC;
    done_1 : OUT STD_LOGIC;
    reset_rtl_0 : IN STD_LOGIC;
    rxbyteclkhs : OUT STD_LOGIC;
    status : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    status_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    video_out_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    video_out_tdest : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    video_out_tlast : OUT STD_LOGIC;
    video_out_tvalid : OUT STD_LOGIC;
    video_out_tuser_0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;
-- COMP_TAG_END ------  End cut for COMPONENT Declaration  ------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

-- INST_TAG     ------ Begin cut for INSTANTIATION Template ------
your_instance_name : mipi_csi2_rx
  PORT MAP (
    mipi_phy_if_0_clk_hs_n => mipi_phy_if_0_clk_hs_n,
    mipi_phy_if_0_clk_hs_p => mipi_phy_if_0_clk_hs_p,
    mipi_phy_if_0_clk_lp_n => mipi_phy_if_0_clk_lp_n,
    mipi_phy_if_0_clk_lp_p => mipi_phy_if_0_clk_lp_p,
    mipi_phy_if_0_data_hs_n => mipi_phy_if_0_data_hs_n,
    mipi_phy_if_0_data_hs_p => mipi_phy_if_0_data_hs_p,
    mipi_phy_if_0_data_lp_n => mipi_phy_if_0_data_lp_n,
    mipi_phy_if_0_data_lp_p => mipi_phy_if_0_data_lp_p,
    clk_100MHz => clk_100MHz,
    done => done,
    done_1 => done_1,
    reset_rtl_0 => reset_rtl_0,
    rxbyteclkhs => rxbyteclkhs,
    status => status,
    status_1 => status_1,
    video_out_tdata => video_out_tdata,
    video_out_tdest => video_out_tdest,
    video_out_tlast => video_out_tlast,
    video_out_tvalid => video_out_tvalid,
    video_out_tuser_0 => video_out_tuser_0
  );
-- INST_TAG_END ------  End cut for INSTANTIATION Template  ------

-- You must compile the wrapper file mipi_csi2_rx.vhd when simulating
-- the module, mipi_csi2_rx. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.
