require 'gosu'
require_relative 'game'
require_relative 'board'

class Player
	#called at the very start
	def initialize(board, color, window)
		@color = color
		@window = window
		@board = board
		@clicked = false
		@grabbed = nil
	end
	
	#called every frame during your turn, return string "end" to end your turn
	def take_turn()
		#puts "taking turn"
		mouse_click = poll_mouse()
		mouse_pos = mouse_over_position()
		
		case mouse_click
			when "click"
			#pick up the piece, check that it exists and is yours
			@grabbed = @board.piece_at(mouse_pos)
			if @grabbed != nil and @grabbed.get_owner != @color
				@grabbed = nil
			end
			
			when "release"
			#drop the piece, attempt to make a move
			puts valid_move?(@grabbed, mouse_pos)
			if make_move(@grabbed, mouse_pos)
				puts @grabbed
				puts mouse_pos.x
				puts mouse_pos.y
				@grabbed = nil
				return "end"
			end
			@grabbed = nil
		end
	end
	
	#update the mouse condition
	def poll_mouse()
		mb = Gosu::button_down? Gosu::MsLeft
		if mb and not @clicked
			@clicked = true
			return "click"
		elsif mb and @clicked
			return "hold"
		elsif not mb and @clicked
			@clicked = false
			return "release"
		else
			return ""
		end
	end
	
	#determine the mouse's current position
	def mouse_over_position()
		mx = (@window.mouse_x - @board.left_edge) / 48
		my = (@window.mouse_y - @board.top_edge) / 48
		
		return Location.new(mx, my)
	end
	
	#move a piece to a location, or return an error(?)
	def make_move(piece, location)
		if valid_move?(piece, location)
			jumped = valid_jump?(piece, location)
			if jumped != nil
				puts "jumped"
				jumped.change_capture(true)
				@board.capture(jumped)
			end
			
			piece.set_pos(location)
			
			if (@color == "red") && (location.y == 0)
				piece.change_king(true)
			elsif (@color != "red") && (location.y == @board.dimensions[1] - 1)
				piece.change_king(true)
			end
			return true
		else
			return false
		end
	end
	
	#return true if the move can be made
	def valid_move?(piece, location)
		if valid?(piece, location) == false
			return false
		end
		
		if location_at_offset?(piece, location, 1, 1)
			return true
		end
		
		if location_at_offset?(piece, location, -1, 1)
			return true
		end
		
		if location_at_offset?(piece, location, 1, -1)
			return true
		end
		
		if location_at_offset?(piece, location, -1, -1)
			return true
		end
		
		if valid_jump?(piece, location) == nil
			return false
		else
			return true
		end
	end
	
	#Is this a valid jump?
	def valid_jump?(piece, location)
		if valid?(piece, location) == false
			return nil
		end
		
		if location_at_offset?(piece, location, 2, 2)
			ret = @board.piece_at(Location.new(location.x + 1, location.y + 1))
			
			if ret != nil && ret.get_owner != @color
				return ret
			end
		end
		
		if location_at_offset?(piece, location, -2, 2)
			ret = @board.piece_at(Location.new(location.x - 1, location.y + 1))
			
			if ret != nil && ret.get_owner != @color
				return ret
			end
		end
		
		if location_at_offset?(piece, location, 2, -2)
			ret = @board.piece_at(Location.new(location.x + 1, location.y - 1))
			
			if ret != nil && ret.get_owner != @color
				return ret
			end
		end
		
		if location_at_offset?(piece, location, -2, -2)
			ret = @board.piece_at(Location.new(location.x - 1, location.y - 1))
			
			if ret != nil && ret.get_owner != @color
				return ret
			end
		end
		
		return nil
	end
	
	def location_at_offset?(piece, location, offX, offY)
		if (location.x + offX == piece.get_pos.x) && (location.y + offY == piece.get_pos.y)
			return true
		end
		
		return false
	end
	
	def valid?(piece, location)
		if piece == nil || location == nil
			return false
		end
		
		if piece.get_owner() != @color
			return false
		end
		
		if @board.piece_at(location) != nil
			return false
		end
		
		if location.x < 0 || location.x >= @board.dimensions[0] || location.y < 0 || location.y >= @board.dimensions[1]
			return false
		end
		
		if (@color == "red") && (location.y > piece.get_pos.y) && (piece.is_king == false)
			return false
		elsif (@color != "red") && (location.y < piece.get_pos.y) && (piece.is_king == false)
			return false
		end
		
		return true
	end
	
	#get the list of pieces in your color
	def my_pieces()
		return @board.get_pieces_by_owner(@color)
	end
	
	#draw the piece you're holding
	def draw()
		if @grabbed != nil
			#draw a translucent piece under the mouse
			mouse_pos = mouse_over_position()
			fade_color = Gosu::Color.argb(192, 255, 255, 255) #75% opacity
			fade_color = Gosu::Color.argb(128, 255, 255, 255) unless valid_move?(@grabbed, mouse_pos)
			@board.get_piece_icon(@grabbed).draw(@board.left_edge+mouse_pos.x*48, @board.top_edge+mouse_pos.y*48-4, 3, 1, 1, fade_color)
		end
	end
end
