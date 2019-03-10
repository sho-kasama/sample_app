class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else 
      render 'new'
    end
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      # 更新に成功した場合を扱う
    else
      render 'edit'
    end
  end



  private 

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end

  # redirect_to @user
  # 上記のコードは redirect_to user_url(@user) と等価になります
  # redirect_to @user というコードからuser_url (@user)といったコードを実行したいということを Railsが推察してくれた