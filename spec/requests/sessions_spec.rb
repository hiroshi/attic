require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /auth/google_oauth2/callback" do
    let!(:user) {}

    before do
      # https://github.com/omniauth/omniauth/wiki/Integration-Testing
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        {
          provider: 'google_oauth2',
          uid: '001',
          info: {
            email: 'taro@example.com'
          }
        }
      )
      get '/auth/google_oauth2/callback'
    end

    shared_examples_for 'success' do
      it { expect(response).to have_http_status(:ok) }

      describe 'user' do
        it { expect(User.where('accounts.uid' => '001')).to exist }
      end
    end

    context 'new user' do
      it_behaves_like 'success'
    end

    context 'existing user' do
      let(:user) { User.create!(accounts: [{ uid: '001', provider: 'google_oauth2', email: 'taro@example.com' }]) }

      it_behaves_like 'success'

      describe 'only one user' do
        it { expect(User.count).to eq(1) }
      end
    end
  end
end
