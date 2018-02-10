module address(input [9:0] drawx,drawy,
					output OE,
					output [31:0] address
					//output [3:0] location
					);
assign OE=1'b0;					
assign address=(drawy*640+drawx);//(2d'16)
//assign location=(drawy*480+drawx)%(2d'16);
endmodule