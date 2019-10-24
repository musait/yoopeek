class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search_result]
  def index
  end
  def search_result
    if params[:search].present?
      @workers = Worker.joins(:categories).where(categories: {name: params[:name]})
    else
      @workers = Worker.paginate(page: params[:page], per_page: params[:per_page])
    end

  end

  def private
  end
end
