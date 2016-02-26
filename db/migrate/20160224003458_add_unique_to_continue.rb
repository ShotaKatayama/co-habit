class AddUniqueToContinue < ActiveRecord::Migration
  def change

    add_index :continues, [:user_id, :group_id], :unique => true
  end
end
