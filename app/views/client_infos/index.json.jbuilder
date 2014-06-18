json.array!(@client_infos) do |client_info|
  json.extract! client_info, :id, :name, :address, :pincode, :date_of_birth, :mobile, :phone, :email, :education, :occupation, :job_post, :name_of_company, :job_expirience_year, :income, :economical_liability, :number_of_child, :anniversary_date
  json.url client_info_url(client_info, format: :json)
end
