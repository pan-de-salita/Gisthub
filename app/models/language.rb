class Language < ApplicationRecord
  belongs_to :user
  has_many :solutions
  scope :with_solutions, -> { joins(:solutions) }
  before_save { name.capitalize! }

  validates :name, presence: true
end
