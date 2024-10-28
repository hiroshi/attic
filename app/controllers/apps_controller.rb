class AppsController < ApplicationController
  include SessionConcern
  before_action :login_required

  def index
    @apps = AtticApp.where('owners.user_id': current_user).all
  end

  def create
    AtticApp.create!(params.require(:app).permit(:name).merge(owners: [{user: current_user}]))
    redirect_to action: :index
  end

  def destroy
    
  end
end
