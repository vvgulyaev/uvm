//-------------------------------------------------------------------------
//						xgmii_crc32_env
//-------------------------------------------------------------------------

`include "xgmii_crc32_agent.sv"
`include "xgmii_crc32_scoreboard.sv"

class xgmii_crc32_env extends uvm_env;
  
  //---------------------------------------
  // agent and scoreboard instance
  //---------------------------------------
  xgmii_crc32_agent      xgmii_crc32_agnt;
  xgmii_crc32_scoreboard xgmii_crc32_scb;
  
  `uvm_component_utils(xgmii_crc32_env)
  
  //--------------------------------------- 
  // constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase - crate the components
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    xgmii_crc32_agnt = mem_agent::type_id::create("xgmii_crc32_agnt", this);
    xgmii_crc32_scb  = mem_scoreboard::type_id::create("xgmii_crc32_scb", this);
  endfunction : build_phase
  
  //---------------------------------------
  // connect_phase - connecting monitor and scoreboard port
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    xgmii_crc32_agnt.monitor.item_collected_port.connect(xgmii_crc32_scb.item_collected_export);
  endfunction : connect_phase

endclass : xgmii_crc32_model_env
