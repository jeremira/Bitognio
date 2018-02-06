class AddPhotoToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :photo, :string, default: 'default_avatar.jpg'
  end
end
