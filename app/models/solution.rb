class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :language

  before_validation :find_or_set_language_id
  before_save { title.capitalize! }
  before_save { programming_language.capitalize! }

  validates :title, presence: true, length: { maximum: 60 }
  validates :instructions, presence: true
  validates :attempt, presence: true
  validates :programming_language, presence: true

  private

  def find_or_set_language_id
    programming_language_on_record = Language.find_by(name: programming_language)

    if programming_language_on_record
      self.language_id = programming_language_on_record.id
    else
      current_user_id = user_id
      new_language = Language.create(name: programming_language, user_id: current_user_id)
      self.language_id = new_language.id
    end
  end
end
