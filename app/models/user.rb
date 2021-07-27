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

  enum role: { member: 0, admin: 1, locked: 2 }

  before_destroy :check_admin_numbers, prepend: true
  

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

  def admin?
    session[ENV["user_role"]] == "admin"
  end

  def user_locked?
    session[ENV["user_role"]] == "locked"
  end

  def locked
    self.role = "locked"
  end

  def unlocked
    self.role = "member"
  end

  def check_admin_numbers
    if self.role == "admin"
      throw :abort if User.where(role: "admin").count <= 1
    end
  end

end
