class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_many :comments, as: :commentable

  validates :name, :project_type, :start_at, :end_at, :user_id, presence: true
  validate :check_starts_before_ends, :check_overlap

  def check_starts_before_ends
    return if start_at.blank? or end_at.blank?
    errors.add(:start_at, 'must be before it ends') if start_at >= end_at
  end

  def check_overlap
    return unless [user_id, project_type, start_at, end_at].all?
    if id.present?
      if Project.exists?(['id != ? AND user_id = ? AND project_type = ? AND end_at > ? AND ? > start_at', id, user_id, project_type, start_at, end_at])
        errors.add(:base, 'overlaps with another project of the same type')
      end
    else
      if Project.exists?(['user_id = ? AND project_type = ? AND end_at > ? AND ? > start_at', user_id, project_type, start_at, end_at])
        errors.add(:base, 'overlaps with another project of the same type')
      end
    end
  end
end
