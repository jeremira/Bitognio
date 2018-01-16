class AddColumnToToPayments < ActiveRecord::Migration[5.1]
  def change
      add_column :payments, :to, :integer
  end
end
