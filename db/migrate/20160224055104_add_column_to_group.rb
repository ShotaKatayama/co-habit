class AddColumnToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :check_span_counter, :integer, :after => :check_span
  end
end
