class Language < ApplicationRecord
  belongs_to :user
  has_many :solutions, dependent: :destroy

  before_save { name.capitalize! }

  validates :name, presence: true, uniqueness: true
  validates :user_id, presence: true
  validate :user_must_exist

  private

  def user_must_exist
    errors.add(:user_id, 'must exist') unless User.exists?(id: user_id)
  end
end
