require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:all) do
    @task = create(:task)
  end

  it 'is valid with valid attributes' do
    expect(@task).to be_valid
  end

  describe 'simple validations' do
    it { should validate_presence_of(:title) }
    describe '#priority' do
      it { should validate_presence_of(:priority)  }
      it { should define_enum_for(:priority).with_values(%i(high medium low)) }
    end
    describe '#status' do
      it { should validate_presence_of(:status) }
      it { should define_enum_for(:status).with_values(%i(pending working done)) }
    end
    it { should validate_presence_of(:project_id) }
  end

  describe 'associations' do
    it { should belong_to(:project) }
  end

  it 'is invalid if the deadline is after the project ends' do
    now = DateTime.now
    project = create(:project, start_at: now.beginning_of_year, end_at: now.end_of_year)
    task = build(:task, project: project, deadline: now + 2.years)
    expect(task).not_to be_valid
  end
end