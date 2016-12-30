require 'rails_helper'

feature 'Profile Editing' do
  context 'valid data provided' do
    it 'updates the information on the user\'s about page' do
      user = sign_in_as_new_user
      visit user_profile_edit_path(user.id)
      about_me = 'This section is about me'
      fill_in_profile_form(about: about_me)
      click_on 'Update Profile'
      expect(current_path).to eq(user_profile_path(user))
      expect(page).to have_content(about_me)
    end
  end
end
