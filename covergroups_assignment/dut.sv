`timescale 1ns/10ps
// prints out the state values
//
/**Use the command to generate URG:

urg -dir ./simv.vdb -format both*/

module dut(intf.idut ix);

default clocking @(posedge(ix.clk));

endclocking
covergroup cg @(posedge ix.clk);
  state_coverage: coverpoint ix.state {
  bins s1=(ix.state==0 => ix.state==1, ix.state==0 => ix.state==0);
...
}endgroup


covergroup dutcg @(posedge ix.clk);
		coverpoint ix.state(iff ix.rst)
		{
		// bins s0 = (ix.rst == 1  =>  ix.state==0);
		 bins s1 = (0 => 1,0 => 0);
		 bins s2 = (1 => 2,4);  //(1 => 4);
		 bins s3 = (2 => 3);
		 bins s4 = (3 => 5,1);  //,(3 => 1);
		 bins s5 = (4 => 5);
		 bins s6 = (5 => 1,6);   //,(5 => 6);
		 bins s7 = (6 => 7);
		 bins s8 = (7 => 0,8);   //,(7 => 8);
		 bins s9 = (8 => 2,4,10,9);  //,(8 => 4 ),(8 => 10),(8 => 9)
		 bins s10 = (9 => 0,8);  //,(9 => 8);
		 bins s11 = (10 => 0);
		 bins s12 = (11 => 4);
		 bins allother = default sequence;		 
		}
endgroup



dutcg cg;
cg.ix.state.getcoverage();

endmodule 


