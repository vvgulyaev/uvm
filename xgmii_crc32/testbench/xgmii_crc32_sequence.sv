//-------------------------------------------------------------------------
//						xgmii_crc32_sequence's - www.verificationguide.com
//-------------------------------------------------------------------------

//=========================================================================
// xgmii_crc32_func_sequence - random stimulus 
//=========================================================================
class xgmii_crc32_func_sequence extends uvm_sequence#(mem_seq_item);
  
  `uvm_object_utils(xgmii_crc32_sequence)
  
  //--------------------------------------- 
  //Constructor
  //---------------------------------------
  function new(string name = "xgmii_crc32_sequence");
    super.new(name);
  endfunction
  
  `uvm_declare_p_sequencer(xgmii_crc32_sequencer)
  
  //---------------------------------------
  // create, randomize and send the item to driver
  //---------------------------------------
  virtual task body();
    parameter TEST_LEN = 1000;
    int         idx_of_term;
    int         byte_idx;
    logic [7:0] cur_byte;
    logic       cur_ctrl;
    logic       packet_done;
    int         cur_byte_idx;
    req = xgmii_crc32_seq_item::type_id::create("req");
    for (int t=0; t<TEST_LEN; t++) begin
        req.xgmii_data[7:0] = CODE_START;
        req.xgmii_ctrl[0]   = 1;
        idx_of_term = $urandom_range(1, MAX_PACKET_LEN_BYTES-1);
        byte_idx = 1;
        packet_done = 0;
      for (int i=0; i<MAX_PACKET_LEN; i++) begin
        while (byte_idx < 8) begin
            cur_byte_idx = (i * 8) + byte_idx;
            if (cur_byte_idx==idx_of_term) begin
                req.xgmii_data[byte_idx*8 +: 8] = CODE_TERM;
                req.xgmii_ctrl[byte_idx]        = 1;
                packet_done = 1;
            end
            else begin
                cur_byte = $urandom_range(0, 8'hFF);
                cur_ctrl = $urandom_range(0, 1);
                if (((cur_byte==CODE_TERM) || (cur_byte==CODE_START)) && (cur_ctrl==1))
                    cur_ctrl = 0;
                req.xgmii_data[byte_idx*8 +: 8] = cur_byte;
                req.xgmii_ctrl[byte_idx]        = cur_ctrl;
            end
            byte_idx++;
        end
        send_request(req);
        wait_for_item_done();
        if (packet_done) break;
        byte_idx = 0;
      end
    end
  endtask
endclass
//=========================================================================

