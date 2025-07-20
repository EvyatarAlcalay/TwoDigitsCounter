module mainQ1(clk, reset, display1, display2,en1,end_count_1); //This is the main modoule which contain 2 counters:
																					//one for the seconds and one for the ten-seconds, LPM counter
																					//which count the seconds and display instance which display every
																					//counter on the card
	//declertaion input and output
	input clk; //clock of the system
	input reset; //reset of the system
	output wire[6:0] display1; //display on the counter the seconds
	output wire[6:0] display2; //display on the counter the ten-seconds 
	output en1;
	output end_count_1;
	
	
	//decleration on internal and on other nessesary things
	wire[25:0] q_sig;
	wire en1;
	wire end_count_1;
	wire[3:0] out_to_disp1;
	wire[3:0] out_to_disp2;
	wire end_count_2;

	
	//objects
	//create the LPM instance (to maintain the seconds, ensure that every second the clock is going on
	LPM	LPM_inst (
	.aclr ( ~reset ),
	.clock ( clk ),
	.cout ( en1 ), //output 1 bit
	.q ( q_sig ) ///output 26bitd
	);
	 
	//create the counter of the seconds
	counter c1(.en(en1),.reset(reset),.clk(clk),.out_to_disp(out_to_disp1),.end_count(end_count_1));
	//create the counter of the ten seconds
	counter c2(.en(end_count_1),.reset(reset),.clk(clk),.out_to_disp(out_to_disp2),.end_count(end_count_2));
	//create the decoder of the seconds
	display d1(out_to_disp1,display1);
	//create the decoder of the ten seconds
	display d2(out_to_disp2,display2);
	
	//
	
endmodule
