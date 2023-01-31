transcript on
vlib work 
set include_path "+incdir+../rtl+incdir+../testbench"
#set vlog_options -64 -incr -lint -sv  $include_path -L mtiOvm -L mtiAvm -L mtiUvm -L mtiUPF -cuname memory -mfcu
set UVM_DPI_HOME "C:/modeltech64_10.7/uvm-1.1d/win64"

vlog -64 -incr -lint -sv  $include_path -L mtiOvm -L mtiAvm -L mtiUvm -L mtiUPF -cuname memory -mfcu ../rtl/memory_design.sv
vlog -64 -incr -lint -sv  $include_path -L mtiOvm -L mtiAvm -L mtiUvm -L mtiUPF -cuname memory -mfcu ../testbench/testbench.sv

vsim -c                             \
    +UVM_VERBOSITY=UVM_FULL         \
    +UVM_NO_RELNOTES                \
    +UVM_TESTNAME=mem_wr_rd_test    \
    -sv_lib $UVM_DPI_HOME/uvm_dpi   \
    -vopt -voptargs=+acc=npr        \
    work.tbench_top

do wave_uvm_mem.do
run -all