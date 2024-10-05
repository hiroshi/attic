module SessionConcern
  include SessionHelper
  extend ActiveSupport::Concern

  included do
    def login_required
      return if current_user
      if request.path =~ %r{/api/}
        render json: { message: 'login required.' }, status: :forbidden
      else
        redirect_to login_path
      end
    end
  end
end
