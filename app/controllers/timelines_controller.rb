
class TimelinesController < ApplicationController
  skip_before_action :correct_user, only: [:show]

  def show
    @user = User.find(params[:user_id])
    @timeline = Timeline.new(@user)
  end

end
