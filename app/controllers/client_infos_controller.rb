class ClientInfosController < ApplicationController
  before_action :set_client_info, only: [:show, :edit, :update, :destroy]
  require "prawn"
  before_filter :authenticate_user!
  # GET /client_infos
  # GET /client_infos.json
  def index
    @client_infos = ClientInfo.all
    @clientbirthdate = ClientInfo.where("MONTH(date_of_birth) = ? AND DAY(date_of_birth) = ?", Date.today.month, Date.today.day)
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
    @client_info = ClientInfo.find(params[:id])
    @child = @client_info.child_infos
    @house = @client_info.house
    @vehicle = @client_info.vehicle
    @investment_type = @client_info.investment_type
  end

  # POST /client_infos
  # POST /client_infos.json
  def create
    @client_info = ClientInfo.new(client_info_params)
    respond_to do |format|
      if @client_info.save
        params[:child_info][:age].each_with_index do |child,index|
          @client_info.child_infos.create!(:age => params[:child_info][:age]["#{index+1}"],:date_of_birth => params[:child_info][:dob]["#{index+1}"]) if params[:child_info][:age]["#{index+1}"].to_i != 0
        end
        @client_info.create_investment_type(:fix_income => params[:investment_type][:fix_income], :equity=>params[:investment_type][:equity], :gold=>params[:investment_type][:gold], :land_and_estate=>params[:investment_type][:land_and_estate])

        @client_info.create_house(:owned => params[:house][:owned],:rented => params[:house][:rented],:co_provider => params[:house][:co_provider])

        @client_info.create_vehicle(:four_wheeler => params[:vehicle][:four_wheeler],:two_wheeler => params[:vehicle][:two_wheeler],:none => params[:vehicle][:none])
        
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
        @child_info = @client_info.child_infos.to_a
        params[:child_info][:age].each_with_index do |child,index|
          if @child_info[index].nil?
            @client_info.child_infos.create!(:age => params[:child_info][:age]["#{index+1}"],:date_of_birth => params[:child_info][:dob]["#{index+1}"]) if params[:child_info][:age]["#{index+1}"].to_i != 0
          else
            @child_info[index].update!(:age => params[:child_info][:age]["#{index+1}"],:date_of_birth => params[:child_info][:dob]["#{index+1}"]) if params[:child_info][:age]["#{index+1}"].to_i != 0
          end
        end
        if @client_info.investment_type.nil?
          @client_info.create_investment_type(:fix_income => params[:investment_type][:fix_income], :equity=>params[:investment_type][:equity], :gold=>params[:investment_type][:gold], :land_and_estate=>params[:investment_type][:land_and_estate])
        else
          @client_info.investment_type.update!(:fix_income => params[:investment_type][:fix_income], :equity=>params[:investment_type][:equity], :gold=>params[:investment_type][:gold], :land_and_estate=>params[:investment_type][:land_and_estate])
        end
        if @client_info.house.nil?
          @client_info.create_house(:owned => params[:house][:owned],:rented => params[:house][:rented],:co_provider => params[:house][:co_provider])
        else
          @client_info.house.update(:owned => params[:house][:owned],:rented => params[:house][:rented],:co_provider => params[:house][:co_provider])
        end
        if @client_info.vehicle.nil?
          @client_info.create_vehicle(:four_wheeler => params[:vehicle][:four_wheeler],:two_wheeler => params[:vehicle][:two_wheeler],:none => params[:vehicle][:none])
        else
          @client_info.vehicle.update(:four_wheeler => params[:vehicle][:four_wheeler],:two_wheeler => params[:vehicle][:two_wheeler],:none => params[:vehicle][:none])
        end
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
      @file_name = "#{@client_infos.first.name} - #{Time.now}"
    else
      @client_infos = ClientInfo.all
      @file_name = "all client info - #{Time.now}"
    end
    headers["Content-Disposition"] = "attachment; filename=\"#{@file_name}.xlsx\""
    respond_to do |format|
      format.html # index.html.erb
      format.xlsx #{ send_data filename: 'my_name.xls'}
    end
  end

  def download_pdf
    if params[:id].present?
      @client_infos = []
      @client_infos << ClientInfo.find(params[:id])
    else
      @client_infos = ClientInfo.all
    end
    if @client_infos.length >1
      @file_name = "all client info - #{Time.now}"
    else
      @file_name = "#{@client_infos.first.name} - #{Time.now}"
    end
    respond_to do |format|
      format.html # index.html.erb
      format.pdf do
        send_data generate_pdf(@client_infos),
                  filename: "#{@file_name}.pdf",
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
      params.require(:client_info).permit(:name, :address, :pincode, :date_of_birth, :mobile, :phone, :email, :education, :occupation, :job_post, :name_of_company, :job_expirience_year, :income, :economical_liability, :number_of_child, :anniversary_date,  :short_term_goal, :long_term_goal, :retirement_age, :plan_child_education, :plan_child_marriage, :plan_retirement_fund,:intend_to_work)
    end
  private

  def generate_pdf(client_info)
    Prawn::Document.new do
      fill_color "2E64FE"
      indent(10) do
        text "Zimmedari<br/> ka<br/> Humsafar",:size => 40, :inline_format => true
      end
      image "#{Rails.root}/app/assets/images/logo.png" ,:image_width => 60, :image_height => 60, :at => [350,750]

      client_info.each_with_index do |client,index|
        fill_color "000000"
        if client_info.length != 1
          pad(10) { text "\n Client #{index+1} Feedback Information", align: :center, :size => 32 }
        else
          pad(10) { text "\n #{client.name}'s Feedback Information", align: :center, :size => 32 }
        end
        stroke_horizontal_rule
        pad(10) { text "<b>Personal Infirmation : </b>", :size => 20,:inline_format => true  }
        indent(30) do
          data = [[ "<b>Name:</b> #{client.name}","<b>Mobile:</b> #{client.mobile}"],
                ["<b>Address:</b> #{client.address}","<b>Phone:</b> #{client.phone}"],
                ["<b>Pincode:</b> #{client.pincode}","<b>Email:</b> #{client.email}"],
                ["<b>Date Of Birth:</b> #{client.date_of_birth.strftime("%F") rescue ""}","<b>Client Anniversary Date:</b> #{client.anniversary_date.strftime("%F") rescue ""}"]]
          table data, :cell_style => { :inline_format => true,:borders => [], :width => 250 }
        end
        pad(10) { text "<b>Education & Job details : </b>",:size => 20, :inline_format => true }
        indent(30) do
          data = [["<b>Education:</b> #{client.education}","<b>Occupation:</b> #{client.occupation}"],
                  ["<b>Name Of Company:</b> #{client.name_of_company}","<b>Job Post:</b> #{client.job_post}"],
                  ["<b>Job Experience:</b> #{client.job_expirience_year}","<b>Income:</b> #{client.income}"],
                  ["<b>Economical Liability:</b> #{client.economical_liability}","<b>Retirement Age:</b> #{client.retirement_age}"],
                  ["<b>How many years intend to work:</b> #{client.intend_to_work}",""]]
          table data, :cell_style => { :inline_format => true,:borders => [], :width => 250 }
        end
        pad(10){text "<b>Child Details</b>", :size => 20,:inline_format => true }
        indent(30) do
          pad(5){text "<b>Number of Child: </b> #{client.number_of_child}", :inline_format => true }
          data = []
          if !client.child_infos.nil?
            client.child_infos.each_with_index do |child,i|
              if !child.date_of_birth.nil?
                data << ["<b>Child #{i+1} Age:</b> #{child.age}","<b>Child #{i+1} Date of Birth:</b> #{child.date_of_birth.strftime("%F") rescue ""}"]
              else
                data << ["<b>Child #{i+1} Age:</b> #{child.age}","<b>Child #{i+1} Date of Birth: </b>"]
              end

            end
            if data.blank?
              pad(5){text "<b>No Child Information</b>", :inline_format => true }
            else
              table data, :cell_style => { :inline_format => true,:borders => [], :width => 250 }
            end
          end
        end
        start_new_page
        pad(10){text "<b>Personal Assets</b>", :size => 20,:inline_format => true  }
        indent(30) do
          if !client.house.nil?
            data = [["<b>House Owned:</b> #{client.house.owned}","<b>Four Wheeler:</b> #{client.vehicle.four_wheeler}"],
                    ["<b>House Rented:</b> #{client.house.rented}","<b>Two Wheeler:</b> #{client.vehicle.two_wheeler}"],
                    ["<b>House Co Provider:</b> #{client.house.co_provider}","<b>No Vehicle:</b> #{client.vehicle.none}"]]
          else
            data = [["<b>House Owned:</b> ","<b>Four Wheeler:</b> "],
                    ["<b>House Rented:</b> ","<b>Two Wheeler:</b> "],
                    ["<b>House Co Provider:</b>","<b>No Vehicle:</b>"]]
          end
          table data, :cell_style => { :inline_format => true,:borders => [], :width => 250 }
        end
        pad(10){text "<b>Future Goal</b>", :size => 20,:inline_format => true }
        indent(30) do
          data = [["<b>Short Term Goal:</b> #{client.short_term_goal}","<b>Long Term Goal:</b> #{client.long_term_goal}"]]
          table data, :cell_style => { :inline_format => true,:borders => [], :width => 250 }
        end
        pad(10){text "<b>Plan</b>", :size => 20,:inline_format => true }
        indent(30) do
          data = [["<b>Child Education:</b> #{client.plan_child_education}","<b>Child Merriage:</b> #{client.plan_child_marriage}"],
                  ["<b>Retirement Fund:</b> #{client.plan_retirement_fund}",""]]
          table data, :cell_style => { :inline_format => true,:borders => [], :width => 250 }
        end
        pad(10){text "<b>Investment</b>", :size => 20,:inline_format => true }
        indent(30) do
          if !client.investment_type.nil?
            data = [["<b>Fix Income:</b> #{client.investment_type.fix_income}%","<b>Equity:</b> #{client.investment_type.equity}%"],
                  ["<b>Gold:</b> #{client.investment_type.gold}%","<b>Land and Estate:</b> #{client.investment_type.land_and_estate}%"]]
          else
            data = [["<b>Fix Income:</b> 0%","<b>Equity:</b> 0%"],
                    ["<b>Gold:</b> 0%","<b>Land and Estate:</b> 0%"]]
          end
          table data, :cell_style => { :inline_format => true,:borders => [], :width => 250 }
        end
        if client_info.length != 1
          start_new_page
        end
        string = "page <page> of <total>"
        # Green page numbers 1 to 7
        options = { :at => [bounds.right - 150, 0],
                    :width => 150,
                    :align => :right,
                    :page_filter => (1..7),
                    :start_count_at => 1,
                    :color => "0000ff" }
        number_pages string, options
      end
    end.render
  end
end
