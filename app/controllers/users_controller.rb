class UsersController < ApplicationController
  def index
     @users = User.all
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
  
   before_action :logged_in_user, only: [:edit, :update]
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

