class Task < ApplicationRecord
  belongs_to :project

  validates :title, :status, :priority, :project_id, presence: true
  validates :priority, inclusion: { in: %w(high medium low) }
  validates :status, inclusion: { in: %w(pending working done) }
  validate :check_deadline

  def check_deadline
    return if deadline.blank? or project.blank? or project.end_at.blank?
    errors.add(:deadline, 'must end before the project') if project.end_at < deadline
  end
end
