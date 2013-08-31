class UsersController < ApplicationController
  before_filter :authenticate_user

  def settings
  end

end
