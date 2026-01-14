namespace eval ::optrace {
  variable script "D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/xdaq_top.runs/impl_1/blue_hd_top.tcl"
  variable category "vivado_impl"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    } elseif { [info exist ::env(HOST)] } {
      set host $::env(HOST)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
OPTRACE "impl_1" END { }
}


OPTRACE "impl_1" START { ROLLUP_1 }
OPTRACE "Phase: Init Design" START { ROLLUP_AUTO }
start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param chipscope.maxJobs 5
  set_param runs.launchOptions { -jobs 10  }
OPTRACE "create in-memory project" START { }
  create_project -in_memory -part xc7a35tfgg484-1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
OPTRACE "create in-memory project" END { }
OPTRACE "set parameters" START { }
  set_property webtalk.parent_dir D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/xdaq_top.cache/wt [current_project]
  set_property parent.project_path D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/xdaq_top.xpr [current_project]
  set_property ip_output_repo D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/xdaq_top.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_FIFO XPM_MEMORY} [current_project]
OPTRACE "set parameters" END { }
OPTRACE "add files" START { }
  add_files -quiet D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/xdaq_top.runs/synth_1/blue_hd_top.dcp
  read_ip -quiet D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/hdl/csi2/ip/rst_clk_200M/rst_clk_200M.xci
  read_ip -quiet D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/ip/clk_ctrl/clk_ctrl.xci
  read_ip -quiet D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/hdl/csi2/ip/mipi_init_gen/mipi_init_gen.xci
  read_ip -quiet D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/ip/indata_ram/indata_ram.xci
  read_ip -quiet D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/hdl/csi2/ip/axis_data_fifo_0/axis_data_fifo_0.xci
  read_ip -quiet D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/ip/seq_lut/seq_lut.xci
  read_ip -quiet D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/hdl/csi2/ip/mipi_csi2_tx_subsys/mipi_csi2_tx_subsys.xci
OPTRACE "read constraints: implementation" START { }
  read_xdc D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/constrs/timing.xdc
  read_xdc D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/source/constrs/blue_hd_top.xdc
OPTRACE "read constraints: implementation" END { }
OPTRACE "read constraints: implementation_pre" START { }
OPTRACE "read constraints: implementation_pre" END { }
OPTRACE "add files" END { }
OPTRACE "link_design" START { }
  link_design -top blue_hd_top -part xc7a35tfgg484-1 
OPTRACE "link_design" END { }
OPTRACE "gray box cells" START { }
OPTRACE "gray box cells" END { }
OPTRACE "init_design_reports" START { REPORT }
OPTRACE "init_design_reports" END { }
OPTRACE "init_design_write_hwdef" START { }
OPTRACE "init_design_write_hwdef" END { }
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

OPTRACE "Phase: Init Design" END { }
OPTRACE "Phase: Opt Design" START { ROLLUP_AUTO }
start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
OPTRACE "read constraints: opt_design" START { }
OPTRACE "read constraints: opt_design" END { }
OPTRACE "opt_design" START { }
  opt_design 
OPTRACE "opt_design" END { }
OPTRACE "read constraints: opt_design_post" START { }
OPTRACE "read constraints: opt_design_post" END { }
OPTRACE "opt_design reports" START { REPORT }
  set_param project.isImplRun true
  generate_parallel_reports -reports { "report_drc -file blue_hd_top_drc_opted.rpt -pb blue_hd_top_drc_opted.pb -rpx blue_hd_top_drc_opted.rpx"  }
  set_param project.isImplRun false
OPTRACE "opt_design reports" END { }
OPTRACE "Opt Design: write_checkpoint" START { CHECKPOINT }
  write_checkpoint -force blue_hd_top_opt.dcp
OPTRACE "Opt Design: write_checkpoint" END { }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

OPTRACE "Phase: Opt Design" END { }
OPTRACE "Phase: Place Design" START { ROLLUP_AUTO }
start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
OPTRACE "read constraints: place_design" START { }
OPTRACE "read constraints: place_design" END { }
OPTRACE "read incremental checkpoint" START { }
  read_checkpoint -auto_incremental  -incremental D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/xdaq_top.srcs/utils_1/imports/impl_1/blue_hd_top_routed.dcp
  catch { report_incremental_reuse -file blue_hd_top_incremental_reuse_pre_placed.rpt }
OPTRACE "read incremental checkpoint" END { }
  if { [llength [get_debug_cores -quiet] ] > 0 }  { 
OPTRACE "implement_debug_core" START { }
    implement_debug_core 
OPTRACE "implement_debug_core" END { }
  } 
OPTRACE "place_design" START { }
  place_design 
OPTRACE "place_design" END { }
OPTRACE "read constraints: place_design_post" START { }
OPTRACE "read constraints: place_design_post" END { }
OPTRACE "place_design reports" START { REPORT }
  set_param project.isImplRun true
  generate_parallel_reports -reports { "report_io -file blue_hd_top_io_placed.rpt" "report_utilization -file blue_hd_top_utilization_placed.rpt -pb blue_hd_top_utilization_placed.pb" "report_control_sets -verbose -file blue_hd_top_control_sets_placed.rpt"  }
  set_param project.isImplRun false
OPTRACE "place_design reports" END { }
OPTRACE "Place Design: write_checkpoint" START { CHECKPOINT }
  write_checkpoint -force blue_hd_top_placed.dcp
OPTRACE "Place Design: write_checkpoint" END { }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

OPTRACE "Phase: Place Design" END { }
OPTRACE "Phase: Physical Opt Design" START { ROLLUP_AUTO }
start_step phys_opt_design
set ACTIVE_STEP phys_opt_design
set rc [catch {
  create_msg_db phys_opt_design.pb
OPTRACE "read constraints: phys_opt_design" START { }
OPTRACE "read constraints: phys_opt_design" END { }
OPTRACE "phys_opt_design" START { }
  phys_opt_design 
OPTRACE "phys_opt_design" END { }
OPTRACE "read constraints: phys_opt_design_post" START { }
OPTRACE "read constraints: phys_opt_design_post" END { }
OPTRACE "phys_opt_design report" START { REPORT }
OPTRACE "phys_opt_design report" END { }
OPTRACE "Post-Place Phys Opt Design: write_checkpoint" START { CHECKPOINT }
  write_checkpoint -force blue_hd_top_physopt.dcp
OPTRACE "Post-Place Phys Opt Design: write_checkpoint" END { }
  close_msg_db -file phys_opt_design.pb
} RESULT]
if {$rc} {
  step_failed phys_opt_design
  return -code error $RESULT
} else {
  end_step phys_opt_design
  unset ACTIVE_STEP 
}

OPTRACE "Phase: Physical Opt Design" END { }
OPTRACE "Phase: Route Design" START { ROLLUP_AUTO }
start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
OPTRACE "read constraints: route_design" START { }
OPTRACE "read constraints: route_design" END { }
OPTRACE "route_design" START { }
  route_design 
OPTRACE "route_design" END { }
OPTRACE "read constraints: route_design_post" START { }
OPTRACE "read constraints: route_design_post" END { }
OPTRACE "route_design reports" START { REPORT }
  set_param project.isImplRun true
  generate_parallel_reports -reports { "report_drc -file blue_hd_top_drc_routed.rpt -pb blue_hd_top_drc_routed.pb -rpx blue_hd_top_drc_routed.rpx" "report_methodology -file blue_hd_top_methodology_drc_routed.rpt -pb blue_hd_top_methodology_drc_routed.pb -rpx blue_hd_top_methodology_drc_routed.rpx" "report_power -file blue_hd_top_power_routed.rpt -pb blue_hd_top_power_summary_routed.pb -rpx blue_hd_top_power_routed.rpx" "report_route_status -file blue_hd_top_route_status.rpt -pb blue_hd_top_route_status.pb" "report_timing_summary -max_paths 10 -report_unconstrained -file blue_hd_top_timing_summary_routed.rpt -pb blue_hd_top_timing_summary_routed.pb -rpx blue_hd_top_timing_summary_routed.rpx -warn_on_violation " "report_incremental_reuse -file blue_hd_top_incremental_reuse_routed.rpt" "report_clock_utilization -file blue_hd_top_clock_utilization_routed.rpt" "report_bus_skew -warn_on_violation -file blue_hd_top_bus_skew_routed.rpt -pb blue_hd_top_bus_skew_routed.pb -rpx blue_hd_top_bus_skew_routed.rpx"  }
  set_param project.isImplRun false
OPTRACE "route_design reports" END { }
OPTRACE "Route Design: write_checkpoint" START { CHECKPOINT }
  write_checkpoint -force blue_hd_top_routed.dcp
OPTRACE "Route Design: write_checkpoint" END { }
OPTRACE "route_design misc" START { }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
OPTRACE "route_design write_checkpoint" START { CHECKPOINT }
OPTRACE "route_design write_checkpoint" END { }
  write_checkpoint -force blue_hd_top_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

OPTRACE "route_design misc" END { }
OPTRACE "Phase: Route Design" END { }
OPTRACE "Phase: Write Bitstream" START { ROLLUP_AUTO }
OPTRACE "write_bitstream setup" START { }
start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
OPTRACE "read constraints: write_bitstream" START { }
OPTRACE "read constraints: write_bitstream" END { }
  set_property XPM_LIBRARIES {XPM_CDC XPM_FIFO XPM_MEMORY} [current_project]
  catch { write_mem_info -force -no_partial_mmi blue_hd_top.mmi }
OPTRACE "write_bitstream setup" END { }
OPTRACE "write_bitstream" START { }
  write_bitstream -force blue_hd_top.bit -bin_file
OPTRACE "write_bitstream" END { }
OPTRACE "write_bitstream misc" START { }
OPTRACE "read constraints: write_bitstream_post" START { }
OPTRACE "read constraints: write_bitstream_post" END { }
  catch {write_debug_probes -quiet -force blue_hd_top}
  catch {file copy -force blue_hd_top.ltx debug_nets.ltx}
OPTRACE "Write Bitstream: post hook" START { }
  set src_rc [catch { 
    puts "source D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/post_script.tcl"
    source D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/post_script.tcl
  } _RESULT] 
  if {$src_rc} { 
    set tool_flow [get_property -quiet TOOL_FLOW [current_project -quiet]]
    if { $tool_flow eq {SDx} } { 
      send_gid_msg -id 2 -ssname VPL_TCL -severity ERROR $_RESULT
      send_gid_msg -id 3 -ssname VPL_TCL -severity ERROR "sourcing script D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/post_script.tcl failed"
    } else {
      send_msg_id runtcl-1 status "$_RESULT"
      send_msg_id runtcl-2 status "sourcing script D:/workspace/gittea-work/BLUE-HD-FPGA/xdaq_top/build/post_script.tcl failed"
    }
    return -code error
  }
OPTRACE "Write Bitstream: post hook" END { }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

OPTRACE "write_bitstream misc" END { }
OPTRACE "Phase: Write Bitstream" END { }
OPTRACE "impl_1" END { }
