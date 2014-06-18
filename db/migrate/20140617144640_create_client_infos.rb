class CreateClientInfos < ActiveRecord::Migration
  def change
    create_table :client_infos do |t|
      t.string :name
      t.text :address
      t.integer :pincode
      t.datetime :date_of_birth
      t.string :mobile
      t.string :phone
      t.string :email
      t.string :education
      t.string :occupation
      t.string :job_post
      t.string :name_of_company
      t.integer :job_expirience_year
      t.float :income
      t.float :economical_liability
      t.integer :number_of_child
      t.datetime :anniversary_date
      t.string :intend_to_work
      t.string :short_term_goal
      t.string :long_term_goal
      t.integer :retirement_age
      t.string :plan_child_education
      t.string :plan_child_marriage
      t.string :plan_retirement_fund

      t.timestamps
    end
  end
end
