require 'rails_helper'

RSpec.describe Project, type: :model do
  before(:all) do
    @project = create(:project)
  end

  it 'is valid with valid attributes' do
    expect(@project).to be_valid
  end

  describe 'simple validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:project_type) }
    it { should validate_presence_of(:start_at) }
    it { should validate_presence_of(:end_at) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  it 'is invalid if it ends before it starts' do
    now = DateTime.now
    project = build(:project, user: create(:user), start_at: now, end_at: now - 1.year)
    expect(project).not_to be_valid
  end

  context 'when a new project is defined' do
    context 'when is the same owner' do
      before(:all) do
        @another_project = build(:project, user: @project.user)
      end

      it 'is invalid if has the same type and has dates overlap' do
        expect(@another_project).not_to be_valid
      end

      it 'is valid with another type' do
        @another_project.project_type = 'personal'
        expect(@another_project).to be_valid
      end
    end

    context 'when is a different owner' do
      before(:all) do
        @another_project = create(:project)
      end

      it 'is valid with same type and dates' do
        expect(@another_project).to be_valid
      end
    end
  end
end