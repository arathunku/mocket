class UsersController < ApplicationController
  before_filter :authenticate_user

  def archives
  end

  def dashboard
    @songs = []
  end

  def favorites
  end

  def settings
  end
end
