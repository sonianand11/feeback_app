class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.integer :owned
      t.integer :rented
      t.integer :co_provider

      t.timestamps
    end
  end
end
