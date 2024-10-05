class SessionsController < ApplicationController
  def new
    # session['login'] = true
  end

  def create
    # debugger
    auth = request.env['omniauth.auth']
    uid_provider = auth.slice(:provider, :uid)
    user = User.find_by(accounts: { '$elemMatch': uid_provider })
    user ||= User.create!(accounts: [uid_provider.merge(auth[:info].slice(:email))])
    session[:user_id] = user.id

    render plain: 'logged in.'
  end
end
