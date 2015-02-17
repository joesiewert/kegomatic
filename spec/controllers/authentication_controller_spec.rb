require 'rails_helper'

describe AuthenticationController do

  describe '#new' do
    it 'is visible to public users' do
      get :new
      expect(response).to render_template('application')
      expect(response.status).to eq(200)
    end

    it 'is visible to signed in users' do
      user = create_user
      session[:user_id] = user.id
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    it 'redirects user to root path after signin' do
      user = create_user
      post :create, username: user.username, password: user.password
      expect(response).to redirect_to(root_path)
    end
  end

  describe '#destroy' do
    it 'redirects user to signin path after signout' do
      user = create_user
      session[:user_id] = user.id
      get :destroy
      expect(response).to redirect_to(signin_path)
    end
  end

end
