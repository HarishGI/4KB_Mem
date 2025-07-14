// Code your design here
// Code your design here
module mem_1024_32(mem_interface mem_intf);
  
  bit [31:0]mem[1024]; //Memory of 4KB size
 
  always @(posedge mem_intf.clk or negedge mem_intf.rst_n)
    begin
      if(!mem_intf.rst_n)begin
        for (int i=0; i<1023; i++)
          begin
            mem[i]<=0;
          end
          mem_intf.ready<=0;
          mem_intf.error<=0;
        end else begin
          mem_intf.ready<=0;
          mem_intf.error<=0;
        end
      
      if(mem_intf.valid==1)begin
        if(!(mem_intf.addr < 1024))begin //Checking the given address is in range or not
          mem_intf.ready<=1;
          mem_intf.error<=1;
          end
        else begin
          if (mem_intf.wr_rd==1)begin
            mem[mem_intf.addr]<=mem_intf.wdata; //Write Operation
            mem_intf.ready<=1;
            mem_intf.error<=0;
          end
          else begin
            mem_intf.rdata<=mem[mem_intf.addr]; //Read Operation
            mem_intf.ready<=1;
            mem_intf.error<=0;
          end
        end
        end
    end
endmodule