require 'gosu'
require 'Board'
require 'Player'

class Game
	#called at the very start
	def initialize
		@board = Board.new
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