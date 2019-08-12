class Project < ApplicationRecord
  belongs_to :user
  validates :name, :project_type, :start_at, :end_at, :user_id, presence: true
  validate :check_overlap, on: :create

  def check_overlap
    if Project.exists?(['project_type = ? AND ? BETWEEN start_at AND end_at', project_type, start_at])
      errors.add(:start_at, 'overlaps with another project of the same type')
    elsif Project.exists?(['project_type = ? AND ? BETWEEN start_at AND end_at', project_type, end_at])
      errors.add(:end_at, 'overlaps with another project of the same type')
    elsif Project.exists?(['project_type = ? AND start_at > ? AND end_at < ?', project_type, start_at, end_at])
      errors.add(:base, 'overlaps with another project of the same type completely')
    end
  end
end
