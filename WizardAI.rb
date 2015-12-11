require 'gosu'
load 'Game.rb'
load 'Board.rb'
load 'Player.rb'

class LegalMove
	attr_reader :piece
	attr_reader :location
	attr_reader :count
	
	def initialize(piece, loc, cnt)
		@piece = piece
		@location = loc
		@count = cnt
	end
	
	def to_s
		return "Count: #{@count}, "
	end
end

#an updated version of basicAI that can use MAGICAL SPELLS
class WizardAI < Player
	def initialize(board, color, window)
		super(board, color, window)
		@cheated = nil
		@can_cheat_in = -rand(3)
		@spell = Gosu::Font.new(20)
	end
	
	def take_turn()
		#hasn't cheated YET this turn
		@cheated = nil

		#get my peices
		myPieces = my_pieces()
		
		#legal moves
		legal = Array.new
		
		#for all of my pieces
		for p in myPieces
			for i in (1..2)
				l = Location.new(p.get_pos.x + i, p.get_pos.y + i)
				if valid_move?(p, l)
					#There is a valid move down and right 1 or 2 spaces
					legal << LegalMove.new(p, l, computePriority(p, l))
					#puts computePriority(p, l)
				end
				
				l = Location.new(p.get_pos.x - i, p.get_pos.y + i)
				if valid_move?(p, l)
					#There is a valid move down and left 1 or 2 spaces
					legal << LegalMove.new(p, l, computePriority(p, l))
					#puts computePriority(p, l)
				end
				
				l = Location.new(p.get_pos.x + i, p.get_pos.y - i)
				if valid_move?(p, l)
					#There is a valid move up and right 1 or 2 spaces
					legal << LegalMove.new(p, l, computePriority(p, l))
					#puts computePriority(p, l)
				end
				
				l = Location.new(p.get_pos.x - i, p.get_pos.y - i)
				if valid_move?(p, l)
					#There is a valid move up and left 1 or 2 spaces
					legal << LegalMove.new(p, l, computePriority(p, l))
					#puts computePriority(p, l)
				end
			end
		end
		
		#legal has all legal moves I can make...
		for i in (4).downto(1)
			max = legal.select{|lm| lm.count == i}
			if max.empty? == false
				#Theres moves to make. make them.
				#choose random move and make it
				move = max.sample
				puts move.piece
				puts move.location.x
				puts move.location.y
				puts valid_move?(move.piece, move.location)
				make_move(move.piece, move.location)
				puts "cheated" unless not @cheated
				#manage the magic cooldown
				@can_cheat_in = -1-rand(2) if @cheated
				@can_cheat_in += 1 unless @cheated
				return "end"
			end
		end

		puts "THERE ARE NO LEGAL MOVES FOR THE AI"
		@cheated = "The wizard curses at you"
		@can_cheat_in = 1 #cheat faster when cornered
		return "end"
	end
	
	def computePriority(p, l)
		cnt = 1
		if valid_jump?(p, l)
			#its a jump!
			cnt = cnt + 2
		end
		
		if (@color == "red") && (l.y == 0) && (p.is_king == false)
			#its a king move!
			cnt = cnt + 1
		elsif (@color != "red") && (l.y == @board.dimensions[1] - 1) && (p.is_king == false)
			#also a king move!
			cnt = cnt + 1
		end
		
		return cnt
	end

	### HAPPY OVERRIDES VIA WIZARD MAGIC! ###

	#move a piece to a location, or return an error(?)
	def make_move(piece, location)
		if valid_move?(piece, location)
			jumped = valid_jump?(piece, location)
			if jumped != nil
				puts "jumped"
				#when jumping own pieces, crown them
				if jumped.get_owner == @color
					jumped.change_king(true)
					piece.change_capture(true)
					@board.capture(piece)
					@cheated = "The wizard crowns his own piece"
				#50% chance of siezing control of a captured unit instead
				elsif rand(2) == 0
					jumped.set_owner(@color)
					@cheated = "the wizard takes over your unit"
				else
					jumped.change_capture(true)
					@board.capture(jumped)
				end
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
			
			if ret != nil && (ret.get_owner != @color || (@can_cheat_in > 0 && !ret.is_king && !piece.is_king))
				return ret
			end
		end
		
		if location_at_offset?(piece, location, -2, 2)
			ret = @board.piece_at(Location.new(location.x - 1, location.y + 1))
			
			if ret != nil && (ret.get_owner != @color || (@can_cheat_in > 0 && !ret.is_king && !piece.is_king))
				return ret
			end
		end
		
		if location_at_offset?(piece, location, 2, -2)
			ret = @board.piece_at(Location.new(location.x + 1, location.y - 1))
			
			if ret != nil && (ret.get_owner != @color || (@can_cheat_in > 0 && !ret.is_king && !piece.is_king))
				return ret
			end
		end
		
		if location_at_offset?(piece, location, -2, -2)
			ret = @board.piece_at(Location.new(location.x - 1, location.y - 1))
			
			if ret != nil && (ret.get_owner != @color || (@can_cheat_in > 0 && !ret.is_king && !piece.is_king))
				return ret
			end
		end
		
		return nil
	end

	def poll_mouse()
		
	end

	def mouse_over_position()
		
	end

	def draw()
		if @cheated != nil
			@spell.draw(@cheated, 185, 12, 9, 1.0, 1.0, 0xff_0077FF)
		end
	end
end
