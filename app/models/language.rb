class Language < ApplicationRecord
  has_many :solutions, dependent: :destroy

  before_save { name.capitalize! }

  validates :name, presence: true, uniqueness: true
end
