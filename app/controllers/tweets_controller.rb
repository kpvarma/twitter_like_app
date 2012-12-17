class TweetsController < ApplicationController
  
  before_filter :require_user, :except=>:index
  before_filter :set_header_nav
  
  def index
    
    @user = User.find_by_username(params[:username])
    
    if @user
      
      # Query to pull all tweets for current_user, including retweets and order from newest to oldest
      #sql = "select * from (
      #    select t.* from tweets as t where user_id = #{@user.id}
      #    union
      #    select t.* from tweets as t where t.id in (select tweet_id from retweets where user_id = #{@user.id}))
      #a order by created_at desc limit 10;"
      #@tweets = Tweet.find_by_sql(sql)
      
      @tweets = @user.tweets.order("created_at desc").limit(30)
      respond_to do |format|
        format.html
      end
    else
      render_404
    end
  end

  def show
    
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html
    end
    
  end

  def new
    
    @tweet = Tweet.new

    respond_to do |format|
      format.html
    end
    
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def create
    
    @tweet = Tweet.new(params[:tweet])
    @tweet.user = current_user
    @tweet.valid?
    
    if @tweet.errors.blank?
      @tweet.save
      @user = current_user
      @tweets = @user.tweets.order("created_at desc").limit(30)
      @success_message = "Tweet has been saved Successfully."
      respond_to do |format|
        format.html { redirect_to user_tweets_path(:username=>current_user.username), notice: 'Tweet was successfully created.' }
        format.js {render :create}
      end
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.js {render :form}
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
      format.html { redirect_to user_tweets_path(:username=>current_user.username) }
    end
  end
  
  private
  
  def set_header_nav
    
    @header_nav = "Tweets"
    
  end
  
end
