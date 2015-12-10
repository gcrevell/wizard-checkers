require 'gosu'
require_relative 'Game'
#require the other files as needed here!

#the main game class
class GameWindow < Gosu::Window
	#set up function, run on game start
	def initialize
		super 640, 480
		self.caption = "Wizard Checkers"
		@game = Game.new(self)
	end

	#per-frame logic function (no drawing)
	def update
		@game.play
	end

	#per-frame drawing function (no logic)
	def draw
		@game.draw
	end

	#show the mouse cursor
	def needs_cursor?
		true
	end
end