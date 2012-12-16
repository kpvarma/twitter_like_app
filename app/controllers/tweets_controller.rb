class TweetsController < ApplicationController
  
  before_filter :require_user, :except=>:index
  before_filter :set_header_nav
  
  def index
    
    @user = User.find_by_username(params[:username])
    
    if @user
      @tweets = @user.tweets.limit(10)
      respond_to do |format|
        format.html # index.html.erb
      end
    else
      render_404
    end
  end

  def show
    
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
    
  end

  def new
    
    @tweet = Tweet.new

    respond_to do |format|
      format.html # new.html.erb
    end
    
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def create
    
    @tweet = Tweet.new(params[:tweet])
    @tweet.user = current_user

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to user_tweets_path(:username=>current_user.username), notice: 'Tweet was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      if @tweet.update_attributes(params[:tweet])
        format.html { redirect_to user_tweets_path(:username=>current_user.username), notice: 'Tweet was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to tweets_url }
    end
  end
  
  private
  
  def set_header_nav
    
    @header_nav = "Tweets"
    
  end
  
end
