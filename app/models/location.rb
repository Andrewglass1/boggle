class Location < ActiveRecord::Base

  attr_accessible :board_id, :row, :slot

  belongs_to :board

  after_create :set_letter

  def other_locations_on_board
    board.locations - [self]
  end

  def possible_moves
    [location_left, location_right, location_up, location_down].compact
  end

  def all_words
    all_paths.collect{|path|path.word}
  end

  def all_paths
    #TODO logic here to actually find all paths rather than just these two samples
    ##should probably abstract path finding logic into new class
    [two_long, three_long]
  end

  def two_long
    locations = [self, possible_moves[1]]
    Path.new(locations)
  end

  def three_long
    locations = [self, possible_moves[1], possible_moves[1].possible_moves[1]]
    Path.new(locations)
  end

private
  
  def set_letter
    update_attribute(:letter, board.content[row][slot])
  end

  def location_left
    other_locations_on_board.detect{|l| l.row == row && l.slot == slot-1}
  end

  def location_right
    other_locations_on_board.detect{|l| l.row == row && l.slot == slot+1}
  end

  def location_up
    other_locations_on_board.detect{|l| l.row == row-1 && l.slot == slot}
  end

  def location_down
    other_locations_on_board.detect{|l| l.row == row+1 && l.slot == slot}
  end

end
