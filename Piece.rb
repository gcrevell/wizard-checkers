require 'gosu'
require_relative 'Location'

#require other libraries as needed

#Piece classs, establishes and tracks piece properties

class Piece
  
  #constructor
  def initialize (posx=0, posy=0, owner=nil)
    #define properties that exist
    @owner = owner
    @king = false
    @captured = false
    #set piece position
    @position = Location.new(posx, posy)
  end
  
  #change owner of the piece
  def set_owner(new_owner)
    @owner = new_owner
  end
  
  #retrieve the owner of the piece
  def get_owner()
    return @owner
  end
  
  #retrieve the position of the piece
  def get_pos()
    return @position
  end
  
  #change the position of the piece
  def set_pos(pos)
    @position = pos
  end
  
  #retrieve the king status
  def is_king()
    return @king
  end
  
  #change the king status
  def change_king(king_status)
    @king = king_status
  end
  
  #retrieve the capture status
  def is_captured()
    return @captured
  end
  
  #change the capture status
  def change_capture(capture_status)
    @capture = capture_status
  end
  
  #function determines the frame number from kingship and color
  def get_frame()
    frame = 0
    if is_king
      frame += 1
    end
    if @owner == "black"
      frame += 2
    end
  return frame
  end
end
