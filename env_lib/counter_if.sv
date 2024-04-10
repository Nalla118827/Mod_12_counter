interface counter_if (input clock);

	logic load;
	logic mode;
	logic [3:0] data_in;
	logic [3:0] data_out;
	logic reset;

	clocking wr_drv_cb@(posedge clock);
		default input #1 output #0;
		output load;
		output data_in;
		output mode;
		output reset;
	endclocking
	
	clocking wr_mon_cb@(posedge clock);
		default input #1 output #0;
		input data_in;
		input mode;
		input load;
		input reset;
	endclocking

	

	clocking rd_mon_cb@(posedge clock);
		default input #1 output #0;
		input data_out;
	endclocking

	modport WR_DRV_MP (clocking wr_drv_cb);
	modport WR_MON_MP (clocking wr_mon_cb);
	modport RD_MON_MP (clocking rd_mon_cb);

endinterface
