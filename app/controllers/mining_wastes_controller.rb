class MiningWastesController < ApplicationController
  before_action :set_mining_waste, only: [:show, :edit, :update, :destroy]

  # GET /mining_wastes
  # GET /mining_wastes.json
  def index
    @mining_wastes = []
    Rails.logger.debug params.inspect

    if params[:owner_id]
      if (params[:owner_id] && ( !params[:labor_id].nil? && params[:labor_id] != "" ))
        labor = Labor.find params[:labor_id]
        @mining_wastes = labor.mining_wastes
      else
        owner = Owner.find params[:owner_id]
        if owner
          @mining_wastes = owner.mining_wastes 
        else
          @mining_wastes = []
        end
      end
    else
      if params[:region_id] && params[:commune_id]
        # region = Region.find params[:region_id]
        commune = Commune.find params[:commune_id]
        @mining_wastes = commune.mining_wastes
      else
        if params[:commune_id]
          commune = Commune.find params[:commune_id]
          @mining_wastes = commune.mining_wastes
        end
        if params[:region_id]
          region = Region.find params[:region_id]
          @mining_wastes = region.mining_wastes
        end
      end
    end
    respond_to do |format|
      format.json { render json: @mining_wastes.as_json(methods: [:coords, :formated_resolution, :formated_resolution_date, :formated_resolution_closure_date, :formated_resolution_closure_number, :labor_name, :owner_name, :formated_utm_north, :formated_utm_east, :formated_partial_ton, :formated_total_ton, :formated_total_volume, :formated_partial_volume, :commune_id]), status: :ok }
    end
  end

  def national_stats
    stats = {}
    stats[:mining_wastes_count] = MiningWaste.all.count
    stats[:active_mining_wastes] = MiningWaste.activo.count
    stats[:inactive_mining_wastes] = MiningWaste.no_activo.count
    stats[:abandoned_mining_wastes] = MiningWaste.abandonado.count
    stats[:no_info] = MiningWaste.sin_info.count
    respond_to do |format|
      format.json { render json: stats.to_json, status: :ok }
    end
  end

  def regional_stats
    stats = {}
    if params[:region_id]
      region = Region.find params[:region_id]
      stats[:mining_wastes_count] = region.mining_wastes.count
      stats[:active_mining_wastes] = region.mining_wastes.activo.count
      stats[:inactive_mining_wastes] = region.mining_wastes.no_activo.count
      stats[:abandoned_mining_wastes] = region.mining_wastes.abandonado.count
      stats[:no_info] = region.mining_wastes.sin_info.count
      stats[:name] = region.name.upcase 
    end
    respond_to do |format|
      format.json { render json: stats.to_json, status: :ok }
    end      
  end

  def communal_stats
    stats = {}
    if params[:commune_id]
      commune = Commune.find params[:commune_id]
      stats[:mining_wastes_count] = commune.mining_wastes.count
      stats[:active_mining_wastes] = commune.mining_wastes.activo.count
      stats[:inactive_mining_wastes] = commune.mining_wastes.no_activo.count
      stats[:abandoned_mining_wastes] = commune.mining_wastes.abandonado.count
      stats[:no_info] = commune.mining_wastes.sin_info.count
      stats[:name] = commune.name
    end
    respond_to do |format|
      format.json { render json: stats.to_json, status: :ok }
    end      
  end

  # GET /mining_wastes/1
  # GET /mining_wastes/1.json
  def show
  end

  # GET /mining_wastes/new
  def new
    @mining_waste = MiningWaste.new
  end

  # GET /mining_wastes/1/edit
  def edit
  end

  # POST /mining_wastes
  # POST /mining_wastes.json
  def create
    @mining_waste = MiningWaste.new(mining_waste_params)

    respond_to do |format|
      if @mining_waste.save
        format.html { redirect_to @mining_waste, notice: 'Mining waste was successfully created.' }
        format.json { render :show, status: :created, location: @mining_waste }
      else
        format.html { render :new }
        format.json { render json: @mining_waste.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mining_wastes/1
  # PATCH/PUT /mining_wastes/1.json
  def update
    respond_to do |format|
      if @mining_waste.update(mining_waste_params)
        format.html { redirect_to @mining_waste, notice: 'Mining waste was successfully updated.' }
        format.json { render :show, status: :ok, location: @mining_waste }
      else
        format.html { render :edit }
        format.json { render json: @mining_waste.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mining_wastes/1
  # DELETE /mining_wastes/1.json
  def destroy
    @mining_waste.destroy
    respond_to do |format|
      format.html { redirect_to mining_wastes_url, notice: 'Mining waste was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mining_waste
      @mining_waste = MiningWaste.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mining_waste_params
      params[:mining_waste]
    end
end
