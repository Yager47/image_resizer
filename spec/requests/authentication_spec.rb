require 'rails_helper'

RSpec.describe 'Authentication API', type: :request do
  describe 'POST /subscribe' do
    before { post '/subscribe' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns auth_token' do
      expect(json).to have_key 'auth_token'
      expect(json['auth_token']).not_to be_empty
    end
  end
end
