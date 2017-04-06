class AddAdminToDrivers < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :admin, :boolean, default: false
  end
end
