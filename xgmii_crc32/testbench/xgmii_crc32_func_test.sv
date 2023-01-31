//-------------------------------------------------------------------------
//						xgmii_crc32_func_test
//-------------------------------------------------------------------------
class xgmii_crc32_func_test extends xgmii_crc32_base_test;

  `uvm_component_utils(xgmii_crc32_func_test)
  
  //---------------------------------------
  // sequence instance 
  //--------------------------------------- 
  xgmii_crc32_func_sequence seq;

  //---------------------------------------
  // constructor
  //---------------------------------------
  function new(string name = "xgmii_crc32_func_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the sequence
    seq = xgmii_crc32_func_sequence::type_id::create("seq");
  endfunction : build_phase
  
  //---------------------------------------
  // run_phase - starting the test
  //---------------------------------------
  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
      seq.start(env.xgmii_crc32_agnt.sequencer);
    phase.drop_objection(this);
    
    //set a drain-time for the environment if desired
    phase.phase_done.set_drain_time(this, 50);
  endtask : run_phase
  
endclass : xgmii_crc32_func_test
