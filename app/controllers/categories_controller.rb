class CategoriesController < ApplicationController
  before_action :require_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_category, only: [:show, :edit, :update]

  def index
    @categories = Category.all.sort{|x,y| x.name.downcase <=> y.name.downcase}
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "#{@category.name} category created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category successfully updated!"
      redirect_to categories_path
    else
      render :edit
    end
  end

  private
  def set_category
    @category = Category.find_by(slug: params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end


end