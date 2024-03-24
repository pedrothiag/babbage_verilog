`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:20:11 03/23/2024 
// Design Name: 
// Module Name:    displaymux 
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
module displaymux(
    input [9:0] bin,
	 input clk,
    output reg [6:0] hex,
    output reg [2:0] dsel
    );

	//Converte o numero binario de entrada em tres numeros bcd
	wire [3:0] cen0, dez0, und0;
	bin2BCD u0 (.bin(bin), .cen(cen0), .dez(dez0), .und(und0));
	
	//Valor intermediario - Saida do Multiplexador
	reg [3:0] decinput;
	
	//Registrador de estado e codificação dos estados
	reg [1:0] state;
	parameter s0 = 0,
	          s1 = 1,
				 s2 = 2;
	
	//------------Maquina de estados para multiplexacao
	//Condicao inicial
	initial begin
		state = s0;
		dsel = 3'b110;
		decinput = und0;
	end
	
	//Diagrama de transicoes
	always @(negedge clk) begin
		case(state)
			//unidade
			s0: begin
				dsel = 3'b110;
				decinput = und0;
				state = s1;
			end
			//dezena
			s1: begin
				dsel = 3'b101;
				decinput = dez0;
				state = s2;
			end
			//centena
			s2: begin
				dsel = 3'b011;
				decinput = cen0;
				state = s0;
			end
			//default
			default: begin
				dsel = 3'b110;
				decinput = und0;
				state = s1;
			end
		endcase
	end
	
	//------------Decodificador para display de sete segmentos
	always @* begin
		case(decinput)
			4'b0000: hex = 7'b1000000;
			4'b0001: hex = 7'b1111001;
			4'b0010: hex = 7'b0100100;
			4'b0011: hex = 7'b0110000;
			4'b0100: hex = 7'b0011001;
			4'b0101: hex = 7'b0010010;
			4'b0110: hex = 7'b0000010;
			4'b0111: hex = 7'b1111000;
			4'b1000: hex = 7'b0000000;
			4'b1001: hex = 7'b0010000;
			default: hex = 7'b1000000;
		endcase
	end
endmodule
