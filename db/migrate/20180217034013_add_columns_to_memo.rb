class AddColumnsToMemo < ActiveRecord::Migration[5.1]
  def change
    add_column :memos, :body, :string
    add_reference :memos, :teacher, index: true
  end
end
