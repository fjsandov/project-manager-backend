class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  validates :name, :project_type, :start_at, :end_at, :user_id, presence: true
  validate :check_starts_before_ends, :check_overlap, on: :create

  def check_starts_before_ends
    return if start_at.blank? or end_at.blank?
    errors.add(:start_at, 'must be before it ends') if start_at >= end_at
  end

  def check_overlap
    return unless [user_id, project_type, start_at, end_at].all?
    if Project.exists?(['user_id = ? AND project_type = ? AND ? BETWEEN start_at AND end_at', user_id, project_type, start_at])
      errors.add(:start_at, 'overlaps with another project of the same type')
    elsif Project.exists?(['user_id = ? AND project_type = ? AND ? BETWEEN start_at AND end_at', user_id, project_type, end_at])
      errors.add(:end_at, 'overlaps with another project of the same type')
    elsif Project.exists?(['user_id = ? AND project_type = ? AND start_at > ? AND end_at < ?', user_id, project_type, start_at, end_at])
      errors.add(:base, 'overlaps with another project of the same type completely')
    end
  end
end
