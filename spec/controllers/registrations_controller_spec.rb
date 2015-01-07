require 'rails_helper'

describe RegistrationsController do

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
    it 'redirects user to elections path after signup' do
      password = Faker::Internet.password
      post :create, user: {
        username: Faker::Internet.user_name,
        password: password,
        password_confirmation: password
      }
      expect(response).to redirect_to(elections_path)
    end
  end

end
