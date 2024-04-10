class counter_write_drv;
	
	virtual counter_if.WR_DRV_MP wr_drv_if;

	mailbox #(counter_trans)gen2wr;
	
	counter_trans data2duv;

	function new(virtual counter_if.WR_DRV_MP wr_drv_if,mailbox #(counter_trans)gen2wr);
		this.wr_drv_if=wr_drv_if;
		this.gen2wr=gen2wr;
	endfunction

	virtual task drive();
		@(wr_drv_if.wr_drv_cb)
		begin
		wr_drv_if.wr_drv_cb.data_in<=data2duv.data_in;
		wr_drv_if.wr_drv_cb.mode<=data2duv.mode;
		wr_drv_if.wr_drv_cb.reset<=data2duv.reset;
		wr_drv_if.wr_drv_cb.load<=data2duv.load;
	//	data2duv.display("Data from Write Driver");

			//repeat(2) @(wr_drv_if.wr_drv_cb);
	
	///wr_drv_if.wr_drv_cb.load<=0;
		end
	endtask

	virtual task start();
		fork
		    forever
			   begin
				gen2wr.get(data2duv);
				drive();
				data2duv.display("DATA FROM WRITE DRIVER");
			   end
		join_none
	endtask

endclass


		
	
		
