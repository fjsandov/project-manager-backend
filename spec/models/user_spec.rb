require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  subject { user }

  it { should be_valid }

  describe 'simple validations' do
    describe '#email' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end
  end

  describe 'associations' do
    it { should have_many(:projects).dependent(:destroy) }
  end

  describe '#email' do
    it { should_not allow_value('not-an-email').for(:email) }
    it { should allow_value('correct@format.com').for(:email) }
  end

  describe '#password' do
    it { should_not allow_value('short').for(:password) }
    it { should allow_value('not-a-short-password').for(:password) }
  end
end