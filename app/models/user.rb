class User < ApplicationRecord
  # name
  validates :name, presence: true

  # email
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }

  # password関係
  attr_accessor :password_current

  validates :password, length: { minimum: 6 }, allow_blank: true
  has_secure_password # BCryptのメソッド。属性の追加や、"password"のハッシュ化、バリデーションなどを行う。
  with_options on: :account_update do
    validates :password_current, presence: true
    validate :authenticate_current_password
  end

  private

  # 現在のパスワードをDBの値と照合する
  def authenticate_current_password
    errors.add(:password_current, 'は不正な値です') unless
        password_current.blank? || User.find(id).authenticate(password_current) # 空白でなく、かつ不正の場合
  end
end
