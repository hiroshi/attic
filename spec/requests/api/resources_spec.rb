require 'rails_helper'

RSpec.describe "Resources", type: :request do
  let!(:attic_app) { AtticApp.create!(name: 'todo', resource_types: [{name: 'item', resource_fields: [{name: 'title', type: :string}]}]) }
  let!(:current_user) { create_current_user }

  describe 'POST /api/v0/:app/:name' do
    before do
      post '/api/v0/todo/items', params: { item: { title: 'todo item 1' } }
    end

    it { expect(response).to have_http_status(:created) }

    describe 'created resource' do
      it { expect(Resource.where(app: attic_app, name: 'item', title: 'todo item 1')).to exist }
    end
  end
end
