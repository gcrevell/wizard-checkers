
class Location
	attr_reader :x
	attr_reader :y
	def initialize(x=0, y=0)
		@x = (x.floor)
		@y = (y.floor)
	end
end
