require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { create(:project) }
  subject { project }

  it { should be_valid }

  describe 'simple validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:project_type) }
    it { should validate_presence_of(:start_at) }
    it { should validate_presence_of(:end_at) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
    it { should have_many(:comments) }
  end

  it 'is invalid if it ends before it starts' do
    now = DateTime.now
    another_user = create(:user)
    another_project = build(:project, user: another_user, start_at: now, end_at: now - 1.year)
    expect(another_project).not_to be_valid
  end

  context 'when a new project is defined' do
    let(:another_project) { create(:project) }
    subject { another_project }

    context 'when is a different owner' do
      describe 'has same type and dates' do
        it { should be_valid }
      end
    end

    context 'when is the same owner' do
      let(:project_type) { project.project_type }
      let(:start_at) { project.start_at }
      let(:end_at) { project.end_at }
      let(:another_project) {
        build(
          :project,
          user: project.user,
          project_type: project_type,
          start_at: start_at,
          end_at: end_at,
        )
      }
      subject { another_project }

      describe 'it checks overlap cases' do
        describe 'invalid if has the same type and has dates overlap' do
          it { should_not be_valid }
        end

        context 'has the same type but has dates before the existent one' do
          let(:start_at) { project.start_at - 1.year }
          let(:end_at) { project.start_at - 1.second }
          it { should be_valid }
        end

        context 'has the same type but has dates after the existent one' do
          let(:start_at) { project.end_at + 1.second }
          let(:end_at) { project.end_at + 1.year }
          it { should be_valid }
        end

        context 'has a different type' do
          let(:project_type) { 'a different type' }
          it { should be_valid }
        end
      end
    end
  end
end