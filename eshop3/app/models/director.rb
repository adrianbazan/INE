class Director < ActiveRecord::Base

    HUMANIZED_ATTRIBUTES = {
    :first_name => "Nombre",
    :last_name => "Apellidos"
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  #validates_presence_of :first_name, :last_name
  validates :first_name,:last_name, presence:{ message: "no puede estar vacío" }

  def name
    "#{first_name} #{last_name}"
  end

end
