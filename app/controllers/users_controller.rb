class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  
  
  def index
     @users = User.all
  end
  
  #showing twitter
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
  end
  
  
  
  #showing profile page
  def show
    @user = User.find(params[:id])
  end
  
  #making new account
  def new
    @user = User.new
  end
  
  #creating new account
   def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user 
    else
      render 'new'
    end
   end
  
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following_users(page: params[:page])
  
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.follower_users(page: params[:page])
  end
  
  
  

   #action for updating
    def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
    end
  
  #deliete mis tweet
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  
  
  #for edit  profile page
  def edit
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:about_self)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end

