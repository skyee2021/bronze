class User < ApplicationRecord
  has_many :missions, dependent: :destroy
  require 'digest'

  validates :email, presence: true,
                    uniqueness: true, 
                    format: { with: /.+\@.+\..+/ }
  validates :password, presence: true,
                       confirmation: true

  before_create :encrypt_password
  before_update :encrypt_password

  def self.login(params)
    email = params[:email]
    password = params[:password]

    encrypted_password = Digest::SHA256.hexdigest("123#{password}321")
    find_by(email: email, password: encrypted_password)
  end

  private 
  def encrypt_password #加密
    self.password = Digest::SHA256.hexdigest("123#{password}321")
  end
end
