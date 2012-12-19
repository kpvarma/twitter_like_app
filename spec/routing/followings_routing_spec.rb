require "spec_helper"

describe FollowingsController do
  describe "routing" do
    
    it "routes to #index" do
      get("/friends").should route_to("followings#friends")
    end
    
    it "routes to #index" do
      get("/followers").should route_to("followings#followers")
    end

    it "routes to #new" do
      get("/follow/1").should route_to("followings#follow", :user_id=>"1")
    end
    
    it "routes to #new" do
      get("/unfollow/1").should route_to("followings#unfollow", :user_id=>"1")
    end

  end
end
