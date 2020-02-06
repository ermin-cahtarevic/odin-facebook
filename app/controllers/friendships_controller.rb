class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @friendship = Friendship.new
  end

  def create
    user = User.find(params[:id])
    friendship = current_user.friendships.create(reciever_id: user.id, status: false)
    if friendship.save
      flash[:success] = 'friendship request send'
    else
      flash[:danger] = 'fail'
    end
    redirect_to request.referrer
  end

  def destroy
    sender = params[:sender.id]
    reject_request(sender)
  end

  def index
    @friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships
  end

  def update
    sender = User.find(params[:id])
    friendship = current_user.inverse_friendships.find_by(sender_id: sender.id)
    friendship.update(status: 'true')
    friendship.save
    redirect_to request.referrer
  end
end
