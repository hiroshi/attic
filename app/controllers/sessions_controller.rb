class SessionsController < ApplicationController
  def new
    # session['login'] = true
    session[:origin] = request.referer
  end

  def create
    auth = request.env['omniauth.auth']
    uid_provider = auth.slice(:provider, :uid)
    user = User.find_by(accounts: { '$elemMatch': uid_provider })
    user ||= User.create!(accounts: [uid_provider.merge(auth[:info].slice(:email))])
    session[:user_id] = user.id

    origin = session[:origin]
    session.delete(:origin)
    # TODO: allow only registerd host
    if origin
      redirect_to origin, allow_other_host: true
    else
      render plain: 'logged in.'
    end
  end
end
