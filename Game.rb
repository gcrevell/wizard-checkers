require 'gosu'
require_relative 'Board'
require_relative 'Player'

class Game
	#called at the very start
	def initialize
		#these two will hold the player and computer players soon enough
		@player = nil
		@computer = nil
		@board = Board.new(8, 8)
		@turn = 0 #players turn at the start
	end

	#called once per frame in a loop, manages game logic
	def play
		if @turn == 0
			#on player turns, see the player's opinion
			#@turn = @player.take_turn
			#print "player's turn!"
		else
			#on any other turn, it's the computer's chance to shine
			#@turn = @computer.take_turn
			#print "computer's turn!"
		end
	end

	#called after play each frame, updates the display
	def draw
		@board.draw
		#other decorations here
	end
end