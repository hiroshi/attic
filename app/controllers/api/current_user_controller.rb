class Api::CurrentUserController < ApplicationController
  include SessionConcern

  before_action :login_required

  def show
    render json: current_user
  end
end
