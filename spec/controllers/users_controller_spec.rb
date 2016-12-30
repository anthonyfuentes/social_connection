require 'rails_helper'

describe UsersController do

  context 'visitor' do
    describe '#new' do
      it 'allows a visitor to visit the sign up page' do
        process :new

        expect(response).to have_http_status(200)
      end
    end

    context 'valid data provided' do
      describe '#create' do
        it 'creates a new user record' do
          valid_data = attributes_for(:user)

          expect {
            process :create, params: { user: valid_data }
          }.to change(User, :count).by(1)
        end
      end
    end

    context 'invalid data provided' do
      describe '#create' do
        it 'does not create a new user record' do
          invalid_data = attributes_for(:user, first_name: nil)

          expect {
            process :create, params: { user: invalid_data }
          }.to change(User, :count).by(0)
        end
      end
    end
  end

  context 'user is signed in' do
    describe '#index' do
      it 'allows user to visit users index page' do
        user = create(:user)
        cookies[:auth_token] = user.auth_token

        process :index

        expect(response).to have_http_status(200)
      end
    end
  end

end
