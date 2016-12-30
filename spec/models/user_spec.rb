require 'rails_helper'

describe User do

  describe 'validations' do
    it 'passwords are at least 5 characters' do
      invalid_user = build(:user, password: 'saad')
      expect(invalid_user).to_not be_valid
      valid_user = build(:user, password: 'happy')
      expect(valid_user).to be_valid
    end

    it 'emails are unique' do
      user = create(:user, email: 'unique@example.com')
      imposter = build(:user, email: user.email)
      expect(imposter).to_not be_valid
    end
  end

  describe 'associations' do
    it 'has one profile' do
      user = build(:user)
      expect(user).to respond_to(:profile)
    end

    it 'has many posts' do
      user = build(:user)
      expect(user).to respond_to(:posts)
    end

    it 'has many likes' do
      user = build(:user)
      expect(user).to respond_to(:posts)
    end

    it 'has many friended users' do
      user = build(:user)
      expect(user).to respond_to(:friended_users)
    end

    it 'has many users who friended them' do
      user = build(:user)
      expect(user).to respond_to(:users_friended_by)
    end
  end

  describe '.send_welcome_email' do
    it 'delays a welcome email to given user' do
      user = create(:user)
      expect {
        User.send_welcome_email(user.id)
      }.to change { Delayed::Job.count }.by(1)
    end
  end

  describe '#name' do
    it 'returns first_name + last_name' do
      user = build(:user, first_name: "First", last_name: "Last")
      expect(user.name).to eq("First Last")
    end
  end

  describe '#regenerate_auth_token' do
    it 'generates a new user authentication token' do
      user = build(:user)
      previous_token = user.auth_token
      user.regenerate_auth_token
      expect(user.auth_token).to_not eq(previous_token)
    end
  end
end

