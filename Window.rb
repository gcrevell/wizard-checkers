require 'gosu'
require_relative 'Game'
#require the other files as needed here!

#the main game class
class GameWindow < Gosu::Window
	#set up function, run on game start
	def initialize
		super 640, 480
		self.caption = "Wizard Checkers"
		@game = Game.new
	end

	#per-frame logic function (no drawing)
	def update
		@game.play
	end

	#per-frame drawing function (no logic)
	def draw
		@game.draw
	end
end

#run the game!
window = GameWindow.new
window.show