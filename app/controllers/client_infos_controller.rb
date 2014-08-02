class ClientInfosController < ApplicationController
  before_action :set_client_info, only: [:show, :edit, :update, :destroy]
  require "prawn"

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
    respond_to do |format|
      if @client_info.save

        i=1
        while(i<=4)
          ChildInfo.create(:age => params[:child_info][:age]["#{i}"],:date_of_birth => params[:child_info][:dob]["#{i}"], :client_info_id => @client_info.id ) if params[:child_info][:age]["#{i}"].present?
          i+=1
        end
        #ChildInfo.create(:age => params[:child_info][:age]["2"],:date_of_birth => params[:child_info][:dob]["2"], :client_info_id => @client_info.id ) if params[:child_info][:age]["2"].present?
        #ChildInfo.create(:age => params[:child_info][:age]["3"],:date_of_birth => params[:child_info][:dob]["3"], :client_info_id => @client_info.id ) if params[:child_info][:age]["3"].present?
        #ChildInfo.create(:age => params[:child_info][:age]["4"],:date_of_birth => params[:child_info][:dob]["4"], :client_info_id => @client_info.id ) if params[:child_info][:age]["4"].present?
        
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
      
	      @client_info.child_infos.destroy_all

        ChildInfo.create(:age => params[:child_info][:age]["1"],:date_of_birth => params[:child_info][:dob]["1"], :client_info_id => @client_info.id )
        ChildInfo.create(:age => params[:child_info][:age]["2"],:date_of_birth => params[:child_info][:dob]["2"], :client_info_id => @client_info.id ) if params[:child_info][:age]["2"].present?
        ChildInfo.create(:age => params[:child_info][:age]["3"],:date_of_birth => params[:child_info][:dob]["3"], :client_info_id => @client_info.id ) if params[:child_info][:age]["3"].present?
        ChildInfo.create(:age => params[:child_info][:age]["4"],:date_of_birth => params[:child_info][:dob]["4"], :client_info_id => @client_info.id ) if params[:child_info][:age]["4"].present?

        @client_info.investment_type.update(:fix_income => params[:investment_type][:fix_income], :equity=>params[:investment_type][:equity], :gold=>params[:investment_type][:gold], :land_and_estate=>params[:investment_type][:land_and_estate], :client_info_id => @client_info.id )
        
        @client_info.house.update(:owned => params[:house][:owned],:rented => params[:house][:rented],:co_provider => params[:house][:co_provider], :client_info_id => @client_info.id)
        
        @client_info.vehicle.update(:four_wheeler => params[:vehicle][:four_wheeler],:two_wheeler => params[:vehicle][:two_wheeler],:none => params[:vehicle][:none],:client_info_id => @client_info.id)

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

  def download_xlsx
    if params[:id].present?
      @client_infos = []
      @client_infos << ClientInfo.find(params[:id])
    else
      @client_infos = ClientInfo.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xlsx
    end
  end

  def download_pdf
    if params[:id].present?
      @client_infos = []
      @client_infos << ClientInfo.find(params[:id])
    else
      @client_infos = ClientInfo.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.pdf do
        send_data generate_pdf(@client_infos),
                  filename: "download.pdf",
                  type: "application/pdf"
      end
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
  private

  def generate_pdf(client_info)
    Prawn::Document.new do
      client_info.each_with_index do |client,index|
        text "\n Client #{index+1}", align: :center
        text "Name: #{client.name}"
        text "Address: #{client.address}"
        text "Pincode: #{client.pincode}"
        text "Date Of Birth: #{client.date_of_birth.strftime("%F") rescue ""}"
        text "Mobile: #{client.mobile}"
        text "Phone: #{client.phone}"
        text "Email: #{client.email}"
        text "Education: #{client.education}"
        text "Occupation: #{client.occupation}"
        text "Job Post: #{client.job_post}"
        text "Name Of Company: #{client.name_of_company}"
        text "Job Experience: #{client.job_expirience_year}"
        text "Income: #{client.income}"
        text "Economical Liability: #{client.economical_liability}"
        text "Number of Child: #{client.number_of_child}"
        text "Child Details"
        client.child_infos.each_with_index do |child,i|
            text "Child #{i+1} Age: #{child.age}"
            if !child.date_of_birth.nil?
              text "Child #{i+1} Date of Birth: #{child.date_of_birth.strftime("%F") rescue ""}"
            else
              text "Child #{i+1} Date of Birth: "
            end
        end
        text "Client Anniversary Date: #{client.anniversary_date.strftime("%F") rescue ""}"
        text "Personal Assets"
        text "House Owned: #{client.house.owned}"
        text "House Rented: #{client.house.rented}"
        text "House Co Provider: #{client.house.co_provider}"
        text "Four Wheeler: #{client.vehicle.four_wheeler}"
        text "Two Wheeler: #{client.vehicle.two_wheeler}"
        text "No Vehicle: #{client.vehicle.none}"
        text "Short Term Goal: #{client.short_term_goal}"
        text "Long Term Goal: #{client.long_term_goal}"
        text "Retirement Age: #{client.retirement_age}"
        text "Plan"
        text "Child Education: #{client.plan_child_education}"
        text "Child Merriage: #{client.plan_child_marriage}"
        text "Retirement Fund: #{client.plan_retirement_fund}"
        text "Investment"
        text "Fix Income: #{client.investment_type.fix_income}"
        text "Equity: #{client.investment_type.equity}"
        text "Gold: #{client.investment_type.gold}"
        text "Land and Estate: #{client.investment_type.land_and_estate}"

      end
    end.render
  end
end
