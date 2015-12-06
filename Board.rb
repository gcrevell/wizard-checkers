require 'gosu'
require_relative 'Piece'
require_relative 'Location'

#require other files as needed

#Board class.  Establishes board properties, getters and setters.

class Board
  #constructor
  def initialize(width=8, height=8)
    #define the attributes
    @left_edge = (640-48*width)/2 #(window width - (board cells * cell width))/2
    @top_edge = (480-48*height)/2 #(window height - (board cells * cell height))/2
    @right_edge = @left_edge + 48*width
    @bottom_edge = @top_edge + 48*height
    @board_dims = Array.new(2)
    @pieces = Array.new
    @captured = Array.new
	#load graphics!
	@piece_icon = Gosu::Image::load_tiles("checkers.bmp", 48, 48)
	@board_back = Gosu::Image.new("checkerboard.bmp") #8x8 of 48x48 tiles
	@table_back = Gosu::Image.new("table.bmp") #a 640x480 wood texture
    #set board dimensions
    @board_dims[0] = width
    @board_dims[1] = height
    puts "Creating new Board!"
    populate()
  end
  
  #draws the board
  def draw()
	#draw the table background
	@table_back.draw(0, 0, 0)
	#draw the board at its specified position
	@board_back.draw(@left_edge, @top_edge, 1)
	#loop through the pieces in the grid and draw them at their positions (x*48, y*48), offset from top-left of board sprite
	for p in @pieces
		px = p.get_pos.x
		py = p.get_pos.y
		@piece_icon[p.get_frame].draw(@left_edge+48*px, @top_edge+48*py, 2)
	end
	#draw captured pieces down the sides
	red_row = red_col = 0
	black_row = black_col = 0
	for p in @captured
		if p.owner == "red" #red case
			@piece_icon[p.get_frame].draw(@left_edge-48*(red_col+1), @top_edge+48*red_row, 2)
			red_row += 1
			if red_row >= 2
				red_col += 1
				red_row = 0
			end
		else #black case
			@piece_icon[p.get_frame].draw(@right_edge+48*black_col, @bottom_edge-48*(black_row+1), 2)
			black_row += 1
			if black_row >= 2
				black_col += 1
				black_row = 0
			end
		end
	end
  end
  
  #do initial population of pieces array
  def populate()
    #create the black piece along the top
	for i in 0...@board_dims[0]
		for j in 0...3
			#only populate black squares, which start at 0, 0
			if (i+j)%2 == 0
				add_piece(Piece.new(i, j, "black"))
			end
		end
	end
	#and red pieces along the bottom
	for i in 0...@board_dims[0]
		for j in (@board_dims[1]-3)...@board_dims[1]
			#only populate black squares, which start at 0, 0
			if (i+j)%2 == 0
				add_piece(Piece.new(i, j, "red"))
			end
		end
	end
  end
  
  #adds piece to pieces to piece list
  def add_piece(piece)
    @pieces << piece
  end
  
  #checks position of a given piece
  def check_pos(piece)
    
    
  end
  
  #captures piece
  def capture(piece)
    #add piece to captured list
    @captured << piece
    #remove piece from playable pieces
    @pieces.delete(piece)
  end
  
  #returns uncaptured pieces
  def get_pieces()
    return @pieces
  end
  
  #return the piece at a specified location, or nil if there isn't one
  def piece_at(location)
    #how does it find the piece? somehow! It just need to be able to do so
    
    
  end
  
  #returns captured pieces
  def get_captured()
    return @captured
  end
  
  def get_pieces_by_owner(color)
    #set up a filter to return only pieces that match the specified
    @pieces_by_owner = Array.new
    
    for p in @pieces
      if p.owner == color
        @owner << p
      end
    end
    
    return @pieces_by_owner
  end
  
end