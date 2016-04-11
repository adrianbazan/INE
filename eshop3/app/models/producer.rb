class Producer < ActiveRecord::Base

    HUMANIZED_ATTRIBUTES = {
    :name => "Nombre"
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  #has_and_belongs_to_many :films
  validates :name, presence:{ message: "no puede estar vacío" }
  validates_length_of :name, in: 2..255, message: "no puede tener ese tamaño"

end
