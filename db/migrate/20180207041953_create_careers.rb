class CreateCareers < ActiveRecord::Migration[5.1]
  def change
    create_table :careers do |t|
      t.references :user, foreign_key: true
      t.string :last_name
      t.string :first_name
      t.datetime :dob
      t.string :country
      t.string :adress
      t.string :city
      t.string :zipcode

      t.timestamps
    end
  end
end
