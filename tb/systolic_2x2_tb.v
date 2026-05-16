`timescale 1ns/1ps

module systolic_2x2_tb;

reg clk;
reg reset;

reg signed [7:0] a0;
reg signed [7:0] a1;

reg signed [7:0] b0;
reg signed [7:0] b1;

wire signed [31:0] c00;
wire signed [31:0] c01;
wire signed [31:0] c10;
wire signed [31:0] c11;



// Instantiate DUT
systolic_2x2 dut (

    .clk(clk),
    .reset(reset),

    .a0(a0),
    .a1(a1),

    .b0(b0),
    .b1(b1),

    .c00(c00),
    .c01(c01),
    .c10(c10),
    .c11(c11)

);


// Clock
always #5 clk = ~clk;


initial begin

    $dumpfile("sim/systolic_2x2.vcd");
    $dumpvars(0, systolic_2x2_tb);

    clk = 0;
    reset = 1;

    a0 = 0;
    a1 = 0;

    b0 = 0;
    b1 = 0;

    #10;
    reset = 0;

       //
    // SKEWED MATRIX STREAMING
    //

    // Cycle 1
    a0 = 1;
    a1 = 0;

    b0 = 5;
    b1 = 0;

    #10;

    // Cycle 2
    a0 = 2;
    a1 = 3;

    b0 = 7;
    b1 = 6;

    #10;

    // Cycle 3
    a0 = 0;
    a1 = 4;

    b0 = 0;
    b1 = 8;

    #10;

    // Flush zeros
    a0 = 0;
    a1 = 0;

    b0 = 0;
    b1 = 0;

    #50;

    $finish;

end



initial begin

    $monitor(
        "T=%0t | c00=%0d c01=%0d c10=%0d c11=%0d",
        $time,
        c00,
        c01,
        c10,
        c11
    );

end

endmodule