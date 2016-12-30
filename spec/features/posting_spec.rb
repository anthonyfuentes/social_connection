require 'rails_helper'

feature 'Posting' do
  context 'valid data provided' do
    it 'allows a user to post to their timeline' do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      fill_in_post_form(body: 'post body')
      expect{ click_on 'Post' }.to change(Post, :count).by(1)
    end

    it 'displays the new post to the user\'s timeline' do
      user = sign_in_as_new_user
      post_body = 'post body'
      visit user_timeline_path(user.id)
      fill_in_post_form(body: post_body)
      click_on 'Post'
      expect(page).to have_content(post_body)
    end
  end

  context 'invalid data provided' do
    it 'disallows a user to post to their timeline' do
      user = sign_in_as_new_user
      visit user_timeline_path(user.id)
      fill_in_post_form(body: '')
      expect{ click_on 'Post' }.to change(Post, :count).by(0)
    end
  end
end
