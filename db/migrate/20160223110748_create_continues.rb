class CreateContinues < ActiveRecord::Migration
  def change
    create_table :continues do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
