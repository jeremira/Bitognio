class AddStatusToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :confirmed, :boolean, default: false
    add_column :lessons, :payed,     :boolean, default: false
  end
end
