class Director < ActiveRecord::Base
  #has_and_belongs_to_many :films
  validates_presence_of :first_name, :last_name
  validates_length_of :first_name, :in => 2..255, :last_name, :in => 2..255

  def name
    "#{first_name} #{last_name}"
  end
end
