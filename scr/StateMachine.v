`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:41:54 03/26/2024 
// Design Name: 
// Module Name:    StateMachine 
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
module StateMachine(
	 input clk,
    output reg [2:0] dsel
    );
	 	
	//Registrador de estado e codifica??o dos estados
	reg [1:0] state;
	parameter s0 = 0,
	          s1 = 1,
				 s2 = 2;
	
	//------------Maquina de estados para multiplexacao
	//Estado Proximo
	always @(posedge clk) begin
		case(state)
			//unidade
			s0: begin
				state <= s1;
				dsel <= 3'b110;
			end
			//dezena
			s1: begin
				state <= s2;
				dsel <= 3'b101;
			end
			//centena
			s2: begin
				state <= s0;
				dsel <= 3'b011;
			end
			//default
			default: begin
				state <= s0;
				dsel <= 3'b110;
			end
		endcase
	end
endmodule
