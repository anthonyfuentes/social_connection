require 'rails_helper'

RSpec.describe PhotosController, type: :controller do

  context 'authorized user' do
    describe '#create' do
      context 'valid data provided' do
        it 'does not create a new photo' do
          user = create(:user)
          cookies[:auth_token] = user.auth_token

          expect{
            process :create, params: { user_id: user.id,
                                       photo: user.photos.build.attributes }
          }.to change(Photo, :count).by(1)
        end
      end
    end
  end


  context 'unauthorized user' do
    describe '#create' do
      context 'valid data provided' do
        it 'does not create a new photo' do
          user, other = create(:user), create(:user)
          cookies[:auth_token] = other.auth_token

          expect{
            process :create, params: { user_id: user.id,
                                       photo: user.photos.build.attributes }
          }.to change(Photo, :count).by(0)
        end
      end
    end
    describe '#destroy' do
      context 'valid data provided' do
        it 'does not delete a photo' do
          user, other = create(:user), create(:user)
          photo = user.photos.create
          cookies[:auth_token] = other.auth_token

          expect{
            process :destroy, params: { user_id: user.id, id: photo.id }
          }.to change(Photo, :count).by(0)
        end
      end
    end
  end

end
