class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :language
  before_save { title.capitalize! }
  before_save { programming_language.capitalize! }

  validates :title, presence: true, length: { maximum: 60 }
  validates :instructions, presence: true
  validates :attempt, presence: true
  validates :programming_language, presence: true
end
