class ArticlesController < ApplicationController
  before_action :logged_in_user,    only: [:new, :create, :edit, :destroy]
  before_action :correct_user,      only: :destroy
  before_action :article_access,  only: [:show, :edit]
  
 
  def index
    # using pg_search gem
    @articles = Article.text_search(params[:query]).paginate(page: params[:page], :per_page => 10)
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "You have successfully brought life to new knowledge"
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
      flash[:success] = "You successfully nurtured the knowledge, and so Skynet begins"
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  
  def destroy
    @article.destroy
    flash[:success] = "You have successfully killed knowledge"
    redirect_to request.referrer || root_url
  end
  
   private

    def article_params
      params.require(:article).permit(:title, :content, :user_id, category_ids: [])
    end
    
    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
    
     # Denies access to internal articles if you are not an internal user.
    def article_access
      @article = Article.find(params[:id])
     
      if @article.internal?
        redirect_to(root_url) && flash[:danger] = "You are not authorized to view that article! Try logging in or contact the site admin if you feel you should have access." unless logged_in? && current_user.internal?
      end
    end  
end
