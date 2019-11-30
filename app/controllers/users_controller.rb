class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show,:get_subcategories,:new_subcategory,:delete_subcategory]
  def show
    @user = User.find(params[:id])
    @jobs = @user.jobs.where(status: :completed_by_customer).page(params[:page])
  end

  def my_subscription
    @plan_limitations = PlanLimitation.order(:show_order).all
    if @plan_limitations.blank?
      PlanLimitation.free_limitation
      PlanLimitation.classic_limitation
      PlanLimitation.premium_limitation
      @plan_limitations = PlanLimitation.order(:show_order).all
    end
  end

  def get_tags
    @category = Category.find(params[:category_id]) if params[:category_id].present?
    @tags = @category.tags if @category
  end

  def get_subcategories
    @profession = Profession.find(params[:profession_id])
    @subcategories = @profession.subcategories
  end
  def new_subcategory
    @subcategory = Subcategory.find(params[:subcategory])
    current_user.subcategories << @subcategory
  end

  def delete_subcategory
    current_user.subcategories.delete_all
  end
  def skill
    current_user.skills.delete(params[:skills])
    respond_to do |format|
      if current_user.save
        format.html
        format.js
      end
    end
  end

end
