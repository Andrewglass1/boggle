class Path

  attr_accessor :locations

  def initialize(locations)
    @locations = locations
  end

  def word
    @locations.collect{|l|l.letter}.join("")
  end

  def has?(location)
    @locations.include?(location)
  end

  def valid_next_moves
    #the four possible next moves the path can take
    @locations.last.possible_moves.reject{|loc| @locations.map(&:id).include?(loc.id)}
  end

  def valid_next_paths
    new_location_series = valid_next_moves.collect{|move| locations + [move]}
    new_location_series.collect{|location_series|Path.new(location_series)}
  end

end