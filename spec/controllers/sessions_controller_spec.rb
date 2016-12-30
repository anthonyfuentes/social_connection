require 'rails_helper'

describe SessionsController do

  context 'valid data provided' do
    describe '#create' do
      it 'redirects to user\'s timeline' do
        user = create(:user, email: 'user@example.com',
                      password: 'testpassword')

        process :create, params: { email: user.email,
                                   password: user.password }

        expect(response).to redirect_to user_newsfeed_url(user)
      end

      it 'adds the user\'s authorization token to cookies' do
        user = create(:user)
        cookies.permanent[:auth_token] = user.auth_token

        process :create #:sign_out

        expect(cookies[:auth_token]).to eq(user.auth_token)
      end
    end
  end

  context 'invalid data provided' do
    describe '#create' do
      it 'redirects to site homepage' do
        user = create(:user, email: 'user@example.com',
                      password: 'testpassword')

        process :create, params: { email: user.email,
                                   password: 'wrongpassword' }

        expect(response).to redirect_to root_url
      end
    end
  end

  context 'the user is signed in' do
    describe '#destroy' do
      it 'redirects the user to the homepage' do
        user = create(:user)
        cookies.permanent[:auth_token] = user.auth_token

        process :destroy

        expect(response).to redirect_to root_url
      end

      describe '#sign_out' do
        it 'removes the user\'s auth token from cookies' do
          user = create(:user)
          cookies.permanent[:auth_token] = user.auth_token

          process :destroy #:sign_out

          expect(cookies[:auth_token]).to be_nil
        end
      end
    end
  end

end
