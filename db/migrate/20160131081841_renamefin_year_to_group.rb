class RenamefinYearToGroup < ActiveRecord::Migration
  def change
    rename_column :groups, :fin_year, :end_year
    rename_column :groups, :fin_month, :end_month
    rename_column :groups, :fin_day, :end_day
    #   呪文     :テーブル名, :旧カラム名, :新カラム名

  end
end
