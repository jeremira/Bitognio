class AddDefaultValueToBalanceAccount < ActiveRecord::Migration[5.1]
  def change
    change_column :accounts, :balance, :integer, :default => 0
  end
end
