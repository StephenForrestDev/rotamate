class ChangeColumnsInDuties < ActiveRecord::Migration[5.0]
  def change
    add_column :duties, :date, :string
    change_column :duties, :endtime, :string
    change_column :duties, :starttime, :string
    change_column :duties, :paytime, :string
  end
end
