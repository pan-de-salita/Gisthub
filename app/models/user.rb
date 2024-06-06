class User < ApplicationRecord
  has_many :languages, dependent: :destroy
  has_many :solutions
  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i

  validates :alias, presence: true, length: { minimum: 6, maximum: 50 }
  validates :email, presence: true, length: { maximum: 256 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
