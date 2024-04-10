# Makefile for Memory - Regression Testing - Lab10

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = VCS
FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64
RTL= ../rtl/counter_RTL.sv
work= work #library name
SVTB1= ../env_lib/counter_if.sv
INC = +incdir+../env +incdir+../env_lib +incdir+../test
SVTB2 = ../test/counter_pkg.sv  ../test/counter_top..sv
COVOP = -coveropt 3 +cover=bcft
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"

help:
	@echo ===========================================================================================================
	@echo " USAGE   	--  make target"
	@echo " clean   	=>  clean the earlier log and intermediate files."
	@echo " sv_cmp    =>  Create library and compile the code."									   
	@echo " TC1       =>  To compile and run the testcase1 in batch mode." 
	@echo " TC2       =>  To compile and run the testcase2 in batch mode.(This testcase is not written,if you want you can extend it(Testcase 1(TC1) covered 100%"  
	@echo " report_12 =>  To merge coverage reports for testcases TC1 and  convert to html format." 
	@echo " covhtml		=>  To view the coverage report in firefox."
	@echo " covtxt	  => To view the coverage report in text editor [only for VCS]"
	@echo "cov_verdi 	=> To view the coverage report in verdi [only for VCS]"
	@echo ===========================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
TC1 : TC1_$(SIMULATOR)
TC2 : TC2_$(SIMULATOR)
report_1 : report_12_$(SIMULATOR)
view_wave : view_wave_$(SIMULATOR)
covhtml : covhtml_$(SIMULATOR)
covtxt: covtxt_$(SIMULATOR)
cov_verdi: cov_verdi_$(SIMULATOR)

# ---- Start of Definitions for Mentor's Questa Specific Targets -----#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) $(COVOP)
		
TC1_Questa:sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed 2975249645 work.top +TEST1  
	vcover report  -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

TC2_Questa:sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed 1556525292 work.top +TEST2 
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

covhtml_Questa:
	 firefox covhtmlreport/index.html&
	
clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear

# ---- End of Definitions for Mentor's Questa Specific Targets -----#
	
# ---- Start of Definitions for Synopsys VCS Specific Targets -----#

sv_cmp_VCS:
	vcs -full64 -l comp.log -sverilog -debug_access+all -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB1) $(SVTB2)

TC1_VCS:clean_VCS  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave_file1.fsdb -cm_dir ./cov1 +ntb_random_seed=4137323363 +TEST1 
	urg -dir cov1.vdb -format both -report urgReport
	
TC2_VCS:	
	./simv -a vcs.log +fsdbfile+wave_file2.fsdb -cm_dir ./cov2 +ntb_random_seed=3072812991 +TEST2 	
	urg -dir cov2.vdb -format both -report urgReport2
	
TC3_VCS:	
	./simv -a vcs.log +fsdbfile+wave_file3.fsdb -cm_dir ./cov3 +ntb_random_seed_automatic +TEST3
	urg -dir cov3.vdb -format both -report urgReport3
	
clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb verdi*
	clear 
	
report_12_VCS:
	urg -dir cov1.vdb  -dbname merged_dir/merged_test -format both -report urgReport
 

covhtml_VCS:
	firefox urgReport/grp*.html &
	
covtxt_VCS:
	vi urgReport/grp*.txt
cov_verdi_VCS:
	verdi -cov -covdir merged_dir.vdb

# ---- End of Definitions for Synopsys VCS Specific Targets -----#	
