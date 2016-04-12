class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :books, :through => :cart_items

  def add(book_id)
    items = cart_items.where(book_id: book_id)
    book = Book.find book_id
    if items.size < 1
      ci = cart_items.create :book_id => book_id, :amount => 1, :price => book.price
    else
      ci = items.first
      ci.update_attribute :amount, ci.amount + 1
    end
    ci
  end

  def remove(book_id)
    ci = cart_items.where(book_id: book_id).first
    if ci.amount > 1
      ci.update_attribute :amount, ci.amount - 1
    else
      CartItem.destroy ci.id
    end
    ci
  end

  def total
    sum = 0
    cart_items.each do |item| sum += item.price * item.amount end
    sum
  end
end
