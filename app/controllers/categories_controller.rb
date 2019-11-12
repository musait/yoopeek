class CategoriesController < ApplicationController

  def get_subcategories
    @category  = Category.find(params[:category_id])
    @subcategories = @category.subcategories
  end

end
