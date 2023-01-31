//-------------------------------------------------------------------------
//						xgmii_crc32_sequencer
//-------------------------------------------------------------------------

class xgmii_crc32_sequencer extends uvm_sequencer#(mem_seq_item);

  `uvm_component_utils(xgmii_crc32_sequencer) 

  //---------------------------------------
  //constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass
