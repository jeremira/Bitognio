class AddColumnsToPostit < ActiveRecord::Migration[5.1]
  def change
    add_column :postits, :body, :string
    add_column :postits, :planning, :string
    add_reference :postits, :student, index: true
  end
end
