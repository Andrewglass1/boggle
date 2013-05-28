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

  def one_length_path
    Path.new([self])
  end

  def all_paths
    while true
      paths ||= []
      new_paths ||= [one_length_path]
      paths, new_paths = expand_paths(paths,new_paths)
      break if new_paths == []
    end
    paths
  end

  def expand_paths(previous_paths, new_paths)
    newer_paths = new_paths.collect{|path|path.valid_next_paths}.flatten
    [previous_paths + new_paths, newer_paths]
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
