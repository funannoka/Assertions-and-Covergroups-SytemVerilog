`timescale 1ns/10ps
// prints out the state values
//


module dut(intf.idut ix);

string expected_state;
const string st0 = "1";
const string st1 = "2 || 4";
const string st2 = "3";
const string st3 = "5 || 1";
const string st4 = "5";
const string st5 = "6 || 1";
const string st6 = "7";
const string st7 = "0 || 8";
const string st8 = "2||4||10||9";
const string st9 = "8||0";
const string st10 = "0";
const string dfalt = "4";


property rst;
ix.rst |-> ix.state == 0; 
endproperty

property s0;
ix.state == 0 ##1 ix.state == 1;
endproperty

property s1;
ix.state == 1 ##1 ix.state == 2 || ix.state ==4;
endproperty

property s2;
ix.state == 2 ##1 ix.state == 3;
endproperty

property s3;
ix.state == 3 ##1 ix.state == 5 ||ix.state == 1;
endproperty

property s4;
ix.state == 4 ##1 ix.state == 5 ;
endproperty

property s5;
ix.state == 5 ##1 ix.state == 6 || ix.state == 1;
endproperty

property s6;
ix.state == 6 ##1 ix.state == 7;
endproperty

property s7;
ix.state == 7 ##1 ix.state == 0 || ix.state == 8;
endproperty

property s8;
ix.state == 8 ##1 ix.state == 2||ix.state == 4||ix.state ==10||ix.state == 9;
endproperty

property s9;
ix.state == 9 ##1 ix.state == 8||ix.state == 0;
endproperty

property s10;
ix.state == 10 ##1 ix.state == 0;
endproperty

property dfault;
ix.state > 10 ##1 ix.state == 4;
endproperty


always @(posedge(ix.clk)) begin
assert property(rst)
//$display("Time:%d Reset assertion successful, current state = %d,reset = %d\n",$time,ix.state,ix.rst);
else
$warning("Reset assertion not successful, current state = %d,expected state = 0 reset = %d\n",ix.state,ix.rst);

assert property(disable iff(ix.rst) s0 or s1 or s2 or s3 or s4 or s5 or s6 or s7 or s8 or s9 or s10 or dfault)
 // $display("State %d assertion successful, current state = %d\n",ix.old_state,ix.state);
else 
  $warning("State %d assertion not successful, expected state = %s, current state = %d\n",ix.old_state,expected_state,ix.state);
end

always @(posedge(ix.clk)) begin
  $display(ix.state); 
case(ix.old_state)
      0: expected_state=st0;
      1: expected_state=st1;
      2: expected_state=st2;
      3: expected_state=st3;
      4: expected_state=st4;
      5: expected_state=st5;
      6: expected_state= st6;
      7: expected_state= st7;
      8: expected_state= st8;
      9: expected_state= st9;
      10: expected_state= st10;
      default: expected_state=dfalt;
endcase 
end
endmodule
