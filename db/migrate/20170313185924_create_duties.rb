class CreateDuties < ActiveRecord::Migration[5.0]
  def change
    create_table :duties do |t|
      t.string :dutynum
      t.datetime :start
      t.datetime :end
      t.time :paytime
      t.text :notes
      t.timestamps
    end
  end
end
