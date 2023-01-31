//-------------------------------------------------------------------------
//				www.verificationguide.com   testbench.sv
//-------------------------------------------------------------------------
//---------------------------------------------------------------
//including interfcae and testcase files
import uvm_pkg::*;
`include "uvm_macros.svh"

`include "xgmii_crc32_interface.sv"
`include "xgmii_crc32_base_test.sv"
`include "xgmii_crc32_func_test.sv"
//---------------------------------------------------------------

module tbench_top;

//mem_model_env env;

  //---------------------------------------
  //clock and reset signal declaration
  //---------------------------------------
  bit clk;
  bit rstn;
    
  //---------------------------------------
  //clock generation
  //---------------------------------------
  always #5 clk = ~clk;
  
  //---------------------------------------
  //reset Generation
  //---------------------------------------
  initial begin
    rstn = 0;
    #5 reset =1;
  end
  
  //---------------------------------------
  //interface instance
  //---------------------------------------
  mem_if intf(clk, rstn);
  
  //---------------------------------------
  //DUT instance
  //---------------------------------------
  xgmii_crc32 DUT (
    .clk          ( intf.clk         ),
    .rstn         ( intf.rstn        ),
    .xgmii_data   ( intf.xgmii_data  ),
    .xgmii_ctrl   ( intf.xgmii_ctrl  ),
    .crc32_o      ( intf.crc32_o     ),
    .crc32_vld_o  ( intf.crc32_vld_o )
  );
  
  //---------------------------------------
  //passing the interface handle to lower heirarchy using set method 
  //and enabling the wave dump
  //---------------------------------------
  initial begin 
    uvm_config_db#(virtual mem_if)::set(uvm_root::get(),"*","vif",intf);
    //enable wave dump
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  //---------------------------------------
  //calling test
  //---------------------------------------
  initial begin 
    run_test();
  end
  
endmodule
