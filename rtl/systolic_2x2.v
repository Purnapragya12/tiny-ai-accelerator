module systolic_2x2 (

    input clk,
    input reset,

    input signed [7:0] a0,
    input signed [7:0] a1,

    input signed [7:0] b0,
    input signed [7:0] b1,

    output signed [31:0] c00,
    output signed [31:0] c01,
    output signed [31:0] c10,
    output signed [31:0] c11

);

//
// Internal interconnect wires
//

wire signed [7:0] a00_to_01;
wire signed [7:0] a10_to_11;

wire signed [7:0] b00_to_10;
wire signed [7:0] b01_to_11;


//
// PE00
//
pe pe00 (
    .clk(clk),
    .reset(reset),

    .a_in(a0),
    .b_in(b0),

    .a_out(a00_to_01),
    .b_out(b00_to_10),

    .acc(c00)
);


//
// PE01
//
pe pe01 (
    .clk(clk),
    .reset(reset),

    .a_in(a00_to_01),
    .b_in(b1),

    .a_out(),
    .b_out(b01_to_11),

    .acc(c01)
);


//
// PE10
//
pe pe10 (
    .clk(clk),
    .reset(reset),

    .a_in(a1),
    .b_in(b00_to_10),

    .a_out(a10_to_11),
    .b_out(),

    .acc(c10)
);


//
// PE11
//
pe pe11 (
    .clk(clk),
    .reset(reset),

    .a_in(a10_to_11),
    .b_in(b01_to_11),

    .a_out(),
    .b_out(),

    .acc(c11)
);

endmodule