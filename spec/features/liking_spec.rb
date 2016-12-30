require 'rails_helper'

feature 'Liking' do
  context 'post has not been liked yet' do
    it 'allows a user to like a post they haven\'t liked yet' do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      create_post
      expect{ click_on 'Like' }.to change(Like, :count).by(1)
    end

    it 'changes the link from like to unlike' do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      create_post
      click_on 'Like'
      expect(page).to have_content('Unlike')
    end
  end

  context 'post has been liked' do
    it 'allows a user to unlike a post they have liked' do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      create_post
      click_on 'Like'
      expect{ click_on 'Unlike' }.to change(Like, :count).by(-1)
    end

    it 'changes the link from unlike to like' do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      create_post
      click_on 'Like'
      click_on 'Unlike'
      expect(page).to have_content('Like')
    end
  end

end
