class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  def show
    @category = Category.find_by(slug: params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    if @category.save
      flash[:notice] = "#{@category.name} category created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end


end