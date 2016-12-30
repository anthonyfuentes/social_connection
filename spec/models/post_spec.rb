require 'rails_helper'

describe Post do
  describe 'validations' do
    it 'body is present' do
      invalid_post = build(:post, body: '')
      expect(invalid_post).to_not be_valid
      valid_post = build(:post, body: 'h')
      expect(valid_post).to be_valid
    end
  end

  describe 'associations' do
    it 'has one author' do
      post = build(:post)
      expect(post).to respond_to(:author)
    end

    it 'has many likes' do
      post = build(:post)
      expect(post).to respond_to(:likes)
    end

    it 'has many likers' do
      post = build(:post)
      expect(post).to respond_to(:likers)
    end

    it 'has many comments' do
      post = build(:post)
      expect(post).to respond_to(:comments)
    end
  end

  # TODO: extract to module test
  describe '#liked_by?' do
    it 'tells if a post has been liked by a user' do
      post = build(:post)
      user = build(:user)
      expect(post.liked_by?(user)).to be false
      post.likers << user
      expect(post.liked_by?(user)).to be true
    end
  end

  describe '#sorted_comments' do
    it 'provides comments in ascending order of created at date' do
      comments = create_list(:comment, 3)
      post = build(:post, comments: comments)
      newest_first = Comment.where(commentable_id: post.id)
        .order(created_at: :asc)
      expect(post.sorted_comments(:asc)).to match_array(newest_first)
    end

    it 'provides comments in descending order of created at date' do
      comments = create_list(:comment, 3)
      post = build(:post, comments: comments)
      oldest_first = Comment.where(commentable_id: post.id)
        .order(created_at: :desc)
      expect(post.sorted_comments(:desc)).to match_array(oldest_first)
    end
  end
end

