class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]

  def show
    @user = current_user
    @posts = current_user.posts.all
  end

  def index
    @users = User.all
  end
end
