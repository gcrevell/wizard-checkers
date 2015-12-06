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

	#called every frame during your turn, return "end" to end your turn
	def take_turn(number)
		
	end

	#move a piece to a location, or return an error(?)
	def make_move(piece, location)
		if valid_move?(piece, location)
			piece.positon = location
		else
			return nil
		end
	end

	#return true if the move can be made
	def valid_move?(piece, location)
		if piece.get_owner() == @color
			return false
		end
		
		if @board.piece_at(location) != nil
			return false
		end
		
		if (@color == "red") && (location.y > piece.positon.y) && (piece.king == false)
			return false
		elsif (location.y < piece.positon.y) && (piece.king == false)
			return false
		end
		
		for i in 1..2
			if (location.x + i == piece.positon.x) && (location.y + i == piece.positon.x)
				return true
			end
			
			if (location.x - i == piece.positon.x) && (location.y + i == piece.positon.x)
				return true
			end
			
			if (location.x + i == piece.positon.x) && (location.y - i == piece.positon.x)
				return true
			end
			
			if (location.x - i == piece.positon.x) && (location.y - i == piece.positon.x)
				return true
			end
		end
	end

	#get the list of pieces in your color
	def my_pieces()
		return @board.get_pieces_by_owner(@color)
	end
end
