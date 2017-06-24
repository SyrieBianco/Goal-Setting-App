class User < ApplicationRecord

  validates :username, :password_digest, :session_token, presence: true
  validates :session_token, :username, uniqueness: true
  attr_reader :password
  after_initialize :ensure_session_token!

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username)
    if @user.nil?
      return nil
    else
      @user.is_password?(password) ? @user : nil
    end
  end

  def ensure_session_token!
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end


end
