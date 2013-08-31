class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    if session[:user_id]
      # handle another provided --- FUTUUUURE
    else
      @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      if @authorization
        # handle existing user
      else
        user = User.new(email: auth_hash[:info][:email],
          name: auth_hash[:info][:name])
        user.authorizations.build(provider: auth_hash[:provider],
          uid: auth_hash[:uid], link: auth_hash[:link])
        user.save
      end
      session[:user_id] = @authorization ? @authorization.user_id : user.id
    end
    redirect_to root_path
  end

  def failure
    render text: "invalid"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
