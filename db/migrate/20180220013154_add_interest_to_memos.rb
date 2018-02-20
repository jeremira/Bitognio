class AddInterestToMemos < ActiveRecord::Migration[5.1]
  def change
    add_column :memos, :interest, :boolean, default: true
  end
end
