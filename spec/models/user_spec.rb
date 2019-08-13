require 'rails_helper'

user_email = 'test-user-1@example.org'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create(:user, email: user_email)
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  describe 'simple validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:projects) }
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