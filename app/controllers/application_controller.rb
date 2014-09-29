class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource_or_scope)
    #session[:reminder]  =  ClientInfo.where("MONTH(date_of_birth) = ? AND DAY(date_of_birth) = ?", Date.today.month, Date.today.day)
    session[:reminder] = ClientInfo.select{|client| client.date_of_birth.month == Date.today.month and client.date_of_birth.day == Date.today.day if !client.date_of_birth.nil?}
    root_url
  end
end
