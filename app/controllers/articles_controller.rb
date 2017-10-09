class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]
  before_action :correct_user,   only: :destroy
  
  def index
    @articles = Article.text_search(params[:query]).paginate(page: params[:page], :per_page => 10)
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
    @categories = Category.all
  end
  
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "You did it Water Boy"
      redirect_to @article
    else
      render 'new'
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Article successfully updated"
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  
  def destroy
    @article.destroy
    flash[:success] = "Article deleted"
    redirect_to request.referrer || root_url
  end
  
   private

    def article_params
      params.require(:article).permit(:title, :content, :user_id, :category_id)
    end
    
    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
end
