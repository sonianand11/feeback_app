require 'test_helper'

class ClientInfosControllerTest < ActionController::TestCase
  setup do
    @client_info = client_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_info" do
    assert_difference('ClientInfo.count') do
      post :create, client_info: { address: @client_info.address, anniversary_date: @client_info.anniversary_date, date_of_birth: @client_info.date_of_birth, economical_liability: @client_info.economical_liability, education: @client_info.education, email: @client_info.email, income: @client_info.income, job_expirience_year: @client_info.job_expirience_year, job_post: @client_info.job_post, mobile: @client_info.mobile, name: @client_info.name, name_of_company: @client_info.name_of_company, number_of_child: @client_info.number_of_child, occupation: @client_info.occupation, phone: @client_info.phone, pincode: @client_info.pincode }
    end

    assert_redirected_to client_info_path(assigns(:client_info))
  end

  test "should show client_info" do
    get :show, id: @client_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_info
    assert_response :success
  end

  test "should update client_info" do
    patch :update, id: @client_info, client_info: { address: @client_info.address, anniversary_date: @client_info.anniversary_date, date_of_birth: @client_info.date_of_birth, economical_liability: @client_info.economical_liability, education: @client_info.education, email: @client_info.email, income: @client_info.income, job_expirience_year: @client_info.job_expirience_year, job_post: @client_info.job_post, mobile: @client_info.mobile, name: @client_info.name, name_of_company: @client_info.name_of_company, number_of_child: @client_info.number_of_child, occupation: @client_info.occupation, phone: @client_info.phone, pincode: @client_info.pincode }
    assert_redirected_to client_info_path(assigns(:client_info))
  end

  test "should destroy client_info" do
    assert_difference('ClientInfo.count', -1) do
      delete :destroy, id: @client_info
    end

    assert_redirected_to client_infos_path
  end
end
