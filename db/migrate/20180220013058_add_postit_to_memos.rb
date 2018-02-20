class AddPostitToMemos < ActiveRecord::Migration[5.1]
  def change
    add_reference :memos, :postit, foreign_key: true
  end
end
