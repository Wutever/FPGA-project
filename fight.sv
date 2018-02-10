module fight(input logic [9:0] addr,frame_clk,
					 output logic [0:99]data);
		  
enum logic [2:0] {stand, fight1, fight2}state, next_state;		
logic [4:0] counter; 
parameter stand_width = 100;
parameter stand_lenth = 100;


parameter [0:stand_lenth-1][0:stand_width-1] ROM = {
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111100000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000000000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000000000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111100000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111100000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000000111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000000000111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111000000011000001000000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111110000000010000001100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111110000000110000001100000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111100000001110000001110000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111100000001110000011111000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111000000011110000011111000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111000000111110000011111100000001111111111111111111111111111111111111,
100'b1111111111111111111111111111111110000000111110000011111110000001111111111111111111111111111111111111,
100'b1111111111111111111111111111111110000001111100000011111110000000111111111111111111111111111111111111,
100'b1111111111111111111111111111111110000001111100000011111111000000011111111111111111111111111111111111,
100'b1111111111111111111111111111111110000001111100000011111111100000011111110001111111111111111111111111,
100'b1111111111111111111111111111111110000001111100000011111111100000001110000000111111111111111111111111,
100'b1111111111111111111111111111111110000001111100000011111111110000000000000000111111111111111111111111,
100'b1111111111111111111111111111111110000011111100000011111111111000000000000000111111111111111111111111,
100'b1111111111111111111111111111111110000011111100000011111111111000000000000001111111111111111111111111,
100'b1111111111111111111111111111111110000011111100000011111111111100000000000011111111111111111111111111,
100'b1111111111111111111111111111111110000011111100000001111111111110000000011111111111111111111111111111,
100'b1111111111111111111111111111111110000011111100000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111110000011111100000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111110000011111100000000111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111110000011111100000000111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111110000011111100000000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111110000111111100000000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111001111111100000000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000001000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000001000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000001000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000011100000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000011100000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000011100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000011100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000011100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000111110000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000111110000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000111110000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000001111110000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000001111110000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000001111110000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000011111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000011111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000011111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000111111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000111111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000111111111000000000011111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000001111000000000001111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000111000000000000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000111000000000000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000111100000000001111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
};

parameter [0:stand_lenth-1][0:stand_width-1] ROM1 = {
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111100000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000000000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000000000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111100000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111110000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111110000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111110000001111111111000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111100000001111111110000011111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111000000000111111110000011111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111000000000111111100000011111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000111111100000011111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111100000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000000000111000000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000000000000111000000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000000110000001111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000000100000001111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000000000000000111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000110000000001111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000011111000000001111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000011111100000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000011111110000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000001000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000001000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000001000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000011100000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000011100000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000011100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000011100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000011100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000111110000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000111110000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000111110000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000001111110000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000001111110000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000001111110000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000011111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000011111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000011111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000111111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000111111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000111111111000000000011111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000001111000000000001111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000111000000000000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000111000000000000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000111100000000001111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000001111111111110011111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,

};

parameter [0:stand_lenth-1][0:stand_width-1] ROM2 = {
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111100000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000000000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000000000000000011111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000000000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111100000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111110000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111100000000111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111000000000000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000000000000000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000000000000000000000000000001111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000000000000000000000000000000000011111111111111111111,
100'b1111111111111111111111111111111111111111100000000000000000000000000000000000000001111111111111111111,
100'b1111111111111111111111111111111111111111000000000000000010000000000000000000000001111111111111111111,
100'b1111111111111111111111111111111111111110000000000000011111111111000000000000000001111111111111111111,
100'b1111111111111111111111111111111111111100000000000000111111111111111111000000000001111111111111111111,
100'b1111111111111111111111111111111111111000000000000000111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111110000000110000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111100000001110000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111100000011110000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111100000111110000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111100000111110000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111100000011110000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111100000001100000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111110000000100000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111110000000000000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111000000000000111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111100000000000111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111110000000000111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000001111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000000011111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000001111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000011111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000000000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000001000001111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000001000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000001000000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000011100000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000011100000111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111110000011100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000011100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000011100000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111100000111110000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000111110000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000000111110000011111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111000001111110000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000001111110000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000001111110000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111110000011111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000011111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000011111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000111111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000111111111000001111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000111111111000000000011111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000001111000000000001111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000111000000000000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111000000000000111000000000000111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000000111100000000001111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111100000000001111111111110011111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111000011111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
100'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111,
};


always_ff @(posedge frame_clk) begin
	state <= next_state;
	if(counter == 5'd10) 
		counter <= 5'b0;
	else 
		counter <= counter + 1'b1;
	end
	
always_comb 
	begin
	next_state = state;
		case(state) 
		stand:
			if(counter == 5'd9)
			next_state = fight1;
			else 
			next_state = stand;
		fight1:
			if(counter == 5'd9)
			next_state = fight2;
			else
			next_state = fight1;
		fight2:
			if(counter == 5'd9)
			next_state = stand;
			else
			next_state = fight2;

		endcase
	end

always_comb 
	begin
	data = data;
		case(state) 
		stand:
			data = ROM[addr][0:99];
		fight1:
			data = ROM1[addr][0:99];
		fight2:
			data = ROM2[addr][0:99];
		endcase
	end

	
	

endmodule 