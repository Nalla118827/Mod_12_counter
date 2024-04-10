class counter_sb;

		event DONE;
		
	static	int data_verified=0;
	static	int rd_mon_data_count=0;
	static	int ref_data_count=0;
		
		mailbox #(counter_trans)ref2sb;
		mailbox #(counter_trans)rm2sb;

		counter_trans ref2sb_data;
		counter_trans rm2sb_data;
		counter_trans cov_data;

		covergroup mem_coverage;
			DATA_IN:coverpoint cov_data.data_in{
					bins zero      	= {[0:2]};
					bins medium_val	={[3:5]};
					bins high     	={[6:8]};
					bins Very_high	={[9:11]};}

			DATA_OUT: coverpoint cov_data.data_out{
					bins zero      	= {[0:2]};
                                        bins medium_val	={[3:5]};
                                        bins high     	={[6:8]};
                                        bins Very_high	={[9:11]};}



			DATA_LOAD: coverpoint cov_data.load{
					bins load_0 = {0};
					bins load_1  = {1};}


			DATA_MODE :coverpoint cov_data.mode{
					bins mode_0 = {0};
					bins mode_1  = {1};}


			DATA_RESET :coverpoint cov_data.reset{
					bins rst_0 = {0};
					bins rs_1  = {1};}

		endgroup
 

		function new (mailbox #(counter_trans)ref2sb,mailbox #(counter_trans)rm2sb);
			this.ref2sb=ref2sb;
			this.rm2sb=rm2sb;
			mem_coverage=new;
		endfunction

		
		virtual task start();
			fork 
				forever
					begin
					ref2sb.get(ref2sb_data);
					ref_data_count++;

					rm2sb.get(rm2sb_data);
					rd_mon_data_count++;
				
					check(rm2sb_data);
					end
			join_none
		endtask


	/*	task check(counter_trans rm2sb_data);
			begin
				if(rm2sb_data.reset==1)
					$display("COUNTER IS RESTED");
				else if(compare(rm2sb_data,diff))
					begin
					rm2sb_data.display("SB:Received data");
					ref2sb_data.display("SB:Data sent to DUT");
					$display("%s\n%m\n\n",diff);
					end
				else
					$dipslay("SB: %s\n%m\n\n",diff);
			   data_verified++;
			end*/
      
      
      
      
      virtual task check(counter_trans rm2sb_data);
        begin
          if(ref2sb_data.data_out==rm2sb_data.data_out)
		begin
              $display("Data Matched");
	//	ref2sb_data.display("SB DATA");
	//	rm2sb_data.display("SB DATA");
		end
          else
		begin
              $display("Data Not match");
	//	ref2sb_data.display("SB DATA");
	//	rm2sb_data.display("SB DATA");
		end
          
	cov_data =ref2sb_data;
          mem_coverage.sample();
          data_verified++;
		end


	//		if(data_verified>=(no_of_transaction-rc_data.no_of_write_trans))
      if(data_verified>=no_of_transaction)
				begin
				   ->DONE;
				end
	        endtask


		function void report();
			$display("====================================================================");
			$display("%0d Read Data Generated, %0d Received Data, %0d Read data Verified\n",ref_data_count,rd_mon_data_count,data_verified);
			$display("====================================================================");
		endfunction

endclass
