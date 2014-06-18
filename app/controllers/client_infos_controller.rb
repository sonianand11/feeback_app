class ClientInfosController < ApplicationController
  before_action :set_client_info, only: [:show, :edit, :update, :destroy]

  # GET /client_infos
  # GET /client_infos.json
  def index
    @client_infos = ClientInfo.all
  end

  # GET /client_infos/1
  # GET /client_infos/1.json
  def show
  end

  # GET /client_infos/new
  def new
    @client_info = ClientInfo.new
  end

  # GET /client_infos/1/edit
  def edit
  end

  # POST /client_infos
  # POST /client_infos.json
  def create
    @client_info = ClientInfo.new(client_info_params)

    p params[:child_info]
    ChildInfo.create(:age => params[:child_info][:age]["1"],:date_of_birth => params[:child_info][:dob]["1"], :client_info_id => @client_info.id )
    respond_to do |format|
      if @client_info.save
        ChildInfo.create(:age => params[:child_info][:age]["1"],:date_of_birth => params[:child_info][:dob]["1"], :client_info_id => @client_info.id )
        ChildInfo.create(:age => params[:child_info][:age]["2"],:date_of_birth => params[:child_info][:dob]["2"], :client_info_id => @client_info.id )
        ChildInfo.create(:age => params[:child_info][:age]["3"],:date_of_birth => params[:child_info][:dob]["3"], :client_info_id => @client_info.id )
        ChildInfo.create(:age => params[:child_info][:age]["4"],:date_of_birth => params[:child_info][:dob]["4"], :client_info_id => @client_info.id )
        InvestmentType.create(:fix_income => params[:investment_type][:fix_income], :equity=>params[:investment_type][:equity], :gold=>params[:investment_type][:gold], :land_and_estate=>params[:investment_type][:land_and_estate], :client_info_id => @client_info.id )
        House.create(:owned => params[:house][:owned],:rented => params[:house][:rented],:co_provider => params[:house][:co_provider], :client_info_id => @client_info.id)
        Vehicle.create(:four_wheeler => params[:vehicle][:four_wheeler],:two_wheeler => params[:vehicle][:two_wheeler],:none => params[:vehicle][:none],:client_info_id => @client_info.id)
        format.html { redirect_to @client_info, notice: 'Client info was successfully created.' }
        format.json { render action: 'show', status: :created, location: @client_info }
      else
        format.html { render action: 'new' }
        format.json { render json: @client_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_infos/1
  # PATCH/PUT /client_infos/1.json
  def update
    respond_to do |format|
      if @client_info.update(client_info_params)

        format.html { redirect_to @client_info, notice: 'Client info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @client_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_infos/1
  # DELETE /client_infos/1.json
  def destroy
    @client_info.destroy
    respond_to do |format|
      format.html { redirect_to client_infos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_info
      @client_info = ClientInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_info_params
      params.require(:client_info).permit(:name, :address, :pincode, :date_of_birth, :mobile, :phone, :email, :education, :occupation, :job_post, :name_of_company, :job_expirience_year, :income, :economical_liability, :number_of_child, :anniversary_date,  :short_term_goal, :long_term_goal, :retirement_age, :plan_child_education, :plan_child_marriage, :plan_retirement_fund)
    end
end
