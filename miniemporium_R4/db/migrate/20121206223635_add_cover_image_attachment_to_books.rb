class AddCoverImageAttachmentToBooks < ActiveRecord::Migration
  def up
    add_attachment :books, :cover_image
  end

  def down
    remove_attachment :books, :cover_image
  end
end
