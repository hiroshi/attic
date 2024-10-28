require 'rails_helper'

RSpec.describe "Apps", type: :request do
  describe 'GET /apps' do
    let!(:current_user) { create_current_user }
    let!(:apps) { [AtticApp.create!(name: 'my app', owners: [{user: current_user}])] }

    before do
      get '/apps'
    end

    it { expect(response).to have_http_status(:ok) }

    it { expect(response.body).to include('my app') }
  end

  describe 'POST /apps' do
    let!(:current_user) { create_current_user }

    before do
      post '/apps', params: { app: { name: 'The app' } }
    end

    it { expect(response).to redirect_to(apps_path) }

    describe 'app with current_user is the owner' do
      it { expect(AtticApp.where(name: 'The app', 'owners.user_id': current_user.id)).to exist }
    end
  end
end
