class AddColumnToCOntinue < ActiveRecord::Migration
  def change
    add_column :continues, :created_day, :date, :after => :group_id
  end
end
