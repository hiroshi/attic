module SessionHelper
  def create_current_user
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
    User.find(session[:user_id])
  end
end
