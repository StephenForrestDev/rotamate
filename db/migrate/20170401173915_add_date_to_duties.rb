class AddDateToDuties < ActiveRecord::Migration[5.0]
  def change
    add_column :duties, :start_date, :date
  end
end
