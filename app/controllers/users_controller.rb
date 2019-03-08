class UsersController < ApplicationController
  def new
  end
end


# このコードはとてもよくまとまっているコード
# class User < ApplicationRecord　という構文で、Userクラスは ApplicationRecordを継承するので
# Userモデルは自動的にActiveRecord::Baseクラスのすべての機能を持つことになります 
# とはいえActiveRecord::Base に含まれるメソッドがわからない