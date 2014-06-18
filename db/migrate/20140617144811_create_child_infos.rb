class CreateChildInfos < ActiveRecord::Migration
  def change
    create_table :child_infos do |t|
      t.integer :age
      t.datetime :date_of_birth
      t.integer :client_info_id

      t.timestamps
    end
  end
end
