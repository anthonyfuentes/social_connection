require 'rails_helper'

feature 'Sign Out' do
  it 'signs the user out' do
    sign_in_as_new_user
    click_on 'Sign Out'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Sign In')
  end
end
