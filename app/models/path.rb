class Path

  attr_accessor :locations

  def initialize(locations)
    @locations = locations
  end

  def word
    @locations.collect{|l|l.letter}.join("")
  end

  def valid_word?
    ValidWords.all_words.include?(word)
  end

end
