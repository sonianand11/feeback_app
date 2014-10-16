class ClientInfo < ActiveRecord::Base
  has_many :child_infos
  has_one :investment_type
  has_one :house
  has_one :vehicle

  # gives set of objects of clients which have birthday at present day
  def self.birthday_reminder
    return self.select{|client| client.date_of_birth.month == Date.today.month and client.date_of_birth.day == Date.today.day if !client.date_of_birth.nil?}
  end

  #create child information
  def create_child child_info
    child_info[:age].each_with_index do |child,index|
      self.child_infos.create!(:age => child_info[:age]["#{index+1}"],:date_of_birth => child_info[:dob]["#{index+1}"]) if child_info[:age]["#{index+1}"].to_i != 0
    end
  end

  #create client's investments information
  def create_investments investment_type
    self.create_investment_type(:fix_income => investment_type[:fix_income], :equity=> investment_type[:equity], :gold=> investment_type[:gold], :land_and_estate=> investment_type[:land_and_estate])
  end

  #create client's Houses information
  def create_houses house
    self.create_house(:owned => house[:owned],:rented => house[:rented],:co_provider => house[:co_provider])
  end

  #create client's vehicles information
  def create_vehicles vehicle
    self.create_vehicle(:four_wheeler => vehicle[:four_wheeler],:two_wheeler => vehicle[:two_wheeler],:none => vehicle[:none])
  end

  #updates children information
  def update_children child_info
    @child_info = self.child_infos.to_a
    child_info[:age].each_with_index do |child,index|
      if @child_info[index].nil?
        self.child_infos.create!(:age => child_info[:age]["#{index+1}"],:date_of_birth => child_info[:dob]["#{index+1}"]) if child_info[:age]["#{index+1}"].to_i != 0
      else
        @child_info[index].update!(:age => child_info[:age]["#{index+1}"],:date_of_birth => child_info[:dob]["#{index+1}"]) if child_info[:age]["#{index+1}"].to_i != 0
      end
    end
  end

  # update client's investment types
  def update_investments investment_type
    if self.investment_type.nil?
      self.create_investments investment_type
    else
      self.investment_type.update!(:fix_income => investment_type[:fix_income], :equity=> investment_type[:equity], :gold=> investment_type[:gold], :land_and_estate=> investment_type[:land_and_estate])
    end
  end

  # update client's house type
  def update_houses house
    if self.house.nil?
      self.create_houses house
    else
      self.house.update!(:owned => house[:owned],:rented => house[:rented],:co_provider => house[:co_provider])
    end
  end

  # update client's vehicle type
  def update_vehicles vehicle
    if self.vehicle.nil?
      self.create_vehicles vehicle
    else
      self.vehicle.update!(:four_wheeler => vehicle[:four_wheeler],:two_wheeler => vehicle[:two_wheeler],:none => vehicle[:none])
    end
  end
end
