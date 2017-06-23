require 'rails_helper'
require 'bcrypt'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_uniqueness_of(:username) }
  end

  # describe "associations" do
  #   it { should have_many(:page_comments) }
  #   it { should have_many(:goals) }
  #   it { should have_many(:goal_comments).through(:goals) }
  #   it { should have_many(:authored_comments) }
  # end


  describe "find_by_credentials" do
    password = 'kwon'
    password_digest = BCrypt::Password.create('kwon')
    user = User.create(username: 'daniel', password_digest: password_digest,
    session_token: "awkejtl")

    it "should return the user if the username and password are valid" do
      exp(User.find_by_credentials(user.username, password)).to eq(user)
    end

    it "should return nil if username doesn't exist" do
      exp(User.find_by_credentials('syrie', password)).to be(nil)
    end

    it "should return nil if password incorrect" do
      exp(User.find_by_credentials('daniel', 'asdf')).to be(nil)
    end
  end
end
