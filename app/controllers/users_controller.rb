class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  # beforeフィルターでdestroyアクションを管理者だけに限定する
  # beforeフィルターのbefore_actionメソッドを使って何らかの処理が実行される直前に特定のメソットを実行する仕組み
  # 今回はユーザーにログインを要求するために,編集か更新しようとすると/login 画面に飛ぶように設定する

  def index
    @users = User.paginate(page: params[:page])
  end

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
      # 上記のコードは redirect_to user_url(@user) と等価になります
    else 
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
      # 更新に成功した場合を扱う
    else
      render 'edit'
    end
  end

  def edit 
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザを削除しました"
    redirect_to users_url
  end

  private 

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  # before アクション


  # ログイン済みユーザーか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

  # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

  # 管理者かどうかを確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end