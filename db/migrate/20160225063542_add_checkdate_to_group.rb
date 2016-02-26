class AddCheckdateToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :last_check_day, :date, :after => :check_span_counter
  end
end
