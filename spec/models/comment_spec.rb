require 'rails_helper'

describe Comment do

  describe 'validations' do
    it 'body is at least 3 characters' do
      invalid_comment = build(:comment, body: 'sa')
      expect(invalid_comment).to_not be_valid
      valid_comment = build(:comment, body: 'hap')
      expect(valid_comment).to be_valid
    end
  end

  describe 'associations' do
    it 'has one target subject' do
      comment = build(:comment)
      expect(comment).to respond_to(:commentable)
    end

    it 'has one author' do
      comment = build(:comment)
      expect(comment).to respond_to(:author)
    end

    it 'has many likes' do
      comment = build(:comment)
      expect(comment).to respond_to(:likes)
    end
  end

  # TODO: extract to module test
  describe '#liked_by?' do
    it 'tells if a comment has been liked by a user' do
      comment = build(:comment)
      user = build(:user)
      expect(comment.liked_by?(user)).to be false
      comment.likers << user
      expect(comment.liked_by?(user)).to be true
    end
  end
end

