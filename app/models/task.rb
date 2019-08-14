class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :status, :priority, :project_id, presence: true
  validates :priority, inclusion: { in: %w(high medium low) }
  validates :status, inclusion: { in: %w(pending working done) }
  validate :check_deadline

  def check_deadline
    return if deadline.blank? or project.blank? or project.end_at.blank?
    errors.add(:deadline, 'must be before the project ends') if project.end_at < deadline
    errors.add(:deadline, 'must be after the project starts') if project.start_at > deadline
  end
end
