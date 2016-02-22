class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_name, :string, :after => :id

  end
end
