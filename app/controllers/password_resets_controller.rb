class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]  # ① パスワード再設定の有効有効期限が切れていないかの対応

  def new
  end


  def create
    @user = User.find(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else 
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:empaty?].empty? # 新しいパスワードが空文字列になってないないか(ユーザー情報の編集ではOKだった)
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params) # 新しいパスワードが正しければ、更新する
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'  # 無効なパスワードであればもう一度編集画面にリダイレクトさせる
    end
  end


  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # beforeフィルタ
    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 有効なユーザーかどうかを確認する
    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
      end
    end

    # トークンが期限切れかを確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
