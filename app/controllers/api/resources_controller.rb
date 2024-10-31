class Api::ResourcesController < ApplicationController
  include SessionConcern
  before_action :login_required

  def create
    app = AtticApp.find_by(name: params[:app])
    raise HttpError.new("No app found: `#{params[:app]}`", :not_found) unless app

    name = params[:name].singularize

    type = app.resource_types.find_by(name:)
    raise HttpError.new("No resource found: `#{params[:name]}`", :not_found) unless type

    field_names = type.resource_fields.map(&:name)
    resource = Resource.create!(app:, name:, **params.require(name).permit(*field_names))
    head :created
  end
end
