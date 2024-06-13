class User < ApplicationRecord
  has_many :languages, dependent: :destroy
  has_many :solutions, dependent: :destroy

  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i

  validates :alias, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :bio, length: { maximum: 512 }
  validates :email, presence: true, length: { maximum: 256 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def solutions_in(lang)
    solutions.filter do |solution|
      solution.language_id == languages.find_by(name: lang).id if languages.find_by(name: lang)
    end
  end
end
