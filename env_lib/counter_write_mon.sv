class counter_write_mon;

	virtual counter_if.WR_MON_MP wr_mon_if;

	mailbox #(counter_trans)wm2ref;

	counter_trans data2rm;
	counter_trans data1;

	function new (virtual counter_if.WR_MON_MP wr_mon_if,mailbox #(counter_trans)wm2ref);
		this.wm2ref=wm2ref;
		this.wr_mon_if=wr_mon_if;
		this.data2rm=new;
	endfunction

	virtual task monitor();	
		@(wr_mon_if.wr_mon_cb);
		begin
		data2rm.mode=wr_mon_if.wr_mon_cb.mode;
		data2rm.data_in=wr_mon_if.wr_mon_cb.data_in;
		data2rm.reset=wr_mon_if.wr_mon_cb.reset;
		data2rm.load=wr_mon_if.wr_mon_cb.load;
				end
	endtask
 
	task start();
		fork
			forever
				begin
					monitor();
					data1=new data2rm;
					wm2ref.put(data1);
					data2rm.display("Data From Write Monitor:");

				end
		join_none
	endtask
endclass


