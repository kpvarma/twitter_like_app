require 'spec_helper'

describe Retweet do
  
  before(:each) do
    @tweet_owner = FactoryGirl.create(:user)
    @tweet = FactoryGirl.create(:tweet, :user=>@tweet_owner)
    @retweeter = FactoryGirl.create(:user)
    @retweet = FactoryGirl.create(:retweet, :tweet=>@tweet, :user=>@retweeter)
  end
  
  it "should be valid" do
    @retweet.should be_valid
  end

  it "should create a new instance given a valid attribute" do
    @retweet.save!
  end
  
  it "should require a user" do
    @retweet.user = nil
    @retweet.valid?
    @retweet.should be_invalid
    @retweet.should have(1).error_on(:user_id)
  end
  
  it "should require a tweet" do
    @retweet.tweet = nil
    @retweet.valid?
    @retweet.should be_invalid
    @retweet.should have(1).error_on(:tweet_id)
  end
  
end
