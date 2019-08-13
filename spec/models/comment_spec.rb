require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Project comments' do
    let(:comment) { create(:project_comment) }
    subject { comment }

    it { should be_valid }

    describe 'simple validations' do
      it { should validate_presence_of(:body) }
    end

    it { should respond_to(:commentable) }
  end

  context 'Task comments' do
    let(:comment) { create(:task_comment) }
    subject { comment }

    it { should be_valid }

    describe 'simple validations' do
      it { should validate_presence_of(:body) }
    end

    it { should respond_to(:commentable) }
  end
end
