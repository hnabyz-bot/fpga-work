#!/usr/bin/tclsh
# Full build script for xdaq_top project

puts "\n========================================================================"
puts "Starting Full Build: Synthesis -> Implementation -> Bitstream"
puts "========================================================================"

# Set working directory
cd [file dirname [info script]]

# Open project
open_project xdaq_top.xpr

# Launch synthesis
puts "\nStep 1: Running Synthesis..."
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    puts "ERROR: Synthesis failed!"
    puts "Check synth_1 run for errors"
    exit 1
}
puts "✓ Synthesis completed successfully"

# Launch implementation
puts "\nStep 2: Running Implementation..."
reset_run impl_1
launch_runs impl_1 -jobs 4
wait_on_run impl_1

if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    puts "ERROR: Implementation failed!"
    puts "Check impl_1 run for errors"
    exit 1
}
puts "✓ Implementation completed successfully"

# Open implemented design
puts "\nStep 3: Opening implemented design..."
open_run impl_1

# Relax DRC checks
puts "\nStep 4: Relaxing DRC checks..."
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

# Generate bitstream
puts "\nStep 5: Generating bitstream..."
write_bitstream -force xdaq_top.runs/impl_1/blue_hd_top.bit -bin_file

puts "\n========================================================================"
puts "BUILD COMPLETED SUCCESSFULLY!"
puts "Bitstream location: xdaq_top.runs/impl_1/blue_hd_top.bit"
puts "========================================================================"
