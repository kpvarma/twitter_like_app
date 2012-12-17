class WelcomeController < ApplicationController
  
  before_filter :set_header_nav
  
  def home
    if signed_in?
      @tweets = Tweet.where("user_id != #{current_user.id}").order("created_at desc").limit(30).all
    else
      @tweets = Tweet.order("created_at desc").limit(30).all
    end
  end
  
  private
  
  def set_header_nav
    
    @header_nav = "Home"
    
  end
  
end
