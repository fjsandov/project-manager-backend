require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:project) { create(:project, start_at: DateTime.now.beginning_of_year, end_at: DateTime.now.end_of_year) }
  let(:deadline) { nil }
  let(:task) { build(:task, project: project, deadline: deadline) }
  subject { task }

  it { should be_valid }

  describe 'simple validations' do
    it { should validate_presence_of(:title) }
    describe '#priority' do
      it { should validate_presence_of(:priority)  }
      it { should validate_inclusion_of(:priority).in_array(%i(high medium low)) }
    end
    describe '#status' do
      it { should validate_presence_of(:status) }
      it { should validate_inclusion_of(:status).in_array(%i(pending working done)) }
    end
    it { should validate_presence_of(:project_id) }
  end

  describe 'associations' do
    it { should belong_to(:project) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  context 'has the deadline after the project ends' do
    let(:deadline) { project.end_at + 1.year }
    it { should_not be_valid }
  end

  context 'has the deadline before the project ends' do
    let(:deadline) { project.start_at - 1.year }
    it { should_not be_valid }
  end
end