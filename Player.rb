require 'gosu'
require_relative 'game'
require_relative 'board'

class Player
	#called at the very start
	def initialize(board, color, window)
		@color = color
		@window = window
		@board = board
	end
	
	#called every frame during your turn, return string "end" to end your turn
	def take_turn(number)
		
	end
	
	#move a piece to a location, or return an error(?)
	def make_move(piece, location)
		if valid_move?(piece, location)
			piece.set_pos(location)
			else
			return nil
		end
	end
	
	#return true if the move can be made
	def valid_move?(piece, location)
		if valid?(piece, location) == false
			return false
		end
		
		if location_at_offset?(piece, location, 1, 1)
			return true
		end
		
		if location_at_offset?(piece, location, -1, 1)
			return true
		end
		
		if location_at_offset?(piece, location, 1, -1)
			return true
		end
		
		if location_at_offset?(piece, location, -1, -1)
			return true
		end
		
		return valid_jump?(piece, location)
	end
	
	#Is this a valid jump?
	def valid_jump?(piece, location)
		if valid?(piece, location) == false
			return nil
		end
		
		if location_at_offset?(piece, location, 2, 2)
			ret = @board.piece(Location.new(location.x + 1, location.y + 1))
			
			if ret != nil && ret.get_owner != @color
				return ret
			end
		end
		
		if location_at_offset?(piece, location, -2, 2)
			ret = @board.piece(Location.new(location.x - 1, location.y + 1))
			
			if ret != nil && ret.get_owner != @color
				return ret
			end
		end
		
		if location_at_offset?(piece, location, 2, -2)
			ret = @board.piece(Location.new(location.x + 1, location.y - 1))
			
			if ret != nil && ret.get_owner != @color
				return ret
			end
		end
		
		if location_at_offset?(piece, location, -2, -2)
			ret = @board.piece(Location.new(location.x - 1, location.y - 1))
			
			if ret != nil && ret.get_owner != @color
				return ret
			end
		end
		
		return nil
	end
	
	def location_at_offset?(piece, location, offX, offY)
		if (location.x + offX == piece.get_pos.x) && (location.y + offY == piece.get_pos.x)
			return true
		end
		
		return false
	end
	
	def valid?(piece, location)
		if piece.get_owner() == @color
			return false
		end
		
		if @board.piece_at(location) != nil
			return false
		end
		
		if (@color == "red") && (location.y > piece.get_pos.y) && (piece.king == false)
			return false
			elsif (location.y < piece.get_pos.y) && (piece.king == false)
			return false
		end
		
		return true
	end
	
	#get the list of pieces in your color
	def my_pieces()
		return @board.get_pieces_by_owner(@color)
	end
end
