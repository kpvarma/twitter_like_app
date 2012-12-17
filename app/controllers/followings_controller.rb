class FollowingsController < ApplicationController
  
  before_filter :require_user, :except=>:friends
  
  def friends
    @header_nav = "Friends"
    @friends = current_user.friends.limit(10)
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def followers
    @header_nav = "Followers"
    @followers = current_user.followers.limit(10)
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def follow
    @user = User.find_by_id(params[:user_id])
    if @user
      @following = Following.new
      @following.user_id = params[:user_id]
      @following.follower_id = current_user.id
      @following.valid?
      
      if @following.errors.blank?
        @following.save
        respond_to do |format|
          format.html { redirect_to user_tweets_path(:username=>@user.username), notice: "You are now following @#{@user.username}." }
        end
      else
        render_404
      end
    else
      render_404
    end
  end
  
  def unfollow
    @user = User.find_by_id(params[:user_id])
    if @user
      @following = Following.where({:user_id=>@user.id, :follower_id=>current_user.id}).first
      if @following
        @following.destroy
        respond_to do |format|
          format.html { redirect_to user_tweets_path(:username=>@user.username), notice: "You are not following @#{@user.username} now." }
        end
      else
        render_404
      end
    else
      render_404
    end
  end
  
end
