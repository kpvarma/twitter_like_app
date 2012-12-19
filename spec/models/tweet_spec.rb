require 'spec_helper'

describe Tweet do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @tweet = FactoryGirl.create(:tweet, :user=>@user)
  end
  
  it "should be valid" do
    @tweet.should be_valid
  end

  it "should create a new instance given a valid attribute" do
    @tweet.save!
  end
  
  it "should require a message" do
    @tweet.message = ""
    @tweet.valid?
    @tweet.should be_invalid
    @tweet.should have(1).error_on(:message)

    @tweet.message = nil
    @tweet.valid?
    @tweet.should be_invalid
    @tweet.should have(1).error_on(:message)
  end
  
  it "should require a user" do
    @tweet.user = nil
    @tweet.valid?
    @tweet.should be_invalid
    @tweet.should have(1).error_on(:user_id)
  end
  
  ## max 160 characters
  it "should accept only upto 160 characters" do
    @tweet.message = Faker::Lorem.words(160).join(" ")
    @tweet.valid?
    @tweet.should be_invalid
    @tweet.should have(1).error_on(:message)
  end
  
end
