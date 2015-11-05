require 'gosu'
#require the other files as needed here!

#the main game class
class GameWindow < Gosu::Window
	#set up function, run on game start
	def initialize
		super 640, 480
		self.caption = "Wizard Checkers"
	end

	#per-frame logic function (no drawing)
	def update
	end

	#per-frame drawing function (no logic)
	def draw
	end
end

#run the game!
window = GameWindow.new
window.show