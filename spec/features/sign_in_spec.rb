require 'rails_helper'

feature 'Sign In' do
  context 'valid data provided' do
    it 'allows registered users to sign in' do
      user = create(:user, :with_profile, email: 'user@example.com',
                    password: 'password')
      visit root_path
      sign_in(user: user)
      expect(current_path).to eq(user_newsfeed_path(user))
    end
  end

  context 'invalid data provided' do
    it 'disallows registered users to sign in' do
      user = create(:user, email: 'user@example.com',
                    password: 'password')
      visit root_path
      sign_in(user: user, password: 'wrong password')
      expect(current_path).to eq(root_path)
    end
  end

  context 'visitor without an account' do
    it 'disallows visitors to sign in' do
      visit root_path
      sign_in(email: 'visitor@example.com', password: 'imadethisup')
      expect(current_path).to eq(root_path)
    end
  end
end
