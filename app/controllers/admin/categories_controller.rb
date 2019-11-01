class Admin::CategoriesController <  AdminController

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
    @subcategories = []
    @category = Category.new
    @subcategories = Subcategory.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    @category.subcategories.build
    respond_to do |format|
      format.html
      format.js
    end

  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    @subcategories = @category.subcategories
    respond_to do |format|
      format.html
      format.js
    end
  end
  def get_subcategories
    @subcategories = Subcategory.where(category_id: params[:category_id])
  end
  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_path, notice: 'La catégorie a été créée avec succès' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_tag
   tag = Tag.find_by(name:params[:tag])
   @new_tag = Tag.create(name:params[:tag]) if !tag
   render :json => @new_tag
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    binding.pry
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_path, notice: 'La catégorie a été mise à jour avec succès' }
        format.json { render :index, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_path, notice: 'La catégorie a été supprimée avec succès' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:id, :name,:tag_ids => [], :subcategory_ids => [],:subcategories_attributes => [:id, :name])
    end
end
