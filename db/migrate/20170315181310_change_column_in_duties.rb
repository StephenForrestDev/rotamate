class ChangeColumnInDuties < ActiveRecord::Migration[5.0]
  def change
    rename_column :duties, :start, :starttime
    rename_column :duties, :end, :endtime
  end
end
