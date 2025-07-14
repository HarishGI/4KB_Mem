class mem_wr_rd_transaction;
  rand bit [14:0]addr;
  rand bit [31:0]data;
  rand bit wr_rd;
  rand bit err_gen;
  constraint addr_err_gen { if(err_gen == 0)
                           {
                             addr<1024;
                           }else{
                             addr>1023;
                           }
                             }
endclass //end of class mem_wr_rd_transaction