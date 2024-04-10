class counter_ref_mod;
	
	mailbox #(counter_trans)ref2sb;
	mailbox #(counter_trans)wm2ref;

	counter_trans mon_data;
	counter_trans con_data;
	
    int ref_count=0;
 
	function new(mailbox #(counter_trans)ref2sb,mailbox #(counter_trans)wm2ref);
		this.ref2sb=ref2sb;
		this.wm2ref=wm2ref;
		this.con_data=new;
		
	endfunction


	virtual task dataread(counter_trans mon_data1);
		begin
	if(mon_data1.reset==1)
            ref_count<=4'd0;
	else if(mon_data1.load==1)
		ref_count<=mon_data1.data_in;
         else  // wait(mon_data1.load==0)
                begin
                   //if(mon_data1.reset==1)
		//	ref_count<=4'd0;
		  // else
		//	begin
                    if(mon_data1.mode==0 )
                      begin
                          if(ref_count==11)
                                ref_count<=4'd0;
                           else
                                 ref_count<=ref_count+1'b1;
                        end
                     else if(mon_data1.mode==1)
                       begin
                           if(ref_count==0)
                                 ref_count<=4'd11;
                           else
                               ref_count<=ref_count-4'b0001;
                       end
			end
        //        end
		//to stop loop
	/*	if(mon_data1.data_out==ref_count)
			$display("finish");
			$finish;*/
   end
	endtask			


	virtual task start();
		fork
		    begin
				forever 
                                begin
					wm2ref.get(mon_data);
					dataread(mon_data);
					mon_data.data_out=ref_count;
					//con_data.data_out= ref_count;
					con_data=new mon_data;
					ref2sb.put(con_data);
					con_data.display("DATA FROM REFERENCE MODEL");
					end
			   end
		join_none
      
	endtask
endclass
				
