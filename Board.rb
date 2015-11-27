require 'gosu'
require_relative 'Location'

#require other files as needed

#Board class.  Establishes board properties, getters and setters.

class Board
  #constructor
  def initialize(width=8, height=8, player=nil, computer=nil)
    #define the attributes
    @board_dims = Array.new(2)
    @pieces = Array.new
    @captured = Array.new
    @locations = Array.new(width)
	#load graphics!
	@piece_icons = Gosu::Image::load_tiles("checkers.bmp", 32, 32)
	#@board_back = Gosu::Image.new("board.bmp")
    #set board dimensions
    @board_dims[0] = width
    @board_dims[1] = height
    puts "Creating new Board!"
	#populate the locations
	for i in 0..width
		@locations[i] = Array.new(height)
		for j in 0..height
			@locations[i][j] = Location.new(i, j)
		end
	end
	populate(player, computer)
  end
  
  #draws the board
  def draw()
    print "I'm drawing!"
  end
  
  #do initial population of pieces array
  def populate(player=nil, computer=nil)
    #initialize pieces, set color, location, and owner put in pieces array
  end
  
  #adds piece to pieces to piece list
  def add_piece(piece)
    @pieces << piece
  end
  
  #checks position of a given piece
  def check_pos()
    
  end
  
  #captures piece
  def caputre(piece)
    #add piece to captured list
    @captured << piece
    #remove piece from playable pieces
    @pieces.delete(piece)    
  end
  
  #returns uncaptured pieces
  def get_pieces()
    return @pieces, @captured
  end
  
end