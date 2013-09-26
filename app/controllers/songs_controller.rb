class SongsController < ApplicationController
  before_filter :authenticate_user, except: [:show]
end
