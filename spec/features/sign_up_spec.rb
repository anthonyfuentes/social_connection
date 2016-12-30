require 'rails_helper'

feature 'Sign Up' do
  context 'valid data provided' do
    it 'allows visitors to create an account' do
      gender = create(:gender, name: 'predictable')
      visit root_path
      password = 'password'
      fill_in_user_form(first: 'First', last: 'Last',
                        email: 'user@example.com',
                        pw: password, pwc: password,
                        gender: gender.name)
      expect{ click_on 'Sign Up' }.to change(User, :count).by(1)
    end
  end

  context 'invalid data provided' do
    it 'disallows visitors to create an account' do
      create(:gender, name: 'predictable')
      visit root_path
      fill_in_user_form(first: '', last: '',
                        email: '', gender: '',
                        pw: '', pwc: '')
      expect{ click_on 'Sign Up' }.to change(User, :count).by(0)
      expect(page).to have_content('Sign Up')
    end
  end
end
