class ChangeColumnNameToPayments < ActiveRecord::Migration[5.1]
  def change
    rename_column :payments, :via, :from
  end
end
