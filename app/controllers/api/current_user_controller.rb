class Api::CurrentUserController < ApplicationController
  include SessionConcern

  before_action :login_required

  def show
    render json: { user_id: session[:user_id] }
  end
end
