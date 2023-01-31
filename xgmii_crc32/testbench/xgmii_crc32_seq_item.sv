//-------------------------------------------------------------------------
//						xgmii_crc32_item - www.verificationguide.com 
//-------------------------------------------------------------------------

class xgmii_crc32_seq_item extends uvm_sequence_item;

  //---------------------------------------
  //data and control fields
  //---------------------------------------
  rand bit [63 : 0] xgmii_data;
  rand bit [ 7 : 0] xgmii_ctrl;

  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(mem_seq_item)
    `uvm_field_int(xgmii_data, UVM_ALL_ON)
    `uvm_field_int(xgmii_ctrl, UVM_ALL_ON)
  `uvm_object_utils_end
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name = "mem_seq_item");
    super.new(name);
  endfunction
  
  //---------------------------------------
  //constaint, to generate any one among write and read
  //---------------------------------------
  //constraint wr_rd_c { wr_en != rd_en; }; 

endclass
