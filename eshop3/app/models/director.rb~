class Director < ActiveRecord::Base

    HUMANIZED_ATTRIBUTES = {
    :first_name => "Nombre",
    :last_name => "Apellidos"
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  #has_and_belongs_to_many :films
  validates :first_name,:last_name, presence:{ message: "no puede estar vacío" }
  validates_length_of :first_name, in: 2..255, message: "no puede tener ese tamaño"  
  validates_length_of :last_name, in: 2..255, message: "no puede tener ese tamaño"

  def name
    "#{first_name} #{last_name}"
  end

end
