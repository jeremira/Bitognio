class AddStripeConnectAccountIdToCareers < ActiveRecord::Migration[5.1]
  def change
    add_column :careers, :connect_account_id, :string
  end
end
