interface mem_interface();
  logic [14:0]addr;
  logic [31:0]wdata;
  logic [31:0]rdata;
  logic wr_rd,ready,error, valid;
  logic clk, rst_n;
  
  clocking drv_cb @(posedge clk);
    default input#1 output#1;
    input ready, error, rdata;
    output addr, wdata, wr_rd, valid;
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input#1;
    input ready, error, rdata, addr, wdata, wr_rd, valid;
  endclocking
  
endinterface //end of mem_interface block