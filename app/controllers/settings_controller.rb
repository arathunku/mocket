class SettingsController < ApplicationController
  before_filter :authenticate_user

  def default
  end

  def api
  end

  def update
    if current_user.update_attributes(user_params)
      respond_to do |format|
        format.html { redirect_to settings_path }
        format.json { render json: current_user, status: 200 }
      end
    else
      respond_to do |format|
        format.html { redirect_to settings_path, notice: 'There was a problem with update.' }
        format.json { render json: current_user, status: 422 }
      end
    end
  end

  private
  def user_params
    params[:user].permit(:default_player)
  end

end
