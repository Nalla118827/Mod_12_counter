package counter_pkg;

      int no_of_transaction=1;
      
          `include "counter_trans.sv"
          `include "counter_generator.sv"
          `include "counter_write_driver.sv"
          `include "counter_write_mon.sv"
          `include "counter_read_mon.sv"
          `include "counter_refmod.sv"
          `include "counter_SB.sv"
          `include "counter_env.sv"
          `include "counter_test.sv"
         // `include "counter_top..sv"
          
endpackage