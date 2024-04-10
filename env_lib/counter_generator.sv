class counter_gen;

	mailbox #(counter_trans) gen2wr;

	counter_trans data2wr;
	counter_trans data;

	function new(mailbox #(counter_trans)gen2wr);
		this.gen2wr=gen2wr;
		this.data=new();
	endfunction

	virtual task start();
		fork
		    begin
			for(int i=0; i<no_of_transaction; i++)
				begin
				assert(data.randomize());
				data2wr=new data;
				gen2wr.put(data2wr);
				end
		    end
		join_none
	endtask

endclass