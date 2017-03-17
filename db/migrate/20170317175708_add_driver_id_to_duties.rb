class AddDriverIdToDuties < ActiveRecord::Migration[5.0]
  def change
    add_column :duties, :driver_id, :integer
  end
end
