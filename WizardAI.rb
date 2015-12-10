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
	end
	
	def take_turn()
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
					puts computePriority(p, l)
				end
				
				l = Location.new(p.get_pos.x - i, p.get_pos.y + i)
				if valid_move?(p, l)
					#There is a valid move down and left 1 or 2 spaces
					legal << LegalMove.new(p, l, computePriority(p, l))
					puts computePriority(p, l)
				end
				
				l = Location.new(p.get_pos.x + i, p.get_pos.y - i)
				if valid_move?(p, l)
					#There is a valid move up and right 1 or 2 spaces
					legal << LegalMove.new(p, l, computePriority(p, l))
					puts computePriority(p, l)
				end
				
				l = Location.new(p.get_pos.x - i, p.get_pos.y - i)
				if valid_move?(p, l)
					#There is a valid move up and left 1 or 2 spaces
					legal << LegalMove.new(p, l, computePriority(p, l))
					puts computePriority(p, l)
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
				make_move(move.piece, move.location)
				return "end"
			end
		end
		
		
		puts "THERE ARE NO LEGAL MOVES FOR THE AI"
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
	
	def poll_mouse()
		
	end
	
	def mouse_over_position()
		
	end
end
