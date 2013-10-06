class UsersController < ApplicationController
  before_action :authenticate_user, except: [:new_api_song]
  skip_before_action :verify_authenticity_token, only: [:new_api_song]
  before_filter :set_post, only: [:destroy_song, :archive,
    :favorite]
  before_action :counters, only: [:dashboard, :favorites, :archives]

  def archives
    @posts = current_user.posts.archives.page(params[:page])
    respond_to do |format|
      format.html { render 'users/dashboard' }
      format.json { render json: @posts, status: 200 }
    end
  end

  def archive
    @post.update_attributes(archived: !@post.archived)
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Song was successfully (un)archived.' }
      format.json { render json: @post, status: 200 }
    end
  end

  def dashboard
    @posts = current_user.posts.current.page(params[:page])
  end

  def favorites
    @posts = current_user.posts.favorites.page(params[:page])
    respond_to do |format|
      format.html { render 'users/dashboard' }
      format.json { render json: @posts, status: 200 }
    end
  end

  def favorite
    @post.update_attributes(favorite: !@post.favorite)
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Song was successfully (un)favorite.' }
      format.json { render json: @post, status: 200 }
    end
  end

  def destroy_song
    @post.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Song was successfully deleted.' }
      format.json { render json: @post, status: 200 }
    end
  end

  def new_song
    @post = current_user.posts.new(post_params)
    if @post.save
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: 'Song was successfully created.' }
        format.json { render json: @post, status: 200 }
      end
    else
      respond_to do |format|
        format.html { redirect_to dashboard_path, flash: {error: 'Missing search.'}  }
        format.json { render json: @post, status: 422}
      end
    end
  end

  def new_api_song
    user = User.find_by_access_token(params[:access_token])
    render json: nil, status: 401 and return unless user
    post = user.posts.new(post_params)
    if post.save
      render json: post, status: 200
    else
      render json: post, status: 422
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params[:post].permit(:search, :favorite, :archive)
  end

  def counters
    @count = {
      favorites: current_user.posts.favorites.count,
      archives: current_user.posts.archives.count,
      current: current_user.posts.current.count
    }
  end
end
