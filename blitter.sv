/*module blitter( input[9:0] figure1positionx,
					 input[9:0] figure1positiony,
					 input[2:0]	status,
					 input[3:0] run1data,
					 input[3:0] run2data,
					 input[3:0] fightdata,
					 input[3:0] fight1data,
					 input[3:0] kick1data,
					 input[3:0] kick2data,
					 input[3:0] stand,
					 input[3:0] inputdata,
					 output[18:0]inputaddress,
					 output[18:0]outputaddress,
					 output[3:0]outputdata,
					 output  WE
						);
				enum logic[3:0] (start,readdata,writedata)*/
				
module blitter(
					input logic[9:0] positionX, DrawX, DrawY, positionY,
					input logic [2:0] data1,
					input logic frame_clk, 
					output logic [7:0]  Red, Green, Blue);
					
logic [9:0]  addr,shape_size;
logic [0:99] data;
//logic [9:0] positionX;
//logic [9:0] positionY;
logic shape_on, background;//, shape_on1;

//logic [99:0] counter;
//enum logic[3:0] {Wait, Paint} state, next_state;

//assign positionX = 10'd200;
//assign positionY = 10'd300;
assign shape_size = 10'd100;
standpic standpic0(.addr(addr), .frame_clk(frame_clk),
                   .data(data));

//assign data = 100'b0;
/*always_ff @ (posedge Clk) begin

 state <= next_state;
 end
 
 always_comb begin
	next_state = state;
	case (state)*/
always_comb	begin
if(DrawX >= positionX && DrawX < (positionX + shape_size) &&
   DrawY >= positionY && DrawY < (positionY + shape_size))
    begin 
	 addr = 	DrawY-positionY;
	 shape_on = 1'b1;
	 background = 1'b0;
// 	 shape_on1 = 1'b0;
	 end
	 else 
	 begin
	 shape_on = 1'b0;
//	 shape_on1 = 1'b1;
	 background = 1'b1;
	 addr = 10'b0;
	 end
end
	 
always_comb
begin
	if((shape_on == 1'b1) && data[DrawX-positionX] == 1'b0)
	begin
		Red = 8'h00;
		Green = 8'h00;
		Blue = 8'h00;
	end
	
	
	  else  if (background == 1'b1 && data1 == 3'h0) 
        begin 
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
        end
     else  if (background == 1'b1 && data1 == 3'h1) 
        begin 
            Red = 8'hff;
            Green = 8'h0;
            Blue = 8'h0;
        end 
     else  if (background == 1'b1 && data1 == 3'h2) 
        begin 
            Red = 8'hff;
            Green = 8'h80;
            Blue = 8'h0;
        end
     else  if (background == 1'b1 && data1 == 3'h3) 
        begin 
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h0;
        end
	 else  if (background == 1'b1 && data1 == 3'h4) 
        begin 
            Red = 8'h0; 
            Green = 8'hff;
            Blue = 8'h0 ;//- DrawX[9:3]
        end
	 else  if (background == 1'b1 && data1 == 3'h5) 
        begin 
            Red = 3'h0; 
            Green = 8'h0;
            Blue = 8'hff ;//- DrawX[9:3]
        end
	 else  if (background == 1'b1 && data1 == 3'h6) 
        begin 
            Red = 8'h0; 
            Green = 8'hff;
            Blue = 8'hff ;//- DrawX[9:3]
        end
	else
			 begin 
            Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff ;//- DrawX[9:3]
        end
end
	
endmodule						