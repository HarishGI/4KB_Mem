class mem_environment;
  mem_agent mem_agnt;
  mem_scoreboard mem_scb;
  
  task build;
    mem_agnt=new();
    mem_scb=new();
    mem_agnt.build();
  endtask
  
  task connect;
    mem_scb.mb_mon_scb=mem_agnt.mem_mon.mb_mon_scb;
    mem_agnt.connect();
  endtask
endclass