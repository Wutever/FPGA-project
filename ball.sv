//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input logic  frame_clk,
					input logic [15:0] keycode,
               output logic [9:0]  BallX, BallY); //, BallS );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;//, Ball_Size;
	 //logic [7:0] KEYCODE;
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

	 assign BallY = 300;
	 assign shape_size = 10'd100;
//    assign Ball_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ ( posedge frame_clk )
    begin: Move_Ball
     /*   if (Reset)  // Asynchronous Reset
        begin 
     //       Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
        end
           
        else 
		  
        begin */
		  	
	begin			
					
   unique case(keycode[7:0])	 
			
		/*	8'h1A:		begin
								Ball_X_Motion <= 10'd0;
				
				if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.	  
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= Ball_Y_Step;
				 else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max ) 
						 Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min ) 
						Ball_X_Motion <= Ball_X_Step;		
				 else 
							Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1); 
								
							end
		/*	8'h16:		begin
							Ball_X_Motion <= 10'd0;
							
		       if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= Ball_Y_Step;
				 else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max ) 
						 Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min ) 
						Ball_X_Motion <= Ball_X_Step;		
				 else 
					Ball_Y_Motion<= Ball_Y_Step;					
							end */
		/*	8'h04:		begin
							Ball_Y_Motion <= 10'd0;
							//if(Ball_X_Motion>0)
						
							//else
							//Ball_X_Motion<= Ball_X_Step;	
		  if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= Ball_Y_Step;
					  
				 
				 else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max ) 
						 Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min ) 
						Ball_X_Motion <= Ball_X_Step;		
				 else 
					Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1); 		
							end*/
			8'h07:		begin
							Ball_Y_Motion <= 10'd0;
							//if(Ball_X_Motion<0)
							//Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1); 
							//else
							
							
	          if ( (Ball_Y_Pos + shape_size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  
				 else if ( Ball_Y_Pos  <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= Ball_Y_Step;
					  
				 
				 else if ( (Ball_X_Pos + shape_size) >= Ball_X_Max ) 
						 Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if ( Ball_X_Pos  <= Ball_X_Min ) 
						Ball_X_Motion <= Ball_X_Step;		
				 else 
					Ball_X_Motion<= Ball_X_Step;			
							end

			default:      
			      /* begin
					      Ball_X_Motion <= Ball_X_Motion;
							Ball_Y_Motion <= Ball_Y_Motion;
					 end*/
			 begin
			 Ball_X_Motion <= 10'b0;
			 Ball_Y_Motion <= 10'b0;
			 /*   if ( (Ball_Y_Pos + shape_size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  
				 else if ( Ball_Y_Pos <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= Ball_Y_Step;
					  
				 
				 else if ( (Ball_X_Pos + shape_size) >= Ball_X_Max ) 
						 Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);// You need to remove this and make both X and Y respond to keyboard input
				 else if ( Ball_X_Pos <= Ball_X_Min ) 
						Ball_X_Motion <= Ball_X_Step;		
				 else 
					begin
						Ball_X_Motion <= Ball_X_Motion; 	
						Ball_Y_Motion <= Ball_Y_Motion; 
					end */
				end
			
			endcase
			
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      		
		end 

			
				
			
    end
       
    assign BallX = Ball_X_Pos;
   
  //  assign BallY = Ball_Y_Pos;
   
  //  assign BallS = Ball_Size;
    

endmodule
