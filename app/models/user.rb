require 'digest'

class User < ApplicationRecord
  has_many :missions, dependent: :destroy

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /.+\@.+\..+/ }
  validates :password, presence: true,
                       confirmation: true

  before_create :encrypt_password
  before_update :encrypt_password

  enum role: { member: 0, admin: 1, locked: 2 }

  before_destroy :check_admin_numbers, prepend: true
  # before_update :check_admin_numbers
  validate :update_admin_to_member, on: :update


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

  # def admin?
  #   session[ENV["user_role"]] == "admin"
  # end

  # def user_locked?
  #   session[ENV["user_role"]] == "locked"
  # end

  # def locked
  #   self.role = "locked"
  # end

  # def unlocked
  #   self.role = "member"
  # end

  def check_admin_numbers
    if admin? && User.admin.count <= 1
      errors[:role] << I18n.t('not_less_one')
    end
  end

  def update_admin_to_member
    if role_changed?(from: 'admin', to: 'member') && User.admin.count <= 1
      errors.add(:role, I18n.t('not_less_one'))
    end
  end

end
