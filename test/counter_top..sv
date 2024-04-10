module counter_top;
  import counter_pkg::*;

      bit clock;
      
      counter_if DUV_if(clock);
      
      counter_test test_h;
      
      
      counter_rtl DUT(.clock(clock),.reset(DUV_if.reset),.load(DUV_if.load),.mode(DUV_if.mode),.data_in(DUV_if.data_in),.data_out(DUV_if.data_out));
      
      
       initial 
            begin
                clock=1'b0;
                  forever
                      #5 clock=~clock;
            end
      
        initial           
            //if($test$plusargs("TEST"))
            begin
              test_h = new (DUV_if,DUV_if,DUV_if);
              no_of_transaction=100;
              test_h.build();
              test_h.run();
              $finish;
            end
	

      
 
              
endmodule
