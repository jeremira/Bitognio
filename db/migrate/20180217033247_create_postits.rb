class CreatePostits < ActiveRecord::Migration[5.1]
  def change
    create_table :postits do |t|

      t.timestamps
    end
  end
end
