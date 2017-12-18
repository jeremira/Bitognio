class AddColumnToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :payment_processed, :boolean
    add_column :payments, :error_message, :string
  end
end
