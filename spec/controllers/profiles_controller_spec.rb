require 'rails_helper'

describe ProfilesController do

  context 'authorized user' do
    describe '#edit' do
      it 'allows access to profile editing page' do
        user = create(:user, auth_token: 'authed')
        cookies[:auth_token] = user.auth_token

        process :edit, params: { user_id: user.id }

        expect(response).to have_http_status(200)
      end
    end

    describe '#update' do
      it 'allows updating of profile information' do
        profile = create(:profile, about_me: 'B4')
        user = create(:user, auth_token: 'authed', profile: profile)
        cookies[:auth_token] = user.auth_token
        new_about_me = 'A4'
        profile.about_me = new_about_me

        process :update, params: { user_id: user.id,
                                   profile: profile.attributes }

        profile.reload
        expect(profile.about_me).to eq(new_about_me)
      end
    end
  end

  context 'unauthorized user' do
    describe '#edit' do
      it 'redirects to root url' do
        user = create(:user)
        other_user = create(:user, auth_token: 'authed')
        cookies[:auth_token] = other_user.auth_token

        process :edit, params: { user_id: user.id }

        expect(response).to have_http_status(302)
      end
    end

    describe '#update' do
      it 'does not allow updating of profile information' do
        original_about_me, new_about_me = 'B4', 'A4'
        profile = create(:profile, about_me: original_about_me)
        user = create(:user, profile: profile)
        profile.about_me = new_about_me
        other_user = create(:user, auth_token: 'authed')
        cookies[:auth_token] = other_user.auth_token

        process :update, params: { user_id: user.id,
                                   profile: profile.attributes }

        profile.reload
        expect(profile.about_me).to eq(original_about_me)
      end
    end
  end

end
