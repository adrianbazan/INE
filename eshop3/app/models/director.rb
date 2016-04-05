class Director < ActiveRecord::Base
  #validates_presence_of :first_name, :last_name
  validates :first_name, presence: { message: "Nombre no puede estar vacío" }
  validates :last_name, presence:{ message: "Apellidos no puede estar vacío" }

  def name
    "#{first_name} #{last_name}"
  end
end
