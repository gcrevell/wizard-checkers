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
		
	end

	#get the list of pieces in your color
	def my_pieces()
		return @board.get_pieces_by_color(@color)
	end
end
