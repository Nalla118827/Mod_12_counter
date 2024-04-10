class counter_test;
      
          virtual counter_if.WR_MON_MP wr_mon_if;
          virtual counter_if.RD_MON_MP rd_mon_if;
          virtual counter_if.WR_DRV_MP wr_drv_if;
          
           counter_env env_h;
      
      function new (virtual counter_if.WR_DRV_MP wr_drv_if, virtual counter_if.WR_MON_MP wr_mon_if,virtual counter_if.RD_MON_MP rd_mon_if);
                      this.wr_mon_if=wr_mon_if;
                      this.rd_mon_if=rd_mon_if;
                      this.wr_drv_if=wr_drv_if;
                      
             env_h=new(wr_drv_if,wr_mon_if,rd_mon_if);
      endfunction
      
      virtual task build();
        env_h.build();
      endtask
      
      virtual task run();
        env_h.run();
      endtask
      
endclass