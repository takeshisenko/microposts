class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    followingall = Relationship.where(follower_id: params[:id])
    @following_users = Array.new
    
    followingall.each do |following|
      p @following_users << User.find_by(id: following.followed_id)
    end   
  end
  
  def followers
    @user  = User.find(params[:id])
    followerall  = Relationship.where(followed_id: params[:id])
    
    p @follower_users = Array.new
    
    followerall.each do |follower|
      @follower_users << User.find_by(id: follower.follower_id)
    end
  end

  # def new
  #   @user = User.new
  # end
  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #   else
  #   render 'new'
  #   end
  # end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
end