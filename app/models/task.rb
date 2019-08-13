class Task < ApplicationRecord
  belongs_to :project

  validates :title, :status, :priority, :project_id, presence: true
  validate :check_deadline, on: :create

  enum priority: %i(high medium low)
  enum status: %i(pending working done)

  def check_deadline
    return if deadline.blank? or project.blank? or project.end_at.blank?
    errors.add(:deadline, 'must end before the project') if project.end_at < deadline
  end
end
