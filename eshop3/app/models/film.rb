class Film < ActiveRecord::Base
	HUMANIZED_ATTRIBUTES = {
		:cover_image => "Imagen de Portada",
		:title => "Título",
		:producer => "Productora",
		:directors => "Directores",
		:produced_at => "Producido por",
		:duration => "Duración",
		:price => "Precio",
		:cod => "Código"
	}
	
	def self.human_attribute_name(attr, options = {})
		HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	end
	
	has_and_belongs_to_many :directors
	belongs_to :producer

	#has_many :cart_items
	#has_many :carts, :through => :cart_items

	has_attached_file :cover_image
	validates_attachment :cover_image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

	validates_length_of :title, :in => 1..255
	validates_presence_of :producer
	validates_presence_of :directors
	validates_presence_of :produced_at
	validates_numericality_of :duration, :only_integer => true
	validates_numericality_of :price
	validates_presence_of :cod
	validates_format_of :cod, :with => /[0-9\-xX]{13}/
	validates_uniqueness_of :cod

	def director_names
		self.directors.map{|director| director.name}.join(", ")
	end

	def self.latest(num)
		all.order("films.id desc").includes(:directors, :producer).limit(num)
	end
end
