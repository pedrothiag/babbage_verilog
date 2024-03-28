`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:55:14 03/16/2024 
// Design Name: 
// Module Name:    vsprocessor 
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
module babbage (clk, rst, start, nextn, outdata);
	input clk, rst, start, nextn;
	output [9:0] outdata;
	
	reg [9:0] h, f, g;
	reg [4:0] n;
	reg [2:0] state;
	
	parameter inicio = 0,
	          espera = 1,
				 espera_sync = 2,
				 setar = 3,
				 calculo = 4,
				 waitnext = 5,
				 waitnext_sync = 6;
	
	//Condicao inicial
	initial begin
		state = inicio;
		h = 10'd0;
		f = 10'd0;
		g = 10'd0;
		n = 5'd0;
	end	
	
	always @(posedge clk or negedge rst) begin
		if(~rst) begin
			state = inicio;
			h = 10'd0;
			f = 10'd0;
			g = 10'd0;
			n = 5'd0;
		end
		
		else begin
			case(state)
				//Inicio
				inicio: begin
					h = 10'd0;
					f = 10'd0;
					g = 10'd0;
					n = 5'd0;
					state = espera;
				end
				
				//Espera
				espera: begin
					if(start == 1'b0) state = espera_sync;
					else state = espera;
				end
				
				//Espera_Sync
				espera_sync: begin
					if(start == 1'b1) state = setar;
					else state = espera_sync;
				end
				
				//Setar
				setar: begin
					h = 10'd1;
					f = 10'd5;
					g = 10'd10;
					state = calculo;
				end
				
				//Calculo
				calculo: begin
					h = h + f;
					f = f + g;
					g = g + 10'd6;
					n = n + 5'd1;
					state = waitnext;
				end
				
				//WaitNext
				waitnext: begin
					if(nextn == 1'b1) state = waitnext;
					else state = waitnext_sync;
				end
				
				//WaitNext_Sync
				waitnext_sync: begin
					if(nextn == 1'b0) state = waitnext_sync;
					else state = calculo;
				end
				
				//Default
				default: state = inicio;
			endcase
		end
	end
	
	assign outdata = h;
endmodule
	