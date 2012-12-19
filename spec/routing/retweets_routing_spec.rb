require "spec_helper"

describe RetweetsController do
  describe "routing" do

    it "routes to #index" do
      get("/retweets").should route_to("retweets#index")
    end

    it "routes to #retweet" do
      get("/retweet/1").should route_to("retweets#retweet", :tweet_id=>"1")
    end

    it "routes to #destroy" do
      delete("/retweets/1").should route_to("retweets#destroy", :id => "1", :method=>:delete)
    end

  end
end
