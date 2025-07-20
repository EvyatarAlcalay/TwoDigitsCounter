module counter(en,reset,clk,out_to_disp,end_count); //This is a module of counter which
                                                    //count ftom 0 to 9 and after that back to zero
																	 //outputs a binary namber (his "state")
	
	//decleration on input and outputs
	input wire en; //the data which enter to the couter and activate it
	input wire reset; //reset of the counter (reset if reset=0)
	input wire clk; //clock of the counter
	output reg [3:0] out_to_disp; //4 bits binary number represent the state of the counter
	output reg end_count; //a bit which on when finish to count until 9 (to progress the second counter)
		
	//action
	always @(posedge clk or negedge reset)
	begin
		if (~reset) //if reset =0 then reset the counter
			begin
				out_to_disp <= 4'b0000;
				end_count <= 1'b0;
			end
		else 
			if(en) //if the enable is on then progress the counter
			begin
				if (out_to_disp == 4'b1001) //if the counter is 9 then zero it next cycle and activate the next counter
					begin
						out_to_disp <= 4'b0000;
						end_count <= 1'b1;
					end 
				else 
				begin
					out_to_disp <= out_to_disp + 4'b0001;
					end_count <= 1'b0;	
				end
			end
		 else 
			end_count <= 1'b0;	
	end
	
endmodule
