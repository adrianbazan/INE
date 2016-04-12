class Book < ActiveRecord::Base

  has_and_belongs_to_many :authors
  belongs_to :publisher

  has_many :cart_items
  has_many :carts, :through => :cart_items

  has_attached_file :cover_image
  validates_attachment :cover_image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_length_of :title, :in => 1..255
  validates_presence_of :publisher
  validates_presence_of :authors
  validates_presence_of :published_at
  validates_numericality_of :page_count, :only_integer => true
  validates_numericality_of :price
  validates_length_of :isbn, :in => 1..13
  validates_format_of :isbn, :with => /[0-9\-xX]{13}/
  validates_uniqueness_of :isbn

  def author_names
    self.authors.map{|author| author.name}.join(", ")
  end

  def self.latest(num)
    all.order("books.id desc").includes(:authors, :publisher).limit(num)
  end
end
