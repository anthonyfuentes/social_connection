require 'active_support/concern'

module Likable
  extend ActiveSupport::Concern

  def liked_by?(user)
    likers.include?(user)
  end

end
