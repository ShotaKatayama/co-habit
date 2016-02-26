class AddUniqueToManages < ActiveRecord::Migration
  def change

    add_index :manages, [:user_id, :group_id], :unique => true
  end
end
