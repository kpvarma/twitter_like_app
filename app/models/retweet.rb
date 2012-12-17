class Retweet < ActiveRecord::Base
  
  validates :tweet_id, :presence=>true
  validates :user_id, :presence=>true
  
  belongs_to :user
  belongs_to :tweet
  
end
