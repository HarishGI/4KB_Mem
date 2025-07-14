class mem_txn_generator;
  int pkt_cnt;
  bit temp;
  mailbox #(bit) mb_gen_drv_sync;
  mailbox #(mem_wr_rd_transaction) mb_gen_drv_pkt;
  
  mem_wr_rd_transaction mem_wr_rd; //class mem_wr_rd_transaction
  
  function new();
    mb_gen_drv_sync=new(1);
    mb_gen_drv_pkt=new(1);
  endfunction
  
  task wr_txn_gen();
    for(int i=0; i<pkt_cnt; i++)
      begin
        mem_wr_rd=new();
        mem_wr_rd.randomize with { data inside {[32'h00000000:32'hFFFFFFFF]};
                                  	wr_rd == 1;
                                  addr inside {[90:100]};};
        mb_gen_drv_pkt.put(mem_wr_rd);
        $display("--------------inside mem_txn_generator write method-------------------");
        mb_gen_drv_sync.get(temp);
      end
  endtask
  
  task rd_txn_gen();
    for(int i=0; i<pkt_cnt; i++)
      begin
        $display("-------------Inside mem_txn_generator Read Transaction----------------");
        mem_wr_rd=new();
        mem_wr_rd.randomize with {	wr_rd == 0;
                                  addr inside {[90:100]};};
        mb_gen_drv_pkt.put(mem_wr_rd);
       mb_gen_drv_sync.get(temp);
      end
  endtask
  
endclass //end of class mem_txn_generator

    
