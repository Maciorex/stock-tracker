class UsersController < ApplicationController

  def my_portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def my_friends
    @friendships = current_user.friends
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    if params[:search_params].blank?
      flash.now[:danger] = "Empty search string "
    else
      @users = User.search(params[:search_params])
      @users = current_user.except_current_user(@users)
      flash.now[:danger] = "No such user :(" if @users.blank?
    end
    respond_to do |format|
      format.js { render partial: "friends/result" }
    end
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      flash[:success] = "Friend was added"
    else
      flash[:danger] = "No one wants to be your friend"
    end
    redirect_to my_friends_path
  end
end
