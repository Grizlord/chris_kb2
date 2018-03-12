class HelpfulLinksController < ApplicationController
  before_action :set_helpful_link, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,   only: [:new, :edit, :index, :destroy]
  before_action :admin_user,       only: [:new, :edit, :index, :destroy]
 
  def index
    @helpful_links = HelpfulLink.all
  end

  def new
    @helpful_link = HelpfulLink.new
  end

  def edit
    @helpful_link = HelpfulLink.find(params[:id])
  end

  def create
    @helpful_link =HelpfulLink.new(helpful_link_params)
    if @helpful_link.save
      flash[:success] = "You are so helpful!"
      redirect_to helpful_links_path
    else
      render 'new'
    end
  end
  
  def update
    @helpful_link = HelpfulLink.find(params[:id])
    if @helpful_link.update_attributes(helpful_link_params)
      flash[:success] = "Link successfully updated"
      redirect_to helpful_links_path
    else
      render 'edit'
    end
  end
  
  def destroy
    HelpfulLink.find(params[:id]).destroy
    flash[:success] = "Link brutally murdered"
    redirect_to helpful_links_url
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_helpful_link
      @helpful_link = HelpfulLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def helpful_link_params
      params.require(:helpful_link).permit(:url, :name)
    end
end
