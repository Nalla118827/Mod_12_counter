module counter_rtl(input bit clock,reset,load,mode,bit [3:0]data_in,output reg [3:0] data_out=4'd0);

  always@(posedge clock)
    begin
        if(reset)
            data_out<=4'b0000;
        else if(load==1'b1)
            data_out<=data_in;
        else if(mode==1'b0)
              begin
                    if(data_out==4'd11)
                      data_out<=4'd0;
                    else
                      data_out<=data_out+4'b0001;
              end
        else if (mode==1'b1)
              begin
                    if(data_out==4'd0)
                      data_out<=4'd11;
                    else
                      data_out<=data_out-4'b0001;
              end
    end
    
endmodule
