class UsersController < ApplicationController
  before_filter :authenticate_user

  def archives
    render text: ''
  end

  def dashboard
    @songs = Song.all
  end

  def favorites
    render text: ''
  end

  def settings
  end
end
