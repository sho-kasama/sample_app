class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user &&  user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render "new"
    end
  end

  def destroy
    log_out if logged_in?  # ログアウトの場合のみログアウトする
    redirect_to root_url
  end

  # 記憶したURL(デフォルト値)にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
