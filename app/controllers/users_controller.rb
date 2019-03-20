class UsersController < ApplicationController


  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  # beforeフィルターのbefore_actionメソッドを使って何らかの処理が実行される直前に特定のメソットを実行する仕組み
  # 今回はユーザーにログインを要求するために,編集か更新しようとすると/login 画面に飛ぶように設定する

  def index
    @users = User.where(activated: FILL_IN).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless FILL_IN
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
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

    # メールアドレスを小文字にする
    def downcase_email
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成及び代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end




end