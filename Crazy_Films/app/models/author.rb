class Author < ActiveRecord::Base
  #has_and_belongs_to_many :films
  validates_presence_of :dni, :firstname, :surnames, :birthdate
  validates_uniqueness_of :dni
  validates_length_of :dni, :in => 9, :firstname, :in => 2..255, :surname, :in => 2..255


  def information
    "#{dni} #{firstname} #{surnames} #{birthdate}"
  end
end
