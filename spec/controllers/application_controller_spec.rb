require 'spec_helper'

describe ApplicationController do


  describe "hashtag" do
    context "with subdomain" do
      Given { controller.stub(:request).and_return double(host: 'www.twaker.com') }
      Then { controller.hashtag == 'twaker' }
    end

    context "without subdomain" do
      Given { controller.stub(:request).and_return double(host: 'tweeter.io') }
      Then { controller.hashtag == 'tweeter' }
    end

    context "with localhost" do
      Given { controller.stub(:request).and_return double(host: 'localhost') }
      Then { controller.hashtag == 'localhost' }
    end
  end

end
