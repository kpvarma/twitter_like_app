class WelcomeController < ApplicationController
  
  before_filter :set_header_nav
  
  def home
    @tweets = Tweet.order(:created_at).limit(30).all
  end
  
  private
  
  def set_header_nav
    
    @header_nav = "Home"
    
  end
  
end
