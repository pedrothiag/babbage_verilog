`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:38 03/24/2024 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
    input clk,
    input rst,
    input start,
	 input nextn,
    output [6:0] hex,
    output [2:0] dsel
    );

	wire [9:0] outdata_bin;
	babbage u0 (.clk(clk), .rst(rst), .start(start), .nextn(nextn), .outdata(outdata_bin));
	displaymux u1 (.bin(outdata_bin), .clk(clk), .hex(hex), .dsel(dsel));

endmodule
