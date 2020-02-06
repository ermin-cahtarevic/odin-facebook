class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]

  def show
    @user = current_user
    @posts = current_user.posts.all
  end

  def index
    @users = User.all
    @friendships = current_user.friendships  
    @inverse_friendships = current_user.inverse_friendships
  end
end
