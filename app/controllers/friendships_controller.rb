class FriendshipsController < ApplicationController
  def destroy
    @frienship = current_user.friendships.where(friend_id: params[:id]).first
    @frienship.destroy
    respond_to do |format|
      format.html { redirect_to my_friends_path, notice: "Friend was successfully removed" }
    end
  end
end