class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :language

  before_validation :find_or_set_language_id
  before_update :downcase_tags
  before_save :downcase_tags
  before_save { programming_language.capitalize! }
  before_save { title.capitalize! }

  validates :title, presence: true, length: { maximum: 60 }
  validates :instructions, presence: true
  validates :attempt, presence: true
  validates :programming_language, presence: true
  validates :tags, presence: true
  validates :language_id, presence: true
  validate :language_must_exist

  private

  def find_or_set_language_id
    capitalized_programming_language = programming_language.capitalize
    programming_language_on_record = Language.find_by(name: capitalized_programming_language)

    if programming_language_on_record
      self.language_id = programming_language_on_record.id
    else
      new_language = Language.create(name: capitalized_programming_language)
      self.language_id = new_language.id
    end
  end

  def downcase_tags
    self.tags = tags.map(&:downcase)
  end

  def language_must_exist
    errors.add(:language_id, 'must exist') unless Language.exists?(id: language_id)
  end
end
