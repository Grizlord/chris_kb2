class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :cat_nav
  before_action :helpful_links
  
  def helpful_links
    @helpful_links = HelpfulLink.all
  end
  
  def cat_nav
    @categories = Category.all
  end
  
  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) && flash[:danger] = "You are not authorized!" unless current_user.admin?
    end
end
