require 'rails_helper'

RSpec.describe 'Images API', type: :request do
  let!(:current_user) { create(:user) }
  let(:auth_token) { JsonWebToken.encode(access_token: current_user.access_token) }
  let(:headers) { { 'Authorization' => auth_token } }

  describe 'POST /images' do
    let(:valid_attributes) { attributes_for(:image) }

    context 'when the request is valid' do
      before { post '/images', params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'creates an image with proper attributes' do
        expect(json['width']).to eq valid_attributes[:width]
        expect(json['height']).to eq valid_attributes[:height]
      end
    end

    context 'when the request is invalid' do
      before { post '/images', params: { width: 100 }, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns validation error messages under proper keys' do
        expect(json).to have_key 'file'
        expect(json).to have_key 'height'

        expect(json['file']).to eq ["can't be blank"]
        expect(json['height']).to eq ["can't be blank", "is not a number"]
      end
    end
  end
end
