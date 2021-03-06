class FuelsController < ApplicationController
  before_action :set_fuel, only: [:show, :edit, :update, :destroy]

  def index
    @query = params[:query]
    @fuels = Fuel.search @query
    @paged_fuels = @fuels.page params[:page]
    authorize @paged_fuels
    respond_to do |format|
      format.html
      format.json
      format.csv  { send_data @fuels.to_csv, filename: export_filename }
    end
  end

  def show
  end

  def new
    @fuel = Fuel.new
    authorize @fuel
    render 'shared/new_or_edit'
  end

  def edit
    render 'shared/new_or_edit'
  end

  def create
    @fuel = Fuel.new fuel_params
    authorize @fuel
    respond_to do |format|
      if @fuel.save
        format.html { redirect_to fuels_url, notice: t('notice.create.success', resource: Fuel.model_name.human) }
        format.json { render :show, status: :created, location: @fuel }
      else
        format.html { render 'shared/new_or_edit' }
        format.json { render json: @fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @fuel.update(fuel_params)
        format.html { redirect_to fuels_url, notice: t('notice.update.success', resource: Fuel.model_name.human) }
        format.json { render :show, status: :ok, location: @fuel }
      else
        format.html { render 'shared/new_or_edit' }
        format.json { render json: @fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fuel.destroy
    respond_to do |format|
      format.html { redirect_to fuels_url, notice: t('notice.destroy.success', resource: Fuel.model_name.human) }
      format.json { head :no_content }
    end
  end

  def import
    authorize Fuel
    if params[:file]
      Fuel.from_csv params[:file]
      redirect_to fuels_url, notice: t('notice.import.success', resource: Fuel.model_name.human(count: 2))
    else
      redirect_to fuels_url, alert: t('alert.import.failure', resource: Fuel.model_name.human(count: 2))
    end
  end

  def autocomplete
    fuels = Fuel.where("description ilike '#{params[:term]}%'").order(:description)
    authorize fuels
    render json: fuels.pluck(:description)
  end

  private
    def set_fuel
      @fuel = Fuel.friendly.find params[:id]
      authorize @fuel
    end

    def fuel_params
      params.require(:fuel).permit(:code, :description)
    end
end
