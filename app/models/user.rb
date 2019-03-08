class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}
    # Userモデルにpassword_digestを追加し、Gemfileにbcryptを追加したことでUserモデル内で has_secure_password が使えるようになりました。
end


# validatesは単なるメソッドメソッドです。
# カッコ内を使って 
# validates(:name, presence:true )  を使って同等のコードに書き換えたものです。