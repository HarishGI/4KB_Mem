class mem_test;
  mailbox #(virtual mem_interface) mb_vintf;
  mem_environment mem_env;
  
  task build;
    mem_env=new();
    mem_env.build();
  endtask
  
  task connect;
    mem_env.connect();
    mem_env.mem_agnt.mem_drv.mb_vmem_intf=mb_vintf;
    mem_env.mem_agnt.mem_mon.mb_vintf=mb_vintf;
  endtask
  
  task wr_txn();
    mem_env.mem_agnt.mem_generator.pkt_cnt=5;
    mem_env.mem_agnt.mem_generator.wr_txn_gen();
  endtask
  
  task rd_txn();
    mem_env.mem_agnt.mem_generator.pkt_cnt=5;
    mem_env.mem_agnt.mem_generator.rd_txn_gen();
  endtask
  
  task wr_rd_txn();
    mem_env.mem_agnt.mem_generator.pkt_cnt=10;
    mem_env.mem_agnt.mem_generator.wr_txn_gen();
    mem_env.mem_agnt.mem_generator.rd_txn_gen();
  endtask
  
    task run;
    fork
       mem_env.mem_agnt.mem_drv.run_txn();
       mem_env.mem_agnt.mem_mon.run_mon();
       mem_env.mem_scb.get_mon_txn();
       wr_rd_txn();
    join_any
  endtask
  
endclass