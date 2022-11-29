require 'rails_helper'

RSpec.describe '::UsersController', type: :request do
  describe 'GET //users' do
    it 'Redirects to user and shows a list of users' do
      get users_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('Here is a list of users')
    end

    it 'Redirects to user and shows a single user' do
      get '/users/:id'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include('Here is a user')
    end
  end
end
