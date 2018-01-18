class AddTimeToLesson < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :time, :time
  end
end
