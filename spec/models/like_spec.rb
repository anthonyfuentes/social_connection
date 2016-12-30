require 'rails_helper'

describe Like do

  describe 'validations' do
    it 'is unique on user, subject type, and subject id' do
      like = create(:like)
      duplicate = build(:like, user: like.user,
                        likable: like.likable)
      expect(duplicate).to_not be_valid
    end
  end

  describe 'associations' do
    it 'has one target subject' do
      like = build(:like)
      expect(like).to respond_to(:likable)
    end

    it 'has one user' do
      like = build(:like)
      expect(like).to respond_to(:user)
    end
  end
end

