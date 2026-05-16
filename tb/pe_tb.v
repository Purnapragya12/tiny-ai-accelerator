`timescale 1ns/1ps

module pe_tb;

reg clk;
reg reset;

reg signed [7:0] a_in;
reg signed [7:0] b_in;

wire signed [7:0] a_out;
wire signed [7:0] b_out;

wire signed [31:0] acc;


// Instantiate PE
pe uut (
    .clk(clk),
    .reset(reset),
    .a_in(a_in),
    .b_in(b_in),
    .a_out(a_out),
    .b_out(b_out),
    .acc(acc)
);


// Clock generation
always #5 clk = ~clk;


initial begin

    // Dump waveform
    $dumpfile("sim/pe_wave.vcd");
    $dumpvars(0, pe_tb);

    // Initialize
    clk = 0;
    reset = 1;
    a_in = 0;
    b_in = 0;

    #10;
    reset = 0;

    // Cycle 1
    a_in = 1;
    b_in = 5;

    #10;

    // Cycle 2
    a_in = 2;
    b_in = 7;

    #10;

    // Cycle 3
    a_in = 3;
    b_in = 4;

    #10;

    // Cycle 4
    a_in = -2;
    b_in = 6;

    #10;

    $finish;

end


initial begin
    $monitor(
        "TIME=%0t | a_in=%0d b_in=%0d | acc=%0d",
        $time,
        a_in,
        b_in,
        acc
    );
end

endmodule