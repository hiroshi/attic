class AppsController < ApplicationController
  include SessionConcern
  before_action :login_required

  def index
    @apps = AtticApp.where('app_owners.user_id': current_user).all
  end

  def create
    AtticApp.create!(params.require(:attic_app).permit(:name).merge(app_owners: [{user: current_user}]))
    redirect_to action: :index
  end

  def destroy
    
  end
end
