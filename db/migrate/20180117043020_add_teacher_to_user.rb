class AddTeacherToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_a_teacher, :boolean, default: false
  end
end
