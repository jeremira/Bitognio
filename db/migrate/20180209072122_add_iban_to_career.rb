class AddIbanToCareer < ActiveRecord::Migration[5.1]
  def change
    add_column :careers, :iban, :string
  end
end
