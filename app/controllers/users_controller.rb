class UsersController < ApplicationController


  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_create :create_activation_digest
  # beforeフィルターのbefore_actionメソッドを使って何らかの処理が実行される直前に特定のメソットを実行する仕組み
  # 今回はユーザーにログインを要求するために,編集か更新しようとすると/login 画面に飛ぶように設定する

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
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      # 更新に成功した場合を扱う
    else
      render 'edit'
    end
  end

  def edit 
    @user = User.find(params[:id])
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

  # メソッド参照
    def create_activation_user
      # 有効化トークンとダイジェストを作成及び代入する
    end




end