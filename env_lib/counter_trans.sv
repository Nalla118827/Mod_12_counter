class counter_trans;
		
		rand logic [3:0] data_in;
		rand logic mode;
		rand logic load;
		  rand   logic reset;
		

		logic [3:0] data_out;

	        constraint VALID_LOAD {load dist{0:=10,1:=2};}
		constraint VALID_DATA { data_in inside {[0:11]} ;}
		constraint VALID_MODE {mode  dist {0:=10,1:=3};}
		constraint VALID_RST {reset dist{0:=20,1:=2};}


	function void display(input string message);
		$display("===========================================================");
		$display("%s",message);
		$display("\tData_out=%0d", data_out);
		$display("\tData_in=%0d",data_in);
		$display("\tLoad=%0d",load);
		$display("\tMode=%0d",mode);
    $display("\tReset=%0d",reset);
		$display("===========================================================");
	endfunction
		
function void post_randomize();
      $display("Randomized DATA");
      this.display("randomized data");
endfunction

endclass
