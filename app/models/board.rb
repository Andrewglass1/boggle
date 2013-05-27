class Board < ActiveRecord::Base
  attr_accessible :size, :board, :content

  has_many :locations, :dependent => :destroy

  serialize :content

  after_create :make_board
  after_save :seed_locations

  LETTERS = ('a'..'z').to_a 

  def all_words
    locations.collect{|location|location.all_words}.flatten
  end

private

  def seed_locations
    size.times do |r|
      size.times do |s|
        self.locations.create(:row => r, :slot => s)
      end
    end
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
