#==============================================================================
# BLUE-HD-FPGA Questa Simulation Script
#==============================================================================
# Usage: vsim -do simulate.do
#==============================================================================

puts "============================================================"
puts "BLUE-HD-FPGA Simulation Script"
puts "============================================================"

# Load the testbench
vsim -t 1ps -voptargs="+acc" work.test_bench

# Add waveforms
do wave.do

# Run simulation
puts "\n--- Starting Simulation ---"
run 100us

puts "\n============================================================"
puts "Simulation Complete!"
puts "============================================================"
