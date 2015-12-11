require 'gosu'
require_relative 'Board'
require_relative 'Player'
#require_relative 'BasicAI'
require_relative 'WizardAI'

class Game
	#called at the very start
	def initialize (window = nil)
		@window = window #required to track mouse input from the player
		@board = Board.new(8, 8)
		#these two will hold the player and computer players soon enough
		@player = Player.new(@board, "red", @window)
		#@computer = BasicAI.new(@board, "black", @window)
		@computer = WizardAI.new(@board, "black", @window)
		@turn = 0 #players turn at the start
		puts "player starts"

		@title = Gosu::Font.new(50)
		@subtitle = Gosu::Font.new(20)
		@scroll = -80
	end

	#called once per frame in a loop, manages game logic
	def play
		#check the win condition here, and skip play input if it's true
		if @board.winner
			@scroll += 2 unless @scroll > 200
		else
			if @turn == 0
				#on player turns, see the player's opinion
				if @player.take_turn == "end"
					@turn = 1
					puts "computer turn"
				end
			else
				#on any other turn, it's the computer's chance to shine
				if @computer.take_turn == "end"
					@turn = 0
					puts "player turn"
				end
			end
		end
	end

	#called after play each frame, updates the display
	def draw
		@board.draw
		@player.draw
		@computer.draw
		if @board.winner == "red"
			#text output for victorious party here!
			@title.draw("YOU WON!", 215, @scroll, 10, 1.0, 1.0, 0xff_FD0000)
			@subtitle.draw("The wizard is vanquished!", 225, @scroll+50, 10, 1.0, 1.0, 0xff_FD0000)
		elsif @board.winner == "black"
			#text output for victorious party here!
			@title.draw("YOU LOSE...", 195, 400-@scroll, 10, 1.0, 1.0, 0xff_555555)
			@subtitle.draw("The wizard laughs at you", 210, 450-@scroll, 10, 1.0, 1.0, 0xff_555555)
		end
	end
end
