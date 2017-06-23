class User < ApplicationRecord

  validates :username, :password_digest, :session_token, presence: true
  validates :session_token, :username, uniqueness: true



end
