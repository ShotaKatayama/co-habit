class AddColumnToManage < ActiveRecord::Migration
  def change
    add_column :manages, :group_num, :integer, :after => :group_id
  end
end
