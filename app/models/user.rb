class User < ApplicationRecord
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,
    presence: true,
    length: {maximum: Settings.users_name_max_length}
  validates :email,
    presence: true,
    length: {maximum: Settings.users_email_max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password,
    length: {maximum: Settings.users_password_max_length}

  private

  def downcase_email
    email.downcase!
  end
end
