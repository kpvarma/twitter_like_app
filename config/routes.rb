Twitter::Application.routes.draw do
  
  root :to => 'welcome#home'
  
  devise_for :users

  resources :tweets, :except=>[:show, :index]

  match 'friends' => "followings#friends", :as => :friends
  match 'followers' => "followings#followers", :as => :followers
  match 'follow/:user_id' => "followings#follow", :as => :follow
  match 'unfollow/:user_id' => "followings#unfollow", :as => :unfollow
  
  match 'retweets' => "retweets#index", :as => :retweets
  match 'retweet/:tweet_id' => "retweets#retweet", :as => :retweet
  match 'retweet/:id/destroy' => "retweets#destroy", :as => :destroy_retweet, :method=>:delete
  
  match ':username' => "tweets#index", :as => :user_tweets
  
end
