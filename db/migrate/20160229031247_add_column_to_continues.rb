class AddColumnToContinues < ActiveRecord::Migration
  def change
    add_column :continues, :group_num, :integer, :after => :group_id
  end
end
