class BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  def index
    @query = params[:query]
    @brands = Brand.search @query
    @paged_brands = @brands.page params[:page]
    authorize @paged_brands
    respond_to do |format|
      format.html
      format.json
      format.csv  { send_data @brands.to_csv, filename: export_filename }
    end
  end

  def show
  end

  def new
    @brand = Brand.new
    authorize @brand
    render 'shared/new_or_edit'
  end

  def edit
    render 'shared/new_or_edit'
  end

  def create
    @brand = Brand.new brand_params
    authorize @brand
    respond_to do |format|
      if @brand.save
        format.html { redirect_to brands_url, notice: t('notice.create.success', resource: Brand.model_name.human) }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render 'shared/new_or_edit' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to brands_url, notice: t('notice.update.success', resource: Brand.model_name.human) }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render 'shared/new_or_edit' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, notice: t('notice.destroy.success', resource: Brand.model_name.human) }
      format.json { head :no_content }
    end
  end

  def import
    authorize Brand
    if params[:file]
      Brand.from_csv params[:file]
      redirect_to brands_url, notice: t('notice.import.success', resource: Brand.model_name.human(count: 2))
    else
      redirect_to brands_url, alert: t('alert.import.failure', resource: Brand.model_name.human(count: 2))
    end
  end

  def autocomplete
    brands = Brand.where("description ilike '#{params[:term]}%'").order(:description)
    authorize brands
    render json: brands.pluck(:description)
  end

  private
    def set_brand
      @brand = Brand.friendly.find params[:id]
      authorize @brand
    end

    def brand_params
      params.require(:brand).permit(:code, :description)
    end
end
