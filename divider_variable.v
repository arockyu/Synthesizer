/////////////////////////////////////////////
/// N+1 Freqency divider 
/// input clk        : input clock
/// output out       : N+1 diveded clock out
/// input divide_num : N (Div Parameter)
/////////////////////////////////////////////

module divider_variable(
  input clk,
  output out,
  input [10:0] div_num);

  //registor definiton
  reg [10:0] count_p=0;
  reg [10:0] count_n=0;
  reg clk_p=0;
  reg clk_n=0;

  assign out = clk_p^clk_n;

  always @(posedge clk) begin
    count_p <= count_n+1;
    if (count_n >= div_num) begin
      count_p <= 0;
      clk_p <= ~clk_p;
    end else;
  end

  always @(negedge clk) begin
    count_n <= count_p+1;
    if (count_p >= div_num) begin
      count_n <= 0;
      clk_n <= ~clk_n;
    end else;
  end 
 
endmodule