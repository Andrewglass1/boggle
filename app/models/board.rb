class Board < ActiveRecord::Base
  attr_accessible :size, :content

  has_many :locations, :dependent => :destroy

  serialize :content

  after_create :make_board
  after_create :seed_locations

  LETTERS = ('a'..'z').to_a 


  def all_words
    @locations.collect{|location|location.all_words}.flatten.sort_by{|w|-w.length}
  end

  def all_valid_words
    word_checker = WordChecker.new
    all_words.select{|word|word_checker.check(word)}
  end

private

  def seed_locations
    @locations = []
    size.times do |r|
      size.times do |s|
         @locations << self.locations.create(:row => r, :slot => s)
      end
    end
    @locations.each{|location|location.set_other_locations_on_board(self)}
    @locations
  end

  def make_board
    b = []
    size.times do
      row = []
      size.times do
        row << LETTERS.sample
      end
      b << row
    end
    update_attribute(:content, b)
  end

end
