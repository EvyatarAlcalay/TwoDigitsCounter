module display(data_in,display); //This is a module of decoder from the binary number
											//the counter output to present it on the card in HEXA
	
	//decleration on input and output
	input [3:0] data_in;
	output reg [6:0] display;

	
	//declerations input parameters
	parameter INNUM0 = 4'b0000;
	parameter INNUM1 = 4'b0001;
	parameter INNUM2 = 4'b0010;
	parameter INNUM3 = 4'b0011;
	parameter INNUM4 = 4'b0100;
	parameter INNUM5 = 4'b0101;
	parameter INNUM6 = 4'b0110;
	parameter INNUM7 = 4'b0111;
	parameter INNUM8 = 4'b1000;
	parameter INNUM9 = 4'b1001;
	
	//declerations outpur parameters (1 OFF, 0 ON)
	parameter OUTNUM0 = 7'b1000000;
	parameter OUTNUM1 = 7'b1111001;
	parameter OUTNUM2 = 7'b0100100;
	parameter OUTNUM3 = 7'b0110000;
	parameter OUTNUM4 = 7'b0011001;
	parameter OUTNUM5 = 7'b0010010;
	parameter OUTNUM6 = 7'b0000010;
	parameter OUTNUM7 = 7'b1111000;
	parameter OUTNUM8 = 7'b0000000;
	parameter OUTNUM9 = 7'b0010000;
	
	always @(data_in)
	begin
		case(data_in)
			INNUM0:
				display = OUTNUM0;
			INNUM1:
				display = OUTNUM1;
			INNUM2:
				display = OUTNUM2;
			INNUM3:
				display = OUTNUM3;
			INNUM4:
				display = OUTNUM4;
			INNUM5:
				display = OUTNUM5;
			INNUM6:
				display = OUTNUM6;
			INNUM7:
				display = OUTNUM7;
			INNUM8:
				display = OUTNUM8;
			INNUM9:
				display = OUTNUM9;
		endcase
	end
	
endmodule
