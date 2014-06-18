class ClientInfo < ActiveRecord::Base
  has_many :child_infos
  has_one :investment_type
  has_one :house
  has_one :vehicle
end
