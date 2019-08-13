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
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status).with_values([:high, :medium, :low])  }
    it { should validate_presence_of(:project_id) }
  end

  describe 'associations' do
    it { should belong_to(:project) }
  end

  it 'is invalid if the deadline is after the project ends' do
    now = DateTime.now
    project = build(:project, start_at: now.beginning_of_year, end_at: now.end_of_year)
    task = build(:task, project: project, deadline: now + 2.years)
    expect(task).not_to be_valid
  end
end