FactoryGirl.define do
  factory :retweet do |rt|
    rt.association :user
    rt.association :tweet
    #rt.user User.all.sort_by{ rand }.first || User.new
    #rt.tweet Tweet.all.sort_by{ rand }.first || Tweet.new
  end
end
