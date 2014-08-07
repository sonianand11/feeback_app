# Let's just save all this as /test/factories
# FactoryGirl.define do - See more at: http://www.hiringthing.com/2012/08/17/rails-testing-factory-girl.html#sthash.8IeH3B8k.dpuf
FactoryGirl.define do
  factory :client_info do
    name "Anand Soni"
    address "Vijaynagar,Vadodara,Gujarat,India"
    pincode 390019
    email "example@artechnologies.com"
    mobile "1234567890"
  end
end