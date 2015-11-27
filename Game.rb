require 'gosu'
require_relative 'Board'
require_relative 'Player'

class Game
	#called at the very start
	def initialize
		#these two will be replaced by the player objects in due time
		@player = nil
		@computer = nil
		@board = Board.new(8, 8, @player, @computer)
	end

	#called once per frame in a loop, manages game logic
	def play
	end

	#called after play each frame, updates the display
	def draw
		@board.draw
		#other decorations here
	end
end