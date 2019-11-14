class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @user = User.find(params[:id])
    @jobs = @user.jobs.page(params[:page])
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
    if !@category.present?
      render json: { error: 'Reply could not be sent.' }, status: 400
    end
  end

  def skill
    binding.pry
    current_user.skills.delete(params[:skills])
    current_user.save!
  end
end
