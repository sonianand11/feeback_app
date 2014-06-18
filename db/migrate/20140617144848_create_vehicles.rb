class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :four_wheeler
      t.integer :two_wheeler
      t.integer :none

      t.timestamps
    end
  end
end
