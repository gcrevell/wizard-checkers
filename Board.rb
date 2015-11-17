require 'gosu'

#require other files as needed

#Board class.  Establishes board properties, getters and setters.

class Board
  #Create board properties
  @@b_width = 8
  @@b_height = 8
  @@pieces = Array.new
  @@captured = Array.new
  @@locations = Array.new(8, Array.new(8))
  
  
  #constructor
  def new()
    puts "Creating new Board!"
	for i in 0..7
		for j in 0..7
			locations[i][j] = Location.new(i, j)
		end
	end
  end
  
  #draws the board
  def draw()
    print "I'm drawing!"
  end
  
  #adds piece to pieces hash
  def add_piece(piece)
    @@pieces << piece
  end
  
  #checks position of a given piece
  def check_pos()
    
  end
  
  #captures piece
  def caputre(piece)
    #add piece to captured list
    @@captured << piece
    #remove piece from playable pieces
    @@pieces.delete(piece)    
  end
  
  #returns uncaptured pieces
  def get_pieces()
    return @@pieces    
  end
  
end