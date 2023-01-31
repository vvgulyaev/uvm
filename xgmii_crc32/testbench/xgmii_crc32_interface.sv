//-------------------------------------------------------------------------
//						xgmii_crc32_interface
//-------------------------------------------------------------------------

interface mem_if(input logic clk, rstn);
  
  //---------------------------------------
  //declaring the signals
  //---------------------------------------
  logic [63 : 0] xgmii_data;
  logic [ 7 : 0] xgmii_ctrl;
  logic [31 : 0] crc32_o;
  logic          crc32_vld_o;
  
  //---------------------------------------
  //driver clocking block
  //---------------------------------------
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output [63 : 0] xgmii_data;
    output [ 7 : 0] xgmii_ctrl;
    input  [31 : 0] crc32_o;
    input           crc32_vld_o;
  endclocking
  
  //---------------------------------------
  //monitor clocking block
  //---------------------------------------
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input  [63 : 0] xgmii_data;
    input  [ 7 : 0] xgmii_ctrl;
    input  [31 : 0] crc32_o;
    input           crc32_vld_o;
  endclocking
  
  //---------------------------------------
  //driver modport
  //---------------------------------------
  modport DRIVER  (clocking driver_cb,input clk, rstn);
  
  //---------------------------------------
  //monitor modport  
  //---------------------------------------
  modport MONITOR (clocking monitor_cb,input clk, rstn);
  
endinterface
