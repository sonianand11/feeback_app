class CreateInvestmentTypes < ActiveRecord::Migration
  def change
    create_table :investment_types do |t|
      t.float :fix_income
      t.float :equity
      t.float :gold
      t.float :land_and_estate
      t.integer :client_info_id

      t.timestamps
    end
  end
end
