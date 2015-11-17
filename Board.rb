require 'gosu'

#require other files as needed

#Board class.  Establishes board properties, getters and setters.

class Board
  #Create board properties
  @@board_dims = Array.new(2)
  @@pieces = Array.new
  @@captured = Array.new
  
  
  #constructor
  def new(width=8, height=8)
    @@board_dims[0] = width
    @@board_dims[1] = height
    puts "Creating new Board!"
  end
  
  #draws the board
  def draw()
    print "I'm drawing!"
  end
  
  #do initial population of pieces array
  def populate()
    #initialize pieces, set color and location, put in pieces array
  end
  
  #adds piece to pieces to piece list
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
    return @@pieces, @@captured
  end
  
end