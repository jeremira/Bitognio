class FixAccountName < ActiveRecord::Migration[5.1]
  def change
    rename_table :acccounts, :accounts
  end
end
