class RetypedatesToGroup < ActiveRecord::Migration
  def change
    change_column :groups, :start_year, :date
    change_column :groups, :start_month, :date
    change_column :groups, :start_day, :date
    change_column :groups, :end_year, :date
    change_column :groups, :end_month, :date
    change_column :groups, :end_day, :date
    #   呪文     :テーブル名, :旧カラム名, :新カラム名
  end
end
