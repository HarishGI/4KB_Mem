class mem_scoreboard;
  mailbox #(mem_wr_rd_transaction) mb_mon_scb;
  logic [31:0] ref_mem[1024];
  
  function new();
    mb_mon_scb=new();
  endfunction
  
  task get_mon_txn;
    mem_wr_rd_transaction mem_txn;
    bit[31:0]temp_data;
    
    forever
      begin
        mb_mon_scb.get(mem_txn);
        if(mem_txn.wr_rd==1)
          begin
            ref_mem[mem_txn.addr]=mem_txn.data;
            $display("Data write to address: %h and Data: %h",mem_txn.addr,ref_mem[mem_txn.addr]);
          end else begin
            temp_data=ref_mem[mem_txn.addr];
            if(!temp_data == mem_txn.data)
              begin
                $display("Error Data Mis-Matched");
              end else begin
                $display("Data from address: %h is matching with data from Ref mem: %h",mem_txn.addr, temp_data);
              end
          end
      end
  endtask
  
endclass