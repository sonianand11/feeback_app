
FactoryGirl.define do
  factory :client_info do
    name "Anand Soni"
    address "Vijaynagar,Vadodara,Gujarat,India"
    pincode 390019
    email "example@artechnologies.com"
    mobile "1234567890"
    date_of_birth Date.new(1985, 12, 3)
    phone "02652255225"
    education "M.C.A."
    occupation "Developer"
    job_post "Software Engineer"
    name_of_company "ARTechnologies & Consulting"
    job_expirience_year 5
    income 5000000
    economical_liability 5.5
    number_of_child 1
    anniversary_date Date.new(2012, 12, 3)
    retirement_age 80
    short_term_goal "bike"
    long_term_goal "BMW"
    plan_child_education "make investment on it"
    plan_child_marriage "after education make suffient fund for mrg"
    plan_retirement_fund "lower and long term investment till 60"
  end

  factory :child_info do
    age 4
    date_of_birth Date.new(2013, 12, 3)
  end

  factory :house do
    owned 1
    rented 2
    co_provider 1
  end

  factory :vehicle do
    four_wheeler 1
    two_wheeler 2
    none 0
  end

  factory :investment_type do
    fix_income 52.5
    equity 12.5
    land_and_estate 20
    gold 15
  end

  trait :with_client_detail do
    after :create do |client_info|
      FactoryGirl.create_list :child_info, 3, :client_info => client_info
      FactoryGirl.create_list :house, 1, :client_info => client_info
      FactoryGirl.create_list :vehicle, 1, :client_info => client_info
      FactoryGirl.create_list :investment_type, 1, :client_info => client_info
    end
  end
end