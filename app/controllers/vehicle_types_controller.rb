class VehicleTypesController < ApplicationController
  before_action :set_vehicle_type, only: [:show, :edit, :update, :destroy]

  def index
    @query = params[:query]
    @vehicle_types = VehicleType.search @query
    @paged_vehicle_types = @vehicle_types.page params[:page]
    authorize @paged_vehicle_types
    respond_to do |format|
      format.html
      format.json
      format.csv  { send_data @vehicle_types.to_csv, filename: export_filename }
    end
  end

  def show
  end

  def new
    @vehicle_type = VehicleType.new
    authorize @vehicle_type
    render 'shared/new_or_edit'
  end

  def edit
    render 'shared/new_or_edit'
  end

  def create
    @vehicle_type = VehicleType.new vehicle_type_params
    authorize @vehicle_type
    respond_to do |format|
      if @vehicle_type.save
        format.html { redirect_to vehicle_types_url, notice: t('notice.create.success', resource: VehicleType.model_name.human) }
        format.json { render :show, status: :created, location: @vehicle_type }
      else
        format.html { render 'shared/new_or_edit' }
        format.json { render json: @vehicle_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vehicle_type.update(vehicle_type_params)
        format.html { redirect_to vehicle_types_url, notice: t('notice.update.success', resource: VehicleType.model_name.human) }
        format.json { render :show, status: :ok, location: @vehicle_type }
      else
        format.html { render 'shared/new_or_edit' }
        format.json { render json: @vehicle_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vehicle_type.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_types_url, notice: t('notice.destroy.success', resource: VehicleType.model_name.human) }
      format.json { head :no_content }
    end
  end

  def import
    authorize VehicleType
    if params[:file]
      VehicleType.from_csv params[:file]
      redirect_to vehicle_types_url, notice: t('notice.import.success', resource: VehicleType.model_name.human(count: 2))
    else
      redirect_to fuels_url, alert: t('alert.import.failure', resource: VehicleType.model_name.human(count: 2))
    end
  end

  def autocomplete
    vehicle_types = VehicleType.where("description ilike '#{params[:term]}%'").order(:description)
    authorize vehicle_types
    render json: vehicle_types.pluck(:description)
  end

  private
    def set_vehicle_type
      @vehicle_type = VehicleType.friendly.find params[:id]
      authorize @vehicle_type
    end

    def vehicle_type_params
      params.require(:vehicle_type).permit(:code, :description)
    end
end
