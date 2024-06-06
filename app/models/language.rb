class Language < ApplicationRecord
  belongs_to :user
  has_many :solutions

  before_save { name.capitalize! }

  validates :name, presence: true
end
