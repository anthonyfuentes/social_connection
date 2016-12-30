
class NewsfeedsController < ApplicationController

  def show
    @newsfeed = Newsfeed.new(current_user)
  end

end
