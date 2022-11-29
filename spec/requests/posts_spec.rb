require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'Redirects to post page and show a list of posts' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('Here is a list of posts')
    end

    it 'Redirects to post page and show a post' do
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include('This is a post')
    end
  end
end
