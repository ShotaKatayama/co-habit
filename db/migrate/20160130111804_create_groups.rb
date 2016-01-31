class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|

      t.string :group_name
      t.string :group_desc
      t.string :drop_users
      t.string :continue_users

      t.integer :start_year
      t.integer :start_month
      t.integer :start_day

      t.integer :fin_year
      t.integer :fin_month
      t.integer :fin_day

      t.integer :check_span

      t.timestamps
    end
  end
end
