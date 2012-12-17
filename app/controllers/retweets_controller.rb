class RetweetsController < ApplicationController
  
  before_filter :require_user
  
  def index
    @header_nav = "Retweets"
    @retweets = current_user.retweets.limit(30)
    respond_to do |format|
      format.html
    end
  end

  def retweet
    @retweet = Retweet.new
    @retweet.tweet_id = params[:tweet_id]
    @retweet.user_id = current_user.id
    @retweet.valid?
    
    if @retweet.errors.blank? 
      @retweet.save
      respond_to do |format|
        format.html { redirect_to retweets_path, notice: 'Retweet was successfully created.' }
      end
    else
      render_404
    end
  end
  
  def destroy
    @retweet = Retweet.find_by_id(params[:id])
    if @retweet
      @retweet.destroy
      respond_to do |format|
        format.html { redirect_to retweets_path, notice: 'Retweet was successfully created.' }
      end
    else
      render_404
    end
  end

end
