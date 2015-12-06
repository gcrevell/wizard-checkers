require 'gosu'
require_relative 'Board'
require_relative 'Player'

class Game
	#called at the very start
	def initialize (window = nil)
		@window = window #required to track mouse input from the player
		#these two will hold the player and computer players soon enough
		@player = Player.new("red")
		@computer = nil #Player.new("black")
		@board = Board.new(8, 8)
		@turn = 0 #players turn at the start
	end

	#called once per frame in a loop, manages game logic
	def play
		#check the win condition here, and skip play input if it's true
		if @turn == 0
			@player.take_turn
			#on player turns, see the player's opinion
			#if @player.take_turn == "end"
				#@turn = 1
			#end
			#print "player's turn!"
		else
			#on any other turn, it's the computer's chance to shine
			#if @computer.take_turn == "end"
				#@turn = 0
			#end
			#print "computer's turn!"
		end
	end

	#called after play each frame, updates the display
	def draw
		@board.draw
		#draw player scoring or something here?
	end
end
