class mem_driver;
  
  virtual mem_interface u_mem_intf;
  mem_wr_rd_transaction mem_pkt;
  mailbox #(virtual mem_interface) mb_vmem_intf;  
  mailbox #(bit) mb_drv_gen;
  mailbox #(mem_wr_rd_transaction) mb_gen_drv;
  
  function new();
    mb_vmem_intf=new(1);
    mb_drv_gen=new(1);
    mb_gen_drv=new(1);
  endfunction
  
  task get_intf();
    mb_vmem_intf.peek(u_mem_intf);
  endtask
  
  task run_txn();
    get_intf();
    forever
      begin
        mb_gen_drv.get(mem_pkt);
        if(mem_pkt.wr_rd ==1)
          begin
            mem_wr();
            mb_drv_gen.put(1);
          end else begin
            mem_rd();
            mb_drv_gen.put(1);
          end
        end
  endtask
  
  task mem_wr();
    @(u_mem_intf.drv_cb);
    u_mem_intf.drv_cb.addr<=mem_pkt.addr;
    u_mem_intf.drv_cb.wdata<=mem_pkt.data;
    u_mem_intf.drv_cb.wr_rd<=1;
    u_mem_intf.drv_cb.valid<=1;
    forever
      begin
        @(u_mem_intf.drv_cb);
        if(u_mem_intf.drv_cb.ready==1)
          break;
      end
      u_mem_intf.drv_cb.valid<=0;
  endtask
  
  task mem_rd();
    @(u_mem_intf.drv_cb);
    u_mem_intf.drv_cb.addr<=mem_pkt.addr;
    u_mem_intf.drv_cb.wr_rd<=0;
    u_mem_intf.drv_cb.valid<=1;
    forever
      begin
        @(u_mem_intf.drv_cb);
        if(u_mem_intf.drv_cb.ready==1)
          break;
      end
      u_mem_intf.drv_cb.valid<=0;
  endtask
  
endclass