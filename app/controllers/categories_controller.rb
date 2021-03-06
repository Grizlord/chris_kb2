class CategoriesController < ApplicationController
  before_action :logged_in_user,     only: [:new, :edit, :index, :destroy]
  before_action :admin_user,         only: [:new, :edit, :index, :destroy]
  before_action :internal_category,  only: :show
  
  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.text_search(params[:query]).paginate(page: params[:page], :per_page => 10)
  end

  def new
    @category = Category.new
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category successfully created!"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category successfully updated"
      redirect_to categories_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category brutally murdered"
    redirect_to categories_url
  end
  
  private

    def category_params
      params.require(:category).permit(:name)
    end
    
    private
    
      # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def internal_category
      @category = Category.find(params[:id])
      if @category.name == "Internal"
        redirect_to(root_url) && flash[:danger] = "You are not authorized to view that category! Contact the site admin if you feel you should have access." unless logged_in? && current_user.internal?
      end
    end
end