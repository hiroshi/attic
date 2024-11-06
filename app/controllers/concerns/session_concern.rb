module SessionConcern
  include SessionHelper
  extend ActiveSupport::Concern

  included do
    def login_required
      return if current_user
      if request.path =~ %r{/api/}
        raise ApplicationController::HttpError.new("login required.", :forbidden)
      else
        redirect_to login_path
      end
    end
  end
end
