class mem_monitor;
  
  virtual mem_interface u_mem_intf;
  mailbox #(virtual mem_interface) mb_vintf;
  mailbox #(mem_wr_rd_transaction) mb_mon_scb;
  
  function new();
    mb_mon_scb=new();
  endfunction
  
  task get_intf();
    mb_vintf.peek(u_mem_intf);
  endtask
  
  task run_mon();
    get_intf();
    fork begin
        mon_wr();
      end begin
        mon_rd();
      end
    join
  endtask
  
  task mon_wr();
    mem_wr_rd_transaction mem_wr;
 
    forever
      begin
        @(u_mem_intf.mon_cb);
        if(u_mem_intf.mon_cb.wr_rd==1 && u_mem_intf.mon_cb.ready==1 && u_mem_intf.mon_cb.valid==1)
          begin
            mem_wr=new();
            mem_wr.wr_rd=1;
            mem_wr.addr=u_mem_intf.mon_cb.addr;
            mem_wr.data=u_mem_intf.mon_cb.wdata;
            mb_mon_scb.put(mem_wr);
          end
      end
  endtask
  
  task mon_rd();
    mem_wr_rd_transaction mem_rd;
    
    forever
      begin
        @(u_mem_intf.mon_cb);
        if(u_mem_intf.mon_cb.wr_rd==0 && u_mem_intf.mon_cb.ready==1 && u_mem_intf.mon_cb.valid==1)
          begin
            mem_rd=new();
            mem_rd.wr_rd=0;
            mem_rd.addr=u_mem_intf.mon_cb.addr;
            mem_rd.data=u_mem_intf.mon_cb.rdata;
            mb_mon_scb.put(mem_rd);
          end
      end
  endtask
  
endclass