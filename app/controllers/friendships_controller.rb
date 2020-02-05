class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    friendship = current_user.friendships.create(friend_params)
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

  private

  def friend_params
    params.require(:friendship).permit(:reciever_id)
  end
end
