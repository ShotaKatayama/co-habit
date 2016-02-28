class RemoveUniqueFromContinue < ActiveRecord::Migration
  def down
    add_index :continues, [:user_id, :group_id], :unique => true
  end
end
