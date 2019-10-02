class SubcategoriesController < ApplicationController
  before_action :set_under_category, only: [:show, :edit, :update, :destroy]

  # GET /subcategories
  # GET /subcategories.json
  def index
    @subcategories = Subcategory.all
  end

  # GET /subcategories/1
  # GET /subcategories/1.json
  def show
  end

  # GET /subcategories/new
  def new
    @under_category = Subcategory.new
  end

  # GET /subcategories/1/edit
  def edit
  end

  # POST /subcategories
  # POST /subcategories.json
  def create
    @under_category = Subcategory.new(under_category_params)

    respond_to do |format|
      if @under_category.save
        format.html { redirect_to @under_category, notice: 'Under category was successfully created.' }
        format.json { render :show, status: :created, location: @under_category }
      else
        format.html { render :new }
        format.json { render json: @under_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subcategories/1
  # PATCH/PUT /subcategories/1.json
  def update
    respond_to do |format|
      if @under_category.update(under_category_params)
        format.html { redirect_to @under_category, notice: 'Under category was successfully updated.' }
        format.json { render :show, status: :ok, location: @under_category }
      else
        format.html { render :edit }
        format.json { render json: @under_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subcategories/1
  # DELETE /subcategories/1.json
  def destroy
    @under_category.destroy
    respond_to do |format|
      format.html { redirect_to under_categories_url, notice: 'Under category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_under_category
      @under_category = Subcategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def under_category_params
      params.fetch(:under_category, {})
    end
end
