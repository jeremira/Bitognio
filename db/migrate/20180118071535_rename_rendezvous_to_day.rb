class RenameRendezvousToDay < ActiveRecord::Migration[5.1]
  def change
    rename_column :lessons, :rendezvous, :date
    change_column :lessons, :date, :date
  end
end
