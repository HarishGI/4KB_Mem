class mem_agent;
  mem_txn_generator mem_generator;
  mem_driver mem_drv;
  mem_monitor mem_mon;
  
  task build();
    mem_generator = new();
    mem_drv=new();
    mem_mon=new();
  endtask
  
  task connect();
    mem_drv.mb_gen_drv=mem_generator.mb_gen_drv_pkt;
    mem_drv.mb_drv_gen=mem_generator.mb_gen_drv_sync;
  endtask
  
endclass