class counter_read_mon;

	virtual counter_if.RD_MON_MP rd_mon_if;
	
	mailbox #(counter_trans)rm2sb;

	counter_trans data2sb;
	counter_trans rrdata;

	function new(virtual counter_if.RD_MON_MP rd_mon_if, mailbox #(counter_trans)rm2sb);
		this.rd_mon_if=rd_mon_if;
		this.rm2sb=rm2sb;
		this.rrdata=new();
	endfunction

	task monitor();
		@(rd_mon_if.rd_mon_cb)
		rrdata.data_out=rd_mon_if.rd_mon_cb.data_out;
	//	rrdata.display("DATA FROM READ MONITOR");
	endtask
	
	task start();
		fork
		    forever
			begin
				monitor();
				data2sb=new rrdata;
				rm2sb.put(data2sb);
				data2sb.display("DATA FROM READ MONITOR");
				//rd2rm.put(data2sb);
			end
		join_none
	endtask

endclass
