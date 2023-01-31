//-------------------------------------------------------------------------
//						xgmii_crc32_agent
//-------------------------------------------------------------------------

`include "xgmii_crc32_seq_item.sv"
`include "xgmii_crc32_sequencer.sv"
`include "xgmii_crc32_sequence.sv"
`include "xgmii_crc32_driver.sv"
`include "xgmii_crc32_monitor.sv"

class xgmii_crc32_agent extends uvm_agent;

  //---------------------------------------
  // component instances
  //---------------------------------------
  xgmii_crc32_driver    driver;
  xgmii_crc32_sequencer sequencer;
  xgmii_crc32_monitor   monitor;

  `uvm_component_utils(xgmii_crc32_agent)
  
  //---------------------------------------
  // constructor
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor = xgmii_crc32_monitor::type_id::create("monitor", this);

    //creating driver and sequencer only for ACTIVE agent
    if(get_is_active() == UVM_ACTIVE) begin
      driver    = xgmii_crc32_driver::type_id::create("driver", this);
      sequencer = xgmii_crc32_sequencer::type_id::create("sequencer", this);
    end
  endfunction : build_phase
  
  //---------------------------------------  
  // connect_phase - connecting the driver and sequencer port
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase

endclass : xgmii_crc32_agent
