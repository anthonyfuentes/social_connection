require 'rails_helper'

describe PostsController do

  context 'user signed in' do
    describe '#create' do
      context 'valid data provided' do
        it 'creates a new post' do
          request.env["HTTP_REFERER"] = "/timeline"
          user = create(:user)
          cookies[:auth_token] = user.auth_token
          valid_data = attributes_for(:post, body: 'post body')

          expect{
            process :create, params: { user_id: user.id, post: valid_data }
          }.to change(Post, :count).by(1)
        end
      end

      context 'invalid data provided' do
        it 'does not create a post' do
          request.env["HTTP_REFERER"] = "/timeline"
          user = create(:user)
          cookies[:auth_token] = user.auth_token
          invalid_data = attributes_for(:post, body: '')

          expect{
            process :create, params: { user_id: user.id, post: invalid_data }
          }.to change(Post, :count).by(0)
        end
      end
    end
  end

  context 'unauthorized user' do
    describe '#create' do
      context 'valid data provided' do
        it 'does not create a new post' do
          user = create(:user)
          other_user = create(:user)
          cookies[:auth_token] = other_user.auth_token

          valid_data = attributes_for(:post, body: 'post body')

          expect{
            process :create, params: { user_id: user.id, post: valid_data }
          }.to change(Post, :count).by(0)
        end
      end
    end
  end

end
