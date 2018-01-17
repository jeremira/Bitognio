class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.datetime :rendezvous

      t.timestamps
    end
  end
end
