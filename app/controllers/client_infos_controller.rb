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

    respond_to do |format|
      if @client_info.save
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
      params.require(:client_info).permit(:name, :address, :pincode, :date_of_birth, :mobile, :phone, :email, :education, :occupation, :job_post, :name_of_company, :job_expirience_year, :income, :economical_liability, :number_of_child, :anniversary_date)
    end
end
