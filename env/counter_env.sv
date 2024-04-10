class counter_env;
	
	virtual counter_if.WR_DRV_MP wr_drv_if;
	virtual counter_if.WR_MON_MP wr_mon_if;
	virtual counter_if.RD_MON_MP rd_mon_if;
	
	mailbox #(counter_trans) gen2wr=new;
	mailbox #(counter_trans) wm2ref=new;
	//mailbox #(counter_trans) rm2ref=new;
	mailbox #(counter_trans) ref2sb=new;
	mailbox #(counter_trans) rm2sb=new;

	counter_gen gen_h;
	counter_write_drv	wr_drv_h;
	counter_write_mon	wr_mon_h;
	counter_read_mon	rd_mon_h;
	counter_ref_mod		ref_h;
	counter_sb 		sb_h;


	function new (virtual counter_if.WR_DRV_MP wr_drv_if,
		      virtual counter_if.WR_MON_MP wr_mon_if,
		      virtual counter_if.RD_MON_MP rd_mon_if);
		this.wr_drv_if=wr_drv_if;
		this.wr_mon_if=wr_mon_if;
		this.rd_mon_if=rd_mon_if;
	endfunction

	virtual task build;
		gen_h	 =new(gen2wr);
		wr_drv_h =new(wr_drv_if,gen2wr);
    		wr_mon_h =new(wr_mon_if,wm2ref);
		rd_mon_h =new(rd_mon_if,rm2sb);
		ref_h	 =new(ref2sb,wm2ref);
    		sb_h	 =new(ref2sb,rm2sb);
	endtask

	virtual task reset_dut();
		begin
		wr_drv_if.wr_drv_cb.load<=0;
		wr_drv_if.wr_drv_cb.data_in<=0;
		wr_drv_if.wr_drv_cb.mode<=0;
		wr_drv_if.wr_drv_cb.reset<=1;
		repeat(5)@(wr_drv_if.wr_drv_cb);
		end
	endtask

	task start();
		gen_h.start();
		wr_drv_h.start();
	        wr_mon_h.start();
		rd_mon_h.start();
		ref_h.start();	
	        sb_h.start();
	endtask

	task stop();
		wait(sb_h.DONE.triggered);
	endtask

	task run();
		reset_dut();
		start();
		stop();
		sb_h.report();
	endtask

endclass

