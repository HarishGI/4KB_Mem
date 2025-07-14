`include "mem_interface.sv"
`include "mem_wr_rd_transaction.sv"
`include "mem_txn_generator.sv"
`include "mem_driver.sv"
`include "mem_monitor.sv"
`include "mem_agent.sv"
`include "mem_scoreboard.sv"
`include "mem_environment.sv"
`include "mem_test.sv"

module tb_mem_4kb();
  bit tb_clk=0;
  bit tb_rst_n=1;
  
  mem_interface u_mem_intf();
  mem_1024_32 dut_mem(.mem_intf(u_mem_intf));
  
  mem_test mem_t;
  mem_driver mem_drv;
  mem_monitor mem_mon;
  mem_wr_rd_transaction mem_wr_rd_tr;
  
  virtual mem_interface u_mem_vintf;
  mailbox #(virtual mem_interface) mem_vintf;
   
    always
    #500 tb_clk=~tb_clk;
  
  assign u_mem_intf.clk=tb_clk;
  assign u_mem_intf.rst_n=tb_rst_n;
  
  initial
    begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    #90000 $finish;
    end
  
  initial
    begin
      mem_vintf=new(1);
      mem_t=new();
      mem_drv=new();
      mem_mon=new();
      
      u_mem_intf.valid=0;
      #500;
      tb_rst_n=0; //Issue active low reset
      #500;
      tb_rst_n=1;
      u_mem_intf.valid=1;
      
      /*mem_wr_rd_tr=new();
      mem_wr_rd_tr.randomize with { data inside {[32'h00000000:32'hFFFFFFFF]};
                                  	wr_rd == 1;
                                   	addr inside {[0:1024]};};
      
      mem_wr_rd_tr.randomize with { wr_rd == 0;
                                   	addr inside {[0:1024]};};*/
      
      u_mem_vintf=u_mem_intf;      
      mem_vintf.put(u_mem_vintf);
      mem_drv.mb_vmem_intf=mem_vintf;
      mem_mon.mb_vintf=mem_vintf;
      mem_t.mb_vintf=mem_vintf;
      
      mem_t.build();
      mem_t.connect();
      mem_t.run();
      
    end
  
endmodule