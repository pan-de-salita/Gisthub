class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :solution
  before_save { title.capitalize }

  validates :title, presence: true, length: { maximum: 60 }
  validates :instructions, presence: true
  validates :solution, presence: true
  validates :language, presence: true
end
